<?php
class ControllerModuleBatchEditor extends Controller {


	//$this->data[''] = $this->language->get('');
	private $error = array ();
	
	private $filters = array(
		'number' => array ('price', 'quantity', 'sort_order', 'minimum', 'points', 'weight', 'length', 'width', 'height'),
		'list'   => array ('fc' => 'category', 'fa' => 'attribute', 'fm' => 'manufacturer', 'fss' => 'stock_status', 'ftc' => 'tax_class', 'fwc' => 'weight_class', 'flc' => 'length_class'),
		'other'  => array ('status', 'subtract', 'shipping')
	);
	
	private $sorts = array ('image' => 'p.image', 'name' => 'pd.name', 'sort_order' => 'p.sort_order', 'model'  => 'p.model', 'sku' => 'p.sku', 'price' => 'p.price', 'quantity' => 'p.quantity', 'status' => 'p.status', 'stock_status' => 'ss.name', 'manufacturer' => 'm.name', 'subtract' => 'p.subtract', 'shipping' => 'p.shipping', 'tax_class' => 'tc.title', 'minimum' => 'p.minimum', 'points' => 'p.points', 'url_alias' => 'ua.keyword', 'length_class' => 'lcd.title', 'length' => 'p.length', 'width' => 'p.width', 'height' => 'p.height', 'weight_class' => 'wcd.title', 'weight' => 'p.weight', 'upc' => 'p.upc', 'location' => 'p.location');
	
	private $pathes = array (
		'descriptions' => array (
			'list' => array ('languages'),
			'lang' => array ('entry_name', 'entry_meta_description', 'entry_meta_keyword', 'entry_description', 'entry_seo_title', 'entry_seo_h1', 'entry_tag')
		),
		'categories' => array (
			'list' => array ('categories'),
			'lang' => array ('column_categories', 'text_none')
		),
		'attributes' => array (
			'list' => array ('languages', 'attributes'),
			'lang' => array ('column_attribute_group', 'column_attribute_name', 'column_attribute_value', 'text_none')
		),
		'options' => array (
			'list' => array (),
			'lang' => array ('entry_required', 'entry_option_value', 'entry_quantity', 'entry_subtract', 'entry_price', 'entry_option_points', 'entry_weight', 'text_yes','text_no'),
			'func' => 1
		),
		'specials' => array (
			'list' => array ('customer_groups'),
			'lang' => array ('column_customer_group', 'column_priority', 'column_discount', 'column_date_start', 'column_date_end')
		),
		'discounts' => array (
			'list' => array ('customer_groups'),
			'lang' => array ('column_customer_group', 'column_quantity', 'column_priority', 'column_discount', 'column_date_start', 'column_date_end')
		),
		'related' => array (
			'list' => array (),
			'lang' => array (),
			'func' => 1
		),
		'stores' => array (
			'list' => array ('stores'),
			'lang' => array ('text_default')
		),
		'downloads' => array (
			'list' => array ('downloads'),
			'lang' => array ()
		),
		'images' => array (
			'list' => array ('no_image'),
			'lang' => array ('text_image_manager', 'column_sort_order', 'text_clear', 'text_path'),
			'func' => 1
		),
		'manufacturer' => 0,
		'stock_status' => 0,
		'status'       => 0,
		'price'        => 0,
		'tax_class'    => 0,
		'weight_class' => 0,
		'weight'       => 0,
		'length_class' => 0,
		'length'       => 0,
		'width'        => 0,
		'height'       => 0,
		'quantity'     => 0,
		'minimum'      => 0,
		'points'       => 0,
		'copy'         => 0,
		'delete'       => 0
	);
	
	public function getPAttributes($product_id) {
		$product_attribute_data = array();
		
		//$product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' GROUP BY attribute_id");
		
		$product_attribute_query = $this->db->query("SELECT pa.attribute_id, ad.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int)$product_id . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY pa.attribute_id ORDER BY  a.attribute_group_id asc");
		
		foreach ($product_attribute_query->rows as $product_attribute) {
			$product_attribute_description_data = array();
			
			$product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");
			
			foreach ($product_attribute_description_query->rows as $product_attribute_description) {
				$product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
			}
			
			$product_attribute_data[] = array(
				'attribute_id'                  => $product_attribute['attribute_id'],
				'name'                          => $product_attribute['name'],
				'product_attribute_description' => $product_attribute_description_data
			);
		}
		
		return $product_attribute_data;
	}
	
