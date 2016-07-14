<?php echo $header; ?>
<link type="text/css" rel="stylesheet" href="view/batch_editor/stylesheet/style.css" />
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
var text = false;
var token = '<?php echo $token; ?>';
var loading = '<img src="view/batch_editor/image/loading.gif" />';
--></script>
<div id="content">
 <div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
 </div>
 <div class="box">
  <div class="heading">
   <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_title; ?></h1>
   <div class="buttons">
    <a class="button" onclick="location = '<?php echo $setting; ?>';"><?php echo $button_setting; ?></a>
    <a class="button" onclick="clearCache();"><?php echo $button_clear_cache; ?></a>
    <a class="button" onclick="location = '<?php echo $cancel; ?>';"><?php echo $button_cancel; ?></a>
   </div>
  </div>
  <div class="content">
   <div id="tabs" class="htabs">
    <a href="#tab-filter"><?php echo $button_filter; ?></a>
    <a href="#tab-general"><?php echo $tab_general; ?></a>
    <a href="#tab-links"><?php echo $tab_links; ?></a>
   </div>
   <div id="tab-filter"><?php include ('filter.tpl'); ?></div>
   <!-- start general -->
   <div id="tab-general">
    <div id="tabs-general" class="htabs">
     <a href="#tab-manufacturer"><?php echo $column_manufacturer; ?></a>
     <a href="#tab-status"><?php echo $column_status; ?></a>
     <a href="#tab-stock_status"><?php echo $column_stock_status; ?></a>
     <a href="#tab-price"><?php echo $column_price; ?></a>
     <a href="#tab-tax_class"><?php echo $column_tax_class; ?></a>
     <a href="#tab-quantity"><?php echo $column_quantity; ?></a>
     <a href="#tab-minimum"><?php echo $column_minimum; ?></a>
     <a href="#tab-points"><?php echo $column_points; ?></a>
     <a href="#tab-weight-dimensions"><?php echo $column_weight_dimensions; ?></a>
    </div>
    <div id="tab-manufacturer">
    <form id="form-manufacturer">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_manufacturer; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <select name="product_manufacturer">
          <option value="0"><?php echo $text_none; ?></option>
          <?php foreach ($manufacturers as $manufacturer) { ?>
          <option value="<?php echo $manufacturer['manufacturer_id']; ?>"><?php echo $manufacturer['name']; ?></option>
          <?php } ?>
         </select>
        </td>
        <td class="left"><a class="button" onclick="editProducts('manufacturer', 'edit');"><?php echo $text_edit; ?></a></td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-status">
    <form id="form-status">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_status; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <select name="product_status">
          <option value="1"><?php echo $text_enabled; ?></option>
          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
         </select>
        </td>
        <td class="left"><a class="button" onclick="editProducts('status', 'edit');"><?php echo $text_edit; ?></a></td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-stock_status">
     <form id="form-stock_status">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_stock_status; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <select name="product_stock_status">
          <?php foreach ($stock_statuses as $stock_status) { ?>
          <option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
          <?php } ?>
         </select>
        </td>
        <td class="left"><a class="button" onclick="editProducts('stock_status', 'edit');"><?php echo $text_edit; ?></a></td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-price">
    <form id="form-price">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_price; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <select name="product_price_action">
          <?php foreach ($price_actions as $price_action) { ?>
          <option value="<?php echo $price_action['action']; ?>"><?php echo $price_action['name']; ?></option>
          <?php } ?>
         </select>
         &nbsp;&nbsp;&nbsp;
         <input type="text" name="product_price" value="" />
        </td>
        <td class="left"><a class="button" onclick="editProducts('price', 'edit');"><?php echo $text_edit; ?></a></td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-tax_class">
     <form id="form-tax_class">
      <table class="list">
       <thead>
        <tr>
         <td class="left" width="30%"><?php echo $column_tax_class; ?></td>
         <td class="left"></td>
        </tr>
       </thead>
       <tbody>
        <tr>
         <td class="left">
          <select name="product_tax_class">
           <option value="0"><?php echo $text_none; ?></option>
           <?php foreach ($tax_classes as $tax_class) { ?>
           <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['name']; ?></option>
           <?php } ?>
          </select>
         </td>
         <td class="left"><a class="button" onclick="editProducts('tax_class', 'edit');"><?php echo $text_edit; ?></a></td>
        </tr>
       </tbody>
      </table>
     </form>
    </div>
    <div id="tab-quantity">
     <form id="form-quantity">
      <table class="list">
       <thead>
        <tr>
         <td class="left" width="30%"><?php echo $column_quantity; ?></td>
         <td class="left"></td>
        </tr>
       </thead>
       <tbody>
        <tr>
         <td class="left"><input type="text" name="product_quantity" /></td>
         <td class="left"><a class="button" onclick="editProducts('quantity', 'edit');"><?php echo $text_edit; ?></a></td>
        </tr>
       </tbody>
      </table>
     </form>
    </div>
    <div id="tab-minimum">
     <form id="form-minimum">
      <table class="list">
       <thead>
        <tr>
         <td class="left" width="30%"><?php echo $column_minimum; ?></td>
         <td class="left"></td>
        </tr>
       </thead>
       <tbody>
        <tr>
         <td class="left"><input type="text" name="product_minimum" /></td>
         <td class="left"><a class="button" onclick="editProducts('minimum', 'edit');"><?php echo $text_edit; ?></a></td>
        </tr>
       </tbody>
      </table>
     </form>
    </div>
    <div id="tab-points">
     <form id="form-points">
      <table class="list">
       <thead>
        <tr>
         <td class="left" width="30%"><?php echo $column_points; ?></td>
         <td class="left"></td>
        </tr>
       </thead>
       <tbody>
        <tr>
         <td class="left"><input type="text" name="product_points" /></td>
         <td class="left"><a class="button" onclick="editProducts('points', 'edit');"><?php echo $text_edit; ?></a></td>
        </tr>
       </tbody>
      </table>
     </form>
    </div>
    <div id="tab-weight-dimensions">
     <div id="tabs-weight-dimensions" class="htabs">
      <a href="#tab-weight_class"><?php echo $column_weight_class; ?></a>
      <a href="#tab-weight"><?php echo $column_weight; ?></a>
      <a href="#tab-length_class"><?php echo $column_length_class; ?></a>
      <a href="#tab-length"><?php echo $column_length; ?></a>
      <a href="#tab-width"><?php echo $column_width; ?></a>
      <a href="#tab-height"><?php echo $column_height; ?></a>
     </div>
     <div id="tab-weight_class">
      <form id="form-weight_class">
      <table class="list">
       <thead>
        <tr>
         <td class="left" width="30%"><?php echo $column_weight_class; ?></td>
         <td class="left"></td>
        </tr>
       </thead>
       <tbody>
        <tr>
         <td class="left">
          <select name="product_weight_class">
           <?php foreach ($weight_classes as $weight_class) { ?>
           <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['name']; ?></option>
           <?php } ?>
          </select>
         </td>
         <td class="left"><a class="button" onclick="editProducts('weight_class', 'edit');"><?php echo $text_edit; ?></a></td>
        </tr>
       </tbody>
      </table>
     </form>
     </div>
     <div id="tab-weight">
      <form id="form-weight">
       <table class="list">
        <thead>
         <tr>
          <td class="left" width="30%"><?php echo $column_weight; ?></td>
          <td class="left"></td>
         </tr>
        </thead>
        <tbody>
         <tr>
          <td class="left"><input name="product_weight" /></td>
          <td class="left"><a class="button" onclick="editProducts('weight', 'edit');"><?php echo $text_edit; ?></a></td>
         </tr>
        </tbody>
       </table>
      </form>
     </div>
     <div id="tab-length_class">
      <form id="form-length_class">
       <table class="list">
        <thead>
         <tr>
          <td class="left" width="30%"><?php echo $column_length_class; ?></td>
          <td class="left"></td>
         </tr>
        </thead>
        <tbody>
         <tr>
          <td class="left">
           <select name="product_length_class">
            <?php foreach ($length_classes as $length_class) { ?>
            <option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['name']; ?></option>
            <?php } ?>
           </select>
          </td>
          <td class="left"><a class="button" onclick="editProducts('length_class', 'edit');"><?php echo $text_edit; ?></a></td>
         </tr>
        </tbody>
       </table>
      </form>
     </div>
     <div id="tab-length">
      <form id="form-length">
       <table class="list">
        <thead>
         <tr>
          <td class="left" width="30%"><?php echo $column_length; ?></td>
          <td class="left"></td>
         </tr>
        </thead>
        <tbody>
         <tr>
          <td class="left"><input name="product_length" /></td>
          <td class="left"><a class="button" onclick="editProducts('length', 'edit');"><?php echo $text_edit; ?></a></td>
         </tr>
        </tbody>
       </table>
      </form>
     </div>
     <div id="tab-width">
      <form id="form-width">
       <table class="list">
        <thead>
         <tr>
          <td class="left" width="30%"><?php echo $column_width; ?></td>
          <td class="left"></td>
         </tr>
        </thead>
        <tbody>
         <tr>
          <td class="left"><input name="product_width" /></td>
          <td class="left"><a class="button" onclick="editProducts('width', 'edit');"><?php echo $text_edit; ?></a></td>
         </tr>
        </tbody>
       </table>
      </form>
     </div>
     <div id="tab-height">
      <form id="form-height">
       <table class="list">
        <thead>
         <tr>
          <td class="left" width="30%"><?php echo $column_height; ?></td>
          <td class="left"></td>
         </tr>
        </thead>
        <tbody>
         <tr>
          <td class="left"><input name="product_height" /></td>
          <td class="left"><a class="button" onclick="editProducts('height', 'edit');"><?php echo $text_edit; ?></a></td>
         </tr>
        </tbody>
       </table>
      </form>
     </div>
    </div>
   </div>
   <!-- end general -->
   
   <!-- start links -->
   <div id="tab-links">
    <div id="tabs-links" class="htabs">
     <a href="#tab-categories"><?php echo $column_categories; ?></a>
     <a href="#tab-attributes"><?php echo $column_attributes; ?></a>
     <a href="#tab-options"><?php echo $column_options; ?></a>
     <a href="#tab-specials"><?php echo $column_specials; ?></a>
     <a href="#tab-discounts"><?php echo $column_discounts; ?></a>
     <a href="#tab-related"><?php echo $column_related; ?></a>
     <a href="#tab-stores"><?php echo $column_stores; ?></a>
     <a href="#tab-downloads"><?php echo $column_downloads; ?></a>
    </div>
    <div id="tab-categories">
    <form id="form-categories">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_categories; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <div class="dd_menu" id="product_categories">
          <div class="dd_menu_title" onclick="toggle('product_categories');"><?php echo $column_categories; ?> <b style="color:red;">(0)</b></div>
          <div class="dd_menu_container">
           <?php $class = 'odd'; ?>
           <?php foreach ($categories as $category) { ?>
           <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
           <div class="<?php echo $class; ?>"><input type="checkbox" name="product_categories[]" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?></div>
           <?php } ?>
          </div>
         </div>
        </td>
        <td class="left"></td>
       </tr>
       <tr>
        <td class="center" colspan="2">
         <a class="button" onclick="editProducts('categories', 'add');"><?php echo $button_insert_sel; ?></a>
         <a class="button" onclick="editProducts('categories', 'del');"><?php echo $button_delete_sel; ?></a>
         <a class="button" onclick="editProducts('categories', 'upd');"><?php echo $text_edit; ?></a>
        </td>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-attributes">
    <form id="form-attributes">
     <table id="attribute" class="list">
      <thead>
       <tr>
        <td class="center" width="3%"></td>
        <td class="left" width="20%"><?php echo $column_attribute_group; ?></td>
        <td class="left" width="20%"><?php echo $column_attribute_name; ?></td>
        <td class="left" width="57%"><?php echo $column_attribute_value; ?></td>
       </tr>
      </thead>
      <tfoot>
       <tr>
        <td class="center"><a onclick="addAttribute('attribute');"><img src="view/image/add.png" title="<?php echo $button_insert; ?>" alt="<?php echo $button_insert; ?>" /></a></td>
        <td class="center" colspan="3">
         <a class="button" onclick="editProducts('attributes', 'add');"><?php echo $button_insert_sel; ?></a>
         <a class="button" onclick="editProducts('attributes', 'del');"><?php echo $button_delete_sel; ?></a>
         <a class="button" onclick="editProducts('attributes', 'upd');"><?php echo $text_edit; ?></a>
        </td>
       </tr>
      </tfoot>
     </table>
    </form>
    </div>
    <div id="tab-options">
    <form id="form-options">
     <div id="vtab-options-form-options" class="vtabs">
      <span id="option-add-form-options"><input name="option" value="" style="width:130px;" />&nbsp;<img src="view/image/add.png" alt="<?php echo $button_insert; ?>" title="<?php echo $button_insert; ?>" /></span>
     </div>
     <div class="before" style="clear:both;"></div>
     <table class="list">
      <tr>
       <td class="center">
        <a class="button" onclick="editProducts('options', 'add');"><?php echo $button_insert_sel; ?></a>
        <a class="button" onclick="editProducts('options', 'del');"><?php echo $button_delete_sel; ?></a>
        <a class="button" onclick="editProducts('options', 'upd');"><?php echo $text_edit; ?></a>
       </td>
      </tr>
     </table>
    </form>
    </div>
    <div id="tab-specials">
    <form id="form-specials">
     <table id="special" class="list">
      <thead>
       <tr>
        <td class="left" width="1%" ></td>
        <td class="left" width="19%"><?php echo $column_customer_group; ?></td>
        <td class="left" width="20%"><?php echo $column_priority; ?></td>
        <td class="left" width="30%"><?php echo $column_price; ?></td>
        <td class="left" width="15%"><?php echo $column_date_start; ?></td>
        <td class="left" width="15%"><?php echo $column_date_end; ?></td>
       </tr>
      </thead>
      <tfoot>
       <tr>
        <td class="center"><a onclick="addSpecial('special');"><img alt="<?php echo $button_insert; ?>" title="<?php echo $button_insert; ?>" src="view/image/add.png"/></a></td>
        <td class="center" colspan="5"><a onclick="editProducts('specials', 'add');" class="button"><?php echo $text_edit; ?></a></td>
       </tr>
      </tfoot>
     </table>
    </form>
    </div>
    <div id="tab-discounts">
    <form id="form-discounts">
     <table id="discount" class="list">
      <thead>
       <tr>
        <td class="left" width="1%" ></td>
        <td class="left" width="19%"><?php echo $column_customer_group; ?></td>
        <td class="left" width="10%"><?php echo $column_quantity; ?></td>
        <td class="left" width="10%"><?php echo $column_priority; ?></td>
        <td class="left" width="30%"><?php echo $column_price; ?></td>
        <td class="left" width="15%"><?php echo $column_date_start; ?></td>
        <td class="left" width="15%"><?php echo $column_date_end; ?></td>
       </tr>
      </thead>
      <tfoot>
       <tr>
        <td class="center"><a onclick="addDiscount('discount');"><img alt="<?php echo $button_insert; ?>" title="<?php echo $button_insert; ?>" src="view/image/add.png"/></a></td>
        <td class="center" colspan="6"><a onclick="editProducts('discounts', 'add');" class="button"><?php echo $text_edit; ?></a></td>
       </tr>
      </tfoot>
     </table>
    </form>
    </div>
    <div id="tab-related">
    <form id="form-related">
     <table class="list">
      <thead>
       <tr>
        <td class="left"><?php echo $column_related; ?></td>
       </tr>
      </thead>
      <tbody>
       <tr><td class="left"><input type="text" name="related" value="" size="100" /></td></tr>
       <tr><td class="left"><div class="scrollbox" id="product-related" style="width:100%; height:250px;"></div></td></tr>
       <tr>
        <td class="center">
         <a class="button" onclick="editProducts('related', 'add');"><?php echo $button_insert_sel; ?></a>
         <a class="button" onclick="editProducts('related', 'del');"><?php echo $button_delete_sel; ?></a>
         <a class="button" onclick="editProducts('related', 'upd');"><?php echo $text_edit; ?></a>
        </td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-stores">
    <form id="form-stores">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_stores; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <div class="dd_menu" id="product_stores">
          <div class="dd_menu_title" onclick="toggle('product_stores');"><?php echo $column_stores; ?> <b style="color:red;">(0)</b></div>
          <div class="dd_menu_container">
           <?php $class = 'even'; ?>
           <div class="<?php echo $class; ?>"><input type="checkbox" name="product_stores[]" value="0" /> <?php echo $text_default; ?></div>
           <?php foreach ($stores as $store) { ?>
           <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
           <div class="<?php echo $class; ?>"><input type="checkbox" name="product_stores[]" value="<?php echo $store['store_id']; ?>" /> <?php echo $store['name']; ?></div>
           <?php } ?>
          </div>
         </div>
        </td>
        <td class="left"></td>
       </tr>
       <tr>
        <td class="center" colspan="2">
         <a class="button" onclick="editProducts('stores', 'add');"><?php echo $button_insert_sel; ?></a>
         <a class="button" onclick="editProducts('stores', 'del');"><?php echo $button_delete_sel; ?></a>
         <a class="button" onclick="editProducts('stores', 'upd');"><?php echo $text_edit; ?></a>
        </td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
    <div id="tab-downloads">
    <form id="form-downloads">
     <table class="list">
      <thead>
       <tr>
        <td class="left" width="30%"><?php echo $column_downloads; ?></td>
        <td class="left"></td>
       </tr>
      </thead>
      <tbody>
       <tr>
        <td class="left">
         <div class="dd_menu" id="product_downloads">
          <div class="dd_menu_title" onclick="toggle('product_downloads');"><?php echo $column_downloads; ?> <b style="color:red;">(0)</b></div>
          <div class="dd_menu_container">
           <?php $class = 'odd'; ?>
           <?php foreach ($downloads as $download) { ?>
           <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
           <div class="<?php echo $class; ?>"><input type="checkbox" name="product_downloads[]" value="<?php echo $download['download_id']; ?>" /> <?php echo $download['name']; ?></div>
           <?php } ?>
          </div>
         </div>
        </td>
        <td class="left"></td>
       </tr>
       <tr>
        <td class="center" colspan="2">
         <a class="button" onclick="editProducts('downloads', 'add');"><?php echo $button_insert_sel; ?></a>
         <a class="button" onclick="editProducts('downloads', 'del');"><?php echo $button_delete_sel; ?></a>
         <a class="button" onclick="editProducts('downloads', 'upd');"><?php echo $text_edit; ?></a>
        </td>
       </tr>
      </tbody>
     </table>
    </form>
    </div>
   </div>
   <!-- end links -->
   
    <table class="list">
     <thead>
      <tr>
       <td class="left" width="50%"><form id="form-delete"><a class="button" onclick="editProducts('delete', 'delete');"><?php echo $button_remove; ?></a></form></td>
       <td class="right" width="50%"><form id="form-copy"><?php echo $text_quantity_copies; ?> <input name="product_copy" type="text" value="<?php echo $quantity_copies_products; ?>" size="3" /> <a class="button" onclick="editProducts('copy', 'copy');"><?php echo $button_copy; ?></a></form></td>
      </tr>
     </thead>
    </table>
   <form id="product_container" style="display:none;"></form>
  </div>
 </div>
 <div class="go_up" onclick="javascript:window.scrollTo(0, 0);" title="<?php echo $text_up; ?>"></div>
