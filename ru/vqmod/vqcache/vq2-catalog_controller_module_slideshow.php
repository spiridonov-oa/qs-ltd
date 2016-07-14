<?php  
class ControllerModuleSlideshow extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('design/banner');
		$this->load->model('tool/image');
		
		//$this->document->addScript('catalog/view/javascript/fractionslider/jquery.fractionslider.js');

		//$this->document->addStyle('catalog/view/javascript/fractionslider/css/fractionslider.css');

		$this->data['banners'] = array();

		if (isset($setting['banner_id'])) {
			$results = $this->model_design_banner->getBanner($setting['banner_id']);

			foreach ($results as $result) {
				if (file_exists(DIR_IMAGE . $result['image'])) {
					$this->data['banners'][] = array(
						'title' => $result['title'],
						'link'  => $result['link'],
						'image' => 'image/'.$result['image'],
'banner_link_description' => $result['banner_link_description']
					);
				}
			}
		}

		$this->data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/fractionslider.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/fractionslider.tpl';
		} else {
			$this->template = 'default/template/module/fractionslider.tpl';
		}
		
		$this->render();
	}
}
?>