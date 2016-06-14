<?php   
class ControllerErrorNotFound extends Controller {
	public function index() {		
		$this->language->load('error/not_found');

          //djb log the error
			if(isset($_SERVER['REMOTE_ADDR']))
				$ip = $_SERVER['REMOTE_ADDR'];
			if(isset($_SERVER['HTTP_REFERER']))
				$referer = $_SERVER['HTTP_REFERER'];
			if(isset($_SERVER['HTTP_USER_AGENT']))
				$browser = $_SERVER['HTTP_USER_AGENT'];
			if(isset($_SERVER['REQUEST_URI']))
				$request_uri = $_SERVER['REQUEST_URI'];
			$datetime = date("h:m:s - d/m/y");
			
			
			if(!empty($referer))
				$referer = "<a href='$referer'  rel='nofollow'>$referer</a>";
			
			if(!$ip)
				$ip = "-";
			if(empty($referer))
				$referer = "-";
			if(!$browser)
				$browser = "-";
			if(empty($referer))
				$referer = "-";
			if(!$datetime)
				$datetime = "-";
				
			
				
			$log_line = "<tr><td>$datetime</td><td>$ip</td><td>$browser</td><td>$referer</td><td>$request_uri</td></tr>";
			
			if(!is_file("404_log.html"))
			{
				$head = '<html>
<head>
<link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet">
</head>
<table class="table table-striped table-bordered">
<thead>
<tr><td>Time</td><td>IP</td><td>Browser</td><td>Referer URL</td><td>URL Requested</td></tr>
</thead>
<tbody>';
				$handle = fopen("404_log.html", 'a+');
				fwrite($handle, $head); //write new time
				fclose($handle);
			}
			
			$handle = fopen("404_log.html", 'a+');
			fwrite($handle, $log_line); //write new time
			fclose($handle);
	
			//send an email once a day
			//if 24 hours passed since last email
			$f_time = @filemtime("last_email");
			if(!($f_time))
				$f_time=0;
				
			if($f_time<(time()-86400))
			{
				$message = "You have 404 Errors on http://".$_SERVER['SERVER_NAME']." Click here to view http://".$_SERVER['SERVER_NAME']."/404_log.html";
				mail('your@email.com', '404 Errors', $message);

				$handle = fopen("last_email", 'w+');
				fwrite($handle, "1"); //write new time
				fclose($handle);
	
			}
			
                        
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();
 
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);		
		
		if (isset($this->request->get['route'])) {
			$data = $this->request->get;
			
			unset($data['_route_']);
			
			$route = $data['route'];
			
			unset($data['route']);
			
			$url = '';
			
			if ($data) {
				$url = '&' . urldecode(http_build_query($data, '', '&'));
			}	
			
			if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
				$connection = 'SSL';
			} else {
				$connection = 'NONSSL';
			}
											
       		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link($route, $url, $connection),
        		'separator' => $this->language->get('text_separator')
      		);	   	
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_error'] = $this->language->get('text_error');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');
		
		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
		} else {
			$this->template = 'default/template/error/not_found.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
		
		$this->response->setOutput($this->render());
  	}
}
?>