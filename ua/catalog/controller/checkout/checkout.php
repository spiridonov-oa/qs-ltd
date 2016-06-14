<?php
class ControllerCheckoutCheckout extends Controller
{
    private $error = array();

    public function index()
    {
        // Validate cart has products and has stock.
        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
            $this->redirect($this->url->link('module/personal_cart'));
        }

        // Validate minimum quantity requirments.
        $products = $this->cart->getProducts();

        foreach ($products as $product) {
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            if ($product['minimum'] > $product_total) {
                $this->redirect($this->url->link('module/personal_cart'));
            }
        }


         $this->language->load('checkout/checkout');
        $this->initializeProducts();
        $this->initializeTotal();
        $this->initializeAddress();
        $this->setTemplateData();
        $this->addPaymentMethods();
        $this->initializeNewShippingAddress();

        //$this->confirm();

        $this->document->setTitle($this->language->get('heading_title'));
        $this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
        $this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_cart'),
            'href' => $this->url->link('module/personal_cart'),
            'separator' => $this->language->get('text_separator')
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('checkout/checkout', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_checkout_option'] = $this->language->get('text_checkout_option');
        $this->data['text_checkout_account'] = $this->language->get('text_checkout_account');
        $this->data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
        $this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
        $this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
        $this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');
        $this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
        $this->data['text_modify'] = $this->language->get('text_modify');

        $this->data['logged'] = $this->customer->isLogged();
        $this->data['shipping_required'] = $this->cart->hasShipping();

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_model'] = $this->language->get('column_model');
        $this->data['column_quantity'] = $this->language->get('column_quantity');
        $this->data['column_price'] = $this->language->get('column_price');
        $this->data['column_total'] = $this->language->get('column_total');

        $this->data['text_recurring_item'] = $this->language->get('text_recurring_item');
        $this->data['text_payment_profile'] = $this->language->get('text_payment_profile');


        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/checkout.tpl';
        } else {
            $this->template = 'default/template/checkout/checkout.tpl';
        }

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        if (isset($this->request->get['quickconfirm'])) {
            $this->data['quickconfirm'] = $this->request->get['quickconfirm'];
        }

