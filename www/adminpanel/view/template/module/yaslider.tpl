<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/yaslider/ya_ico.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" id="form" enctype="multipart/form-data" class="form-horizontal">
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> </div>
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <div id="language-<?php echo $module_row; ?>" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
            <fieldset>
              <legend>Language settings</legend>
              <div class="control-group">
                <label class="control-label">Buy button text</label>
                <div class="controls">
                  <input class="span2" type="text" name="yaslider_module[<?php echo $module_row; ?>][buy_text][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['buy_text'][$language['language_id']]) ? $module['buy_text'][$language['language_id']] : ''; ?>" />
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Details button text</label>
                <div class="controls">
                  <input class="span2" type="text" name="yaslider_module[<?php echo $module_row; ?>][details_text][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['details_text'][$language['language_id']]) ? $module['details_text'][$language['language_id']] : ''; ?>" />
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Heading</label>
                <div class="controls">
                  <select class="span1" name="yaslider_module[<?php echo $module_row; ?>][show_heading]">
                    <?php if ($module['show_heading']) { ?>
                    <option value="1" selected="selected">Yes</option>
                    <option value="0">No</option>
                    <?php } else { ?>
                    <option value="1">Yes</option>
                    <option value="0" selected="selected">No</option>
                    <?php } ?>
                  </select>
                  <input class="span4" type="text" name="yaslider_module[<?php echo $module_row; ?>][heading_text][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['heading_text'][$language['language_id']]) ? $module['heading_text'][$language['language_id']] : ''; ?>" />
                  <span class="help-inline">It will be shown above yaSlider</span>
                </div>
              </div>
            </fieldset>
          </div>
          <?php } ?>
          <fieldset>
            <legend>Products settings</legend>
            <div class="control-group">
              <label class="control-label">Search products</label>
              <div class="controls">
                <input class="span2" type="text" name="product-search[<?php echo $module_row; ?>]" value="" />
                <span class="help-inline">Start typing name of the product...</span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Selected products</label>
              <div class="controls">
                <div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($module['products'] as $product) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="yaslider-product_<?php echo $module_row; ?>_<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" />
                    <input type="hidden" value="<?php echo $product['product_id']; ?>" />
                  </div>
                  <?php } ?>
                </div>
                <input type="hidden" name="yaslider_module[<?php echo $module_row; ?>][products_ids]" value="<?php echo $module['products_ids']; ?>" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Description</label>
              <div class="controls">
                <select class="span1" name="yaslider_module[<?php echo $module_row; ?>][show_description]">
                  <?php if ($module['show_description']) { ?>
                  <option value="1" selected="selected">Yes</option>
                  <option value="0">No</option>
                  <?php } else { ?>
                  <option value="1">Yes</option>
                  <option value="0" selected="selected">No</option>
                  <?php } ?>
                </select> &nbsp;&nbsp; 
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][description_length]" value="<?php echo isset($module['description_length']) ? $module['description_length'] : ''; ?>" />
                <span class="help-inline">Type number of symbols to display (eg. 100)</span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Image width&height</label>
              <div class="controls">
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][image_width]" value="<?php echo isset($module['image_width']) ? $module['image_width'] : ''; ?>" /> x 
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][image_height]" value="<?php echo isset($module['image_height']) ? $module['image_height'] : ''; ?>" />
                <span class="help-inline">For better look, use same width&height (perfect size is: 200x200)</span>
              </div>
            </div>
          </fieldset>
          <fieldset>
            <legend>Slider settings</legend>
            <div class="control-group">
              <label class="control-label">Slideshow timeout</label>
              <div class="controls">
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][slider_timeout]" value="<?php echo isset($module['slider_timeout']) ? $module['slider_timeout'] : ''; ?>" />
                <span class="help-inline">Time in milliseconds between each slide (eg. 7000)</span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Slideshow effect</label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][slider_effect]">
                  <?php foreach ($slider_effect as $effect) { ?>
                  <?php if ($module['slider_effect'] == $effect['effect']) { ?>
                  <option value="<?php echo $effect['effect']; ?>" selected="selected"><?php echo $effect['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $effect['effect']; ?>"><?php echo $effect['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Randomize slides</label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][slider_random]">
                  <?php if ($module['slider_random']) { ?>
                  <option value="1" selected="selected">Yes</option>
                  <option value="0">No</option>
                  <?php } else { ?>
                  <option value="1">Yes</option>
                  <option value="0" selected="selected">No</option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Slider width&height</label>
              <div class="controls">
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][slider_width]" value="<?php echo isset($module['slider_width']) ? $module['slider_width'] : ''; ?>" /> x 
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][slider_height]" value="<?php echo isset($module['slider_height']) ? $module['slider_height'] : ''; ?>" />
                <span class="help-inline">Width and height in pixels. For homepage use 976x260 </span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Slider style</label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][slider_style]">
                  <?php foreach ($slider_style as $style) { ?>
                  <?php if ($module['slider_style'] == $style['style']) { ?>
                  <option value="<?php echo $style['style']; ?>" selected="selected"><?php echo $style['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $style['style']; ?>"><?php echo $style['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Slider color</label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][slider_color]">
                  <?php foreach ($slider_color as $color) { ?>
                  <?php if ($module['slider_color'] == $color['color']) { ?>
                  <option value="<?php echo $color['color']; ?>" selected="selected"><?php echo $color['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $color['color']; ?>"><?php echo $color['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Badge</label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][slider_badge]">
                  <?php foreach ($slider_badge as $badge) { ?>
                  <?php if ($module['slider_badge'] == $badge['badge']) { ?>
                  <option value="<?php echo $badge['badge']; ?>" selected="selected"><?php echo $badge['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $badge['badge']; ?>"><?php echo $badge['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
          </fieldset>
          <fieldset>
            <legend>Position settings</legend>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_layout; ?></label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][layout_id]">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
                <span class="help-inline">Where yaSlider will be placed</span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_position; ?></label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][position]">
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php echo $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php echo $text_column_right; ?></option>
                  <?php } ?>
                </select>
                <span class="help-inline">Left and Right positions are not recommended</span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
                <select class="span2" name="yaslider_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
                <span class="help-inline">Turn module on/off</span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_sort_order; ?></label>
              <div class="controls">
                <input class="span1" type="text" name="yaslider_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" />
                <span class="help-inline">If you want module at very top of the page &mdash; type 0 (or even -1)</span>
              </div>
            </div>
          </fieldset>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

$('input[name^="product-search"]').live('focus', function(){
  $(this).autocomplete({
    delay: 0,
    source: function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
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
      var box = $(this).closest('.control-group').next().find('.scrollbox');
      var module_row = parseInt(box.next('input').attr('name'));
      $('#yaslider-product_'+module_row+'_'+ui.item.value).remove();
      $(box).append('<div id="yaslider-product_'+module_row+'_'+ ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" value="' + ui.item.value + '" /></div>');
      $('div:odd', box).attr('class', 'odd');
      $('div:even', box).attr('class', 'even');
      data = $.map($('input', box), function(element){
        return $(element).attr('value');
      });
      $(box).parent().children('input').attr('value', data.join());		

      return false;
    }
  });
});

$('.scrollbox div img').live('click', function() {
  var box = $(this).closest('.scrollbox');
  $(this).parent().remove();
  $('div:odd', box).attr('class', 'odd');
  $('div:even', box).attr('class', 'even');
  data = $.map($('input', box), function(element){
    return $(element).attr('value');
  });
  $(box).next('input').attr('value', data.join());
});
	
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '  <div id="language-' + module_row + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
	html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    <?php } ?>
	html += '  </div>';

	<?php foreach ($languages as $language) { ?>
	html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	html += '      <fieldset>';
	html += '        <legend>Language settings</legend>';
	html += '        <div class="control-group">';
	html += '          <label class="control-label">Buy button text</label>';
	html += '          <div class="controls">';
	html += '            <input class="span2" type="text" name="yaslider_module[' + module_row + '][buy_text][<?php echo $language['language_id']; ?>]" value="" />';
	html += '          </div>';
	html += '        </div>';
	html += '        <div class="control-group">';
	html += '          <label class="control-label">Details button text</label>';
	html += '          <div class="controls">';
	html += '              <input class="span2" type="text" name="yaslider_module[' + module_row + '][details_text][<?php echo $language['language_id']; ?>]" value="" />';
	html += '                </div>';
	html += '              </div>';
 	html += '             <div class="control-group">';
	html += '                <label class="control-label">Heading</label>';
	html += '                <div class="controls">';
	html += '                  <select class="span1" name="yaslider_module[' + module_row + '][show_heading]">';
	html += '                    <option value="1" selected="selected">Yes</option>';
	html += '                    <option value="0">No</option>';
	html += '                  </select>';
	html += '                  <input class="span4" type="text" name="yaslider_module[' + module_row + '][heading_text][<?php echo $language['language_id']; ?>]" value="" />';
	html += '                  <span class="help-inline">It will be shown above yaSlider</span>';
	html += '                </div>';
	html += '              </div>';
	html += '      </fieldset>';
	html += '    </div>';
	<?php } ?>

	html += '          <fieldset>';
	html += '            <legend>Products settings</legend>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Search products</label>';
	html += '              <div class="controls">';
	html += '                <input class="span2" type="text" name="product-search['+module_row+']" value="" /><span class="help-inline">Start typing name of the product...</span>';
	html += '              </div>';
	html += '            </div>';
 	html += '            <div class="control-group">';
	html += '              <label class="control-label">Selected products</label>';
	html += '              <div class="controls">';
	html += '                <div class="scrollbox">';
	html += '                </div>';
	html += '                <input type="hidden" name="yaslider_module['+module_row+'][products_ids]" value="" />';
	html += '              </div>';
	html += '            </div>';

	html += '            <div class="control-group">';
	html += '              <label class="control-label">Description</label>';
	html += '              <div class="controls">';
	html += '                <select class="span1" name="yaslider_module['+module_row+'][show_description]">';
	html += '                  <option value="1" selected="selected">Yes</option>';
	html += '                  <option value="0">No</option>';
	html += '                </select> &nbsp;&nbsp; ';
	html += '                <input class="span1" type="text" name="yaslider_module['+module_row+'][description_length]" value="" />';
	html += '                <span class="help-inline">Type number of symbols to display (eg. 100)</span>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Image width&height</label>';
	html += '              <div class="controls">';
	html += '                <input class="span1" type="text" name="yaslider_module['+module_row+'][image_width]" value="" /> x ';
	html += '                <input class="span1" type="text" name="yaslider_module['+module_row+'][image_height]" value="" /> ';
	html += '                <span class="help-inline">For better look, use same width&height (perfect size is: 200x200)</span>';
	html += '              </div>';
	html += '            </div>';
	html += '          </fieldset>';

	html += '          <fieldset>';
	html += '            <legend>Slider settings</legend>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Slideshow timeout</label>';
	html += '              <div class="controls">';
	html += '                <input class="span1" type="text" name="yaslider_module['+module_row+'][slider_timeout]" value="" />';
	html += '                <span class="help-inline">Time in milliseconds between each slide (eg. 7000)</span>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Slideshow effect</label>';
	html += '              <div class="controls">';
	html += '                <select class="span2" name="yaslider_module['+module_row+'][slider_effect]">';
                 <?php foreach ($slider_effect as $effect) { ?>
	html += '                  <option value="<?php echo $effect['effect']; ?>"><?php echo $effect['title']; ?></option>';
	         <?php } ?>

	html += '                </select>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Randomize slides</label>';
	html += '              <div class="controls">';
	html += '                <select class="span2" name="yaslider_module['+module_row+'][slider_random]">';
	html += '                  <option value="1" selected="selected">Yes</option>';
	html += '                  <option value="0">No</option>';
	html += '                </select>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Slider width&height</label>';
	html += '              <div class="controls">';
	html += '                <input class="span1" type="text" name="yaslider_module['+module_row+'][slider_width]" value="" /> x ';
	html += '                <input class="span1" type="text" name="yaslider_module['+module_row+'][slider_height]" value="" />';
	html += '                <span class="help-inline">Width and height in pixels. For homepage use 976x260 </span>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Slider style</label>';
	html += '              <div class="controls">';
	html += '                <select class="span2" name="yaslider_module['+module_row+'][slider_style]">';
	                  <?php foreach ($slider_style as $style) { ?>
	html += '                  <option value="<?php echo $style['style']; ?>"><?php echo $style['title']; ?></option>';
	                  <?php } ?>
	html += '                </select>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Slider color</label>';
	html += '              <div class="controls">';
	html += '                <select class="span2" name="yaslider_module['+module_row+'][slider_color]">';
	                  <?php foreach ($slider_color as $color) { ?>
	html += '                  <option value="<?php echo $color['color']; ?>"><?php echo $color['title']; ?></option>';
	                  <?php } ?>
	html += '                </select>';
	html += '              </div>';
	html += '            </div>';
	html += '            <div class="control-group">';
	html += '              <label class="control-label">Badge</label>';
	html += '              <div class="controls">';
	html += '                <select class="span2" name="yaslider_module['+module_row+'][slider_badge]">';
	                  <?php foreach ($slider_badge as $badge) { ?>
	html += '                  <option value="<?php echo $badge['badge']; ?>"><?php echo $badge['title']; ?></option>';
	                  <?php } ?>
	html += '                </select>';
	html += '              </div>';
	html += '            </div>';
	html += '          </fieldset>';

	html += '  <fieldset>';
	html += '    <legend>Position settings</legend>';
	html += '    <div class="control-group">';
	html += '      <label class="control-label"><?php echo $entry_layout; ?></label>';
	html += '      <div class="controls">';
	html += '        <select class="span3" name="yaslider_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '          <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '        </select>';
	html += '      </div>';
	html += '    </div>';
	html += '    <div class="control-group">';
	html += '      <label class="control-label"><?php echo $entry_position; ?></label>';
	html += '      <div class="controls">';
	html += '        <select class="span3" name="yaslider_module[' + module_row + '][position]">';
	html += '          <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '          <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '          <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '          <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '        </select>';
	html += '      </div>';
	html += '    </div>';
	html += '    <div class="control-group">';
	html += '      <label class="control-label"><?php echo $entry_status; ?></label>';
	html += '      <div class="controls">';
	html += '        <select class="span3" name="yaslider_module[' + module_row + '][status]">';
	html += '          <option value="1"><?php echo $text_enabled; ?></option>';
	html += '          <option value="0"><?php echo $text_disabled; ?></option>';
	html += '        </select>';
	html += '      </div>';
	html += '    </div>';
	html += '    <div class="control-group">';
	html += '      <label class="control-label"><?php echo $entry_sort_order; ?></label>';
	html += '      <div class="controls">';
	html += '        <input class="span1" type="text" name="yaslider_module[' + module_row + '][sort_order]" value="" size="3" />';
	html += '      </div>';
	html += '    </div>';
	html += '  </fieldset>'; 
	html += '</div>';
	
	$('#form').append(html);
	
	
	$('#language-' + module_row + ' a').tabs();
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<?php echo $footer; ?>