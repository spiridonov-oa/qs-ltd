<?php if ($products) { ?>
<div class="pagination"><?php echo $pagination; ?></div>
<br /><br />
<table id="product" class="list">
 <thead>
  <tr class="sort">
   <td class="center" width="1"><input type="checkbox" onclick="selected_row_all(this);" /></td>
   <td class="left" colspan="2"></td>
   <?php if (in_array ('image', $filter_columns)) { ?>
   <td class="center" colspan="2"><?php echo $column_images; ?></td>
   <?php } ?>
   <td class="left"><?php $class = ($sort == 'pd.name') ? strtolower($order) : ''; ?><a href="<?php echo $sort_name; ?>" class="<?php echo $class; ?>"><?php echo $column_name; ?></a></td>
   <?php if (in_array ('sort_order', $filter_columns)) { ?>
   <td class="left" width="1"><?php $class = ($sort == 'p.sort_order') ? strtolower($order) : ''; ?><a href="<?php echo $sort_sort_order; ?>" class="<?php echo $class; ?>"><?php echo $column_sort_order; ?></a></td>
   <?php } ?>
   <?php if (in_array ('manufacturer', $filter_columns)) { ?>
   <td class="left" width="8%"><?php $class = ($sort == 'm.name') ? strtolower($order) : ''; ?><a href="<?php echo $sort_manufacturer; ?>" class="<?php echo $class; ?>"><?php echo $column_manufacturer; ?></a></td>
   <?php } ?>
   <?php if (in_array ('model', $filter_columns)) { ?>
   <td class="left" width="8%"><?php $class = ($sort == 'p.model') ? strtolower($order) : ''; ?><a href="<?php echo $sort_model; ?>" class="<?php echo $class; ?>"><?php echo $column_model; ?></a></td>
   <?php } ?>
   <?php if (in_array ('sku', $filter_columns)) { ?>
   <td class="left" width="8%"><?php $class = ($sort == 'p.sku') ? strtolower($order) : ''; ?><a href="<?php echo $sort_sku; ?>" class="<?php echo $class; ?>"><?php echo $column_sku; ?></a></td>
   <?php } ?>
   <?php if (in_array ('price', $filter_columns)) { ?>
   <td class="left" width="5"><?php $class = ($sort == 'p.price') ? strtolower($order) : ''; ?><a href="<?php echo $sort_price; ?>" class="<?php echo $class; ?>"><?php echo $column_price; ?></a></td>
   <?php } ?>
   <?php if (in_array ('quantity', $filter_columns)) { ?>
   <td class="left" width="1"><?php $class = ($sort == 'p.quantity') ? strtolower($order) : ''; ?><a href="<?php echo $sort_quantity; ?>" class="<?php echo $class; ?>"><?php echo $column_quantity; ?></a></td>
   <?php } ?>
   <?php if (in_array ('shipping', $filter_columns)) { ?>
   <td class="left" width="1"><?php $class = ($sort == 'p.shipping') ? strtolower($order) : ''; ?><a href="<?php echo $sort_shipping; ?>" class="<?php echo $class; ?>"><?php echo $column_shipping; ?></a></td>
   <?php } ?>
   <?php if (in_array ('subtract', $filter_columns)) { ?>
   <td class="left" width="1"><?php $class = ($sort == 'p.subtract') ? strtolower($order) : ''; ?><a href="<?php echo $sort_subtract; ?>" class="<?php echo $class; ?>"><?php echo $column_subtract; ?></a></td>
   <?php } ?>
   <?php if (in_array ('stock_status', $filter_columns)) { ?>
   <td class="left" width="7%"><?php $class = ($sort == 'ss.name') ? strtolower($order) : ''; ?><a href="<?php echo $sort_stock_status; ?>" class="<?php echo $class; ?>"><?php echo $column_stock_status; ?></a></td>
   <?php } ?>
   <?php if (in_array ('tax_class', $filter_columns)) { ?>
   <td class="left" width=""><?php $class = ($sort == 'tc.title') ? strtolower($order) : ''; ?><a href="<?php echo $sort_tax_class; ?>" class="<?php echo $class; ?>"><?php echo $column_tax_class; ?></a></td>
   <?php } ?>
   <?php if (in_array ('minimum', $filter_columns)) { ?>
   <td class="left" width=""><?php $class = ($sort == 'p.minimum') ? strtolower($order) : ''; ?><a href="<?php echo $sort_minimum; ?>" class="<?php echo $class; ?>"><?php echo $column_minimum; ?></a></td>
   <?php } ?>
   <?php if (in_array ('points', $filter_columns)) { ?>
   <td class="left" width=""><?php $class = ($sort == 'p.points') ? strtolower($order) : ''; ?><a href="<?php echo $sort_points; ?>" class="<?php echo $class; ?>"><?php echo $column_points; ?></a></td>
   <?php } ?>
   <?php if (in_array ('url_alias', $filter_columns)) { ?>
   <td class="left" width=""><?php $class = ($sort == 'ua.keyword') ? strtolower($order) : ''; ?><a href="<?php echo $sort_url_alias; ?>" class="<?php echo $class; ?>"><?php echo $column_url_alias; ?></a></td>
   <?php } ?>
   <?php if (in_array ('weight_class', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'wcd.title') ? strtolower($order) : ''; ?><a href="<?php echo $sort_weight_class; ?>" class="<?php echo $class; ?>"><?php echo $column_weight_class; ?></a></td>
   <?php } ?>
   <?php if (in_array ('weight', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'p.weight') ? strtolower($order) : ''; ?><a href="<?php echo $sort_weight; ?>" class="<?php echo $class; ?>"><?php echo $column_weight; ?></a></td>
   <?php } ?>
   <?php if (in_array ('length_class', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'lcd.title') ? strtolower($order) : ''; ?><a href="<?php echo $sort_length_class; ?>" class="<?php echo $class; ?>"><?php echo $column_length_class; ?></a></td>
   <?php } ?>
   <?php if (in_array ('length', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'p.length') ? strtolower($order) : ''; ?><a href="<?php echo $sort_length; ?>" class="<?php echo $class; ?>"><?php echo $column_length; ?></a></td>
   <?php } ?>
   <?php if (in_array ('width', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'p.width') ? strtolower($order) : ''; ?><a href="<?php echo $sort_width; ?>" class="<?php echo $class; ?>"><?php echo $column_width; ?></a></td>
   <?php } ?>
   <?php if (in_array ('height', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'p.height') ? strtolower($order) : ''; ?><a href="<?php echo $sort_height; ?>" class="<?php echo $class; ?>"><?php echo $column_height; ?></a></td>
   <?php } ?>
   <?php if (in_array ('upc', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'p.upc') ? strtolower($order) : ''; ?><a href="<?php echo $sort_upc; ?>" class="<?php echo $class; ?>"><?php echo $column_upc; ?></a></td>
   <?php } ?>
   <?php if (in_array ('location', $filter_columns)) { ?>
   <td class="left"><?php $class = ($sort == 'p.location') ? strtolower($order) : ''; ?><a href="<?php echo $sort_location; ?>" class="<?php echo $class; ?>"><?php echo $column_location; ?></a></td>
   <?php } ?>
   <?php if (in_array ('status', $filter_columns)) { ?>
   <td class="left" width="7%"><?php $class = ($sort == 'p.status') ? strtolower($order) : ''; ?><a href="<?php echo $sort_status; ?>" class="<?php echo $class; ?>"><?php echo $column_status; ?></a></td>
   <?php } ?>
  </tr>
 </thead>
 <tbody>
 <?php foreach ($products as $product) { ?>
  <?php $class = ($product['selected']) ? 'selected' : ''; ?>
  <tr class="selected_row-<?php echo $product['product_id']; ?> <?php echo $class; ?>">
   <td class="center">
    <?php if ($product['selected']) { ?>
    <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" />
    <?php } ?>
   </td>
   <td class="left" width="1"><a class="related" onclick="editProducts('to_related', <?php echo $product['product_id']; ?>)" title="<?php echo $text_related; ?>"></a></td>
   <td class="left" width="1"><a class="link" target="_blank" href="<?php echo $link.$product['product_id']; ?>" title="<?php echo $text_view; ?>"></a></td>
   <?php if (in_array ('image', $filter_columns)) { ?>
   <td class="center" width="1">
    <div class="dd_menu" id="product_images_<?php echo $product['product_id']; ?>">
     <div class="dd_menu_title" onclick="toggleImages('product_images_<?php echo $product['product_id']; ?>', <?php echo $product['product_id']; ?>);"></div>
     <div class="dd_menu_container"></div>
    </div>
   </td>
   <td class="center" width="1">
   <div class="image_edit">
    <?php if ($product['image']) { ?>
    <div class="image_remove" id="image_remove-<?php echo $product['product_id']; ?>" title="<?php echo $button_remove; ?>"></div>
    <?php } ?>
    <img id="thumb-<?php echo $product['product_id']; ?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $text_edit; ?>" />
    <input type="hidden" id="image-<?php echo $product['product_id']; ?>" value="<?php echo $product['image']; ?>" />
    <a id="image_manager-<?php echo $product['product_id']; ?>" onclick="getImageManager('image_manager', <?php echo $product['product_id']; ?>, 0)"><?php echo $text_path; ?></a>
    </div>
   </td>
   <?php } ?>
   <td class="left product_name">
    <span class="input-name-<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?></span>
    <div>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'descriptions')"><?php echo $column_descriptions; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'categories')"><?php echo $column_categories; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'attributes')"><?php echo $column_attributes; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'options')"><?php echo $column_options; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'specials')"><?php echo $column_specials; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'discounts')"><?php echo $column_discounts; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'related')"><?php echo $column_related; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'stores')"><?php echo $column_stores; ?></a>
     <a onclick="getProductList(<?php echo $product['product_id']; ?>, 'downloads')"><?php echo $column_downloads; ?></a>
    </div>
   </td>
   <?php if (in_array ('sort_order', $filter_columns)) { ?>
   <td class="left"><span class="input-sort_order-<?php echo $product['product_id']; ?>"><?php echo $product['sort_order']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('manufacturer', $filter_columns)) { ?>
   <?php $class = (!$product['manufacturer']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_manufacturer<?php echo $product['product_id']; ?>"><span class="select-manufacturer-<?php echo $product['product_id']; ?>"><?php echo $product['manufacturer']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('model', $filter_columns)) { ?>
   <?php $class = (!$product['model']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_model<?php echo $product['product_id']; ?>"><span class="input-model-<?php echo $product['product_id']; ?>"><?php echo $product['model']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('sku', $filter_columns)) { ?>
   <?php $class = (!$product['sku']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_sku<?php echo $product['product_id']; ?>"><span class="input-sku-<?php echo $product['product_id']; ?>"><?php echo $product['sku']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('price', $filter_columns)) { ?>
   <td class="left"><span class="input-price-<?php echo $product['product_id']; ?>"><?php echo $product['price']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('quantity', $filter_columns)) { ?>
   <?php $class = (0 < $product['quantity']) ? 'quantity' : 'quantity_0'; ?>
   <td class="left <?php echo $class; ?> td_quantity<?php echo $product['product_id']; ?>"><span class="input-quantity-<?php echo $product['product_id']; ?>"><?php echo $product['quantity']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('shipping', $filter_columns)) { ?>
   <td class="left"><span class="select-shipping-<?php echo $product['product_id']; ?>"><?php echo $product['shipping']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('subtract', $filter_columns)) { ?>
   <td class="left"><span class="select-subtract-<?php echo $product['product_id']; ?>"><?php echo $product['subtract']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('stock_status', $filter_columns)) { ?>
   <?php $class = (!$product['stock_status']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_stock_status<?php echo $product['product_id']; ?>"><span class="select-stock_status-<?php echo $product['product_id']; ?>"><?php echo $product['stock_status']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('tax_class', $filter_columns)) { ?>
   <?php $class = (!$product['tax_class']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_tax_class<?php echo $product['product_id']; ?>"><span class="select-tax_class-<?php echo $product['product_id']; ?>"><?php echo $product['tax_class']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('minimum', $filter_columns)) { ?>
   <td class="left"><span class="input-minimum-<?php echo $product['product_id']; ?>"><?php echo $product['minimum']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('points', $filter_columns)) { ?>
   <td class="left"><span class="input-points-<?php echo $product['product_id']; ?>"><?php echo $product['points']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('url_alias', $filter_columns)) { ?>
   <?php $class = (!$product['url_alias']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_url_alias<?php echo $product['product_id']; ?>"><span class="input-url_alias-<?php echo $product['product_id']; ?>"><?php echo $product['url_alias']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('weight_class', $filter_columns)) { ?>
   <td class="left"><span class="select-weight_class-<?php echo $product['product_id']; ?>"><?php echo $product['weight_class']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('weight', $filter_columns)) { ?>
   <td class="left"><span class="input-weight-<?php echo $product['product_id']; ?>"><?php echo $product['weight']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('length_class', $filter_columns)) { ?>
   <td class="left"><span class="select-length_class-<?php echo $product['product_id']; ?>"><?php echo $product['length_class']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('length', $filter_columns)) { ?>
   <td class="left"><span class="input-length-<?php echo $product['product_id']; ?>"><?php echo $product['length']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('width', $filter_columns)) { ?>
   <td class="left"><span class="input-width-<?php echo $product['product_id']; ?>"><?php echo $product['width']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('height', $filter_columns)) { ?>
   <td class="left"><span class="input-height-<?php echo $product['product_id']; ?>"><?php echo $product['height']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('upc', $filter_columns)) { ?>
   <?php $class = (!$product['upc']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_upc<?php echo $product['product_id']; ?>"><span class="input-upc-<?php echo $product['product_id']; ?>"><?php echo $product['upc']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('location', $filter_columns)) { ?>
   <?php $class = (!$product['location']) ? 'attention' : ''; ?>
   <td class="left <?php echo $class; ?> td_location<?php echo $product['product_id']; ?>"><span class="input-location-<?php echo $product['product_id']; ?>"><?php echo $product['location']; ?></span></td>
   <?php } ?>
   <?php if (in_array ('status', $filter_columns)) { ?>
   <?php $class = ($product['status'] == $text_enabled) ? 'enabled' : 'disabled'; ?>
   <td class="left <?php echo $class; ?> td_status<?php echo $product['product_id']; ?>"><span class="select-status-<?php echo $product['product_id']; ?>"><?php echo $product['status']; ?></span></td>
   <?php } ?>
  </tr>
 <?php } ?>
 </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<div align="center" class="attention"><?php echo $text_no_results; ?></div>
<?php } ?>