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
		
		if (isset($parts[1])) {
			$this->data['child_id'] = $parts[1];
		} else {
			$this->data['child_id'] = 0;
		}
      if (isset($parts[2])) {
         $this->data['sisters_id'] = $parts[2];
      } else {
         $this->data['sisters_id'] = 0;
      }  
							
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));

			$children_data = array();
             $sister_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			             foreach ($children as $child) {           
                $sister_data = array();
                $sisters = $this->model_catalog_category->getCategories($child['category_id']);
                if($sisters) {
                   foreach ($sisters as $sisterMember) {
                      $sister_data[] = array(
                         'category_id' =>$sisterMember['category_id'],
                         'name'        => $sisterMember['name'],
                         'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']. '_' . $sisterMember['category_id'])   
                      );                     
                                 
                   }
                   $children_data[] = array(
                         'category_id' => $child['category_id'],
                         'sister_id'   => $sister_data,
                         'name'        => $child['name'],
                         'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])   
                      );   
                }else{                     
                   $children_data[] = array(
                      'category_id' => $child['category_id'],
                      'sister_id'    =>'',
                      'name'        => $child['name'],
                      'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])   
                   );   
                }
             } 














			}

			$this->data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $total . ')' : ''),
				'children'    => $children_data,
'sister'    => $sister_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);	
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category.tpl';
		} else {
			$this->template = 'default/template/module/category.tpl';
		}
		
		$this->render();
  	}
}
?>