	public function index() {
		$setting = $this->config->get('batch_editor_setting');
		
		$this->data['columns'] = (isset ($setting['columns']) && is_array ($setting['columns'])) ? $setting['columns'] : array ();
		$this->data['limits'] = (isset ($setting['limits']) && is_array ($setting['limits'])) ? $setting['limits'] : array (20);
		
		$this->data['filter_columns'] = $this->sorts;
		unset ($this->data['filter_columns']['name']);
		
		$this->load->language('module/batch_editor');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_min'] = $this->language->get('text_min');
		$this->data['text_max'] = $this->language->get('text_max');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_up'] = $this->language->get('text_up');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_exact_entry'] = $this->language->get('text_exact_entry');
		$this->data['text_in_name'] = $this->language->get('text_in_name');
		$this->data['text_in_description'] = $this->language->get('text_in_description');
		$this->data['text_in_model'] = $this->language->get('text_in_model');
		$this->data['text_in_sku'] = $this->language->get('text_in_sku');
		$this->data['text_in_upc'] = $this->language->get('text_in_upc');
		$this->data['text_in_location'] = $this->language->get('text_in_location');
		$this->data['text_quantity_copies'] = $this->language->get('text_quantity_copies');
		
		$this->data['entry_option_value'] = $this->language->get('entry_option_value');
		$this->data['entry_option_points'] = $this->language->get('entry_option_points');
		$this->data['entry_quantity'] = $this->language->get('entry_quantity');
		$this->data['entry_subtract'] = $this->language->get('entry_subtract');
		$this->data['entry_price'] = $this->language->get('entry_price');
		$this->data['entry_weight'] = $this->language->get('entry_weight');
		$this->data['entry_required'] = $this->language->get('entry_required');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_links'] = $this->language->get('tab_links');
		
		$this->data['column_categories'] = $this->language->get('column_categories');
		$this->data['column_attributes'] = $this->language->get('column_attributes');
		$this->data['column_options'] = $this->language->get('column_options');
		$this->data['column_specials'] = $this->language->get('column_specials');
		$this->data['column_discounts'] = $this->language->get('column_discounts');
		$this->data['column_related'] = $this->language->get('column_related');
		$this->data['column_stores'] = $this->language->get('column_stores');
		$this->data['column_downloads'] = $this->language->get('column_downloads');
		$this->data['column_images'] = $this->language->get('column_images');
		
