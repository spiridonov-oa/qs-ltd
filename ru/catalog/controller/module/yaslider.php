<?php  
class ControllerModuleYaslider extends Controller {
	protected function index($setting) {
                static $module = 0;

		$this->language->load('module/yaslider');
		
		// le styles and scripts
		$this->document->addStyle('catalog/view/theme/default/stylesheet/yaslider.css', $rel = 'stylesheet', $media = 'screen');
		$this->document->addScript('catalog/view/javascript/yaslider/jquery.cycle.all.js');

		// language vars
		$this->data['btn_buy'] 		= $setting['buy_text'][$this->config->get('config_language_id')];
		$this->data['btn_details'] 	= $setting['details_text'][$this->config->get('config_language_id')];
                $this->data['show_heading']	= $setting['show_heading'];
	    	$this->data['heading'] 		= $setting['heading_text'][$this->config->get('config_language_id')];
    	
		//slider settings
		$this->data['slider_timeout'] 	= $setting['slider_timeout'];
		$this->data['slider_effect'] 	= $setting['slider_effect'];
		$this->data['slider_random'] 	= $setting['slider_random'];
		$this->data['slider_width'] 	= $setting['slider_width'];
		$this->data['slider_height'] 	= $setting['slider_height'];
		$this->data['slider_style'] 	= $setting['slider_style'];
		$this->data['slider_color'] 	= $setting['slider_color'];
		$this->data['slider_badge'] 	= $setting['slider_badge'];

		// products
		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');

		$this->data['products'] = array();
		$this->data['show_description'] = $setting['show_description'];
		$this->data['image_width'] 	= $setting['image_width'];
		$this->data['image_height'] 	= $setting['image_height'];

		$products = explode(',', $setting['products_ids']);		

		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image = false;
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = $product_info['rating'];
				} else {
					$rating = false;
				}
					
				$this->data['products'][] = array(
					'product_id'	=> $product_info['product_id'],
					'thumb'		=> $image,
					'name'    	=> $product_info['name'],
					'price'   	=> $price,
					'special' 	=> $special,
					'rating'    	=> $rating,
					'description'	=> substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['description_length']) . '..',
					'reviews'   	=> sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'href'    	=> $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
				);
			}
		}

		$this->data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/yaslider.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/yaslider.tpl';
		} else {
			$this->template = 'default/template/module/yaslider.tpl';
		}
		
		$this->render();
	}
}
?>