<?php
class ModelCatalogBatchEditorProducts extends Model {
	public function quickEditProduct($product_id, $value, $action) {
		if ($action == 'name' && $value) {
			$this->db->query('UPDATE ' . DB_PREFIX . 'product_description SET name = "' . $this->db->escape($value) . '" WHERE product_id = ' . (int) $product_id . ' AND language_id = ' . (int) $this->config->get('config_language_id'));
			
			$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id = ' . (int) $product_id);
			
			$value = html_entity_decode ($value, ENT_QUOTES, 'UTF-8');
		} else if ($action == 'url_alias') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . $product_id . "'");
			
			if ($value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET keyword = '" . $this->db->escape($value) . "', query = 'product_id=" . $product_id . "'");
			}
			
			$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id = ' . (int) $product_id);
			
			$value = html_entity_decode ($value, ENT_QUOTES, 'UTF-8');
		} else {
			$actions = array (
				'price'        => array ('f' => 'price'          , 't' => 'num_format', 'num' => 4),
				'sort_order'   => array ('f' => 'sort_order'     , 't' => 'int'),
				'model'        => array ('f' => 'model'          , 't' => 'text'),
				'sku'          => array ('f' => 'sku'            , 't' => 'text'),
				'image'        => array ('f' => 'image'          , 't' => 'text'),
				'quantity'     => array ('f' => 'quantity'       , 't' => 'int'),
				'manufacturer' => array ('f' => 'manufacturer_id', 't' => 'int'),
				'stock_status' => array ('f' => 'stock_status_id', 't' => 'int'),
				'status'       => array ('f' => 'status'         , 't' => 'int'),
				'upc'          => array ('f' => 'upc'            , 't' => 'text'),
				'location'     => array ('f' => 'location'       , 't' => 'text'),
				'minimum'      => array ('f' => 'minimum'        , 't' => 'int'),
				'subtract'     => array ('f' => 'subtract'       , 't' => 'int'),
				'shipping'     => array ('f' => 'shipping'       , 't' => 'int'),
				'tax_class'    => array ('f' => 'tax_class_id'   , 't' => 'int'),
				'points'       => array ('f' => 'points'         , 't' => 'int'),
				'weight'       => array ('f' => 'weight'         , 't' => 'num_format', 'num' => (VERSION < '1.5.2') ? 2 : 8),
				'weight_class' => array ('f' => 'weight_class_id', 't' => 'int'),
				'length'       => array ('f' => 'length'         , 't' => 'num_format', 'num' => (VERSION < '1.5.2') ? 2 : 8),
				'width'        => array ('f' => 'width'          , 't' => 'num_format', 'num' => (VERSION < '1.5.2') ? 2 : 8),
				'height'       => array ('f' => 'height'         , 't' => 'num_format', 'num' => (VERSION < '1.5.2') ? 2 : 8),
				'length_class' => array ('f' => 'length_class_id', 't' => 'num_format', 'num' => (VERSION < '1.5.2') ? 2 : 8)
			);
			
			if (isset ($actions[$action])) {
				if ($actions[$action]['t'] == 'text') {
					if ($action != 'model' || ($action == 'model' && $value)) {
						$this->db->query('UPDATE ' . DB_PREFIX . 'product SET ' . $actions[$action]['f'] . ' = "' . $this->db->escape($value) . '", date_modified = NOW() WHERE product_id = ' . (int) $product_id);
					}
					
					if ($action == 'image') {
						$this->load->model('tool/image');
						
						$value = $this->model_tool_image->resize($value, 40, 40);
					} else {
						$value = html_entity_decode ($value, ENT_QUOTES, 'UTF-8');
					}
				} else {
					if ($actions[$action]['t'] == 'int') {
						$value = (int) $value;
					}
					
					if ($actions[$action]['t'] == 'float') {
						$value = (float) $value;
					}
					
					if ($actions[$action]['t'] == 'num_format') {
						$value = number_format ((float) $value, $actions[$action]['num'], '.', FALSE);
					}
					
					$this->db->query('UPDATE ' . DB_PREFIX . 'product SET ' . $actions[$action]['f'] . ' = "' . $value . '", date_modified = NOW() WHERE product_id = ' . (int) $product_id);
				}
			}
		}
		
		return $value;
	}
	
	public function getProducts($data = array ()) {
		$sql = "SELECT ";
		
		if (in_array ('image', $data['filter_columns'])) $sql .= "p.image AS image, ";
		if (in_array ('sort_order', $data['filter_columns'])) $sql .= "p.sort_order AS sort_order, ";
		if (in_array ('manufacturer', $data['filter_columns'])) $sql .= "m.name AS manufacturer, ";
		if (in_array ('model', $data['filter_columns'])) $sql .= "p.model AS model, ";
		if (in_array ('sku', $data['filter_columns'])) $sql .= "p.sku AS sku, ";
		if (in_array ('upc', $data['filter_columns'])) $sql .= "p.upc AS upc, ";
		if (in_array ('location', $data['filter_columns'])) $sql .= "p.location AS location, ";
		if (in_array ('quantity', $data['filter_columns'])) $sql .= "p.quantity AS quantity, ";
		if (in_array ('minimum', $data['filter_columns'])) $sql .= "p.minimum AS minimum, ";
		if (in_array ('stock_status', $data['filter_columns'])) $sql .= "ss.name AS stock_status, ";
		if (in_array ('subtract', $data['filter_columns'])) $sql .= "p.subtract AS subtract, ";
		if (in_array ('status', $data['filter_columns'])) $sql .= "p.status AS status, ";
		if (in_array ('shipping', $data['filter_columns'])) $sql .= "p.shipping AS shipping, ";
		if (in_array ('price', $data['filter_columns'])) $sql .= "p.price AS price, ";
		if (in_array ('tax_class', $data['filter_columns'])) $sql .= "tc.title AS tax_class, ";
		if (in_array ('points', $data['filter_columns'])) $sql .= "p.points AS points, ";
		if (in_array ('weight', $data['filter_columns'])) $sql .= "p.weight AS weight, ";
		if (in_array ('weight_class', $data['filter_columns'])) $sql .= "wcd.title AS weight_class, ";
		if (in_array ('length', $data['filter_columns'])) $sql .= "p.length AS length, ";
		if (in_array ('width', $data['filter_columns'])) $sql .= "p.width AS width, ";
		if (in_array ('height', $data['filter_columns'])) $sql .= "p.height AS height, ";
		if (in_array ('length_class', $data['filter_columns'])) $sql .= "lcd.title AS length_class, ";
		if (in_array ('url_alias', $data['filter_columns'])) $sql .= "ua.keyword AS url_alias, ";
		
		$sql .= "p.product_id AS product_id, pd.name AS name ";
		
		$sql .= "FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) ";
		
		if (in_array ('tax_class', $data['filter_columns'])) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "tax_class tc ON (p.tax_class_id = tc.tax_class_id) ";
		}
		
		if (in_array ('weight_class', $data['filter_columns'])) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "weight_class_description wcd ON (p.weight_class_id = wcd.weight_class_id AND wcd.language_id = '" . (int) $this->config->get('config_language_id') . "') ";
		}
		
		if (in_array ('length_class', $data['filter_columns'])) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "length_class_description lcd ON (p.length_class_id = lcd.length_class_id AND lcd.language_id = '" . (int) $this->config->get('config_language_id') . "') ";
		}
		
		if (in_array ('manufacturer', $data['filter_columns'])) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) ";
		}
		
		if (in_array ('stock_status', $data['filter_columns'])) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "stock_status ss ON (p.stock_status_id = ss.stock_status_id AND ss.language_id = '" . (int) $this->config->get('config_language_id') . "') ";
		}
		
		if (in_array ('url_alias', $data['filter_columns'])) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "url_alias ua ON (ua.query = CONCAT('product_id=', p.product_id)) ";
		}
		
		$sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";
		
		$sql .= $this->getFilterSql($data);
		
		$sql .= " GROUP BY p.product_id";
		
		$sql .= (isset ($data['sort']) && in_array ($data['sort'], $data['sorts'])) ? " ORDER BY " . $data['sort'] : " ORDER BY pd.name";
		
		$sql .= (isset ($data['order']) && ($data['order'] == 'DESC')) ? " DESC" : " ASC";
		
		if (isset ($data['start']) || isset ($data['limit'])) {
			$data['start'] = ($data['start'] < 0) ? 0  : $data['start'];
			$data['limit'] = ($data['limit'] < 1) ? 20 : $data['limit'];
			
			$sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
		}
		
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	
	public function getTotalProducts($data = array ()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";
		
		$sql .= $this->getFilterSql($data);
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}
	
	private function getFilterSql($data = array ()) {
		$sql = FALSE;
		
		if (!empty ($data['filter_keyword'])) {
			$implode = array ();
			
			if (isset ($data['filter_search_in']['exact_entry'])) {
				$words[] = $data['filter_keyword'];
			} else {
				$words = explode (' ', $data['filter_keyword']);
			}
			
			$fields = array ('name' => 'pd', 'description' => 'pd', 'model' => 'p', 'sku' => 'p', 'upc' => 'p', 'location' => 'p');
			
			foreach ($fields as $key => $field) {
				if (isset ($data['filter_search_in'][$key])) {
					foreach ($words as $word) {
						$implode[] = "LCASE(" . $field . "." . $key . ") LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";
					}
				}
			}
			
			$sql .= ($implode) ? " AND ( " . implode (" OR ", $implode) . ") " : FALSE;
		}
		
		$fields_1 = array ('price', 'quantity', 'sort_order', 'minimum', 'points', 'weight', 'length', 'width', 'height');
		
		foreach ($fields_1 as $field) {
			$sql .= (isset ($data['filter_' . $field]['min'])) ? " AND p." . $field . " >= '" . (float) $data['filter_' . $field]['min'] . "'" : FALSE;
			$sql .= (isset ($data['filter_' . $field]['max'])) ? " AND p." . $field . " <= '" . (float) $data['filter_' . $field]['max'] . "'" : FALSE;
		}
		
		$sql .= (isset ($data['filter_status'  ])) ? " AND p.status   = '" . (int) $data['filter_status'  ] . "'" : FALSE;
		$sql .= (isset ($data['filter_subtract'])) ? " AND p.subtract = '" . (int) $data['filter_subtract'] . "'" : FALSE;
		$sql .= (isset ($data['filter_shipping'])) ? " AND p.shipping = '" . (int) $data['filter_shipping'] . "'" : FALSE;
		
		$fields_2 = array ('attribute' => 'attribute', 'to_category' => 'category', 'manufacturer', 'tax_class', 'stock_status', 'weight_class', 'length_class');
		
		foreach ($fields_2 as $key => $field) {
			if (is_integer ($key)) {
				$sql .= (!empty ($data['filter_' . $field]) || $data['filter_' . $field][0] == '0') ? " AND p." . $field . "_id " . $data['filter'][$field . '_not'] . " IN (" . $data['filter_' . $field] . ")" : FALSE;
			} else {
				$sql .= (!empty ($data['filter_' . $field])) ? " AND p.product_id " . $data['filter'][$field . '_not'] . " IN (SELECT product_id FROM " . DB_PREFIX . "product_" . $key . " WHERE " . $field . "_id IN (" . $data['filter_' . $field] . "))" : FALSE;
				
				$sql .= (empty ($data['filter_' . $field]) && $data['filter'][$field . '_not']) ? " AND p.product_id " . $data['filter'][$field . '_not'] . " IN (SELECT product_id FROM " . DB_PREFIX . "product_" . $key . ")" : FALSE;
			}
		}
		
		return $sql;
	}
}
?>