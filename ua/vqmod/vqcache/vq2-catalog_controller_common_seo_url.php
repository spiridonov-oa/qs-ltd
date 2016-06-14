<?php
class ControllerCommonSeoUrl extends Controller {
	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		// Decode URL
		if (isset($this->request->get['_route_'])) {
			
                $parts = explode('/', trim($this->request->get['_route_'], '/'));
                if(!empty($parts[0]) && preg_match('/^[a-z]{2}$/iu', $parts[0])) {
                    array_shift($parts);
                }
            
			
			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
				
				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);
					
					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}
					
					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}	
					
					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}
					
					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}	
				} else {
					

                if(!isset($this->request->get['route'])){
                    $route = '';
                    foreach($parts as $part) {
                        $route .= '/' . $part;
                    }
                    $route = substr($route, 1);
                    $this->request->get['route'] = $route;
                }
            
                if(empty($this->request->get['route'])) {
                    $this->request->get['route'] = 'error/not_found';
                }
            	
				}
			}
			
			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			}
			
			if (isset($this->request->get['route'])) {
				return $this->forward($this->request->get['route']);
			}
		}

        if (isset($this->request->get['route'])) {
            return $this->forward($this->request->get['route']);
        }
            
	}
	
	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));
	
		$url = ''; 
		
		$data = array();
		
		parse_str($url_info['query'], $data);
		
		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
				
					if ($query->num_rows) {

                        if ($data['route'] == 'product/product') {
                            $url = $this->getProductPath($value);
                            unset($data['path']);
                        }
            
						$url .= '/' . $query->row['keyword'];
						
						unset($data[$key]);
					}					
				} elseif ($key == 'path') {
					$categories = explode('_', $value);
					
					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
				
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
						}							
					}
					
					unset($data[$key]);
				}
			}
		}
	

                if (isset($data['route']) && $url == '') {
                    $url = '/' . $data['route'];
                }
            
		if ($url) {
			unset($data['route']);

            if ($url == '/common/home') {
                $url = '';
            }
            if (substr($url, -1) != '/') {
                $url .= '/';
            }
            
		
			$query = '';
		
			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . $key . '=' . $value;
				}
				
				if ($query) {
					$query = '?' . trim($query, '&');
				}
			}

			
                return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . '/' . $this->session->data['language'] . $url . $query;
            
		} else {
			return $link;
		}
	}	
                private function getProductPath ($productId) {
                    $this->load->model('catalog/product');
                    $this->load->model('catalog/category');
                    $path = '';
                    $categories = $this->model_catalog_product->getCategories($productId);

                    if(!empty($categories)) {
                        $product_categories = array();
                        foreach ($categories as $category) {
                            $product_categories[$category['category_id']] = $this->getFullCategoryPath($category['category_id']);
                        }

                        foreach ($product_categories as $category_path) {
                            if(strlen($path) < strlen($category_path)) {
                                $path = $category_path;
                            }
                        }
                    }

                    return $path;
                }

                private function getFullCategoryPath ($category_id) {
                    $category_path = '';
                    if($category_id != 0) {
                        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category_id . "'");
                        if ($query->num_rows) {
                            //$category_path[$category_id] = '/' . $query->row['keyword'];
                            $path = '/' . $query->row['keyword'];
                        } else {
                            //$category_path[$category_id] = '/' . 'unnamed_category';
                            $path = '/' . 'unnamed_category';
                        }

                        $category = $this->model_catalog_category->getCategory($category_id);
                        if(isset($category['parent_id'])) {
                            $category_path = $this->getFullCategoryPath($category['parent_id']) . $path;
                        }
                    }

                    return $category_path;
                }
            
}
?>