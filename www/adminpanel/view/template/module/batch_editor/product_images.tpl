<div class="content">
 <form id="form_list">
  <table class="list" id="images_list">
   <thead>
    <tr>
     <td class="center" width="1"></td>
     <td class="center" width="1"><?php echo $column_images; ?></td>
     <td class="center"></td>
     <td class="center"><?php echo $column_sort_order; ?></td>
    </tr>
   </thead>
   <?php $image_row = 0; ?>
   <?php foreach ($product_images as $product_image) { ?>
   <tbody id="image-row<?php echo $image_row; ?>">
    <tr>
     <td class="center"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();"><img src="view/image/delete.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
     <td class="center"><div class="image"><a onclick="image_upload('product_images<?php echo $image_row; ?>', 'product_thumbs<?php echo $image_row; ?>');"><img id="product_thumbs<?php echo $image_row; ?>" src="<?php echo $product_image['thumb']; ?>" alt="" /></a></div><br /><a id="image_manager_list-<?php echo $image_row; ?>" onclick="getImageManager('image_manager_list', <?php echo $image_row; ?>, 1)"><?php echo $text_path; ?></a></td>
     
     <td class="center"><a onclick="$('#product_thumbs<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#product_images<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></td>
     
     <td class="center"><input name="product_images[<?php echo $image_row; ?>][sort_order]" type="text" value="<?php echo $product_image['sort_order']; ?>" size="2" /><input id="product_images<?php echo $image_row; ?>" name="product_images[<?php echo $image_row; ?>][image]" type="hidden" value="<?php echo $product_image['image']; ?>" /></td>
    </tr>
   </tbody>
   <?php $image_row++; ?>
   <?php } ?>
   <tfoot>
    <tr>
     <td class="center"><a onclick="addImage();"><img src="view/image/add.png" alt="<?php echo $button_insert; ?>" title="<?php echo $button_insert; ?>" /></a></td>
     <td class="center" colspan="4"><a class="button" onclick="editProductList(<?php echo $product_id; ?>, 'images', 'upd');"><?php echo $button_save; ?></a></td>
    </tr>
   </tfoot>
  </table>
 </form>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#dialog').dialog('option', 'title', '<?php echo $column_images; ?>');
});

function image_upload(image, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=' + token + '&field=' + encodeURIComponent(image) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		height: 400,
		width: 800,
		modal: true,
		bgiframe: false,
		resizable: false,
		close: function (event, ui) {
			if ($('#form_list #' + image).val()) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=' + token + '&image=' + encodeURIComponent($('#form_list #' + image).val()),
					dataType: 'text',
					success: function() {
						$.post('index.php?route=module/batch_editor/imageResize&token=' + token, 'image=' + $('#form_list #' + image).val(), function(image) {
							$('#' + thumb).attr('src', image);
						});
					}
				});
			}
			
			$('#dialog').show();
		}
	});
}

var image_row = <?php echo $image_row; ?>;

function addImage() {
	html  = '<tbody id="image-row' + image_row + '"><tr>';
	html += '<td class="center"><a onclick="$(\'#image-row' + image_row + '\').remove();"><img src="view/image/delete.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>';
	html += '<td class="center"><div class="image"><a onclick="image_upload(\'product_images' + image_row + '\', \'product_thumbs' + image_row + '\');"><img id="product_thumbs' + image_row + '" src="<?php echo $no_image; ?>" alt="" /></a></div><br /><a id="image_manager_list-' + image_row + '" onclick="getImageManager(\'image_manager_list\', ' + image_row + ', 1)"><?php echo $text_path; ?></a></td>';
	html += '<td class="center"><a onclick="$(\'#product_thumbs' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#product_images' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></td>';
	html += '<td class="center"><input id="product_images' + image_row + '" name="product_images[' + image_row + '][image]" type="hidden" value="" /><input name="product_images[' + image_row + '][sort_order]" type="text" value="" size="2" /></td></tr></tbody>';
	
	$('#images_list tfoot').before(html);
	
	image_row++;
}
</script>