</div>
<script type="text/javascript"><!--
var attribute_row = 0;
var option_row = 0;
var option_value_row = 0;
var special_row = 0;
var discount_row = 0;

function addAttribute(table) {
	html  = '<tbody id="attribute-row' + attribute_row + '">';
	html += '<tr class="filter">';
	html += '<td class="center"><a onclick="$(\'#' + table + ' #attribute-row' + attribute_row + '\').remove();">';
	html += '<img src="view/image/delete.png" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" /></a></td>';
	html += '<td class="left"><select name="product_attribute_group[' + attribute_row + ']" onchange="loadAttribute(\'' + table + '\', ' + attribute_row + ');">';
	html += '<option value="0"><?php echo $text_none; ?></option>';
	<?php foreach ($attributes as $attribute) { ?>
	html += '<option value="<?php echo $attribute["attribute_group_id"]; ?>"><?php echo $attribute["attribute_group_name"]; ?></option>';
	<?php } ?>
	html += '</select></td>';
	html += '<td class="left attribute_container' + attribute_row + '"><input type="text" name="product_attributes[' + attribute_row + '][name]" value="" />';
	html += '<input type="hidden" name="product_attributes[' + attribute_row + '][attribute_id]" value="" /></td>';
	html += '<td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<input name="product_attributes[' + attribute_row + '][product_attribute_description][<?php echo $language["language_id"]; ?>][text]" /> ';
	html += '<img src="view/image/flags/<?php echo $language["image"]; ?>" title="<?php echo $language["name"]; ?>" />';
	html += ' &nbsp;&nbsp;&nbsp; ';
	<?php } ?>
	html += '</td>';
	html += '</tr>';
	html += '</tbody>';
	
	$('#' + table + ' tbody.no_results').replaceWith('');
	$('#' + table + ' tfoot').before(html);
	
	attributeautocomplete(table, attribute_row);
	attribute_row++;
}

