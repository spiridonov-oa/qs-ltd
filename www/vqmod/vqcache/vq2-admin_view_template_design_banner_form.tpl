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
      <h1><img src="view/image/banner.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_name; ?></td>
            <td><input type="text" name="name" value="<?php echo $name; ?>" size="100" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="status">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
        </table>
        <table id="images" class="list">
          <thead>
            <tr>
              <td class="left" style="width: 160px"><?php echo $entry_title; ?></td>
              <td class="left" style="width: 700px"><?php echo $entry_link; ?></td>
              <td class="left"><?php echo $entry_image; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $image_row = 0; ?>
          <?php foreach ($banner_images as $banner_image) { ?>
          <tbody id="image-row<?php echo $image_row; ?>">
            <tr>
              <td class="left"><?php foreach ($languages as $language) { ?>
                <input type="text" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($banner_image['banner_image_description'][$language['language_id']]) ? $banner_image['banner_image_description'][$language['language_id']]['title'] : ''; ?>" />
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                <?php if (isset($error_banner_image[$image_row][$language['language_id']])) { ?>
                <span class="error"><?php echo $error_banner_image[$image_row][$language['language_id']]; ?></span>
                       <?php } ?>
                       <?php } ?>
                       <p><?php echo $entry_link; ?></p>
                       <input type="text" name="banner_image[<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" />
                       </td>


              <td class="left banner-link-list">
                        <table id="banner_image_<?php echo $image_row; ?>" style="border: none; width: 100%">
                            <?php if(!empty($banner_image['banner_link_description'])) { ?>
                                <?php for ($sort_order = 0; $sort_order <= count($banner_image['banner_link_description']); $sort_order++ ) { ?>
                                <tr id="banner_link_<?php echo $image_row; ?><?php echo $sort_order; ?>" class="banner-link">
                                    <td style="border: none;"><?php echo $sort_order; ?></td>
                                    <td style="border: none;">
                                    <?php foreach ($languages as $language) { ?>
                                        <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                                        <input type="text" size="40" name="banner_image[<?php echo $image_row; ?>][banner_link_description][<?php echo $sort_order; ?>][<?php echo $language['language_id']; ?>][text]" value="<?php echo $banner_images[$image_row]['banner_link_description'][$sort_order][$language['language_id']]['text'] ?>" placeholder="Text"/>
                                        </br>
                                    <?php } ?>
                                    </td>
                                    <td style="border: none;">
                                    <?php foreach ($languages as $language) { ?>
                                        <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                                        <input type="text" size="40" name="banner_image[<?php echo $image_row; ?>][banner_link_description][<?php echo $sort_order ?>][<?php echo $language['language_id']; ?>][link]; ?>" value="<?php echo $banner_images[$image_row]['banner_link_description'][$sort_order][$language['language_id']]['link']; ?>" placeholder="link http://" />
                                        </br>
                                    <?php } ?>
                                    </td>
                                    <td style="border: none;"><p class="button" onclick="deleteBannerLink(<?php echo $image_row; ?>, <?php echo $sort_order; ?>)">Delete <?php echo $sort_order; ?></p></td>
                                </tr>
                                <?php } ?>
                            <?php } else { ?>
                                <tr id="banner_link_<?php echo $image_row; ?>0" class="banner-link">
                                    <td style="border: none;">0</td>
                                    <td style="border: none;">
                                        <?php foreach ($languages as $language) { ?>
                                            <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                                            <input type="text" size="40" name="banner_image[<?php echo $image_row; ?>][banner_link_description][0][<?php echo $language['language_id']; ?>][text]" value="" placeholder="Text"/>
                                            </br>
                                        <?php } ?>
                                    </td>
                                    <td style="border: none;">
                                        <?php foreach ($languages as $language) { ?>
                                            <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                                            <input type="text" size="40" name="banner_image[<?php echo $image_row; ?>][banner_link_description][0][<?php echo $language['language_id']; ?>][link]; ?>" value="" placeholder="link http://" />
                                            </br>
                                        <?php } ?>
                                    </td>
                                    <td style="border: none;"><p class="button" onclick="deleteBannerLink()">Delete 0</p></td>
                                </tr>
                            <?php } ?>
                            <tr><td style="border: none;" colspan="4"></td></tr>
                        </table>
                        <p onclick="addNewBannerLink(<?php echo $image_row; ?>, <?php echo count($banner_image['banner_link_description']); ?>)" class="button">Add</p>
                    </td>
              <td class="left"><div class="image"><img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                  <input type="hidden" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image<?php echo $image_row; ?>"  />
                  <br />
                  <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
              <td class="left"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $image_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="left"><a onclick="addImage();" class="button"><?php echo $button_add_banner; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
    html  = '<tbody id="image-row' + image_row + '">';
	html += '<tr>';
    html += '<td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<input type="text" name="banner_image[' + image_row + '][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
    <?php } ?>
	html += '</td>';	
	html += '<td class="left"><input type="text" name="banner_image[' + image_row + '][link]" value="" /></td>';	
	html += '<td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '<td class="left"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '</tr>';
	html += '</tbody>'; 
	
	$('#images tfoot').before(html);
	
	image_row++;
}
//--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> <style type="text/css">
                            .list .banner-link td {
                                padding-bottom: 10px;
                            }
                            .list .banner-link-list .button {
                                background: #003A88;
                                color: #fff;
                                text-align: center;
                                width: 100px;
                                padding: 4px;
                            }
                        </style>
                        <script type="text/javascript">
                            var number_new_banner_link = [];
                            var html = '';

                            var languages = [];
                            <?php foreach ($languages as $key => $language) { ?>
                                languages['<?php echo $key; ?>'] = [];
                                languages['<?php echo $key; ?>']['language_id'] = <?php echo $language['language_id']; ?>;
                                languages['<?php echo $key; ?>']['image'] = '<?php echo $language['image']; ?>';
                                languages['<?php echo $key; ?>']['name'] = '<?php echo $language['name']; ?>';
                            <?php } ?>

                            function addNewBannerLink (image_row, count_banner_link) {
                                var banner_link_id;
                                html = '';
                                if(number_new_banner_link[image_row]){
                                    banner_link_id = count_banner_link + number_new_banner_link[image_row];
                                }else{
                                    banner_link_id = count_banner_link;
                                    number_new_banner_link[image_row] = 0;
                                }

                                html += '<tr id="banner_link_'+image_row+''+banner_link_id+'" class="banner-link" >';
                                html += '<td style="border: none;">'+banner_link_id+'</td>';
                                html += '<td style="border: none;">';
                                for(var key in languages) {
                                    var language = languages[key]['language_id'];
                                    html += '<img src="view/image/flags/'+languages[key]['image']+'" title="'+languages[key]['name']+'" />';
                                    html += '<input type="text" size="40" name="banner_image['+image_row+'][banner_link_description]['+banner_link_id+']['+language+'][text]" value="" placeholder="Text"/>';
                                    html += '</br>';
                                }
                                html += '</td>';
                                html += '<td style="border: none;">';
                                for(var key in languages) {
                                    var language = languages[key]['language_id'];
                                    html += '<img src="view/image/flags/'+languages[key]['image']+'" title="'+languages[key]['name']+'" />';
                                    html += '<input type="text" size="40" name="banner_image['+image_row+'][banner_link_description]['+banner_link_id+']['+language+'][link]; ?>" value="" placeholder="link http://" />';
                                    html += '</br>';
                                }
                                html += '</td>';
                                html += '<td style="border: none;"><p class="button" onclick="deleteBannerLink(' + image_row + ', ' + banner_link_id + ')">Delete '+banner_link_id+'</p></td>';
                                html += '</tr>';
                                $("#banner_image_"+image_row).append(html);

                                number_new_banner_link[image_row]++;
                            }

                            function deleteBannerLink (image_row, banner_link_id) {
                                if(image_row && banner_link_id) {
                                    var banner_link_class = '#banner_link_' + image_row + '' + banner_link_id;
                                    $(banner_link_class).remove();
                                    number_new_banner_link[image_row]--;
                                }
                                if(banner_link_id == 0){
                                    addNewBannerLink(image_row,0);
                                }
                            }

                        </script>
<?php echo $footer; ?>