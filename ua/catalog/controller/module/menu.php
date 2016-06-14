<?php  
class ControllerModuleMenu extends Controller {
	
	protected function index($setting) {
		static $module = 0;
		$this->load->model('menu/menus');
		$this->load->model('menu/menuitems');
		$menu_id=$setting['menu_id'];
		$menu_data=array();
			
    		$this->data['class']=$this->model_menu_menus->getMenuClass($setting['menu_id']);
    		$menuitem_data = $this->cache->get('menuitems_front.' . (int)$this->config->get('config_language_id') . '.' . (int)$setting['menu_id']);
    		if (!$menuitem_data) {
    			$menuitem_data=$this->model_menu_menuitems->getMenuitems(0,$setting['menu_id']);
    			$this->cache->set('menuitems_front.' . (int)$this->config->get('config_language_id') . '.' . (int)$setting['menu_id'], $menuitem_data);
    		}
    		$menu_data = $this->model_menu_menuitems->getMenuitems(0,$setting['menu_id']);

            $categories_sort_order = 0; // Categories order in menu. Start from '0'
            array_splice($menu_data, $categories_sort_order, 0, $this->getCategories());


    		$this->data['menuitems']=$menuitem_data;
    		$this->data['menu'] = $this->drawMenu($menu_data);
    		$this->data['module'] = $module++;

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/menu.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/menu.tpl';
			} else {
				$this->template = 'default/template/module/menu.tpl';
			}

            $this->children = array(
                'module/cart',
            );

			$this->render();
  	}

  	public function drawMenu($menuitems, $class=array('ulclass'=>'menu', 'liclass'=>'menu-li' )){
  		$toprint="";
  		foreach($menuitems as $menuitem){
  			$toprint.="<li class='".$class['liclass']." ".$menuitem['menu_class']."' ><a href='".$menuitem['menu_link']."'>".$menuitem['menu_name']."</a>";
  			if(count($menuitem['children'])){
  			    $saved_class = $class;
  				$class['liclass'].="-sub";
  				$class['ulclass'].="-sub";
  				$subitem=$this->drawMenu($menuitem['children'], $class);
  				$toprint.="<div class=\"dropdown-container\"><div class=\"dropdown clearafter\" ><ul class='".$class['ulclass']."'>".$subitem."</ul></div></div>";
  			    $class = $saved_class;
  			}
  			$toprint.="</li>";
  		}
  		return $toprint;
  	}

  	private function getCategories () {
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $categories_data =  array();

        $categories = $this->model_catalog_category->getCategories(0);

        foreach ($categories as $category) {
            if ($category['top']) {
                // Level 2
                $sub_category_data = array();

                $sub_categories = $this->model_catalog_category->getCategories($category['category_id']);

                foreach ($sub_categories as $sub_category) {
                    $children_data = array();

                    $children = $this->model_catalog_category->getCategories($sub_category['category_id']);

                    foreach ($children as $child) {
                        $data = array(
                            'filter_category_id'  => $child['category_id'],
                            'filter_sub_category' => true
                        );

                        //$product_total = $this->model_catalog_product->getTotalProducts($data);

                        $children_data[] = array(
                            //'menu_name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
                            'menu_name'  => $child['name'],
                            'menu_class' => 'sub-category',
                            'children'   => array(),
                            'menu_link'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $sub_category['category_id'] . '_' . $child['category_id'])
                        );
                    }

                    $data = array(
                        'filter_category_id'  => $sub_category['category_id'],
                        'filter_sub_category' => true
                    );

                    //$product_total = $this->model_catalog_product->getTotalProducts($data);

                    $sub_category_data[] = array(
                        //'menu_name'     => $sub_category['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
                        'menu_name'     => $sub_category['name'],
                        'menu_class'    => 'sub-category',
                        'children'      => $children_data,
                        'menu_link'     => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $sub_category['category_id'])
                    );
                }
                // Level 1
                $categories_data[] = array(
                    'menu_name'     => $category['name'],
                    'menu_class'    => '',
                    'children'      => $sub_category_data,
                    'menu_link'     => $this->url->link('product/category', 'path=' . $category['category_id'])
                );
            }
        }
        return $categories_data;
  	}
}
?>