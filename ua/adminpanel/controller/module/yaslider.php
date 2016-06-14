<?php
class ControllerModuleYaslider extends Controller {
	private $error = array(); 
	 
	public function index() {   
		$this->load->language('module/yaslider');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/yaslider.css');
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('yaslider', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		$this->data['tab_module'] = $this->language->get('tab_module');
		
		$this->data['token'] = $this->session->data['token'];

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/yaslider', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/yaslider', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		if (isset($this->request->post['yaslider_module'])) {
			$this->data['modules'] = $this->request->post['yaslider_module'];
		} elseif ($this->config->get('yaslider_module')) { 
			$this->data['modules'] = $this->config->get('yaslider_module');
		}	

		$this->load->model('catalog/product');
      
		// add product by its ID
    foreach ($this->data['modules'] as $module=>$info) {
         		$prods = explode(',', $info['products_ids']);
                        $this->data['modules'][$module]['products'] = array();

                        foreach ($prods as $product_id) {
         			$product_info = $this->model_catalog_product->getProduct($product_id);
         			if ($product_info) {
         				$this->data['modules'][$module]['products'][] = array(
         					'product_id' => $product_info['product_id'],
         					'name'       => $product_info['name']
         				);
         			}
         		}
       
    }

    // add slider effect
		$this->data['slider_effect'] = array();

    $this->data['slider_effect'][] = array(
			'effect' => 'scrollHorz',
			'title'  => 'Horizontal scroll',
		);
		$this->data['slider_effect'][] = array(
			'effect' => 'scrollVert',
			'title'  => 'Vertical scroll',
		);
		$this->data['slider_effect'][] = array(
			'effect' => 'fade',
			'title'  => 'Fade',
		);
		$this->data['slider_effect'][] = array(
			'effect' => 'zoom',
			'title'  => 'Zoom',
		);
		$this->data['slider_effect'][] = array(
			'effect' => 'uncover',
			'title'  => 'Uncover',
		);

		// add slider style
		$this->data['slider_style'] = array();

                $this->data['slider_style'][] = array(
			'style' => 'ys-style-default',
			'title' => 'Default',
		);
		$this->data['slider_style'][] = array(
			'style' => 'ys-style-bubble',
			'title' => 'Bubble',
		);
		
		// add slider color
		$this->data['slider_color'] = array();

                $this->data['slider_color'][] = array(
			'color' => 'ys-color-grey',
			'title' => 'Default (grey)',
		);
		$this->data['slider_color'][] = array(
			'color' => 'ys-color-blue',
			'title' => 'Blue',
		);
		$this->data['slider_color'][] = array(
			'color' => 'ys-color-red',
			'title' => 'Red',
		);
		$this->data['slider_color'][] = array(
			'color' => 'ys-color-green',
			'title' => 'Green',
		);
		$this->data['slider_color'][] = array(
			'color' => 'ys-color-orange',
			'title' => 'Orange',
		);
		$this->data['slider_color'][] = array(
			'color' => 'ys-color-black',
			'title' => 'Black',
		);

		// add slider badge
		$this->data['slider_badge'] = array();

                $this->data['slider_badge'][] = array(
			'badge' => 'ys-badge-no',
			'title' => 'No badge',
		);
		$this->data['slider_badge'][] = array(
			'badge' => 'ys-badge-top',
			'title' => 'Top',
		);
		$this->data['slider_badge'][] = array(
			'badge' => 'ys-badge-new',
			'title' => 'New',
		);
		$this->data['slider_badge'][] = array(
			'badge' => 'ys-badge-hot',
			'title' => 'Hot',
		);
		$this->data['slider_badge'][] = array(
			'badge' => 'ys-badge-best',
			'title' => 'Best',
		);

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'module/yaslider.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/yaslider')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>