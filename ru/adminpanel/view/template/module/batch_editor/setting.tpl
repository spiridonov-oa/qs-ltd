<?php echo $header; ?>
<div id="content">
 <div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
 </div>
 <?php if ($warning) { ?>
 <div class="warning"><?php echo $warning; ?></div>
 <?php } ?>
 <div class="box">
  <div class="heading">
   <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_title; ?></h1>
   <div class="buttons">
    <a class="button" onclick="$('#form_setting').submit();"><?php echo $button_save; ?></a>
    <a class="button" onclick="location = '<?php echo $cancel; ?>';"><?php echo $button_cancel; ?></a>
   </div>
  </div>
  <div class="content">
   <form id="form_setting" action="<?php echo $action; ?>" method="post">
    <table class="list" id="limits">
     <thead>
      <tr>
       <td class="center" width="1"></td>
       <td class="left"><?php echo $column_limit; ?></td>
      </tr>
     </thead>
     <?php $limit_row = 0; ?>
     <?php foreach ($limits as $limit) { ?>
     <tbody id="limit-<?php echo $limit_row; ?>">
      <tr>
       <td class="center"><a onclick="$('#limits #limit-<?php echo $limit_row; ?>').remove();"><img src="view/image/delete.png" /></a></td>
       <td class="left"><div><input name="batch_editor_setting[limits][]" value="<?php echo $limit; ?>" /></div></td>
      </tr>
     </tbody>
     <?php $limit_row++; ?>
     <?php } ?>
     <tfoot>
      <tr>
       <td class="center"><a onclick="addLimit();"><img src="view/image/add.png" /></a></td>
       <td></td>
      </tr>
     </tfoot>
    </table>
    <table class="list">
     <thead>
      <tr>
       <td class="left"><?php echo $column_columns; ?></td>
      </tr>
     </thead>
     <tbody>
      <tr>
       <td class="left">
        <div class="scrollbox" style="width:100%; height:350px;">
         <?php $class = 'even'; ?>
         <?php foreach ($columns as $column => $value) { ?>
         <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
         <div class="<?php echo $class; ?>">
          <?php if (in_array ($column, $columns_setting)) { ?>
          <input type="checkbox" name="batch_editor_setting[columns][]" value="<?php echo $column; ?>" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="batch_editor_setting[columns][]" value="<?php echo $column; ?>" />
          <?php } ?>
          <?php echo ${'column_' . $column}; ?>
         </div>
         <?php } ?>
        </div>
       </td>
      </tr>
     </tbody>
    </table>
   </form>
  </div>
 </div>
</div>
<script type="text/javascript">
var limit_row = <?php echo $limit_row; ?>

function addLimit() {
	$('#limits tfoot').before('<tbody id="limit-' + limit_row + '"><tr><td class="center"><a onclick="$(\'#limits #limit-' + limit_row + '\').remove();"><img src="view/image/delete.png" /></a></td><td class="left"><div><input name="batch_editor_setting[limits][]" value="" /></div></td></tr></tbody>');
	
	limit_row++;
}
</script>
<?php echo $footer; ?>