function addOptionValue(form, option_row) {
	html  = '<tbody id="option-value-row-' + form + '-' + option_value_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]">';
	html += $('#option-values-' + form + option_row).html();
	html += '</select><input type="hidden" name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
	html += '    <td class="right"><input type="text" name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value="" size="3" /></td>';
	html += '    <td class="left"><select name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][subtract]">';
	html += '      <option value="1"><?php echo $text_yes; ?></option>';
	html += '      <option value="0"><?php echo $text_no; ?></option>';
	html += '    </select></td>';
	html += '    <td class="right"><select name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" size="5" /></td>';
	html += '    <td class="right"><select name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][points_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][points]" value="" size="5" /></td>';	
	html += '    <td class="right"><select name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][weight_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="product_options[' + option_row + '][product_option_value][' + option_value_row + '][weight]" value="" size="5" /></td>';
	html += '    <td class="left"><a onclick="$(\'#option-value-row-' + form + '-' + option_value_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#' + form + ' #option-value-' + form + '-' + option_row + ' tfoot').before(html);
	
	option_value_row++;
}

function addSpecial(table) {
	html  = '<tbody id="special-row' + special_row + '">';
	html += '<tr class="filter">';
	html += '<td class="center"><a onclick="$(\'#' + table + ' #special-row' + special_row + '\').remove();"><img alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" src="view/image/delete.png"/></a></td>';
	html += '<td class="left"><select name="product_specials[' + special_row + '][customer_group_id]">';
	<?php foreach ($customer_groups as $customer_group) { ?>
	html += '<option value="<?php echo $customer_group["customer_group_id"]; ?>"><?php echo $customer_group["name"]; ?></option>';
	<?php } ?>
	html += '</select></td>';
	html += '<td class="left"><input type="text" name="product_specials[' + special_row + '][priority]"   value="" size="2" /></td>';
	html += '<td class="left">';
	
	if (table == 'special') {
		html += '<select name="product_specials[' + special_row + '][action]">';
		<?php foreach ($discount_actions as $discount_action) { ?>
		html += '<option value="<?php echo $discount_action["action"]; ?>"><?php echo $discount_action["name"]; ?></option>';
		<?php } ?>
		html += '</select>';
	}
	
	html += ' <input type="text" name="product_specials[' + special_row + '][special]" value="" /></td>';
	html += '<td class="left"><input type="text" name="product_specials[' + special_row + '][date_start]" value="" class="date" /></td>';
	html += '<td class="left"><input type="text" name="product_specials[' + special_row + '][date_end]"   value="" class="date" /></td>';
	html += '</tr>';
	html += '</tbody>';
	
	$('#' + table + ' tbody.no_results').replaceWith('');
	
	$('#' + table + ' tfoot').before(html);
	$('#' + table + ' #special-row' + special_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
	special_row++;
}

function addDiscount(table) {
	html  = '<tbody id="discount-row' + discount_row + '">';
	html += '<tr class="filter">';
	html += '<td class="center"><a onclick="$(\'#' + table + ' #discount-row' + discount_row + '\').remove();"><img alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" src="view/image/delete.png"/></a></td>';
	html += '<td class="left"><select name="product_discounts[' + discount_row + '][customer_group_id]">';
	<?php foreach ($customer_groups as $customer_group) { ?>
	html += '<option value="<?php echo $customer_group["customer_group_id"]; ?>"><?php echo $customer_group["name"]; ?></option>';
	<?php } ?>
	html += '</select></td>';
	html += '<td class="left"><input type="text" name="product_discounts[' + discount_row + '][quantity]" value="" size="2" /></td>';
	html += '<td class="left"><input type="text" name="product_discounts[' + discount_row + '][priority]" value="" size="2" /></td>';
	html += '<td class="left">';
	
	if (table == 'discount') {
		html += '<select name="product_discounts[' + discount_row + '][action]">';
		<?php foreach ($discount_actions as $discount_action) { ?>
		html += '<option value="<?php echo $discount_action["action"]; ?>"><?php echo $discount_action["name"]; ?></option>';
		<?php } ?>
		html += '</select>';
	}
	
	html += ' <input type="text" name="product_discounts[' + discount_row + '][discount]" value="" /></td>';
	html += '<td class="left"><input type="text" name="product_discounts[' + discount_row + '][date_start]" value="" class="date" /></td>';
	html += '<td class="left"><input type="text" name="product_discounts[' + discount_row + '][date_end]" value="" class="date" /></td>';
	html += '</tr>';
	html += '</tbody>';
	
	$('#' + table + ' tbody.no_results').replaceWith('');
	
	$('#' + table + ' tfoot').before(html);
	
	$('#' + table + ' #discount-row' + discount_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
	
	discount_row++;
}

function attributeautocomplete(table, attribute_row) {
	$('#' + table + ' input[name=\'product_attributes[' + attribute_row + '][name]\']').catcomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/attribute/autocomplete&token=' + token + '&filter_name=' + encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							category: item.attribute_group,
							label: item.name,
							value: item.attribute_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('#' + table + ' input[name=\'product_attributes[' + attribute_row + '][name]\']').attr('value', ui.item.label);
			$('#' + table + ' input[name=\'product_attributes[' + attribute_row + '][attribute_id]\']').attr('value', ui.item.value);
			
			return false;
		}
	});
}

