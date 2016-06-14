<?php
class ModelCatalogBatchEditorProductEdit extends Model {
	public function Copy($products, $copies, $action) {
		if ($action == 'copy') {
			$this->load->model('catalog/product');
			
			$copies = abs ((int) $copies);
			
			if (!$copies) {
				$copies = 1;
			}
			
			for ($i = 0; $i < $copies; $i++) {
				foreach ($products as $product_id) {
					$this->model_catalog_product->copyProduct((int) $product_id);
				}
			}
		}
	}
	
	public function Delete($products, $delete, $action) {
		$this->load->model('catalog/product');
		
		if ($action == 'delete') {
			foreach ($products as $product_id) {
				$this->model_catalog_product->deleteProduct((int) $product_id);
			}
		}
	}
	
	public function Manufacturer($products, $manufacturer, $action) {
		$product_id = implode (', ', $products);
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET manufacturer_id = ' . $manufacturer . ', date_modified = NOW() WHERE product_id IN (' . $product_id . ')');
	}
	
	public function Status($products, $status, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET status=' . (int) $status . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Stock_Status($products, $stock_status, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET stock_status_id = ' . $stock_status . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Price($products, $price, $action) {
		$sql = array (
			'equal_number'    => $price,
			'plus_number'     => '(price + ' . $price . ')',
			'minus_number'    => '(price - ' . $price . ')',
			'multiply_number' => '(price * ' . $price . ')',
			'divide_number'   => '(price / ' . $price . ')',
			'plus_percent'    => '(price * ' . (100 + $price) * 0.01 . ')',
			'minus_percent'   => '(price * ' . (100 - $price) * 0.01 . ')'
		);
		
		$price_action = (isset ($this->request->post['product_price_action'])) ? (string) $this->request->post['product_price_action'] : FALSE;
		
		if (isset ($sql[$price_action])) {
			$this->db->query('UPDATE ' . DB_PREFIX . 'product SET price = ' . $sql[$price_action] . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
		}
	}
	
	public function Tax_Class($products, $tax_class_id, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET tax_class_id = ' . (int) $tax_class_id . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Weight_Class($products, $weight_class_id, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET weight_class_id = ' . (int) $weight_class_id . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Weight($products, $weight, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET weight = ' . (float) $weight . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Length_Class($products, $length_class_id, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET length_class_id = ' . (int) $length_class_id . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Length($products, $length, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET length = ' . (float) $length . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Width($products, $width, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET width = ' . (float) $width . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Height($products, $height, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET height = ' . (float) $height . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Quantity($products, $quantity, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET quantity = ' . (int) $quantity . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Minimum($products, $minimum, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET minimum = ' . (int) $minimum . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Points($products, $points, $action) {
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET points = ' . (int) $points . ', date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Descriptions ($products, $descriptions, $action) {
		foreach ($products as $product_id) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int) $product_id . "'");
			
			foreach ($descriptions['descriptions'] as $language_id => $value) {
				$sql = "INSERT INTO " . DB_PREFIX . "product_description SET name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "',tag = '" . $descriptions['tags'][$language_id] . "', product_id = '" . (int) $product_id . "', language_id = '" . (int) $language_id . "'";
				
				if (isset ($value['seo_title']) && isset ($value['seo_h1'])) {
					$sql .= ", seo_title = '" . $this->db->escape($value['seo_title']) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "'";
				}
				
				$this->db->query($sql);
			}
			

			

		}
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Categories($products, $categories, $action) {
		if ($action == 'upd') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id IN (" . implode (', ', $products) . ")");
		}
		
		if ($action == 'del') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id IN (" . implode (', ', $products) . ") AND category_id IN (" . implode (', ', $categories) . ")");
		}
		
		if ($action == 'add' || $action == 'upd') {
			foreach ($products as $product_id) {
				foreach ($categories as $key => $category_id) {
					if ($action == 'add') {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "' AND category_id = '" . (int) $category_id . "'");
						
						if (!$query->num_rows) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . (int) $category_id . "'");
						}
					}
					
					if ($action == 'upd') {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . (int) $category_id . "'");
					}
				}
			}
		}
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Attributes($products, $attributes, $action) {
		if ($action == 'upd') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id IN (" . implode (', ', $products) . ")");
		}
		
