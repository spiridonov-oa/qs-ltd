<div class="content">
 <table class="form">
  <tr>
   <td width="1%"><img src="<?php echo $product_image; ?>" /></td>
   <td width="99%"><h3><?php echo $product_name; ?></h3></td>
  </tr>
 </table>
 <form id="form_list">
  <table class="form">
   <tr>
    <td><?php echo $column_categories; ?></td>
    <td>
     <div class="scrollbox" style="width:99%; height:400px;">
      <?php $class = 'odd'; ?>
      <?php foreach ($categories as $category) { ?>
      <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
      <div class="<?php echo $class; ?>">
       <?php if (in_array ($category['category_id'], $product_categories)) { ?>
       <input type="checkbox" name="product_categories[]" value="<?php echo $category['category_id']; ?>" checked="checked" /> <?php echo $category['name']; ?>
       <?php } else { ?>
       <input type="checkbox" name="product_categories[]" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?>
       <?php } ?>
      </div>
      <?php } ?>
     </div>
    </td>
   </tr>
  </table>
  <table class="list">
   <tr>
    <td class="center"><a class="button" onclick="editProductList(<?php echo $product_id; ?>, 'categories', 'upd');"><?php echo $button_save; ?></a></td>
   </tr>
  </table>
 </form>
</div>
<script type="text/javascript">
$('#dialog').dialog('option', 'title', '<?php echo $column_categories; ?>');
</script>