		$this->data['column_keyword'] = $this->language->get('column_keyword');
		$this->data['column_manufacturer'] = $this->language->get('column_manufacturer');
		$this->data['column_limit'] = $this->language->get('column_limit');
		$this->data['column_quantity'] = $this->language->get('column_quantity');
		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_price'] = $this->language->get('column_price');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_stock_status'] = $this->language->get('column_stock_status');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_priority'] = $this->language->get('column_priority');
		$this->data['column_discount'] = $this->language->get('column_discount');
		$this->data['column_date_start'] = $this->language->get('column_date_start');
		$this->data['column_date_end'] = $this->language->get('column_date_end');
		
		$this->data['column_customer_group'] = $this->language->get('column_customer_group');
		$this->data['column_attribute_group'] = $this->language->get('column_attribute_group');
		$this->data['column_attribute_name'] = $this->language->get('column_attribute_name');
		$this->data['column_attribute_value'] = $this->language->get('column_attribute_value');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_model'] = $this->language->get('column_model');
		$this->data['column_sku'] = $this->language->get('column_sku');
		$this->data['column_upc'] = $this->language->get('column_upc');
		$this->data['column_location'] = $this->language->get('column_location');
		$this->data['column_minimum'] = $this->language->get('column_minimum');
		$this->data['column_subtract'] = $this->language->get('column_subtract');
		$this->data['column_shipping'] = $this->language->get('column_shipping');
		$this->data['column_tax_class'] = $this->language->get('column_tax_class');
		$this->data['column_points'] = $this->language->get('column_points');
		$this->data['column_weight'] = $this->language->get('column_weight');
		$this->data['column_weight_class'] = $this->language->get('column_weight_class');
		$this->data['column_dimensions'] = $this->language->get('column_dimensions');
		$this->data['column_length_class'] = $this->language->get('column_length_class');
		$this->data['column_length'] = $this->language->get('column_length');
		$this->data['column_width'] = $this->language->get('column_width');
		$this->data['column_height'] = $this->language->get('column_height');
		$this->data['column_url_alias'] = $this->language->get('column_url_alias');
		$this->data['column_columns'] = $this->language->get('column_columns');
		$this->data['column_weight_dimensions'] = $this->language->get('column_weight_dimensions');
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_copy'] = $this->language->get('button_copy');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_filter'] = $this->language->get('button_filter');
		$this->data['button_reset'] = $this->language->get('button_reset');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_setting'] = $this->language->get('button_setting');
		
		$this->data['button_insert_sel'] = $this->language->get('button_insert_sel');
		$this->data['button_delete_sel'] = $this->language->get('button_delete_sel');
		$this->data['button_clear_cache'] = $this->language->get('button_clear_cache');
		
		$this->data['product_id'] = (isset ($this->request->post['selected'])) ? $this->request->post['selected'] : array ();
		
		$this->data['breadcrumbs'] = array (
			array (
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => FALSE
			),
			array (
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			),
			array (
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/batch_editor', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			)
		);
		
		$this->getLists(array ('languages', 'attributes', 'manufacturers', 'stock_statuses', 'categories', 'customer_groups', 'tax_classes', 'length_classes', 'weight_classes', 'discount_actions', 'price_actions', 'stores', 'downloads'));
		
		if (isset ($this->request->post['quantity_copies_products'])) {
			$this->data['quantity_copies_products'] = abs ((int) $this->request->post['quantity_copies_products']);
		} else {
			$this->data['quantity_copies_products'] = 1;
		}
		
		if ($this->data['quantity_copies_products'] == 0) {
			$this->data['quantity_copies_products'] = 1;
		}
		
		$this->load->model('tool/image');
		
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 40, 40);
		
		$this->data['token'] = $this->session->data['token'];
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['setting'] = $this->url->link('module/batch_editor/setting', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset ($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset ($this->session->data['success']);
		} else {
			$this->data['success'] = FALSE;
		}
		
		$this->template = 'module/batch_editor/index.tpl';
		$this->children = array (
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}
	
	public function getProducts() {
		$this->load->language('module/batch_editor');
		
		$this->data['text_view'] = $this->language->get('text_view');
		$this->data['text_related'] = $this->language->get('text_related');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_path'] = $this->language->get('text_path');
		
		$this->data['column_descriptions'] = $this->language->get('column_descriptions');
		$this->data['column_categories'] = $this->language->get('column_categories');
		$this->data['column_attributes'] = $this->language->get('column_attributes');
		$this->data['column_options'] = $this->language->get('column_options');
		$this->data['column_specials'] = $this->language->get('column_specials');
		$this->data['column_discounts'] = $this->language->get('column_discounts');
		$this->data['column_manufacturer'] = $this->language->get('column_manufacturer');
		$this->data['column_stock_status'] = $this->language->get('column_stock_status');
		$this->data['column_related'] = $this->language->get('column_related');
		
		$this->data['column_stores'] = $this->language->get('column_stores');
		$this->data['column_downloads'] = $this->language->get('column_downloads');
		$this->data['column_images'] = $this->language->get('column_images');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_model'] = $this->language->get('column_model');
		$this->data['column_sku'] = $this->language->get('column_sku');
		$this->data['column_quantity'] = $this->language->get('column_quantity');
		$this->data['column_price'] = $this->language->get('column_price');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		
		$this->data['column_more'] = $this->language->get('column_more');
		$this->data['column_upc'] = $this->language->get('column_upc');
		$this->data['column_location'] = $this->language->get('column_location');
		$this->data['column_minimum'] = $this->language->get('column_minimum');
		$this->data['column_subtract'] = $this->language->get('column_subtract');
		$this->data['column_shipping'] = $this->language->get('column_shipping');
		$this->data['column_tax_class'] = $this->language->get('column_tax_class');
		$this->data['column_points'] = $this->language->get('column_points');
		$this->data['column_weight'] = $this->language->get('column_weight');
		$this->data['column_weight_class'] = $this->language->get('column_weight_class');
		$this->data['column_dimensions'] = $this->language->get('column_dimensions');
		$this->data['column_length'] = $this->language->get('column_length');
		$this->data['column_width'] = $this->language->get('column_width');
		$this->data['column_height'] = $this->language->get('column_height');
		$this->data['column_length_class'] = $this->language->get('column_length_class');
		$this->data['column_url_alias'] = $this->language->get('column_url_alias');
		
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		$this->data['product_id'] = (isset ($this->request->post['selected'])) ? $this->request->post['selected'] : array ();
		
		$this->data['image'] = (isset ($this->request->post['image'])) ? (int) $this->request->post['image'] : 0;
		
		$this->data['limit'] = (isset ($this->request->post['limit'])) ? abs ((int) $this->request->post['limit']) : 20;
		$this->data['page'] = (isset ($this->request->post['page'])) ? abs ((int) $this->request->post['page']) : 1;
		
		$this->data['sort'] = (isset ($this->request->post['sort'])) ? (string) $this->request->post['sort'] : 'pd.name';
		$this->data['order'] = (isset ($this->request->post['order'])) ? (string) $this->request->post['order'] : 'ASC';
		
		$this->data['filter_keyword'] = (isset ($this->request->post['filter_keyword'])) ? trim ($this->request->post['filter_keyword']) : NULL;
		$this->data['filter_search_in'] = (isset ($this->request->post['filter_search_in'])) ? $this->request->post['filter_search_in'] : NULL;
		
		foreach ($this->filters['other'] as $filter) {
			$this->data['filter_' . $filter] = (isset ($this->request->post['filter_' . $filter])) ? (int) $this->request->post['filter_' . $filter] : NULL;
		}
		
		foreach ($this->filters['number'] as $filter) {
			$this->data['filter_' . $filter] = (isset ($this->request->post['filter_' . $filter])) ? $this->request->post['filter_' . $filter] : NULL;
		}
		
		foreach ($this->filters['list'] as $key => $filter) {
			$this->data['filter_' . $filter] = (isset ($this->request->post[$key]) && is_array ($this->request->post[$key])) ? implode (', ', $this->request->post[$key]) : FALSE;
		}
		
		foreach ($this->filters['list'] as $key => $filter) {
			$this->data['filter'][$filter . '_not'] = (isset ($this->request->post['filter'][$key . '_not'])) ? 'NOT' : FALSE;
		}
		
		foreach ($this->sorts as $key => $sort) {
			$this->data['sort_' . $key] = $sort;
		}
		
		if (isset ($this->request->post['filter_columns']) && is_array ($this->request->post['filter_columns'])) {
			$this->data['filter_columns'] = $this->request->post['filter_columns'];
		} else {
			$this->data['filter_columns'] = array ();
		}
		
		$this->data['products'] = array ();
		
		$data = array (
			'filter'              => $this->data['filter'],
			'filter_keyword'      => $this->data['filter_keyword'],
			'filter_search_in'    => $this->data['filter_search_in'],
			'filter_status'       => $this->data['filter_status'],
			'filter_subtract'     => $this->data['filter_subtract'],
			'filter_shipping'     => $this->data['filter_shipping'],
			'filter_price'        => $this->data['filter_price'],
			'filter_quantity'     => $this->data['filter_quantity'],
			'filter_sort_order'   => $this->data['filter_sort_order'],
			'filter_minimum'      => $this->data['filter_minimum'],
			'filter_points'       => $this->data['filter_points'],
			'filter_weight'       => $this->data['filter_weight'],
			'filter_length'       => $this->data['filter_length'],
			'filter_width'        => $this->data['filter_width'],
			'filter_height'       => $this->data['filter_height'],
			'filter_category'     => $this->data['filter_category'],
			'filter_attribute'    => $this->data['filter_attribute'],
			'filter_manufacturer' => $this->data['filter_manufacturer'],
			'filter_stock_status' => $this->data['filter_stock_status'],
			'filter_tax_class'    => $this->data['filter_tax_class'],
			'filter_weight_class' => $this->data['filter_weight_class'],
			'filter_length_class' => $this->data['filter_length_class'],
			'filter_columns'      => $this->data['filter_columns'],
			'sorts'               => $this->sorts,
			'sort'                => $this->data['sort'],
			'order'               => $this->data['order'],
			'start'               => ($this->data['page'] - 1) * $this->data['limit'],
			'limit'               => $this->data['limit']
		);
		
		$this->load->model('catalog/batch_editor/products');
		
		$product_total = $this->model_catalog_batch_editor_products->getTotalProducts($data);
		
		$results = $this->model_catalog_batch_editor_products->getProducts($data);
		
		$this->load->model('tool/image');
		
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 40, 40);
		
		$this->data['link'] = HTTP_CATALOG . 'index.php?route=product/product&product_id=';
		
		foreach ($results as $result) {
			if (in_array ('image', $this->data['filter_columns'])) {
				$thumb = ($result['image'] && file_exists (DIR_IMAGE . $result['image'])) ? $this->model_tool_image->resize($result['image'], 40, 40) : $this->data['no_image'];
			}
			
			/*$product = array ();
			
			foreach ($this->data['filter_columns'] as $column) {
				$product['product_id'] = $result['product_id'];
				$product['selected'] = in_array ($result['product_id'], $this->data['product_id']);
				$product['name'] = $result['name'];
				
				if ($column == 'image') {
					$product['image'] = $result['image'];
					$product['thumb'] = ($result['image'] && file_exists (DIR_IMAGE . $result['image'])) ? $this->model_tool_image->resize($result['image'], 40, 40) : $this->data['no_image'];
				} else if ($column == 'subtract' || $column == 'shipping') {
					$product[$column] = $result[$column] ? $this->language->get('text_yes') : $this->language->get('text_no');
				} else if ($column == 'status') {
					$product[$column] = $result[$column] ? $this->language->get('text_enabled') : $this->language->get('text_disabled');
				} else {
					$product[$column] = $result[$column];
				}
			}
			
			$this->data['products'][] = $product;*/
			
			$this->data['products'][] = array (
				'product_id'   => $result['product_id'],
				'name'         => $result['name'],
				'thumb'        => in_array ('image', $this->data['filter_columns']) ? $thumb : NULL,
				'image'        => in_array ('image', $this->data['filter_columns']) ? $result['image'] : NULL,
				'sort_order'   => in_array ('sort_order', $this->data['filter_columns']) ? $result['sort_order'] : NULL,
				'manufacturer' => in_array ('manufacturer', $this->data['filter_columns']) ? $result['manufacturer'] : NULL,
				'model'        => in_array ('model', $this->data['filter_columns']) ? $result['model'] : NULL,
				'sku'          => in_array ('sku', $this->data['filter_columns']) ? $result['sku'] : NULL,
				'upc'          => in_array ('upc', $this->data['filter_columns']) ? $result['upc'] : NULL,
				'location'     => in_array ('location', $this->data['filter_columns']) ? $result['location'] : NULL,
				'quantity'     => in_array ('quantity', $this->data['filter_columns']) ? $result['quantity'] : NULL,
				'minimum'      => in_array ('minimum', $this->data['filter_columns']) ? $result['minimum'] : NULL,
				'stock_status' => in_array ('stock_status', $this->data['filter_columns']) ? $result['stock_status'] : NULL,
				'subtract'     => in_array ('subtract', $this->data['filter_columns']) ? (($result['subtract'] ? $this->language->get('text_yes') : $this->language->get('text_no'))) : NULL,
				'shipping'     => in_array ('shipping', $this->data['filter_columns']) ? (($result['shipping'] ? $this->language->get('text_yes') : $this->language->get('text_no'))) : NULL,
				'status'       => in_array ('status', $this->data['filter_columns']) ? (($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled'))) : NULL,
				'price'        => in_array ('price', $this->data['filter_columns']) ? $result['price'] : NULL,
				'tax_class'    => in_array ('tax_class', $this->data['filter_columns']) ? $result['tax_class'] : NULL,
				'points'       => in_array ('points', $this->data['filter_columns']) ? $result['points'] : NULL,
				'weight'       => in_array ('weight', $this->data['filter_columns']) ? $result['weight'] : NULL,
				'weight_class' => in_array ('weight_class', $this->data['filter_columns']) ? $result['weight_class'] : NULL,
				'length'       => in_array ('length', $this->data['filter_columns']) ? $result['length'] : NULL,
				'width'        => in_array ('width', $this->data['filter_columns']) ? $result['width'] : NULL,
				'height'       => in_array ('height', $this->data['filter_columns']) ? $result['height'] : NULL,
				'length_class' => in_array ('length_class', $this->data['filter_columns']) ? $result['length_class'] : NULL,
				'url_alias'    => in_array ('url_alias', $this->data['filter_columns']) ? $result['url_alias'] : NULL,
				'selected'     => in_array ($result['product_id'], $this->data['product_id'])
			);
		}
		
		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $this->data['page'];
		$pagination->limit = $this->data['limit'];
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = '{page}';
		
		$this->data['pagination'] = $pagination->render();
		
		$this->template = 'module/batch_editor/products.tpl';
		
		$this->response->setOutput($this->render());
	}
	
		public function getProductTags($product_id) {
		$product_tag_data = array();
		
		$query = $this->db->query("SELECT tag,language_id FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		
		
		
		foreach ($query->rows as $result) {
			$tag_data[$result['language_id']][] = $result['tag'];
		}
		
		foreach ($tag_data as $language => $tags) {
			$product_tag_data[$language] = implode(',', $tags);
		}
		
		return $product_tag_data;
	}
	
	public function getProductList() {
		$path = (isset ($this->request->post['path'])) ? (string) $this->request->post['path'] : FALSE;
		
		if (isset ($this->pathes[$path])) {
			$this->data['product_id'] = (isset ($this->request->post['product_id'])) ? (int) $this->request->post['product_id'] : FALSE;
			
			if (isset ($this->pathes[$path]['func'])) {
				$this->load->model('catalog/batch_editor/get_lists');
				
				$this->data['product_' . $path] = $this->model_catalog_batch_editor_get_lists->{'getProduct' . $path}($this->data['product_id']);
			} else {
				$this->load->model('catalog/product');
				
				if ($path=="attributes") 
				$this->data['product_' . $path] = $this->getPAttributes($this->data['product_id']);
				else
				$this->data['product_' . $path] = $this->model_catalog_product->{'getProduct' . $path}($this->data['product_id']);
			}
			
			if ($path == 'descriptions') {
				$this->data['product_tags'] = $this->getProductTags($this->data['product_id']);
			}
			
			$this->load->language('module/batch_editor');
			
			$this->data['column_' . $path] = $this->language->get('column_' . $path);
			
			$this->data['text_no_results'] = $this->language->get('text_no_results');
			
			$this->data['button_insert'] = $this->language->get('button_insert');
			$this->data['button_remove'] = $this->language->get('button_remove');
			$this->data['button_save'] = $this->language->get('button_save');
			
			foreach ($this->pathes[$path]['lang'] as $lang) {
				$this->data[$lang] = $this->language->get($lang);
			}
			
			$this->data['language_id'] = (int) $this->config->get('config_language_id');
			
			$this->getLists($this->pathes[$path]['list']);
			
			$this->load->model('tool/image');
			
			$this->data['product_name'] = $this->model_catalog_batch_editor_get_lists->getProductName((int) $this->data['product_id']);
			
			$this->data['product_image'] = $this->model_tool_image->resize($this->model_catalog_batch_editor_get_lists->getProductImage((int) $this->data['product_id']), 40, 40);
			
			$this->template = 'module/batch_editor/product_' . $path . '.tpl';
			
			$this->response->setOutput($this->render());
		}
	}
	
	public function editProducts() {
		$this->load->language('module/batch_editor');
		
		$this->data['product_id'] = (isset ($this->request->post['selected'])) ? $this->request->post['selected'] : array ();
		
		$path = (isset ($this->request->post['path'])) ? $this->request->post['path'] : FALSE;
		
		$action = (isset ($this->request->post['action'])) ? $this->request->post['action'] : FALSE;
		
		if (isset ($this->pathes[$path])) {
			
			if ($path == 'descriptions') {
				$validate = 'validateForm';
				
				$this->data['product_' . $path][$path] = (isset ($this->request->post['product_' . $path])) ? $this->request->post['product_' . $path] : array ();
				$this->data['product_' . $path]['tags'] = (isset ($this->request->post['product_tags'])) ? $this->request->post['product_tags'] : array ();
			} else {
				$validate = 'validate';
				
				$this->data['product_' . $path] = (isset ($this->request->post['product_' . $path])) ? $this->request->post['product_' . $path] : array ();
			}
			
			//------- errors start -------//
			if (!$this->data['product_id']) {
				$this->error['warning'] = $this->language->get('error_empty_product');
			}
			
			if ($path == 'categories' || $path == 'attributes' || $path == 'options' || $path == 'related' || $path == 'stores' || $path == 'downloads') {
				if (!$this->data['product_' . $path] && $action != 'upd') {
					$this->error['warning'] = $this->language->get('error_empty_' . $path);
				}
			}
			
			if ($path == 'attributes') {
				foreach ($this->data['product_attributes'] as $product_attribute) {
					if (empty ($product_attribute['name'])) {
						$this->error['warning'] = $this->language->get('error_empty_attribute_name');
						break;
					}
				}
			}
			
			if ($path == 'price') {
				if (!$this->data['product_price']) {
					$this->error['warning'] = $this->language->get('error_empty_number');
				}
			}
			//------- errors end -------//
			
			if ($this->{$validate}()) {
				$this->load->model('catalog/batch_editor/product_edit');
				
				$this->model_catalog_batch_editor_product_edit->{$path}($this->data['product_id'], $this->data['product_' . $path], $action);
				
				$this->data['success'] = $this->language->get('success_edit_' . $path);
				
				$this->cache->delete('product');
			}
			
			echo json_encode (array (
				'warning' => (isset ($this->error['warning'])) ? $this->error['warning'] : FALSE,
				'success' => (isset ($this->data['success'])) ? $this->data['success'] : FALSE
			));
		}
		
	}
	
	public function setting() {
		$this->load->language('module/batch_editor');
		
		$this->document->setTitle($this->language->get('button_setting'));
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->load->model('setting/setting');
			
			if (!isset ($this->request->post['batch_editor_setting']['limits'])) {
				$this->request->post['batch_editor_setting']['limits'] = array (20);
			}
			
			foreach ($this->request->post['batch_editor_setting']['limits'] as $key => $value) {
				$this->request->post['batch_editor_setting']['limits'][$key] = (int) $value;
				
				if (!$this->request->post['batch_editor_setting']['limits'][$key]) {
					unset ($this->request->post['batch_editor_setting']['limits'][$key]);
				}
			}
			
			$this->request->post['batch_editor_setting']['limits'] = array_unique ($this->request->post['batch_editor_setting']['limits']);
			
			asort ($this->request->post['batch_editor_setting']['limits']);
			
			$this->model_setting_setting->editSetting('batch_editor', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('success_edit_setting');
			
			$this->redirect($this->url->link('module/batch_editor', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['columns'] = $this->sorts;
		unset ($this->data['columns']['name']);
		
		$this->data['heading_title'] = $this->language->get('button_setting');
		
		$this->data['column_columns'] = $this->language->get('column_columns');
		$this->data['column_limit'] = $this->language->get('column_limit');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_setting'] = $this->language->get('button_setting');
		
		foreach ($this->data['columns'] as $column => $value) {
			$this->data['column_' . $column] = $this->language->get('column_' . $column);
		}
		
		$this->data['breadcrumbs'] = array (
			array (
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => FALSE
			),
			array (
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			),
			array (
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/batch_editor', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			),
			array (
				'text'      => $this->language->get('button_setting'),
				'href'      => $this->url->link('module/batch_editor/setting', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			)
		);
		
		$setting = $this->config->get('batch_editor_setting');
		
		if (isset ($setting['columns']) && is_array ($setting['columns'])) {
			$this->data['columns_setting'] = $setting['columns'];
		} else {
			$this->data['columns_setting'] = array ();
		}
		
		if (isset ($setting['limits']) && is_array ($setting['limits'])) {
			$this->data['limits'] = $setting['limits'];
		} else {
			$this->data['limits'] = array (20);
		}
		
		$this->data['action'] = $this->url->link('module/batch_editor/setting', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('module/batch_editor', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset ($this->error['warning'])) {
			$this->data['warning'] = $this->error['warning'];
		} else {
			$this->data['warning'] = FALSE;
		}
		
		$this->template = 'module/batch_editor/setting.tpl';
		
		$this->children = array (
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}
	
	public function loadAttributes() {
		$path = 'model_catalog_batch_editor_get_lists';
		
		$this->load->model('catalog/batch_editor/get_lists');
		
		$this->load->language('module/batch_editor');
		
		$this->data['text_none'] = $this->language->get('text_none');
		
		$this->data['get'] = array (
			'table'              => (isset ($this->request->get['table'])) ? (string) $this->request->get['table'] : FALSE,
			'row_id'             => (isset ($this->request->get['row_id'])) ? (int) $this->request->get['row_id'] : 0,
			'attribute_group_id' => (isset ($this->request->get['attribute_group_id'])) ? (int) $this->request->get['attribute_group_id'] : 0
		);
		
		$this->data['attributes'] = $this->{$path}->getAttributesByGroupId($this->data['get']['attribute_group_id']);
		
		$this->template = 'module/batch_editor/select_attributes.tpl';
		
		$this->response->setOutput($this->render());
	}
	
	public function quickEditProduct() {
		$path = 'model_catalog_batch_editor_products';
		
		$this->load->model('catalog/batch_editor/products');
		
		$this->load->language('module/batch_editor');
		
		$product_id = (isset ($this->request->post['product_id'])) ? $this->request->post['product_id'] : FALSE;
		$value      = (isset ($this->request->post['value'])) ? $this->request->post['value'] : FALSE;
		$action     = (isset ($this->request->post['action'])) ? $this->request->post['action'] : FALSE;
		
		if ($this->validate()) {
			$value = $this->{$path}->quickEditProduct($product_id, $value, $action);
			
			$this->cache->delete('product');
		}
		
		echo json_encode (array (
			'value'   => $value,
			'warning' => (isset ($this->error['warning'])) ? $this->error['warning'] : FALSE)
		);
	}
	
	public function quickEditProductSelect() {
		$this->data['id'] = (isset ($this->request->get['id'])) ? (int) $this->request->get['id'] : FALSE;
		
		$this->data['name'] = (isset ($this->request->get['name'])) ? (string) $this->request->get['name'] : FALSE;
		
		$this->data['action'] = (isset ($this->request->get['action'])) ? (string) $this->request->get['action'] : FALSE;
		
		$this->data['actions'] = array (
			'manufacturer' => 'manufacturers',
			'stock_status' => 'stock_statuses',
			'status'       => 'statuses',
			'shipping'     => 'shippings',
			'subtract'     => 'subtracts',
			'tax_class'    => 'taxclasses',
			'length_class' => 'lengthclasses',
			'weight_class' => 'weightclasses',
		);
		
		if (isset ($this->data['actions'][$this->data['action']])) {
			$this->getLists(array ($this->data['actions'][$this->data['action']]));
			
			$this->template = 'module/batch_editor/select_quick_edit.tpl';
			
			$this->response->setOutput($this->render());
		}
	}
	
	public function clearCache() {
		$this->load->language('module/batch_editor');
		
		if ($this->validate()) {
			$this->cache->delete('batch_editor');
		}
		
		echo json_encode (array (
			'warning' => ($this->error) ? $this->error['warning'] : FALSE,
			'success' => (!$this->error) ? $this->language->get('success_clear_cache') : FALSE
		));
	}
	
	public function imageResize() {
		$this->load->model('tool/image');
		
		$image = (isset ($this->request->post['image'])) ? $this->request->post['image'] : FALSE;
		
		$width = (isset ($this->request->post['width'])) ? abs ((int) $this->request->post['width']) : FALSE;
		
		$height = (isset ($this->request->post['height'])) ? abs ((int) $this->request->post['height']) : FALSE;
		
		if ($width == 0 || $height == 0) {
			$width = $height = 40;
		}
		
		if ($image && file_exists (DIR_IMAGE . $image)) {
			$image = $this->model_tool_image->resize($image, $width, $height);
		} else {
			$image = $this->model_tool_image->resize('no_image.jpg', $width, $height);
		}
		
		$this->response->setOutput($image);
	}
	
	public function getImageManager() {
		if (isset ($this->request->get['keyword']) && isset ($this->request->get['dir'])) {
			$results = $images = array ();
			
			$dir = $this->request->get['dir'];
			$keyword = trim ($this->request->get['keyword']);
			
			if (is_dir (DIR_IMAGE . $dir) && $keyword) {
				$results = glob (DIR_IMAGE . $dir . $keyword . '*.{JPG,jpg,JPEG,jpeg,PNG,png,GIF,gif}', GLOB_BRACE);
			}
			
			if ($results) {
				$this->load->model('tool/image');
				
				$i = 0;
				
				foreach ($results as $result) {
					if (!is_dir ($result)) {
						$file = str_replace (DIR_IMAGE . $dir, '', $result);
						
						$images[] = array (
							'file' => $file,
							'img'  => $this->model_tool_image->resize($dir . $file, 40, 40)
						);
					}
					
					$i++;
					
					if ($i == 10) {
						break;
					}
				}
			}
			
			$this->response->setOutput(json_encode ($images));
		} else {
			if (isset ($this->request->get['id'])) {
				$this->data['id'] = (int) $this->request->get['id'];
			} else {
				$this->data['id'] = FALSE;
			}
			
			if (isset ($this->request->get['list']) && $this->request->get['list']) {
				$this->data['list'] = (int) $this->request->get['list'];
			} else {
				$this->data['list'] = FALSE;
			}
			
			$this->data['button_remove'] = $this->language->get('button_remove');
			
			$this->data['dirs'] = $this->cache->get('batch_editor.dirs_images');
			
			if (!$this->data['dirs']) {
				$this->data['dirs'] = $this->getDirsImages();
				
				$this->cache->set('batch_editor.dirs_images', $this->data['dirs']);
			}
			
			$this->template = 'module/batch_editor/image_manager.tpl';
			
			$this->response->setOutput($this->render());
		}
	}
	
	private function getDirsImages($path = 'data/') {
		static $dirs = array ('data/');
		
		$results = scandir (DIR_IMAGE . $path);
		
		foreach ($results as $result) {
			if ($result != '.' && $result != '..' && is_dir (DIR_IMAGE . $path . $result)) {
				$dirs[] = $path . $result . '/';
				
				$this->getDirsImages($path . $result . '/');
			}
		}
		
		return $dirs;
	}
	
	private function getLists($keys = array ()) {
		$this->load->model('catalog/batch_editor/get_lists');
		
		foreach ($keys as $key) {
			$this->data[$key] = $this->model_catalog_batch_editor_get_lists->{'get' . str_replace ('_', FALSE, $key)} ();
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/batch_editor')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		return (!$this->error) ? TRUE : FALSE;
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'module/batch_editor')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		foreach ($this->request->post['product_descriptions'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 1) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_product_name');
			}
		}
		
		if ($this->error && !isset ($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_validate_form');
		}
		
		return (!$this->error) ? TRUE : FALSE;
	}
}
?>