        $this->response->setOutput($this->render());
    }

    public function country()
    {
        $json = array();

        $this->load->model('localisation/country');

        $country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

        if ($country_info) {
            $this->load->model('localisation/zone');

            $json = array(
                'country_id' => $country_info['country_id'],
                'name' => $country_info['name'],
                'iso_code_2' => $country_info['iso_code_2'],
                'iso_code_3' => $country_info['iso_code_3'],
                'address_format' => $country_info['address_format'],
                'postcode_required' => $country_info['postcode_required'],
                'zone' => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
                'status' => $country_info['status']
            );
        }

        $this->response->setOutput(json_encode($json));
    }


    //spiridonov.oa@gmail.com
    public function initializeProducts()
    {
        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
            $redirect = $this->url->link('module/personal_cart');
        }

        // Validate minimum quantity requirments.
        $products = $this->cart->getProducts();

        foreach ($products as $product) {
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            if ($product['minimum'] > $product_total) {
                $redirect = $this->url->link('module/personal_cart');

                break;
            }

            $option_data = array();

            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
                    $value = $option['option_value'];
                } else {
                    $filename = $this->encryption->decrypt($option['option_value']);

                    $value = utf8_substr($filename, 0, utf8_strrpos($filename, '.'));
                }

                $option_data[] = array(
                    'name' => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                );
            }


            $profile_description = '';

            if ($product['recurring']) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year'),
                );

                if ($product['recurring_trial']) {
                    $recurring_price = $this->currency->format($this->tax->calculate($product['recurring_trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')));
                    $profile_description = sprintf($this->language->get('text_trial_description'), $recurring_price, $product['recurring_trial_cycle'], $frequencies[$product['recurring_trial_frequency']], $product['recurring_trial_duration']) . ' ';
                }

                $recurring_price = $this->currency->format($this->tax->calculate($product['recurring_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')));

                if ($product['recurring_duration']) {
                    $profile_description .= sprintf($this->language->get('text_payment_description'), $recurring_price, $product['recurring_cycle'], $frequencies[$product['recurring_frequency']], $product['recurring_duration']);
                } else {
                    $profile_description .= sprintf($this->language->get('text_payment_until_canceled_description'), $recurring_price, $product['recurring_cycle'], $frequencies[$product['recurring_frequency']], $product['recurring_duration']);
                }
            }

            $this->data['products'][] = array(
                'key' => $product['key'],
                'product_id' => $product['product_id'],
                'name' => $product['name'],
                'model' => $product['model'],
                'option' => $option_data,
                'quantity' => $product['quantity'],
                'subtract' => $product['subtract'],
                'price' => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))),
                'total' => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']),
                'href' => $this->url->link('product/product', 'product_id=' . $product['product_id']),
                'recurring' => $product['recurring'],
                'profile_name' => $product['profile_name'],
                'profile_description' => $profile_description,
            );
        }

        // Gift Voucher
        $this->data['vouchers'] = array();

        if (!empty($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $voucher) {
                $this->data['vouchers'][] = array(
                    'description' => $voucher['description'],
                    'amount' => $this->currency->format($voucher['amount'])
                );
            }
        }
    }

    private function initializeTotal()
    {
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        $this->load->model('setting/extension');

        $sort_order = array();

        $results = $this->model_setting_extension->getExtensions('total');

        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }

        array_multisort($sort_order, SORT_ASC, $results);

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
            }
        }

        $sort_order = array();

        foreach ($total_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $total_data);

        $this->data['totals'] = $total_data;
    }

    private function initializeAddress()
    {
        if ($this->customer->isLogged()) {
            $this->load->model('account/address');

            $address_id = $this->customer->getAddressId();
            $this->session->data['address_id'] = $address_id;

            $this->data['addresses'] = $this->model_account_address->getAddresses();
            $this->data['address_id'] = $address_id;

            $this->load->model('account/order');
            $shipping_address_id = $address_id;
            $last_orders = $this->model_account_order->getOrders(0, 1);
            if(isset($last_orders[0])){
                $last_order =  $this->model_account_order->getOrder($last_orders[0]['order_id']);
                foreach($this->data['addresses'] as $address) {
                    if($address['address_1'] == $last_order['shipping_address_1'] && $address['address_2'] == $last_order['shipping_address_2']){
                        $shipping_address_id = $address['address_id'];
                    }
                }
            }

            $this->data['text_address_existing'] = $this->language->get('text_address_existing');
            $this->data['shipping_address_id'] = $shipping_address_id;
            $this->setShippingAddress($shipping_address_id);
            $this->setPaymentAddress($address_id);
        }
    }

    public function changeAddress()
    {
        $json = array();
        if (!empty($this->request->post['address_id'])) {
            $address_id = $this->request->post['address_id'];
            $this->session->data['address_id'] = $address_id;

            $json = $this->validateProducts($json);

            if (!$json) {
                $this->setShippingAddress($address_id);
            }
            $json['new_address_id'] = $this->session->data['address_id'];
        }

        $this->response->setOutput(json_encode($json));
    }

    private function setShippingAddress($address_id)
    {
        if ($this->customer->isLogged()) {
            $this->load->model('account/address');

            $this->session->data['shipping_address_id'] = $address_id;

            $address_info = $this->model_account_address->getAddress($address_id);

            if ($address_info) {
                $this->session->data['shipping_country_id'] = $address_info['country_id'];
                $this->session->data['shipping_zone_id'] = $address_info['zone_id'];
                $this->session->data['shipping_postcode'] = $address_info['postcode'];
            } else {
                unset($this->session->data['shipping_country_id']);
                unset($this->session->data['shipping_zone_id']);
                unset($this->session->data['shipping_postcode']);
            }
        }
    }

    private function setPaymentAddress($address_id)
    {
        if ($this->customer->isLogged()) {
            $this->load->model('account/address');

            $this->session->data['payment_address_id'] = $address_id;

            $address_info = $this->model_account_address->getAddress($this->session->data['address_id']);

            if ($address_info) {
                $json = array();

                $this->load->model('account/customer_group');

                $customer_group_info = $this->model_account_customer_group->getCustomerGroup($this->customer->getCustomerGroupId());

                // Company ID
                if ($customer_group_info['company_id_display'] && $customer_group_info['company_id_required'] && !$address_info['company_id']) {
                    $json['error']['warning'] = $this->language->get('error_company_id');
                }

                // Tax ID
                if ($customer_group_info['tax_id_display'] && $customer_group_info['tax_id_required'] && !$address_info['tax_id']) {
                    $json['error']['warning'] = $this->language->get('error_tax_id');
                }

                if (!$json) {
                    $this->session->data['payment_country_id'] = $address_info['country_id'];
                    $this->session->data['payment_zone_id'] = $address_info['zone_id'];
                } else {
                    unset($this->session->data['payment_country_id']);
                    unset($this->session->data['payment_zone_id']);
                }
            }
        }
    }

    private function initializeNewShippingAddress ()
    {
        $this->language->load('account/address');
        $this->language->load('checkout/checkout');

        $this->data['text_edit_address'] = $this->language->get('text_edit_address');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_select'] = $this->language->get('text_select');
        $this->data['text_none'] = $this->language->get('text_none');

        $this->data['entry_firstname'] = $this->language->get('entry_firstname');
        $this->data['entry_lastname'] = $this->language->get('entry_lastname');
        $this->data['entry_company'] = $this->language->get('entry_company');
        $this->data['entry_company_id'] = $this->language->get('entry_company_id');
        $this->data['entry_tax_id'] = $this->language->get('entry_tax_id');
        $this->data['entry_address_1'] = $this->language->get('entry_address_1');
        $this->data['entry_address_2'] = $this->language->get('entry_address_2');
        $this->data['entry_postcode'] = $this->language->get('entry_postcode');
        $this->data['entry_city'] = $this->language->get('entry_city');
        $this->data['entry_country'] = $this->language->get('entry_country');
        $this->data['entry_zone'] = $this->language->get('entry_zone');
        $this->data['entry_default'] = $this->language->get('entry_default');

        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_back'] = $this->language->get('button_back');

        if (isset($this->error['firstname'])) {
            $this->data['error_firstname'] = $this->error['firstname'];
        } else {
            $this->data['error_firstname'] = '';
        }

        if (isset($this->error['lastname'])) {
            $this->data['error_lastname'] = $this->error['lastname'];
        } else {
            $this->data['error_lastname'] = '';
        }

        if (isset($this->error['company_id'])) {
            $this->data['error_company_id'] = $this->error['company_id'];
        } else {
            $this->data['error_company_id'] = '';
        }

        if (isset($this->error['tax_id'])) {
            $this->data['error_tax_id'] = $this->error['tax_id'];
        } else {
            $this->data['error_tax_id'] = '';
        }

        if (isset($this->error['address_1'])) {
            $this->data['error_address_1'] = $this->error['address_1'];
        } else {
            $this->data['error_address_1'] = '';
        }

        if (isset($this->error['city'])) {
            $this->data['error_city'] = $this->error['city'];
        } else {
            $this->data['error_city'] = '';
        }

        if (isset($this->error['postcode'])) {
            $this->data['error_postcode'] = $this->error['postcode'];
        } else {
            $this->data['error_postcode'] = '';
        }

        if (isset($this->error['country'])) {
            $this->data['error_country'] = $this->error['country'];
        } else {
            $this->data['error_country'] = '';
        }

        if (isset($this->error['zone'])) {
            $this->data['error_zone'] = $this->error['zone'];
        } else {
            $this->data['error_zone'] = '';
        }

        if (!isset($this->request->get['address_id'])) {
            $this->data['action'] = $this->url->link('account/address/insert', '', 'SSL');
        } else {
            $this->data['action'] = $this->url->link('account/address/update', 'address_id=' . $this->request->get['address_id'], 'SSL');
        }

        if (isset($this->request->get['address_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $address_info = $this->model_account_address->getAddress($this->request->get['address_id']);
        }

        if (isset($this->request->post['firstname'])) {
            $this->data['firstname'] = $this->request->post['firstname'];
        } elseif (!empty($address_info)) {
            $this->data['firstname'] = $address_info['firstname'];
        } else {
            $this->data['firstname'] = '';
        }

        if (isset($this->request->post['lastname'])) {
            $this->data['lastname'] = $this->request->post['lastname'];
        } elseif (!empty($address_info)) {
            $this->data['lastname'] = $address_info['lastname'];
        } else {
            $this->data['lastname'] = '';
        }

        if (isset($this->request->post['company'])) {
            $this->data['company'] = $this->request->post['company'];
        } elseif (!empty($address_info)) {
            $this->data['company'] = $address_info['company'];
        } else {
            $this->data['company'] = '';
        }

        if (isset($this->request->post['company_id'])) {
            $this->data['company_id'] = $this->request->post['company_id'];
        } elseif (!empty($address_info)) {
            $this->data['company_id'] = $address_info['company_id'];
        } else {
            $this->data['company_id'] = '';
        }

        if (isset($this->request->post['tax_id'])) {
            $this->data['tax_id'] = $this->request->post['tax_id'];
        } elseif (!empty($address_info)) {
            $this->data['tax_id'] = $address_info['tax_id'];
        } else {
            $this->data['tax_id'] = '';
        }

        $this->load->model('account/customer_group');

        $customer_group_info = $this->model_account_customer_group->getCustomerGroup($this->customer->getCustomerGroupId());

        if ($customer_group_info) {
            $this->data['company_id_display'] = $customer_group_info['company_id_display'];
        } else {
            $this->data['company_id_display'] = '';
        }

        if ($customer_group_info) {
            $this->data['tax_id_display'] = $customer_group_info['tax_id_display'];
        } else {
            $this->data['tax_id_display'] = '';
        }

        if (isset($this->request->post['address_1'])) {
            $this->data['address_1'] = $this->request->post['address_1'];
        } elseif (!empty($address_info)) {
            $this->data['address_1'] = $address_info['address_1'];
        } else {
            $this->data['address_1'] = '';
        }

        if (isset($this->request->post['address_2'])) {
            $this->data['address_2'] = $this->request->post['address_2'];
        } elseif (!empty($address_info)) {
            $this->data['address_2'] = $address_info['address_2'];
        } else {
            $this->data['address_2'] = '';
        }

        if (isset($this->request->post['postcode'])) {
            $this->data['postcode'] = $this->request->post['postcode'];
        } elseif (!empty($address_info)) {
            $this->data['postcode'] = $address_info['postcode'];
        } else {
            $this->data['postcode'] = '';
        }

        if (isset($this->request->post['city'])) {
            $this->data['city'] = $this->request->post['city'];
        } elseif (!empty($address_info)) {
            $this->data['city'] = $address_info['city'];
        } else {
            $this->data['city'] = '';
        }

        if (isset($this->request->post['country_id'])) {
            $this->data['country_id'] = $this->request->post['country_id'];
        }  elseif (!empty($address_info)) {
            $this->data['country_id'] = $address_info['country_id'];
        } else {
            $this->data['country_id'] = $this->config->get('config_country_id');
        }

        if (isset($this->request->post['zone_id'])) {
            $this->data['zone_id'] = $this->request->post['zone_id'];
        }  elseif (!empty($address_info)) {
            $this->data['zone_id'] = $address_info['zone_id'];
        } else {
            $this->data['zone_id'] = '';
        }

        $this->load->model('localisation/country');

        $this->data['countries'] = $this->model_localisation_country->getCountries();

        if (isset($this->request->post['default'])) {
            $this->data['default'] = $this->request->post['default'];
        } elseif (isset($this->request->get['address_id'])) {
            $this->data['default'] = $this->customer->getAddressId() == $this->request->get['address_id'];
        } else {
            $this->data['default'] = false;
        }

    }

    private function addNewShippingAddress ()
    {

        $this->language->load('account/address');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('account/address');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateAddressForm()) {
            $this->model_account_address->addAddress($this->request->post);

            $this->session->data['success'] = $this->language->get('text_insert');
        }
    }

    protected function validateAddressForm() {
        if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
            $this->error['firstname'] = $this->language->get('error_firstname');
        }

        if ((utf8_strlen($this->request->post['lastname']) < 1) || (utf8_strlen($this->request->post['lastname']) > 32)) {
            $this->error['lastname'] = $this->language->get('error_lastname');
        }

        if ((utf8_strlen($this->request->post['address_1']) < 3) || (utf8_strlen($this->request->post['address_1']) > 128)) {
            $this->error['address_1'] = $this->language->get('error_address_1');
        }

        if ((utf8_strlen($this->request->post['city']) < 2) || (utf8_strlen($this->request->post['city']) > 128)) {
            $this->error['city'] = $this->language->get('error_city');
        }

        $this->load->model('localisation/country');

        $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

        if ($country_info) {
            if ($country_info['postcode_required'] && (utf8_strlen($this->request->post['postcode']) < 2) || (utf8_strlen($this->request->post['postcode']) > 10)) {
                $this->error['postcode'] = $this->language->get('error_postcode');
            }

            // VAT Validation
            $this->load->helper('vat');

            if ($this->config->get('config_vat') && !empty($this->request->post['tax_id']) && (vat_validation($country_info['iso_code_2'], $this->request->post['tax_id']) == 'invalid')) {
                $this->error['tax_id'] = $this->language->get('error_vat');
            }
        }

        if ($this->request->post['country_id'] == '') {
            $this->error['country'] = $this->language->get('error_country');
        }

        if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '') {
            $this->error['zone'] = $this->language->get('error_zone');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function setTemplateData()
    {
        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_password'] = $this->language->get('entry_password');
        $this->data['entry_firstname'] = $this->language->get('entry_firstname');
        $this->data['entry_lastname'] = $this->language->get('entry_lastname');
        $this->data['entry_telephone'] = $this->language->get('entry_telephone');
        $this->data['entry_tax_id'] = $this->language->get('entry_tax_id');

        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_login'] = $this->language->get('button_login');
        $this->data['text_forgotten'] = $this->language->get('text_forgotten');
        $this->data['text_new_customer'] = $this->language->get('text_new_customer');
        $this->data['text_address_new'] = $this->language->get('text_address_new');
        $this->data['text_your_address'] = $this->language->get('text_your_address');
        $this->data['text_new_customer_order'] = $this->language->get('text_new_customer_order');
        $this->data['text_confirm_email'] = $this->language->get('text_confirm_email');

        $this->data['text_checkout'] = $this->language->get('text_checkout');


        $this->data['error_registration_login'] = $this->language->get('error_login');
        $this->data['error_registration_firstname'] = $this->language->get('error_firstname');
        $this->data['error_registration_email'] = $this->language->get('error_email');
        $this->data['error_registration_telephone'] = $this->language->get('error_telephone');
        $this->data['error_registration_password'] = $this->language->get('error_password');
        $this->data['error_registration_tax_id'] = $this->language->get('error_tax_id');

        $this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
    }

    public function isEmailRegistered()
    {
        $json = array();
        $this->load->model('checkout/validation');

        $json = $this->validateProducts($json);
        $json = $this->validateLogged($json);

        if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
            $json['error']['email'] = $this->language->get('error_email');
        }

        if (!$json) {

            $this->load->model('account/customer');

            $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

            if ($customer_info) {
                $json['registered'] = true;
            } else {
                $json['registered'] = false;
            }
        }

        $this->response->setOutput(json_encode($json));
    }

    private function validateProducts($json)
    {
        // Validate cart has products and has stock.
        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
            $json['redirect'] = $this->url->link('module/personal_cart');
        }

        // Validate minimum quantity requirments.
        $products = $this->cart->getProducts();

        foreach ($products as $product) {
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            if ($product['minimum'] > $product_total) {
                $json['redirect'] = $this->url->link('module/personal_cart');

                break;
            }
        }
        return $json;
    }

    private function validateLogged($json)
    {
        // Validate if customer is already logged out.
        if ($this->customer->isLogged()) {
            $json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
        }

        return $json;
    }

    private function addPaymentMethods()
    {
        if ($this->customer->isLogged() && isset($this->session->data['payment_address_id'])) {
            $payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);
        } elseif (isset($this->session->data['guest'])) {
            $payment_address = $this->session->data['guest']['payment'];
        }

        if (!empty($payment_address)) {

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            $this->load->model('setting/extension');

            $sort_order = array();

            $results = $this->model_setting_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            // Payment Methods
            $method_data = array();
            $this->load->model('setting/extension');

            $results = $this->model_setting_extension->getExtensions('payment');

            $cart_has_recurring = $this->cart->hasRecurringProducts();

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('payment/' . $result['code']);

                    $method = $this->{'model_payment_' . $result['code']}->getMethod($payment_address, $total);

                    if ($method) {
                        if ($cart_has_recurring > 0) {
                            if (method_exists($this->{'model_payment_' . $result['code']}, 'recurringPayments')) {
                                if ($this->{'model_payment_' . $result['code']}->recurringPayments() == true) {
                                    $method_data[$result['code']] = $method;
                                }
                            }
                        } else {
                            $method_data[$result['code']] = $method;
                        }
                    }
                }
            }

            $sort_order = array();

            foreach ($method_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $method_data);

            $this->session->data['payment_methods'] = $method_data;
        }
    }

  	public function submit () {
        error_reporting(E_ALL);
        ini_set('display_errors', '1');

  	    $json = array();
  	    if ($this->customer->isLogged()) {
  	        if(!$this->request->post['shipping-address']) {
  	            $this->addNewShippingAddress();
  	        }
  	        if(!$this->error){
                $this->addOrder();
                $json['redirect'] = $this->url->link('checkout/success', '', 'SSL');
            } else {
                $json['error'] = $this->error;
            }
  	    } else {
            $this->registerNewCustomer();
            $this->initializeAddress();
            $this->addOrder();
            $json['redirect'] = $this->url->link('checkout/success', '', 'SSL');
  	    }

        $this->response->setOutput(json_encode($json));
  	}

  	private function registerNewCustomer() {
  	    if (!$this->customer->isLogged()) {

            if ($this->validateRegistration()) {
                $this->load->model('account/customer');

                $data = array();
                $data['email'] = $this->request->post['email'];
                $data['firstname'] = $this->request->post['firstname'];
                $data['telephone'] = $this->request->post['telephone'];
                $data['tax_id'] = isset($this->request->post['tax_id']) ? $this->request->post['tax_id'] : '';

                $data['comment'] = isset($this->request->post['comment']) ? $this->request->post['comment'] : '';
                $data['lastname'] =  '';
                $data['customer_group_id'] = '';
                $data['address_1'] =  '';
                $data['address_2'] = '';
                $data['city'] =  '';
                $data['country_id'] =  '';
                $data['zone_id'] =  '';
                $data['postcode'] =  '';
                $data['fax'] = '';
                $data['company'] = '';
                $data['company_id'] = '';

                $data['password'] = $this->generatePassword(8);

                $this->model_account_customer->addCustomer($data);

                $this->customer->login($data['email'], $data['password']);
            }
  	    }
  	}

    private function generatePassword ($number) {
        $arr = array('a','b','c','d','e','f',
            'g','h','i','j','k','l',
            'm','n','o','p','r','s',
            't','u','v','x','y','z',
            'A','B','C','D','E','F',
            'G','H','I','J','K','L',
            'M','N','O','P','R','S',
            'T','U','V','X','Y','Z',
            '1','2','3','4','5','6',
            '7','8','9','0');

        $pass = "";
        for($i = 0; $i < $number; $i++)
        {
            $index = rand(0, count($arr) - 1);
            $pass .= $arr[$index];
        }
        return $pass;
    }

  	protected function validateRegistration() {
        $this->load->model('account/customer');

        if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
            $this->error['firstname'] = $this->language->get('error_firstname');
        }

        if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
            $this->error['email'] = $this->language->get('error_email');
        }

        if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
            $this->error['warning'] = $this->language->get('error_exists');
        }

        if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
            $this->error['telephone'] = $this->language->get('error_telephone');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

  	private function addOrder () {
  	    if ($this->customer->isLogged()) {
            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            $this->load->model('setting/extension');

            $sort_order = array();

            $results = $this->model_setting_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);

            $this->language->load('checkout/checkout');

            $data = array();

            $data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
            $data['store_id'] = $this->config->get('config_store_id');
            $data['store_name'] = $this->config->get('config_name');

            if ($data['store_id']) {
                $data['store_url'] = $this->config->get('config_url');
            } else {
                $data['store_url'] = HTTP_SERVER;
            }

            $data['customer_id'] = $this->customer->getId();
            $data['customer_group_id'] = $this->customer->getCustomerGroupId();
            $data['firstname'] = $this->customer->getFirstName();
            $data['lastname'] = $this->customer->getLastName();
            $data['email'] = $this->customer->getEmail();
            $data['telephone'] = $this->customer->getTelephone();
            $data['fax'] = $this->customer->getFax();

            $this->load->model('account/address');

            $payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);

            $data['payment_firstname'] = $payment_address['firstname'];
            $data['payment_lastname'] = $payment_address['lastname'];
            $data['payment_company'] = $payment_address['company'];
            $data['payment_company_id'] = $payment_address['company_id'];
            $data['payment_tax_id'] = $payment_address['tax_id'];
            $data['payment_address_1'] = $payment_address['address_1'];
            $data['payment_address_2'] = $payment_address['address_2'];
            $data['payment_city'] = $payment_address['city'];
            $data['payment_postcode'] = $payment_address['postcode'];
            $data['payment_zone'] = $payment_address['zone'];
            $data['payment_zone_id'] = $payment_address['zone_id'];
            $data['payment_country'] = $payment_address['country'];
            $data['payment_country_id'] = $payment_address['country_id'];
            $data['payment_address_format'] = $payment_address['address_format'];

            if (isset($this->session->data['payment_method']['title'])) {
                $data['payment_method'] = $this->session->data['payment_method']['title'];
            } else {
                $data['payment_method'] = '';
            }

            if (isset($this->session->data['payment_method']['code'])) {
                $data['payment_code'] = $this->session->data['payment_method']['code'];
            } else {
                $data['payment_code'] = '';
            }

            if ($this->cart->hasShipping()) {

                $this->load->model('account/address');

                $shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);

                $data['shipping_firstname'] = $shipping_address['firstname'];
                $data['shipping_lastname'] = $shipping_address['lastname'];
                $data['shipping_company'] = $shipping_address['company'];
                $data['shipping_address_1'] = $shipping_address['address_1'];
                $data['shipping_address_2'] = $shipping_address['address_2'];
                $data['shipping_city'] = $shipping_address['city'];
                $data['shipping_postcode'] = $shipping_address['postcode'];
                $data['shipping_zone'] = $shipping_address['zone'];
                $data['shipping_zone_id'] = $shipping_address['zone_id'];
                $data['shipping_country'] = $shipping_address['country'];
                $data['shipping_country_id'] = $shipping_address['country_id'];
                $data['shipping_address_format'] = $shipping_address['address_format'];

                if (isset($this->session->data['shipping_method']['title'])) {
                    $data['shipping_method'] = $this->session->data['shipping_method']['title'];
                } else {
                    $data['shipping_method'] = '';
                }

                if (isset($this->session->data['shipping_method']['code'])) {
                    $data['shipping_code'] = $this->session->data['shipping_method']['code'];
                } else {
                    $data['shipping_code'] = '';
                }
            } else {
                $data['shipping_firstname'] = '';
                $data['shipping_lastname'] = '';
                $data['shipping_company'] = '';
                $data['shipping_address_1'] = '';
                $data['shipping_address_2'] = '';
                $data['shipping_city'] = '';
                $data['shipping_postcode'] = '';
                $data['shipping_zone'] = '';
                $data['shipping_zone_id'] = '';
                $data['shipping_country'] = '';
                $data['shipping_country_id'] = '';
                $data['shipping_address_format'] = '';
                $data['shipping_method'] = '';
                $data['shipping_code'] = '';
            }

            $product_data = array();

            foreach ($this->cart->getProducts() as $product) {
                $option_data = array();

                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {
                        $value = $option['option_value'];
                    } else {
                        $value = $this->encryption->decrypt($option['option_value']);
                    }

                    $option_data[] = array(
                        'product_option_id'       => $option['product_option_id'],
                        'product_option_value_id' => $option['product_option_value_id'],
                        'option_id'               => $option['option_id'],
                        'option_value_id'         => $option['option_value_id'],
                        'name'                    => $option['name'],
                        'value'                   => $value,
                        'type'                    => $option['type']
                    );
                }

                $product_data[] = array(
                    'product_id' => $product['product_id'],
                    'name'       => $product['name'],
                    'model'      => $product['model'],
                    'option'     => $option_data,
                    'download'   => $product['download'],
                    'quantity'   => $product['quantity'],
                    'subtract'   => $product['subtract'],
                    'price'      => $product['price'],
                    'total'      => $product['total'],
                    'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
                    'reward'     => $product['reward']
                );
            }

            // Gift Voucher
            $voucher_data = array();

            if (!empty($this->session->data['vouchers'])) {
                foreach ($this->session->data['vouchers'] as $voucher) {
                    $voucher_data[] = array(
                        'description'      => $voucher['description'],
                        'code'             => substr(md5(mt_rand()), 0, 10),
                        'to_name'          => $voucher['to_name'],
                        'to_email'         => $voucher['to_email'],
                        'from_name'        => $voucher['from_name'],
                        'from_email'       => $voucher['from_email'],
                        'voucher_theme_id' => $voucher['voucher_theme_id'],
                        'message'          => $voucher['message'],
                        'amount'           => $voucher['amount']
                    );
                }
            }

            if (!isset($this->session->data['comment']) && isset($this->request->post['comment'])) {
                $this->session->data['comment'] = $this->request->post['comment'];
            }

            $data['products'] = $product_data;
            $data['vouchers'] = $voucher_data;
            $data['totals'] = $total_data;
            $data['comment'] = isset($this->session->data['comment']) ? $this->session->data['comment'] : '';
            $data['total'] = $total;

            if (isset($this->request->cookie['tracking'])) {
                $this->load->model('affiliate/affiliate');

                $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
                $subtotal = $this->cart->getSubTotal();

                if ($affiliate_info) {
                    $data['affiliate_id'] = $affiliate_info['affiliate_id'];
                    $data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
                } else {
                    $data['affiliate_id'] = 0;
                    $data['commission'] = 0;
                }
            } else {
                $data['affiliate_id'] = 0;
                $data['commission'] = 0;
            }

            $data['language_id'] = $this->config->get('config_language_id');
            $data['currency_id'] = $this->currency->getId();
            $data['currency_code'] = $this->currency->getCode();
            $data['currency_value'] = $this->currency->getValue($this->currency->getCode());
            $data['ip'] = $this->request->server['REMOTE_ADDR'];

            if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
                $data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
            } elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
                $data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
            } else {
                $data['forwarded_ip'] = '';
            }

            if (isset($this->request->server['HTTP_USER_AGENT'])) {
                $data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
            } else {
                $data['user_agent'] = '';
            }

            if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
                $data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
            } else {
                $data['accept_language'] = '';
            }

            $this->load->model('checkout/order');

            $this->session->data['order_id'] = $this->model_checkout_order->addOrder($data);

            $this->load->model('cart/personal_cart');

            foreach($data['products'] as $product) {
                $this->model_cart_personal_cart->addRecentProduct($product['product_id'], $product['option'], $this->session->data['order_id']);
            }

            $this->model_checkout_order->confirm($this->session->data['order_id'], $this->config->get('config_order_status_id'));

  	    }

  	}

}

?>