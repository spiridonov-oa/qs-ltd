<?php echo $header; ?>

<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php //echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="right">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } else { ?>
	  <div class="image"><span class="no-image"><img src="image/no_image.jpg" alt="<?php echo $heading_title; ?>" id="image" /></span></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional clearafter">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>

        <?php if ($videos) { ?>
        <div class="image-additional clearafter">
            <?php foreach ($videos as $video) { ?>
            <a onclick="openVideo('<?php echo $video['video']; ?>')" class="product-video" title="<?php echo $heading_title; ?>"><img src="<?php echo $video['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
            <?php } ?>

        </div>
        <?php } ?>

    </div>
    <?php } ?>
    <div class="left">
      <h1><?php echo $heading_title; ?></h1>

      <div class="cart">
          <div class="button highlight" id="button-cart"><span><?php echo $button_cart; ?></span></div>
          <input type="text" class="quantity" name="quantity" pattern="[0-9]{,7}" size="1" value="<?php echo $minimum; ?>" /> <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          <?php if ($minimum > 1) { ?>
          <div class="minimum"><?php echo $text_minimum; ?></div>
          <?php } ?>
      </div>

      <?php if ($price) { ?>
      <div class="price"><?php echo $currency; ?>
        <?php if (!$special) { ?>
		<div><span class="price-fixed"><?php echo $price; ?><?php echo $currency; ?></span></div>
        <?php } else { ?>
		<div class="special-price"><span class="price-fixed"><?php echo $special; ?><?php echo $currency; ?></span><span class="price-old"><?php echo $price; ?></span></div>
        <?php } ?>

        <?php  if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span>
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><?php echo $text_points; ?> <?php echo $points; ?></span>
        <?php } ?>
        <?php if ($discounts) { ?>
        <p class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </p>
        <?php } ?>
      </div>
      <?php } ?>

      <?php if ($review_status) { ?>
      <div class="review">
        <img src="catalog/view/theme/acceptus/image/icons/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" /><a class="show-review" href="#tabs"><?php echo $reviews; ?></a>
        <a class="new-review" href="#tabs"><?php echo $text_write; ?></a>
      </div>
      <?php } ?>

      <?php if ($attribute_groups || $options || $manufacturer || $reward || $show_stock) { ?>
          <div id="block-attribute" class="block-table">
              <div class="block-title"><span><?php echo $tab_attribute; ?></span></div>
              <table>
                  <?php if ($attribute_groups) { ?>
                      <?php foreach ($attribute_groups as $attribute_group) { ?>
                          <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                            <tr>
                                <td><strong><?php echo $attribute['name']; ?>:</strong></td>
                                <td><?php echo $attribute['text']; ?></td>
                            </tr>
                          <?php } ?>
                      <?php } ?>
                  <?php } ?>
                  <?php if ($manufacturer) { ?>
                      <tr>
                         <td><strong><?php echo $text_manufacturer; ?></strong> </td>
                         <td><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></td>
                      </tr>
                  <?php } ?>
                      <tr>
                         <td><strong><?php echo $text_model; ?></strong> </td>
                         <td><?php echo $sku; ?></td>
                      </tr>
                  <?php if ($reward) { ?>
                      <tr>
                        <td><strong><?php echo $text_reward; ?></strong>  </td>
                        <td><?php echo $reward; ?> </td>
                      </tr>
                  <?php } ?>
                  <?php if ($show_stock) { ?>
                      <tr>
                        <td><strong><?php echo $text_stock; ?></strong>  </td>
                        <td><?php echo $stock; ?> </td>
                       </tr>
                  <?php } ?>
              </table>
          </div>
          <?php if ($options) { ?>
              <div id="block-options" class="block-table">
                  <table>
                  <?php foreach ($options as $option) { ?>
                  <?php if ($option['type'] == 'link') { ?>
                  <tr>
                      <td><strong><?php echo $option['name']; ?>:</strong>
                          <?php if ($option['required']) { ?>
                          <span class="required">*</span>
                          <?php } ?>
                      </td>
                      <td>
                          <ul>
                          <?php foreach ($option['option_value'] as $option_value) { ?>
                              <?php if ($option_value['link_id'] == $product_id) {?>
                              <li><span><?php echo $option_value['name']; ?></span></li>
                              <?php }  ?>
                          <?php } ?>

                          <?php foreach ($option['option_value'] as $option_value) { ?>

                              <?php if ($option_value['link_id'] != $product_id ) { ?>
                                  <?php if ($option_value['link']) { ?>
                              <li><a href="<?php echo $option_value['link']; ?>"><?php echo $option_value['name']; ?></a></li>
                                  <?php } else { ?>
                              <li><span><?php echo $option_value['name']; ?></span></li>
                                  <?php }  ?>
                              <?php } ?>

                          <?php } ?>
                          </ul>
                      </td>
                  </tr>
                  <?php } ?>
                  <?php }?>
                  </table>
              </div>
          <?php } ?>

          <?php if ($review_status) { ?>
              <div class="block-title"><?php echo $tab_review; ?></div>
          <?php } ?>
          <?php } ?>
          
      <?php if ($profiles): ?>
      <div class="option">
          <h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
          <br />
          <select name="profile_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($profiles as $profile): ?>
              <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
              <?php endforeach; ?>
          </select>
          <br />
          <br />
          <span id="profile-description"></span>
          <br />
          <br />
      </div>
      <?php endif; ?>

      <?php if ($options) { ?>
          <div class="options">
              <?php //echo $text_option; ?>
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <select name="option[<?php echo $option['product_option_id']; ?>]">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option multi">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <div>
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              <br />
              <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option multi">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <div>
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              <br />
              <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <table class="option-image">
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <tr>
                  <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label></td>
                </tr>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
              
            <?php if ($option['type'] == 'text') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option multi">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>">
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <strong><?php echo $option['name']; ?>:</strong>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
            </div>
            <?php } ?>
            <?php } ?>
          </div>
      <?php } ?>
      

      <div id="block-description">
          <h2 class="block-title"><?php echo $tab_description; ?></h2>
          <?php echo $description; ?>
      </div>
      <div class="share clearafter"><!-- AddThis Button BEGIN -->
         <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
         <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js"></script>
        <!-- AddThis Button END -->
      </div>
    </div>

  </div>

  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
	<p class="clearafter">
    <strong><?php echo $entry_name; ?></strong>
    <input type="text" name="name" value="" />
	</p>
	<p class="clearafter">
    <strong><?php echo $entry_review; ?></strong>
    <textarea name="text" cols="40" rows="8"></textarea>
	</p>
    <p><?php echo $text_note; ?></p>
    <p>
	<strong><?php echo $entry_rating; ?></strong> <span><?php echo $entry_bad; ?></span>
    <input type="radio" name="rating" value="1" />
    <input type="radio" name="rating" value="2" />
    <input type="radio" name="rating" value="3" />
    <input type="radio" name="rating" value="4" />
    <input type="radio" name="rating" value="5" />
    <span><?php echo $entry_good; ?></span>
    </p>
    <div class="captcha-field clearafter">
      <div class="left"><strong><?php echo $entry_captcha; ?></strong></div>
      <div class="right">
        <input type="text" name="captcha" value="" />
        <p><img src="index.php?route=product/product/captcha" alt="" id="captcha" /></p>
      </div>
    </div>
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>

  


  <?php if ($products) { ?>
  <div class="box-heading"><span><?php echo $tab_related; ?></span></div>
  <div class="box-content">
    <div class="box-product product-grid">
      <?php foreach ($products as $product) { ?>
      <?php
        $thumb_width = $this->config->get('config_image_related_width');
        $thumb_height = $this->config->get('config_image_related_height');
      ?>
      <div class="item">
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>" style="<?php echo ($thumb_height < 208) ? 'line-height: 208px' : ''; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } else { ?>
        <div class="image">
			<span class="no-image" style="<?php echo ($thumb_width < 208) ? 'width: 208px' : 'width: '.$thumb_width.'px'; ?>; <?php echo ($thumb_height < 208) ? 'line-height: 208px' : 'line-height: '.$thumb_height.'px;'; ?>">
			<img src="image/no_image.jpg" alt="<?php echo $product['name']; ?>" /></span>
		</div>
        <?php } ?>
          <div class="shadow-bg" onclick="goToPage('<?php echo $product['href']; ?>')"></div>
              <div class="info-wrapper">
			  <a href="<?php echo $product['href']; ?>">
					  <div class="name"><?php echo $product['name']; ?></div>
					  <?php if ($product['rating']) { ?>
					  <div class="rating"><img
							  src="catalog/view/theme/acceptus/image/icons/stars-<?php echo $product['rating']; ?>.png"
							  alt="<?php echo $product['reviews']; ?>"/></div>
					  <?php } ?>  
			  </a>
              </div>
          <?php if ($product['price']) { ?>
                  <div class="price">
                      <?php if (!$product['special']) { ?>
                      <div><span class="price-fixed"><?php echo $product['price']; ?></span></div>
                      <?php } else { ?>
                      <div class="special-price"><span
                              class="price-fixed"><?php echo $product['special']; ?></span><span
                              class="price-old"><?php echo $product['price']; ?></span></div>
                      <?php } ?>
                  </div>
                  <?php } ?>
          
                  <a class="btn-cart" onclick="addToCart('<?php echo $product_id; ?>');">
                      <span><?php echo $button_cart; ?></span>
                  </a>
              
      </div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><strong><?php echo $text_tags; ?></strong>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script>
<script type="text/javascript"><!--

$('#button-cart').on('click',function(){
    var quantity = $('input[name=\'quantity\']').val();
    if(!isNaN(quantity)){
        var data = $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea');
        addToCart('<?php echo $product_id; ?>', quantity, data);
    }

    var text = $('.product-info input[type=\'text\']');
    var hidden = $('.product-info input[type=\'hidden\']');
    var radio = $('.product-info input[type=\'radio\']:checked');
    var checkbox = $('.product-info input[type=\'checkbox\']:checked');
    var text = $('.product-info select, .product-info textarea');
    var data = $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea');

    $('input[name=\'quantity\']').val('1');
});

$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
		dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();

			if (json['success']) {
                $('#profile-description').html(json['success']);
			}
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript">
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);

		$('.error').remove();

		if (json['success']) {
			alert(json['success']);

			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}

		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}

		$('.loading').remove();
	}
});
</script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript">
$('#review .pagination a').on('click', function() {
	$('#review').fadeOut('slow');

	$('#review').load(this.href);

	$('#review').fadeIn('slow');

	return false;
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}

			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});


function openVideo(video) {
    var width = $(window).width();
    var height = $(window).height();
    var video_width = width*0.5;
    var video_height = width*0.28125;
    var html= '';
    html += '<div id="popup-bg">';
    html += '<div class="video-wrapper" style="width: ' + width/2 + 'px; height: ' + height/2 + 'px; position: absolute; top:' + (height-video_height)/2 + 'px; left: ' + (width-video_width)/2 + 'px">';
    html += '<div id="close-popup-bg"></div>';
    html += '<iframe class="video-iframe" width="' + video_width + '" height="' + video_height + '" src="//www.youtube.com/embed/' + video + '?rel=0&autoplay=1" frameborder="0" allowfullscreen></iframe>';
    html += '</div>';
    html += '</div>';
    $('body').append(html);
    $('#popup-bg').on('click', function() {closePopup(this)}).show();
    $('#close-popup-bg').on('click', function() {closePopup('#popup-bg')}).show();
}
function closePopup(popup) {
    $(popup).hide();
    $(popup).remove();
}
</script>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<?php echo $footer; ?>