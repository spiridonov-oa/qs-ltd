<?php  
class ControllerModuleLanguage extends Controller {
	protected function index() {
    	if (isset($this->request->post['language_code'])) {
			$this->session->data['language'] = $this->request->post['language_code'];
		
			if (isset($this->request->post['redirect'])) {
				
                $url = $this->request->post['redirect'];
                $url = preg_replace('/'.addcslashes($this->request->server['HTTP_HOST'], '.-/').'\/[a-z]{2}\//', $this->request->server['HTTP_HOST'] . '/', $url);
                $url = str_replace($this->request->server['HTTP_HOST'], $this->request->server['HTTP_HOST']. '/'.$this->session->data['language'], $url);
                $this->redirect($url);
            
			} else {
				$this->redirect($this->url->link('common/home'));
			}
    	}		
		
		$this->language->load('module/language');
		
		$this->data['text_language'] = $this->language->get('text_language');
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$connection = 'SSL';
		} else {
			$connection = 'NONSSL';
		}
			
		$this->data['action'] = $this->url->link('module/language', '', $connection);

		$this->data['language_code'] = $this->session->data['language'];
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = array();
		
		$results = $this->model_localisation_language->getLanguages();
		
		
        foreach ($results as $result) {
            if (!isset($this->request->get['_route_'])) {
                $link = $this->request->server['HTTP_HOST'] . '/' . $result['code'];
            } else {
                $url = $this->request->get['_route_'];
                $pos = strpos($this->request->get['_route_'], '/');
                if($pos == 2){
                    $url = substr($url, 3);
                }
                 $link = $this->request->server['HTTP_HOST'] . '/' . $result['code'] . '/' . $url;
            }
            $link = 'http://' . $link;
			if ($result['status']) {
				$this->data['languages'][] = array(
					'name'  => $result['name'],
					'code'  => $result['code'],
                    'link'  => $link,
					'image' => $result['image']
				);
			}
		}
            









		if (!isset($this->request->get['route'])) {
			$this->data['redirect'] = $this->url->link('common/home');
		} else {
			$data = $this->request->get;
			
			unset($data['_route_']);
			
			$route = $data['route'];
			
			unset($data['route']);
			
			$url = '';
			
			if ($data) {
				$url = '&' . urldecode(http_build_query($data, '', '&'));
			}	
					
			$this->data['redirect'] = $this->url->link($route, $url, $connection);
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/language.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/language.tpl';
		} else {
			$this->template = 'default/template/module/language.tpl';
		}
		
		$this->render();
	}
}
?>