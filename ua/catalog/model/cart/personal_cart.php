<?php
class ModelCartPersonalCart extends Model {
	public function getOrderProducts($customer_id) {
	    $user_product_ids = $this->db->query("SELECT DISTINCT product_id FROM " . DB_PREFIX . "order_product WHERE `order_id` in (SELECT `order_id` FROM " . DB_PREFIX . "order` WHERE `customer_id` = " . (int)$customer_id . ")" );
	    $query = $this->db->query("SELECT ");
		return $query->row;	
	}

	public function addRecentProduct($product_id, $product_options, $order_id) {
	    $customer_id = $this->customer->getId();
        $group_id = 1;
        $recentProduct = $this->getRecentProduct($product_id, $product_options);
        if($order_id && !$recentProduct) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "customer_products (customer_id, product_id, order_id, group_id) VALUES (" . (int)$customer_id . ", " . (int)$product_id . ", " . (int)$order_id . ', ' . (int)$group_id . ")");
        }
        return;
	}

    private function getRecentProductOptions ($product_id, $order_id) {
        $options = array();
        $order_product_id_query = $this->db->query("SELECT order_product_id FROM " . DB_PREFIX . "order_product WHERE order_id = " . (int)$order_id . " and product_id = " . (int)$product_id);
        foreach($order_product_id_query->rows as $key => $order_product_id) {
            $options[$key] = array();
            $order_options_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = " . (int)$order_id . " and order_product_id = " . (int)$order_product_id['order_product_id']);
            foreach ($order_options_query->rows as $order_option) {
                if($order_option['type'] == 'checkbox') {
                    $options[$key][$order_option['product_option_id']][] = $order_option['product_option_value_id'] . '';
                } else {
                    $options[$key][$order_option['product_option_id']] = $order_option['product_option_value_id'] . '';
                }
            }
        }
        return $options;
    }

    private function getRecentProduct($product_id, $product_options) {
        $customer_id = $this->customer->getId();
        if($customer_id && $product_id) {
            $customer_products_query = $this->db->query("SELECT order_id FROM " . DB_PREFIX . "customer_products WHERE customer_id = " . (int)$customer_id . " and product_id = " . (int)$product_id);
            if ($customer_products_query->num_rows) {
                foreach ($customer_products_query->rows as $row) {

                    $recent_options = $this->getRecentProductOptions($product_id, $row['order_id']);

                    $p_option = array();
                    foreach ($product_options as $product_option) {
                        if(is_array($product_option) && array_key_exists('product_option_id', $product_option) && array_key_exists('product_option_value_id', $product_option)) {
                            if($product_option['type'] == 'checkbox') {
                                $p_option[$product_option['product_option_id']][] = $product_option['product_option_value_id'] ? $product_option['product_option_value_id'] . '' : 0;
                            } else {
                                $p_option[$product_option['product_option_id']] = $product_option['product_option_value_id'] ? $product_option['product_option_value_id'] . '' : 0;
                            }
                        }
                    }
                    if(empty($p_option)) {
                        $p_option = $product_options;
                    }

                    foreach($recent_options as $r_option) {
                        $diff = array_diff_assoc($r_option, $p_option);
                        if(empty($diff)) {
                            $recent_product = array();
                            $recent_product['product_id'] = $product_id;
                            $recent_product['order_id'] = $row['order_id'];
                            $recent_product['option'] = $r_option;
                            return $recent_product;
                        }
                    }

                }
            }
        }
        return false;
    }

    private function getRecentProductKey ($product_id, $option, $profile_id) {
        $key = (int) $product_id . ':';

        if ($option) {
            $key .= base64_encode(serialize($option)) . ':';
        }  else {
            $key .= ':';
        }

        if ($profile_id) {
            $key .= (int) $profile_id;
        }

        return $key;
    }

	public function getRecentProductIds() {
	    $product_ids = array();
        if ($this->customer->isLogged()) {
            $customer_id = $this->customer->getId();
            if($customer_id) {
                $query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "customer_products WHERE customer_id = " . (int)$customer_id);
                $product_ids = array();
                foreach($query->rows as $result) {
                    $product_ids[] = $result['product_id'];
                }
            }
        }
        return $product_ids;
	}

	public function getAllProducts($convertToKey = false) {
        $products = array();
        $customer_id = $this->customer->getId();
        if ($customer_id) {
            $customer_products_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_products WHERE customer_id = " . (int)$customer_id );
            foreach ($customer_products_query->rows as $row) {
                $recent_options = $this->getRecentProductOptions($row['product_id'], $row['order_id']);
                if(!empty($recent_options)) {
                    foreach ($recent_options as $option) {
                        $product = array();
                        $product['product_id'] = $row['product_id'];
                        $product['option'] = $option;
                        $products[] = $product;
                    }
                } else {
                    $product = array();
                    $product['product_id'] = $row['product_id'];
                    $product['option'] = array();
                    $products[] = $product;
                }
            }
        }
        if($convertToKey) {
            $products_key = array();
            $quantity = 0;
            foreach($products as $product) {
                $key = $this->getRecentProductKey($product['product_id'], $product['option'], false);
                $products_key[$key] = $quantity;
            }
            $products = $products_key;
        }
        return $products;
	}

	public function getRecentProducts() {
        $products_data = array();
        $recent_products = $this->getAllProducts(true);

        foreach ($recent_products as $key => $quantity) {
            $product = explode(':', $key);
            $product_id = $product[0];
            $stock = true;

            // Options
            if (!empty($product[1])) {
                $options = unserialize(base64_decode($product[1]));
            } else {
                $options = array();
            }

            // Profile

            if (!empty($product[2])) {
                $profile_id = $product[2];
            } else {
                $profile_id = 0;
            }

            $product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1'");

            if ($product_query->num_rows) {
                $option_price = 0;
                $option_points = 0;
                $option_weight = 0;

                $option_data = array();

                foreach ($options as $product_option_id => $option_value) {
                    $option_query = $this->db->query("SELECT po.product_option_id, po.option_id, od.name, o.type FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_option_id = '" . (int)$product_option_id . "' AND po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

                    if ($option_query->num_rows) {
                        if ($option_query->row['type'] == 'select' || $option_query->row['type'] == 'radio' || $option_query->row['type'] == 'image') {
                            $option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$option_value . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

                            if ($option_value_query->num_rows) {
                                if ($option_value_query->row['price_prefix'] == '+') {
                                    $option_price += $option_value_query->row['price'];
                                } elseif ($option_value_query->row['price_prefix'] == '-') {
                                    $option_price -= $option_value_query->row['price'];
                                }

                                if ($option_value_query->row['points_prefix'] == '+') {
                                    $option_points += $option_value_query->row['points'];
                                } elseif ($option_value_query->row['points_prefix'] == '-') {
                                    $option_points -= $option_value_query->row['points'];
                                }

                                if ($option_value_query->row['weight_prefix'] == '+') {
                                    $option_weight += $option_value_query->row['weight'];
                                } elseif ($option_value_query->row['weight_prefix'] == '-') {
                                    $option_weight -= $option_value_query->row['weight'];
                                }

                                if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
                                    $stock = false;
                                }

                                $option_data[] = array(
                                    'product_option_id'       => $product_option_id,
                                    'product_option_value_id' => $option_value,
                                    'option_id'               => $option_query->row['option_id'],
                                    'option_value_id'         => $option_value_query->row['option_value_id'],
                                    'name'                    => $option_query->row['name'],
                                    'option_value'            => $option_value_query->row['name'],
                                    'type'                    => $option_query->row['type'],
                                    'quantity'                => $option_value_query->row['quantity'],
                                    'subtract'                => $option_value_query->row['subtract'],
                                    'price'                   => $option_value_query->row['price'],
                                    'price_prefix'            => $option_value_query->row['price_prefix'],
                                    'points'                  => $option_value_query->row['points'],
                                    'points_prefix'           => $option_value_query->row['points_prefix'],
                                    'weight'                  => $option_value_query->row['weight'],
                                    'weight_prefix'           => $option_value_query->row['weight_prefix']
                                );
                            }
                        } elseif ($option_query->row['type'] == 'checkbox' && is_array($option_value)) {
                            foreach ($option_value as $product_option_value_id) {
                                $option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

                                if ($option_value_query->num_rows) {
                                    if ($option_value_query->row['price_prefix'] == '+') {
                                        $option_price += $option_value_query->row['price'];
                                    } elseif ($option_value_query->row['price_prefix'] == '-') {
                                        $option_price -= $option_value_query->row['price'];
                                    }

                                    if ($option_value_query->row['points_prefix'] == '+') {
                                        $option_points += $option_value_query->row['points'];
                                    } elseif ($option_value_query->row['points_prefix'] == '-') {
                                        $option_points -= $option_value_query->row['points'];
                                    }

                                    if ($option_value_query->row['weight_prefix'] == '+') {
                                        $option_weight += $option_value_query->row['weight'];
                                    } elseif ($option_value_query->row['weight_prefix'] == '-') {
                                        $option_weight -= $option_value_query->row['weight'];
                                    }

                                    if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
                                        $stock = false;
                                    }

                                    $option_data[] = array(
                                        'product_option_id'       => $product_option_id,
                                        'product_option_value_id' => $product_option_value_id,
                                        'option_id'               => $option_query->row['option_id'],
                                        'option_value_id'         => $option_value_query->row['option_value_id'],
                                        'name'                    => $option_query->row['name'],
                                        'option_value'            => $option_value_query->row['name'],
                                        'type'                    => $option_query->row['type'],
                                        'quantity'                => $option_value_query->row['quantity'],
                                        'subtract'                => $option_value_query->row['subtract'],
                                        'price'                   => $option_value_query->row['price'],
                                        'price_prefix'            => $option_value_query->row['price_prefix'],
                                        'points'                  => $option_value_query->row['points'],
                                        'points_prefix'           => $option_value_query->row['points_prefix'],
                                        'weight'                  => $option_value_query->row['weight'],
                                        'weight_prefix'           => $option_value_query->row['weight_prefix']
                                    );
                                }
                            }
                        } elseif ($option_query->row['type'] == 'text' || $option_query->row['type'] == 'textarea' || $option_query->row['type'] == 'file' || $option_query->row['type'] == 'date' || $option_query->row['type'] == 'datetime' || $option_query->row['type'] == 'time') {
                            $option_data[] = array(
                                'product_option_id'       => $product_option_id,
                                'product_option_value_id' => '',
                                'option_id'               => $option_query->row['option_id'],
                                'option_value_id'         => '',
                                'name'                    => $option_query->row['name'],
                                'option_value'            => $option_value,
                                'type'                    => $option_query->row['type'],
                                'quantity'                => '',
                                'subtract'                => '',
                                'price'                   => '',
                                'price_prefix'            => '',
                                'points'                  => '',
                                'points_prefix'           => '',
                                'weight'                  => '',
                                'weight_prefix'           => ''
                            );
                        }
                    }
                }

                if ($this->customer->isLogged()) {
                    $customer_group_id = $this->customer->getCustomerGroupId();
                } else {
                    $customer_group_id = $this->config->get('config_customer_group_id');
                }

                $price = $product_query->row['price'];

                // Product Discounts
                $discount_quantity = 0;

                foreach ($recent_products as $key_2 => $quantity_2) {
                    $product_2 = explode(':', $key_2);

                    if ($product_2[0] == $product_id) {
                        $discount_quantity += $quantity_2;
                    }
                }

                $product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND quantity <= '" . (int)$discount_quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");

                if ($product_discount_query->num_rows) {
                    $price = $product_discount_query->row['price'];
                }

                // Product Specials
                $product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");

                if ($product_special_query->num_rows) {
                    $price = $product_special_query->row['price'];
                }

                // Reward Points
                $product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "'");

                if ($product_reward_query->num_rows) {
                    $reward = $product_reward_query->row['points'];
                } else {
                    $reward = 0;
                }

                // Downloads
                $download_data = array();

                $download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE p2d.product_id = '" . (int)$product_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

                foreach ($download_query->rows as $download) {
                    $download_data[] = array(
                        'download_id' => $download['download_id'],
                        'name'        => $download['name'],
                        'filename'    => $download['filename'],
                        'mask'        => $download['mask'],
                        'remaining'   => $download['remaining']
                    );
                }

                // Stock
                if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $quantity)) {
                    $stock = false;
                }

                $recurring = false;
                $recurring_frequency = 0;
                $recurring_price = 0;
                $recurring_cycle = 0;
                $recurring_duration = 0;
                $recurring_trial_status = 0;
                $recurring_trial_price = 0;
                $recurring_trial_cycle = 0;
                $recurring_trial_duration = 0;
                $recurring_trial_frequency = 0;
                $profile_name = '';

                if ($profile_id) {
                    $profile_info = $this->db->query("SELECT * FROM `" . DB_PREFIX . "profile` `p` JOIN `" . DB_PREFIX . "product_profile` `pp` ON `pp`.`profile_id` = `p`.`profile_id` AND `pp`.`product_id` = " . (int) $product_query->row['product_id'] . " JOIN `" . DB_PREFIX . "profile_description` `pd` ON `pd`.`profile_id` = `p`.`profile_id` AND `pd`.`language_id` = " . (int) $this->config->get('config_language_id') . " WHERE `pp`.`profile_id` = " . (int) $profile_id . " AND `status` = 1 AND `pp`.`customer_group_id` = " . (int) $customer_group_id)->row;

                    if ($profile_info) {
                        $profile_name = $profile_info['name'];

                        $recurring = true;
                        $recurring_frequency = $profile_info['frequency'];
                        $recurring_price = $profile_info['price'];
                        $recurring_cycle = $profile_info['cycle'];
                        $recurring_duration = $profile_info['duration'];
                        $recurring_trial_frequency = $profile_info['trial_frequency'];
                        $recurring_trial_status = $profile_info['trial_status'];
                        $recurring_trial_price = $profile_info['trial_price'];
                        $recurring_trial_cycle = $profile_info['trial_cycle'];
                        $recurring_trial_duration = $profile_info['trial_duration'];
                    }
                }

                $products_data[$key] = array(
                    'key'                       => $key,
                    'product_id'                => $product_query->row['product_id'],
                    'name'                      => $product_query->row['name'],
                    'model'                     => $product_query->row['model'],
                    'shipping'                  => $product_query->row['shipping'],
                    'image'                     => $product_query->row['image'],
                    'option'                    => $option_data,
                    'download'                  => $download_data,
                    'quantity'                  => $quantity,
                    'minimum'                   => 0,
                    'subtract'                  => $product_query->row['subtract'],
                    'stock'                     => $stock,
                    'price'                     => ($price + $option_price),
                    'total'                     => ($price + $option_price) * $quantity,
                    'reward'                    => $reward * $quantity,
                    'points'                    => ($product_query->row['points'] ? ($product_query->row['points'] + $option_points) * $quantity : 0),
                    'tax_class_id'              => $product_query->row['tax_class_id'],
                    'weight'                    => ($product_query->row['weight'] + $option_weight) * $quantity,
                    'weight_class_id'           => $product_query->row['weight_class_id'],
                    'length'                    => $product_query->row['length'],
                    'width'                     => $product_query->row['width'],
                    'height'                    => $product_query->row['height'],
                    'length_class_id'           => $product_query->row['length_class_id'],
                    'profile_id'                => $profile_id,
                    'profile_name'              => $profile_name,
                    'recurring'                 => $recurring,
                    'recurring_frequency'       => $recurring_frequency,
                    'recurring_price'           => $recurring_price,
                    'recurring_cycle'           => $recurring_cycle,
                    'recurring_duration'        => $recurring_duration,
                    'recurring_trial'           => $recurring_trial_status,
                    'recurring_trial_frequency' => $recurring_trial_frequency,
                    'recurring_trial_price'     => $recurring_trial_price,
                    'recurring_trial_cycle'     => $recurring_trial_cycle,
                    'recurring_trial_duration'  => $recurring_trial_duration,
                );
            } else {
                $products_data = array();
            }
        }
        return $products_data;
    }

    public function getRelatedProducts ($data = array()) {
        $relatedProducts = array();
        foreach($data as $product_id) {
            $this->load->model('catalog/product');
            $relatedProducts[$product_id] = $this->model_catalog_product->getProductRelated($product_id);
        }
        return $relatedProducts;
    }

    public function removeRecent ($key) {
        if ($this->customer->isLogged()) {
            $product = explode(':', $key);
            $product_id = $product[0];
            $stock = true;

            // Options
            if (!empty($product[1])) {
                $options = unserialize(base64_decode($product[1]));
            } else {
                $options = array();
            }

            // Profile
            if (!empty($product[2])) {
                $profile_id = $product[2];
            } else {
                $profile_id = 0;
            }

            $recentProduct = $this->getRecentProduct($product_id, $options);
            if($recentProduct && $product_id) {
                $order_id = $recentProduct['order_id'];
                $this->db->query("DELETE  FROM " . DB_PREFIX . "customer_products WHERE product_id = " . (int)$product_id . " AND order_id = " . (int)$order_id );
            }
        }
    }
}
?>