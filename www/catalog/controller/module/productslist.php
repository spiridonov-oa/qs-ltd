<?php  
class ControllerModuleProductslist extends Controller {
    public function index() {
        $this->load->model('catalog/product');
        $this->data['heading_title'] = 'Products List';

        $products = $this->model_catalog_product->getProducts();

        $this->data['products'] = $products;

        $this->data['http_path'] = 'http://qs-ltd.com/image/';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/productslist.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/productslist.tpl';
		} else {
			$this->template = 'default/template/module/productslist.tpl';
		}

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_bottom',
            'common/content_top',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
	}
}
?>