		foreach ($products as $product_id) {
		
			foreach ($attributes as $attribute) {
				if ($attribute['attribute_id']) {
					foreach ($attribute['product_attribute_description'] as $language_id => $attribute_description) {
						if ($action == 'del') {
							$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "' AND attribute_id = '" . (int) $attribute['attribute_id'] . "'");
						}
						
						if ($action == 'add' || $action == 'upd') {
							$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "' AND attribute_id = '" . (int) $attribute['attribute_id'] . "' AND language_id = '" . (int) $language_id  . "'");
							
							if (!$query->num_rows) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int) $product_id . "', attribute_id = '" . (int) $attribute['attribute_id'] . "', language_id = '" . (int) $language_id  . "', text = '" . $this->db->escape($attribute_description['text']) . "'");
							} else {
								$this->db->query("UPDATE " . DB_PREFIX . "product_attribute SET text = '" . $this->db->escape($attribute_description['text']) . "' WHERE attribute_id = '" . (int) $attribute['attribute_id'] . "' AND product_id = '" . (int) $product_id . "' AND language_id  = '" . (int) $language_id . "'");
							}
						}
					}
				}
			}
		}
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Options($products, $options, $action) {
		if ($action == 'upd') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id IN (" . implode (', ', $products) . ")");
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id IN (" . implode(', ', $products) . ")");
		}
		
		foreach ($products as $product_id) {
			foreach ($options as $option) {
				if ($action == 'del') {
					$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int) $product_id . "' AND option_id = '" . (int) $option['option_id'] . "'");
					$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int) $product_id . "' AND option_id = '" . (int) $option['option_id'] . "'");
				} else {
					if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int) $option['product_option_id'] . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option['option_id'] . "', required = '" . (int) $option['required'] . "'");
						
						$option_id = $this->db->getLastId();
						
						if (isset($option['product_option_value'])) {
							foreach ($option['product_option_value'] as $option_value) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_value_id = '" . (int) $option_value['product_option_value_id'] . "', product_option_id = '" . (int) $option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option['option_id'] . "', option_value_id = '" . $this->db->escape($option_value['option_value_id']) . "', quantity = '" . (int) $option_value['quantity'] . "', subtract = '" . (int) $option_value['subtract'] . "', price = '" . (float) $option_value['price'] . "', price_prefix = '" . $this->db->escape($option_value['price_prefix']) . "', points = '" . (int) $option_value['points'] . "', points_prefix = '" . $this->db->escape($option_value['points_prefix']) . "', weight = '" . (float) $option_value['weight'] . "', weight_prefix = '" . $this->db->escape($option_value['weight_prefix']) . "'");
							}
						}
					} else { 
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int) $option['product_option_id'] . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option['option_id'] . "', option_value = '" . $this->db->escape($option['option_value']) . "', required = '" . (int) $option['required'] . "'");
					}
				}
			}
		}
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id IN (' . implode (', ', $products) . ')');
	}
	
	public function Specials($products, $specials, $action) {
		$product_id = implode (', ', $products);
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id IN (" . $product_id . ")");
		
		if ($action == 'add') {
			$product_data_1 = $this->db->query("SELECT product_id, price FROM " . DB_PREFIX . "product WHERE product_id IN (" . $product_id . ")")->rows;
			
			foreach($product_data_1 as $product_data) {
				foreach ($specials as $special) {
					if ($special['action'] == 'equal_number') {
						$product_data['special'] = (float) $special['special'];
					} else if ($special['action'] == 'minus_number') {
						$product_data['special'] = $product_data['price'] - (float) $special['special'];
					} else if ($special['action'] == 'minus_percent') {
						$product_data['special'] = $product_data['price'] * (100 - (float) $special['special']) * 0.01;
					} else {
						$product_data['special'] = FALSE;
					}
					
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int) $product_data['product_id'] . "', customer_group_id = '" . (int) $special['customer_group_id'] . "', priority = '" . (int) $special['priority'] . "', price = '" . (float) $product_data['special'] . "', date_start  = '" . $this->db->escape($special['date_start']) . "', date_end = '" . $this->db->escape($special['date_end']) . "'");
				}
			}
		}
		
		if ($action == 'upd') {
			foreach ($specials as $special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $special['customer_group_id'] . "', priority = '" . (int) $special['priority'] . "', price = '" . (float) $special['special'] . "', date_start = '" . $this->db->escape($special['date_start']) . "', date_end = '" . $this->db->escape($special['date_end']) . "'");
			}
		}
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id IN (' . $product_id . ')');
	}
	
	public function Discounts($products, $discounts, $action) {
		$product_id = implode (', ', $products);
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id IN (" . $product_id . ")");
		
		if ($action == 'add') {
			$product_data_1 = $this->db->query("SELECT product_id, price FROM " . DB_PREFIX . "product WHERE product_id IN (" . $product_id . ")")->rows;
			
			foreach($product_data_1 as $product_data) {
				foreach ($discounts as $discount) {
					if ($discount['action'] == 'equal_number') {
						$product_data['discount'] = (float) $discount['discount'];
					} else if ($discount['action'] == 'minus_number') {
						$product_data['discount'] = $product_data['price'] - (float) $discount['discount'];
					} else if ($discount['action'] == 'minus_percent') {
						$product_data['discount'] = $product_data['price'] * (100 - (float) $discount['discount']) * 0.01;
					} else {
						$product_data['discount'] = FALSE;
					}
					
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int) $product_data['product_id'] . "', customer_group_id = '" . (int) $discount['customer_group_id'] . "', quantity = '" . (int) $discount['quantity'] . "', priority = '" . (int) $discount['priority'] . "', price = '" . (float) $product_data['discount'] . "', date_start = '" . $this->db->escape($discount['date_start']) . "', date_end = '" . $this->db->escape($discount['date_end']) . "'");
				}
			}
		}
		
		if ($action == 'upd') {
			foreach ($discounts as $discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $discount['customer_group_id'] . "', quantity = '" . (int) $discount['quantity'] . "', priority = '" . (int) $discount['priority'] . "', price = '" . (float) $discount['discount'] . "', date_start = '" . $this->db->escape($discount['date_start']) . "', date_end = '" . $this->db->escape($discount['date_end']) . "'");
			}
		}
		
		$this->db->query('UPDATE ' . DB_PREFIX . 'product SET date_modified = NOW() WHERE product_id IN (' . $product_id . ')');
	}
	
	public function Related($products, $related, $action) {
		if ($action == 'upd') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id IN (" . implode (', ', $products) . ")");
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id IN (" . implode (', ', $products) . ")");
		}
		
		if ($action == 'del') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id IN (" . implode (', ', $products) . ") AND related_id IN (" . implode (', ', $related) . ")");
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id IN (" . implode (', ', $related) . ") AND related_id IN (" . implode (', ', $products) . ")");
		}
		
		if ($action == 'add' || $action == 'upd') {
			foreach ($products as $product_id) {
				foreach ($related as $related_id) {
					if ($action == 'add') {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
						if (!$query->num_rows) {
							if ($product_id != $related_id) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
							}
						}
						
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
						if (!$query->num_rows) {
							if ($related_id != $product_id) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'");
							}
						}
					}
					
					if ($action == 'upd') {
						$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
						$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'");
					}
				}
			}
		}
	}
	
	public function Stores($products, $stores, $action) {
		if ($action == 'upd') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id IN (" . implode (', ', $products) . ")");
		}
		
		if ($action == 'del') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id IN (" . implode (', ', $products) . ") AND store_id IN (" . implode (', ', $stores) . ")");
		}
		
		if ($action == 'add' || $action == 'upd') {
			foreach ($products as $product_id) {
				foreach ($stores as $store_id) {
					if ($action == 'add') {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int) $product_id . "' AND store_id = '" . (int) $store_id . "'");
						if (!$query->num_rows) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int) $product_id . "', store_id = '" . (int) $store_id . "'");
						}
					}
					
					if ($action == 'upd') {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int) $product_id . "', store_id = '" . (int) $store_id . "'");
					}
				}
			}
		}
	}
	
	public function Downloads($products, $downloads, $action) {
		if ($action == 'upd') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id IN (" . implode (', ', $products) . ")");
		}
		
		if ($action == 'del') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id IN (" . implode (', ', $products) . ") AND download_id IN (" . implode (', ', $downloads) . ")");
		}
		
		if ($action == 'add' || $action == 'upd') {
			foreach ($products as $product_id) {
				foreach ($downloads as $download_id) {
					if ($action == 'add') {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int) $product_id . "' AND download_id = '" . (int) $download_id . "'");
						
						if (!$query->num_rows) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int) $product_id . "', download_id = '" . (int) $download_id . "'");
						}
					}
					
					if ($action == 'upd') {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int) $product_id . "', download_id = '" . (int) $download_id . "'");
					}
				}
			}
		}
	}
	
	public function Images($products, $images, $action) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id IN (" . implode (', ', $products) . ")");
		
		foreach ($products as $product_id) {
			foreach ($images as $image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int) $product_id . "', image = '" . $this->db->escape($image['image']) . "', sort_order = '" . (int) $image['sort_order'] . "'");
			}
		}
	}
}
?>