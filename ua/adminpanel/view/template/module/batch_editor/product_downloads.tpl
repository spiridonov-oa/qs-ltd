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
    <tr class="">
     <td class="left">
      <div class="scrollbox" style="width:100%; height:350px;">
       <?php $class = 'odd'; ?>
       <?php foreach ($downloads as $download) { ?>
       <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
       <div class="<?php echo $class; ?>">
        <?php if (in_array($download['download_id'], $product_downloads)) { ?>
        <input type="checkbox" name="product_downloads[]" value="<?php echo $download['download_id']; ?>" checked="checked" /> <?php echo $download['name']; ?>
        <?php } else { ?>
        <input type="checkbox" name="product_downloads[]" value="<?php echo $download['download_id']; ?>" /> <?php echo $download['name']; ?>
        <?php } ?>
       </div>
       <?php } ?>
      </div>
     </td>
    </tr>
   </tbody>
   <tfoot>
    <tr>
     <td class="center"><a class="button" onclick="editProductList(<?php echo $product_id; ?>, 'downloads', 'upd');"><?php echo $button_save; ?></a></td>
    </tr>
   </tfoot>
  </table>
 </form>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#dialog').dialog('option', 'title', '<?php echo $column_downloads; ?>');
});
</script>