function optionautocomplete(form, option_row) {
	$('#' + form + ' input[name=\'option\']').catcomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/option/autocomplete&token=' + token + '&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							category: item.category,
							label: item.name,
							value: item.option_id,
							type: item.type,
							option_value: item.option_value
						}
					}));
				}
			});
		},
		select: function(event, ui) {
			html  = '<div id="tab-option-' + form + '-' + option_row + '" class="vtabs-content">';
			html += ' <input type="hidden" name="product_options[' + option_row + '][product_option_id]" value="" />';
			html += ' <input type="hidden" name="product_options[' + option_row + '][name]" value="' + ui.item.label + '" />';
			html += ' <input type="hidden" name="product_options[' + option_row + '][option_id]" value="' + ui.item.value + '" />';
			html += ' <input type="hidden" name="product_options[' + option_row + '][type]" value="' + ui.item.type + '" />';
			html += ' <table class="form">';
			html += '  <tr>';
			html += '   <td><?php echo $entry_required; ?></td>';
			html += '   <td><select name="product_options[' + option_row + '][required]">';
			html += '    <option value="1"><?php echo $text_yes; ?></option>';
			html += '    <option value="0"><?php echo $text_no; ?></option>';
			html += '   </select></td>';
			html += '  </tr>';
			
			if (ui.item.type == 'text') {
				html += '  <tr>';
				html += '   <td><?php echo $entry_option_value; ?></td>';
				html += '   <td><input type="text" name="product_options[' + option_row + '][option_value]" value="" /></td>';
				html += '  </tr>';
			}
			
			if (ui.item.type == 'textarea') {
				html += '  <tr>';
				html += '   <td><?php echo $entry_option_value; ?></td>';
				html += '   <td><textarea name="product_options[' + option_row + '][option_value]" cols="40" rows="5"></textarea></td>';
				html += '  </tr>';
			}
			
			if (ui.item.type == 'file') {
				html += ' <tr style="display: none;">';
				html += '  <td><?php echo $entry_option_value; ?></td>';
				html += '  <td><input type="text" name="product_options[' + option_row + '][option_value]" value="" /></td>';
				html += ' </tr>';
			}
			
			if (ui.item.type == 'date') {
				html += ' <tr>';
				html += '  <td><?php echo $entry_option_value; ?></td>';
				html += '  <td><input type="text" name="product_options[' + option_row + '][option_value]" value="" class="date" /></td>';
				html += ' </tr>';
			}
			
			if (ui.item.type == 'datetime') {
				html += '  <tr>';
				html += '   <td><?php echo $entry_option_value; ?></td>';
				html += '   <td><input type="text" name="product_options[' + option_row + '][option_value]" value="" class="datetime" /></td>';
				html += '  </tr>';
			}
			
			if (ui.item.type == 'time') {
				html += '  <tr>';
				html += '   <td><?php echo $entry_option_value; ?></td>';
				html += '   <td><input type="text" name="product_options[' + option_row + '][option_value]" value="" class="time" /></td>';
				html += '  </tr>';
			}
			
			html += ' </table>';
			
			if (ui.item.type == 'select' || ui.item.type == 'radio' || ui.item.type == 'checkbox' || ui.item.type == 'image') {
				html += ' <table id="option-value-' + form + '-' + option_row + '" class="list">';
				html += '  <thead>'; 
				html += '   <tr>';
				html += '    <td class="left"><?php echo $entry_option_value; ?></td>';
				html += '    <td class="right"><?php echo $entry_quantity; ?></td>';
				html += '    <td class="left"><?php echo $entry_subtract; ?></td>';
				html += '    <td class="right"><?php echo $entry_price; ?></td>';
				html += '    <td class="right"><?php echo $entry_option_points; ?></td>';
				html += '    <td class="right"><?php echo $entry_weight; ?></td>';
				html += '    <td></td>';
				html += '   </tr>';
				html += '  </thead>';
				html += '  <tfoot>';
				html += '   <tr>';
				html += '    <td colspan="6"></td>';
				html += '    <td class="left"><a onclick="addOptionValue(\'' + form + '\', ' + option_row + ');" class="button"><?php echo $button_insert; ?></a></td>';
				html += '   </tr>';
				html += '  </tfoot>';
				html += ' </table>';
				html += ' <select id="option-values-' + form + option_row + '" style="display: none;">';
				
				for (i = 0; i < ui.item.option_value.length; i++) {
					html += '  <option value="' + ui.item.option_value[i]['option_value_id'] + '">' + ui.item.option_value[i]['name'] + '</option>';
				}
				
				html += ' </select>';
				html += '</div>';
			}
			
			$('#' + form + ' .before').before(html);
			
			$('#' + form + ' #option-add-' + form).before('<a href="#tab-option-' + form + '-' + option_row + '" id="option-' + form + '-' + option_row + '">' + ui.item.label + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#' + form + ' #vtab-options-' + form + ' a:first\').trigger(\'click\'); $(\'#option-' + form + '-' + option_row + '\').remove(); $(\'#tab-option-' + form + '-' + option_row + '\').remove(); return false;" /></a>');
			
			$('#' + form + ' #vtab-options-' + form + ' a').tabs();
			
			$('#' + form + ' #option-' + form + '-' + option_row).trigger('click');
			
			$('#' + form + ' .datetime').datetimepicker({dateFormat: 'yy-mm-dd', timeFormat: 'h:m'});
			$('#' + form + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
			$('#' + form + ' .time').timepicker({timeFormat: 'h:m'});
			
			option_row++;
			
			return false;
		}
	});
}

