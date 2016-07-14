<?php
class ModelCheckoutValidation extends Model {
	public function getCustomerByEmail($email) {
        $customer = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer` WHERE email=\"" . $email . "\"");
        return $customer;
    }
}
?>