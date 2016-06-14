<div class="content">
 <table class="form">
  <tr>
   <td width="1%"><img src="<?php echo $product_image; ?>" /></td>
   <td width="99%"><h3><?php echo $product_name; ?></h3></td>
  </tr>
 </table>
 <form id="form_list">
  <table class="list">
   <tbody>
    <tr>
     <td class="left"><input type="text" name="related" value="" size="100" /></td>
    </tr>
    <tr>
     <td class="left">
      <div class="scrollbox" id="product-related" style="width:100%; height:350px;">
       <?php $class = 'odd'; ?>
       <?php foreach ($product_related as $product_related) { ?>
       <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
       <div id="product-related<?php echo $product_related['product_id']; ?>" class="<?php echo $class; ?>"> <?php echo $product_related['name']; ?><img src="view/image/delete.png" /><input type="hidden" name="product_related[]" value="<?php echo $product_related['product_id']; ?>" /></div>
       <?php } ?>
      </div>
     </td>
    </tr>
   </tbody>
   <tfoot>
    <tr>
     <td class="center"><a class="button" onclick="editProductList(<?php echo $product_id; ?>, 'related', 'upd');"><?php echo $button_save; ?></a></td>
    </tr>
   </tfoot>
  </table>
 </form>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#dialog').dialog('option', 'title', '<?php echo $column_related; ?>');
	
	$('#form_list #product-related div img').live('click', function() {
		$(this).parent().remove();
		
		$('#form_list #product-related div:odd').attr('class', 'odd');
		$('#form_list #product-related div:even').attr('class', 'even');
	});
	
	relatedautocomplete('form_list');
});
</script>