function relatedautocomplete(form) {
	$('#' + form + ' input[name=\'related\']').autocomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=' + token + '&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.product_id
						}
					}));
				}
			});
			
		},
		select: function(event, ui) {
			$('#' + form + ' #product-related' + ui.item.value).remove();
			$('#' + form + ' #product-related').append('<div id="product-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="product_related[]" value="' + ui.item.value + '" /></div>');
			$('#' + form + ' #product-related div:odd').attr('class', 'odd');
			$('#' + form + ' #product-related div:even').attr('class', 'even');
			
			return false;
		}
	});
}

function loadAttribute(table, row_id) {
	var attribute_group_id = $('table#' + table + ' select[name="product_attribute_group[' + row_id + ']"]').val();
	
	$.ajax({
		type: 'get',
		url: 'index.php?route=module/batch_editor/loadAttributes&token=' + token + '&table=' + table + '&row_id=' + row_id + '&attribute_group_id=' + attribute_group_id,
		beforeSend: function(data) {
			$('table#' + table + ' td.attribute_container' + row_id).html(loading);
		},
		success: function(data) {
			$('table#' + table + ' td.attribute_container' + row_id).html(data);
		}
	});
}

function selectAttribute(table, row_id) {
	var value = $('table#' + table + ' select[name="product_attributes[' + row_id + '][attribute_id]"]').val();
	var input = $('table#' + table + ' input[name="product_attributes[' + row_id + '][name]"]')
	
	if (value > 0) {
		input.attr('value', $('#' + table + ' select[name="product_attributes[' + row_id + '][attribute_id]"] option:selected').text());
	} else {
		input.attr('value', '');
	}
}

