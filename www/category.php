<?php  
class ControllerModuleCategory extends Controller {
	protected function index($setting) {
		$this->language->load('module/category');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if (isset($parts[0])) {
			$this->data['category_id'] = $parts[0];
		} else {
			$this->data['category_id'] = 0;
		}
							
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->data['categories'] = array();

		$categories = $this->getCategories(0);
    
    foreach ($categories as $category) {
		$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));
			if($total > 0){$varr =  ($this->config->get('config_product_count') ? ' (' . $total  . ')' : '');
			}else{$varr =  "";};

			$this->data['categories'][] = array(
			'category_id' => $category['category_id'],
			'name'        => $category['name'] .$varr,
			'href'        =>  $category['href']
			)
			
		;	
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category.tpl';
		} else {
			$this->template = 'default/template/module/category.tpl';
		}
		
		$this->render();
  	}    
    
    function getCategories($parent_id, $_path="", $space = "", $trees = array())
    {
        if(!$trees)
        {
            $trees = array();
        }
        $categories = $this->model_catalog_category->getCategories($parent_id);
        foreach ($categories as $category)
        {  
            if ($parent_id == 0) {            
              $trees[] = array( 'category_id' => $category['category_id'],
				                        'name'        => $space . $category['name'],
				                        'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
                                  );
              
              $path = $category['category_id'];
            }
            else {            
              $trees[] = array( 'category_id' => $category['category_id'],
				                        'name'        => $space . '- ' . $category['name'],
				                        'href'        => $this->url->link('product/category', 'path=' . $_path . '_' . $category['category_id'])
                                  );
            
              $path = $_path . '_' . $category['category_id'];
            }
            
            $trees = $this->getCategories($category['category_id'], $path, $space.'&nbsp;&nbsp;&nbsp;', $trees);
        }
        return $trees;
    }
}
?>