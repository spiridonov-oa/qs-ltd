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

		$this->data['parts'] = $parts;
		
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
            $this->data['sub_child_id'] = $parts[2];
        } else {
            $this->data['sub_child_id'] = 0;
        }

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->data['categories'] = array();
        $this->data['categories'] =  $this->getSubCategories(0, false);
        /*
		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));

			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach ($children as $child) {
				$data = array(
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				);

				$product_total = $this->model_catalog_product->getTotalProducts($data);

				$total += $product_total;

				$children_data[] = array(
					'category_id' => $child['category_id'],
					'name'        => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
					'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
				);
			}

			$this->data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $total . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}
*/
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category.tpl';
		} else {
			$this->template = 'default/template/module/category.tpl';
		}

		$this->render();
  	}

  	private function getSubCategories($category_id, $path) {
  	    $category_data = array();

  	    if($category_id == 0) {
            $path = '';
        } else {
             if($path == '') {
                 $path = $category_id;
             } else {
                 $path .= '_' . $category_id;
             }

        }

  	    $categories = $this->model_catalog_category->getCategories($category_id);

  	    foreach ($categories as $category) {

            $data = array(
                'filter_category_id'  => $category['category_id'],
                'filter_sub_category' => true
            );
            //$product_total = $this->model_catalog_product->getTotalProducts($data);

            if($path == '') {
                $category_path = $category['category_id'];
            } else {
                $category_path = $path . '_' . $category['category_id'];
            }

            $children_data = $this->getSubCategories($category['category_id'], $path);


            $active =  false;
            if(in_array($category['category_id'], $this->data['parts'])) {
                $active = true;
            }

            foreach($children_data as $children){
                if($children['active'] == true) {
                    $active = true;
                }
            }

            $category_data[] = array(
                'category_id' => $category['category_id'],
                'name'        => $category['name'],// . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
                'children'    => $children_data,
                'active'      => $active,
                'href'        => $this->url->link('product/category', 'path=' . $category_path)
            );
        }

        return $category_data;
  	}

  	private function isCategoryActive($category_id) {
        if(in_array($this->data['parts'], $category_id)) {
            return true;
        }
  	    return false;
  	}

}
?>