function addCKEDITOR() {
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description_edit<?php echo $language["language_id"]; ?>', {
		filebrowserBrowseUrl:      'index.php?route=common/filemanager&token=' + token,
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=' + token,
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=' + token,
		filebrowserUploadUrl:      'index.php?route=common/filemanager&token=' + token,
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=' + token,
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=' + token
	});
	<?php } ?>
}

function delCKEDITOR() {
	<?php foreach ($languages as $language) { ?>
	<!--<?php $ckeditor = 'CKEDITOR.instances.description_edit' . $language['language_id']; ?>-->
	if (<?php echo $ckeditor; ?>) {
		<?php echo $ckeditor; ?>.destroy();
	}
	<?php } ?>
}

function toggle(id) {
	$('.dd_menu .dd_menu_container').removeClass('dd_menu_shadow').hide('low');
	$('.dd_menu_title').removeClass('dd_menu_shadow');
	$('#form_list').remove();
	$('#dialog').remove();
	
	if ($('#' + id + ' .dd_menu_container').css('display') == 'none') {
		$('#' + id + ' .dd_menu_container').addClass('dd_menu_shadow').show('fast');
		$('#' + id + ' .dd_menu_title').addClass('dd_menu_shadow');
	} else {
		$('#' + id + ' .dd_menu_container').removeClass('dd_menu_shadow').hide('low');
		$('#' + id + ' .dd_menu_title').removeClass('dd_menu_shadow');
	}
}

function toggleImages(id, product_id) {
	$('.dd_menu .dd_menu_container').removeClass('dd_menu_shadow').hide('low');
	$('.dd_menu_title').removeClass('dd_menu_shadow');
	$('#form_list').remove();
	$('#dialog').remove();
	
	if ($('#' + id + ' .dd_menu_container').css('display') == 'none') {
		$.ajax({
			type: 'post',
			data: 'path=images&product_id=' + product_id,
			url: 'index.php?route=module/batch_editor/getProductList&token=' + token,
			success: function(data) {
				$('#' + id + ' .dd_menu_title').addClass('dd_menu_shadow');
				$('#' + id + ' .dd_menu_container').html(data).addClass('dd_menu_shadow').show('fast');
			}
		});
	} else {
		$('#' + id + ' .dd_menu_container').removeClass('dd_menu_shadow').hide('low').html('');
		$('#' + id + ' .dd_menu_title').removeClass('dd_menu_shadow');
	}
}

function selected_row_all(_this) {
	var array = $('input[name*="selected"]');
	
	$('#product tbody input[name*="selected"]').attr('checked', _this.checked);
	
	if (_this.checked) {
		$('#product tbody tr').addClass('selected');
	} else {
		$('#product tbody tr').removeClass('selected');
	}
}

function clearCache() {
	$.ajax({
		type: 'get',
		dataType: 'json',
		url: 'index.php?route=module/batch_editor/clearCache&token=' + token,
		success: function(message) {
			creatMessage(message);
		}
	});
}

function getProducts(data) {
	$('#product_container').fadeOut('fast');
	
	$.post('index.php?route=module/batch_editor/getProducts&token=' + token, getFilterUrl() + data, function(html) {
		$('#product_container').html(html).fadeIn('low');
	});
}

function getProductList(id, path) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog"></div>');
	
	$('#dialog').dialog({
		height: 'auto',
		width:  '90%',
		modal: true,
		bgiframe: true,
		resizable: true,
		autoOpen: false
	});
	
	$.ajax({
		type: 'post',
		data: 'path=' + path + '&product_id=' + id,
		url: 'index.php?route=module/batch_editor/getProductList&token=' + token,
		success: function(data) {
			$('#dialog').html(data).dialog('open');
		}
	});
}

function editProducts(path, action) {
	if (path == 'delete') {
		if (!confirm('<?php echo $button_remove; ?>?')) {
			return false;
		}
	}
	
	var url = 'index.php?route=module/batch_editor/editProducts&token=' + token;
	
	if (path == 'to_related') {
		var data = 'path=related&action=add&product_related[]=' + action + '&' + $('#product_container').serialize();
	} else {
		var data = 'path=' + path + '&action=' + action + '&' + $('#form-' + path).serialize() + '&' + $('#product_container').serialize();
	}
	
	$.ajax({
		type: 'post',
		dataType: 'json',
		data: data,
		url: url,
		beforeSend: function() {
			//$('#product_container').fadeOut('fast');
		},
		success: function(message) {
			if (message['success']) {
				if (path != 'to_related') {
					getProducts('');
				}
				
				creatMessage(message);
			} else {
				creatMessage(message);
			}
		}
	});
}

function editProductList(product_id, path, action) {
	if (path == 'descriptions') {
		<?php foreach ($languages as $language) { ?>
		<!--<?php $ckeditor = "CKEDITOR.instances.description_edit" . $language['language_id'] . ".getData()"; ?>-->
		$('#description<?php echo $language["language_id"]; ?>').html(<?php echo $ckeditor; ?>);
		<?php } ?>
	}
	
	$.ajax({
		type: 'post',
		dataType: 'json',
		url: 'index.php?route=module/batch_editor/editProducts&token=' + token,
		data: 'path=' + path + '&action=' + action + '&selected[]=' + product_id + '&' + $('#form_list').serialize(),
		beforeSend: function() {
			//$('#dialog').hide();
		},
		success: function(message) {
			creatMessage(message);
		}
	});
	//$('#dialog').remove();
}

