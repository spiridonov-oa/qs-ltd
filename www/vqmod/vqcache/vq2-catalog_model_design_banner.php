<?php
class ModelDesignBanner extends Model {	
	public function getBanner($banner_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image bi LEFT JOIN " . DB_PREFIX . "banner_image_description bid ON (bi.banner_image_id  = bid.banner_image_id) WHERE bi.banner_id = '" . (int)$banner_id . "' AND bid.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		$results = $query->rows;
                        foreach ($results as $key => $banner_image) {
                            $results[$key]['banner_link_description'] = array();
                            $link_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_link_description WHERE banner_image_id = '" . (int)$banner_image['banner_image_id'] . "' AND banner_id = '" . (int)$banner_image['banner_id'] . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");
                            if($link_query->num_rows) {
                                for($i = 0; $i < count($link_query->rows); $i++){
                                    foreach ($link_query->rows as $banner_link_description) {
                                        if($i == $banner_link_description['sort_order'])
                                        $results[$key]['banner_link_description'][] = $banner_link_description;
                                    }
                                }
                            }
                        }

                        return $results;
	}
}
?>