function getFilterUrl() {
	url = 'index.php?route=module/batch_editor/getProducts&token=' + token;
	
	if ($('input[name=\'filter_keyword\']').val() != '') {
		url += '&' + $("#filter_keyword").serialize();
	}
	
	if (!$('input[name*=\'filter_search_in\']:checked').val() && $('input[name=\'filter_keyword\']').val()) {
		url += '&filter_search_in[name]=1';
		$('input[name=\'filter_search_in[name]\']').attr('checked', 'checked');
	}
	
	var limit = $('select[name=\'limit\']').val();
	if (limit != '' && limit != 20) { url += '&limit=' + limit; }
	
	var filter_status = $('select[name=\'filter_status\']').val();
	if (filter_status && filter_status != '*') { url += '&filter_status=' + filter_status; }
	
	var filter_subtract = $('select[name=\'filter_subtract\']').val();
	if (filter_subtract && filter_subtract != '*') { url += '&filter_subtract=' + filter_subtract; }
	
	var filter_shipping = $('select[name=\'filter_shipping\']').val();
	if (filter_shipping && filter_shipping != '*') { url += '&filter_shipping=' + filter_shipping; }
	
	var filter_price_min = $('input[name=\'filter_price[min]\']').val();
	if (filter_price_min) { url += '&filter_price[min]=' + filter_price_min; }
	
	var filter_price_max = $('input[name=\'filter_price[max]\']').val();
	if (filter_price_max) { url += '&filter_price[max]=' + filter_price_max; }
	
	var filter_quantity_min = $('input[name=\'filter_quantity[min]\']').val();
	if (filter_quantity_min) { url += '&filter_quantity[min]=' + filter_quantity_min; }
	
	var filter_quantity_max = $('input[name=\'filter_quantity[max]\']').val();
	if (filter_quantity_max) { url += '&filter_quantity[max]=' + filter_quantity_max; }
	
	var filter_sort_order_min = $('input[name=\'filter_sort_order[min]\']').val();
	if (filter_sort_order_min) { url += '&filter_sort_order[min]=' + filter_sort_order_min; }
	
	var filter_sort_order_max = $('input[name=\'filter_sort_order[max]\']').val();
	if (filter_sort_order_max) { url += '&filter_sort_order[max]=' + filter_sort_order_max; }
	
	var filter_minimum_min = $('input[name=\'filter_minimum[min]\']').val();
	if (filter_minimum_min) { url += '&filter_minimum[min]=' + filter_minimum_min; }
	
	var filter_minimum_max = $('input[name=\'filter_minimum[max]\']').val();
	if (filter_minimum_max) { url += '&filter_minimum[max]=' + filter_minimum_max; }
	
	var filter_points_min = $('input[name=\'filter_points[min]\']').val();
	if (filter_points_min) { url += '&filter_points[min]=' + filter_points_min; }
	
	var filter_points_max = $('input[name=\'filter_points[max]\']').val();
	if (filter_points_max) { url += '&filter_points[max]=' + filter_points_max; }
	
	var filter_weight_min = $('input[name=\'filter_weight[min]\']').val();
	if (filter_weight_min) { url += '&filter_weight[min]=' + filter_weight_min; }
	
	var filter_weight_max = $('input[name=\'filter_weight[max]\']').val();
	if (filter_weight_max) { url += '&filter_weight[max]=' + filter_weight_max; }
	
	var filter_length_min = $('input[name=\'filter_length[min]\']').val();
	if (filter_length_min) { url += '&filter_length[min]=' + filter_length_min; }
	
	var filter_length_max = $('input[name=\'filter_length[max]\']').val();
	if (filter_length_max) { url += '&filter_length[max]=' + filter_length_max; }
	
	var filter_width_min = $('input[name=\'filter_width[min]\']').val();
	if (filter_width_min) { url += '&filter_width[min]=' + filter_width_min; }
	
	var filter_width_max = $('input[name=\'filter_width[max]\']').val();
	if (filter_width_max) { url += '&filter_width[max]=' + filter_width_max; }
	
	var filter_height_min = $('input[name=\'filter_height[min]\']').val();
	if (filter_height_min) { url += '&filter_height[min]=' + filter_height_min; }
	
	var filter_height_max = $('input[name=\'filter_height[max]\']').val();
	if (filter_height_max) { url += '&filter_height[max]=' + filter_height_max; }
	
	var fc = $("#filter_category").serialize();
	if (fc) { url += '&' + fc };
	
	var fa = $("#filter_attribute").serialize();
	if (fa) { url += '&' + fa };
	
	var fm = $("#filter_manufacturer").serialize();
	if (fm) { url += '&' + fm };
	
	var fss = $("#filter_stock_status").serialize();
	if (fss) { url += '&' + fss };
	
	var ftc = $("#filter_tax_class").serialize();
	if (ftc) { url += '&' + ftc };
	
	var flc = $("#filter_length_class").serialize();
	if (flc) { url += '&' + flc };
	
	var fwc = $("#filter_weight_class").serialize();
	if (fwc) { url += '&' + fwc };
	
	var product_id = $("#product_container").serialize();
	if (product_id) { url += '&' + product_id };
	
	if ($('#product_container .sort a.asc').attr('href')) {
		url += '&sort=' + $('#product_container .sort a.asc').attr('href') + '&order=ASC';
	} else if ($('#product_container .sort a.desc').attr('href')) {
		url += '&sort=' + $('#product_container .sort a.desc').attr('href') + '&order=DESC';
	} else {
		url += '&sort=pd.name&order=ASC';
	}
	
	if ($('#product_container .pagination b').html()) {
		url += '&page=' + $('#product_container .pagination b').html();
	}
	
	var filter_column = $("#filter_column").serialize();
	if (filter_column) { url += '&' + filter_column };
	
	return url;
}

function creatMessage(message) {
	if (message['success']) {
		$('#message').removeClass('warning').addClass('success').html(message['success']);
	} else {
		$('#message').removeClass('success').addClass('warning').html(message['warning']);
	}
	//ShowMessage(message['success']);
	$('#message').fadeIn(700).fadeOut(3000);
}

function getImageManager(image_manager, id, list) {
	$("#product .image_manager").remove();
	
	$.get('index.php?route=module/batch_editor/getImageManager&token=' + token + '&id=' + id + '&list=' + list, function(data) {
		$('#product tbody #' + image_manager + '-' + id).after(data);
	});
}

$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';
		
		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');
				currentCategory = item.category;
			}
			
			self._renderItem(ul, item);
		});
	}
});

$(document).ready(function() {
	/*$(document).click(function(event) {
		if ($(event.target).closest("#product .image_manager").length) return;
		$("#product .image_manager").remove();
		event.stopPropagation();
	});*/
	
	$('#product input, #product select').live('keypress', function(e) {
		if (e.keyCode == 13) {
			$(this).trigger('blur');
			return false;
		}
	});
	
	$('#product tbody input[name=\'selected[]\']').live('change', function() {
		if ($(this).attr('checked') == 'checked') {
			$('#product .selected_row-' + $(this).val()).addClass('selected');
		} else {
			$('#product .selected_row-' + $(this).val()).removeClass('selected');
		}
	});
	
	$('#product tbody span').live('click', function() {
		var arr = $(this).attr('class').match(/^([a-z]*)\-([a-z\_]*)\-([0-9]*)$/);
		
		text = $(this).html().split('"').join('&quot;');
		
		if (arr[1] == 'select') {
			$.get('index.php?route=module/batch_editor/quickEditProductSelect&token=' + token + '&id=' + arr[3] + '&name=' + encodeURIComponent(text) + '&action=' + arr[2],
				function(data) {
					$('#product .' + arr[0]).replaceWith(data);
					$('#product .' + arr[0]).focus();
				}
			);
		} else if (arr[1] == 'textarea') {
			$('#product .' + arr[0]).replaceWith('<textarea class="' + arr[0] + '" rows="2">' + text + '</textarea>');
			$('#product .' + arr[0]).focus();
		} else {
			$('#product .' + arr[0]).replaceWith('<input type="text" class="' + arr[0] + '" value="' + text + '" />');
			$('#product .' + arr[0]).focus();
		}
	});
	
	$('#product tbody input, #product tbody textarea, #product tbody select').live('blur', function() {
		var arr = $(this).attr('class').match(/^([a-z]*)\-([a-z\_]*)\-([0-9]*)$/);
		
		var html = '<span class="' + arr[0] + '">';
		
		if (arr[1] == 'select') {
			var text_1 = $('#product .' + arr[0] + ' :selected').text();
		} else {
			var text_1 = $(this).val();
		}
		
		if (text != text_1) {
			var value = $(this).val();
			
			$.ajax({
				type: 'post',
				dataType: 'json',
				data: 'product_id=' + arr[3] + '&value=' + value + '&action=' + arr[2],
				url:  'index.php?route=module/batch_editor/quickEditProduct&token=' + token,
				success: function(data) {
					if (data['warning']) {
						$('#product .' + arr[0]).replaceWith(html + text + '</span>');
						
						creatMessage(data);
						//alert(data['warning']);
					} else {
							if (arr[2] == 'status') {
								if (data['value'] == 0) {
									$('#product .' + 'td_' + arr[2] + arr[3]).removeClass('enabled').addClass('disabled');
								} else {
									$('#product .' + 'td_' + arr[2] + arr[3]).removeClass('disabled').addClass('enabled');
								}
							} else if (arr[2] == 'quantity') {
								if (data['value'] <= 0) {
									$('#product .' + 'td_' + arr[2] + arr[3]).removeClass('quantity').addClass('quantity_0');
								} else {
									$('#product .' + 'td_' + arr[2] + arr[3]).removeClass('quantity_0').addClass('quantity');
								}
							} else if(arr[2] == 'model') {
							} else {
								if (data['value'] == 0) {
									$('#product .' + 'td_' + arr[2] + arr[3]).addClass('attention');
								} else {
									$('#product .' + 'td_' + arr[2] + arr[3]).removeClass('attention');
								}
							}
							
							if (arr[1] == 'select') {
								$('#product .' + arr[0]).replaceWith(html + text_1 + '</span>');
							} else if ((arr[2] == 'name' && data['value'] == '') || (arr[2] == 'model' && data['value'] == '')) {
								$('#product .' + arr[0]).replaceWith(html + text + '</span>');
							} else {
								$('#product .' + arr[0]).replaceWith(html + data['value'] + '</span>');
							}
						}
					},
					complete: function() {
						//$('#product .' + arr[0]).html(loading);
					}
				});
			} else {
				$(this).replaceWith(html + text_1 + '</span>');
			}
		});
	
	$('#product tbody .image_edit img').live('click', function() {
		$('#dialog').remove();
		
		var arr = $(this).attr('id').match(/^([a-z]*)\-([0-9]*)$/);
		var input = 'image-' + arr[2];
		
		$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=' + token + '&field=' + encodeURIComponent(input) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
		
		$('#dialog').dialog({
			title: '<?php echo $text_image_manager; ?>',
			height: 400,
			width: 800,
			modal: true,
			bgiframe: false,
			resizable: false,
			close: function (event, ui) {
				if ($('#product #' + input).val()) {
					$.ajax({
						url: 'index.php?route=common/filemanager/image&token=' + token + '&image=' + encodeURIComponent($('#product #' + input).val()),
						dataType: 'text',
						success: function() {
							$.ajax({
								type: 'post',
								dataType: 'json',
								url:  'index.php?route=module/batch_editor/quickEditProduct&token=' + token,
								data: 'product_id=' + arr[2] + '&value=' + $('#product #' + input).val() + '&action=image',
								success: function(data) {
									if (data['warning']) {
										creatMessage(data);
									} else {
										$('#product #image_remove-' + arr[2]).remove();
										$('#product #thumb-' + arr[2]).attr('src', data['value']).before('<div class="image_remove" id="image_remove-'  + arr[2] + '" title="<?php echo $button_remove; ?>"></div>');
									}
								}
							});
						}
					});
				}
			}
		});
	});
	
	$('#product tbody .image_edit div.image_remove').live('click', function() {
		if (!confirm('<?php echo $button_remove; ?>?')) {
			return false;
		}
		
		var arr = $(this).attr('id').match(/^[a-z\_]*\-([0-9]*)$/);
		
		$.ajax({
			type: 'post',
			dataType: 'json',
			url:  'index.php?route=module/batch_editor/quickEditProduct&token=' + token,
			data: 'product_id=' + arr[1] + '&value=&action=image',
			success: function(data) {
				if (data['warning']) {
					creatMessage(data);
					//alert(data['warning']);
				} else {
					$('#product #image-' + arr[1]).val();
					$('#product #thumb-' + arr[1]).attr('src', '<?php echo $no_image; ?>');
					$('#product #image_remove-' + arr[1]).replaceWith('');
				}
			}
		});
	});
	
	$('#product_container .pagination a').live('click', function() {
		var data = '&page=' + $(this).attr('href');
		
		getProducts(data);
		
		return false;
	});
	
	$('#product_container .sort a').live('click', function() {
		var data = '&sort=' + $(this).attr('href');
		
		if ($(this).attr('class') == 'asc') {
			data += '&order=DESC';
		} else {
			data += '&order=ASC';
		}
		
		getProducts(data);
		
		return false;
	});
	
	$('.dd_menu').click(function() {
		var count = $('#' + $(this).attr('id') + ' input[type=\'checkbox\']:checked').length;
		
		if (count > 0) {
			count = '<b style="color:green;">(' + count + ')</b>';
		} else {
			count = '<b style="color:red;">(' + count + ')</b>';
		}
		
		$('#' + $(this).attr('id') + ' .dd_menu_title b').replaceWith(count);
	});
	
	$('#attribute tbody').each(function(index, element) {
		attributeautocomplete('attribute', index);
	});
	
	$('#product tr').live('mouseover', function(e) {
		$(this).addClass('hover');
	});
	
	$('#product tr').live('mouseout', function(e) {
		$(this).removeClass('hover');
	});
	
	$('input[name="filter_keyword"]').autocomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=' + token + '&filter_name=' + encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return { label: item.name, value: item.product_id}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('input[name=\'filter_keyword\']').val(ui.item.label);
			return false;
		}
	});
	
	$('#tabs a').tabs();
	$('#tabs-general a').tabs();
	$('#tabs-links a').tabs();
	$('#tabs-weight-dimensions a').tabs();
	
	$('body').after('<div id="message"></div>');
	
	optionautocomplete('form-options', 0);
	
	relatedautocomplete('form-related');
	
	$('#form-related #product-related div img').live('click', function() {
		$(this).parent().remove();
		
		$('#form-related #product-related div:odd').attr('class', 'odd');
		$('#form-related #product-related div:even').attr('class', 'even');
	});
	
	<?php if ($success) { ?>
	message = {'success' : '<?php echo $success; ?>'};
	creatMessage(message);
	<?php } ?>
	
	getProducts('');
});
//--></script>
<?php echo $footer; ?>