<?php echo $header; ?>
<?php if ($attention) { ?>
<div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="box">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?>
    <?php if ($weight) { ?>
    &nbsp;(<?php echo $weight; ?>)
    <?php } ?>
  </h1>



  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <div class="cart-info order-products">
          <?php if(is_array($products) && !empty($products)) { ?>
        <table class="list">
        <thead>
          <tr>
            <td class="image"><?php echo $column_image; ?></td>
            <td class="name"><?php echo $column_name; ?></td>
            <td class="quantity"><?php echo $column_quantity; ?></td>
            <td class="price"><?php echo $column_price; ?></td>
            <td class="total"><?php echo $column_total; ?></td>
            <td class="remove"></td>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $product) { ?>
            <?php if($product['recurring']): ?>
              <tr>
                  <td colspan="6" style="border:none;"><image src="catalog/view/theme/acceptus/image/reorder.png" alt="" title="" style="float:left;" /><span style="float:left;line-height:18px; margin-left:10px;">
                      <strong><?php echo $text_recurring_item ?></strong>
                      <?php echo $product['profile_description'] ?>
                  </td>
                </tr>
            <?php endif; ?>
          <tr>
            <td class="image"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?></td>
            <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
              <?php if (!$product['stock']) { ?>
              <span class="stock">***</span>
              <?php } ?>
              <?php if ($product['option']) { ?>
              <div>
                <?php foreach ($product['option'] as $option) { ?>
                - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                <?php } ?>
                <?php if($product['recurring']): ?>
                - <small><?php echo $text_payment_profile ?>: <?php echo $product['profile_name'] ?></small>
                <?php endif; ?>
              </div>
              <?php } ?>
              <?php if ($product['reward']) { ?>
              <div>
              <small><?php echo $product['reward']; ?></small>
              <?php } ?>
              </div>
            </td>
            <td class="quantity"><input class="quantity-input" type="text" data-product-key="<?php echo $product['key']; ?>" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" /></td>
            <td class="price"><?php echo $product['price']; ?></td>
            <td class="total"><?php echo $product['total']; ?></td>
            <td class="remove"><a href="<?php echo $product['remove']; ?>"><i class="close-icon" title="<?php echo $button_remove; ?>" >×</i></a></td>
          </tr>
          <?php } ?>
          <?php foreach ($vouchers as $vouchers) { ?>
          <tr>
            <td class="image"></td>
            <td class="name"><?php echo $vouchers['description']; ?></td>
            <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" /></td>
            <td class="price"><?php echo $vouchers['amount']; ?></td>
            <td class="total"><?php echo $vouchers['amount']; ?></td>
            <td class="remove"><a href="<?php echo $vouchers['remove']; ?>"><i class="close-icon" title="<?php echo $button_remove; ?>" >×</i></a></td>
          </tr>
          <?php } ?>
        </tbody>
        </table>
        <?php } ?>


        <?php if (!empty($recent_products)) { ?>
        <h3 class="recent-products">Recent products</h3>
        <table class="list">
            <thead>
            <tr>
                <td class="image"><?php echo $column_image; ?></td>
                <td class="name"><?php echo $column_name; ?></td>
                <td class="quantity"><?php echo $column_quantity; ?></td>
                <td class="price"><?php echo $column_price; ?></td>
                <td class="total"><?php echo $column_total; ?></td>
                <td class="remove"></td>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($recent_products as $product) { ?>
            <?php if($product['recurring']): ?>
            <tr>
                <td colspan="6" style="border:none;"><image src="catalog/view/theme/acceptus/image/reorder.png" alt="" title="" style="float:left;" /><span style="float:left;line-height:18px; margin-left:10px;">
                    <strong><?php echo $text_recurring_item ?></strong>
                    <?php echo $product['profile_description'] ?>
                </td>
            </tr>
            <?php endif; ?>
            <tr>
                <td class="image"><?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                    <?php } ?></td>
                <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                    <?php if (!$product['stock']) { ?>
                    <span class="stock">***</span>
                    <?php } ?>
                    <?php if ($product['option']) { ?>
                    <div>
                        <?php foreach ($product['option'] as $option) { ?>
                        - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                        <?php } ?>
                        <?php if($product['recurring']): ?>
                        - <small><?php echo $text_payment_profile ?>: <?php echo $product['profile_name'] ?></small>
                        <?php endif; ?>
                    </div>
                    <?php } ?>
                    <?php if ($product['reward']) { ?>
                    <div>
                        <small><?php echo $product['reward']; ?></small>
                        <?php } ?>
                    </div>
                </td>
                <td class="quantity"><input class="quantity-input" type="text" data-product-key="<?php echo $product['key']; ?>" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" /></td>
                <td class="price"><?php echo $product['price']; ?></td>
                <td class="total"><?php echo $product['total']; ?></td>
                <td class="remove"><a href="<?php echo $product['removeRecent']; ?>"><i class="close-icon" title="<?php echo $button_remove; ?>" >×</i></a></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $vouchers) { ?>
            <tr>
                <td class="image"></td>
                <td class="name"><?php echo $vouchers['description']; ?></td>
                <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" />
                    &nbsp;<a href="<?php echo $vouchers['remove']; ?>"><img src="catalog/view/theme/acceptus/image/icons/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
                <td class="price"><?php echo $vouchers['amount']; ?></td>
                <td class="total"><?php echo $vouchers['amount']; ?></td>
                <td class="remove"><a href="<?php echo $vouchers['remove']; ?>"><i class="close-icon" title="<?php echo $button_remove; ?>" >×</i></a></td>
            </tr>
            <?php } ?>
            </tbody>
        </table>
        <?php } ?>





        <div class="cart-total">
            <?php if(!empty($products) || !empty($recent_products)) {?>
            <div class="buttons">
                    <a href="<?php echo $checkout; ?>" class="button btn-checkout green"><?php echo $button_checkout; ?></a>
                    <a href="<?php echo $continue; ?>" class="button btn-continue"><?php echo $button_shopping; ?></a>
            </div>
            <table id="total">
                <?php foreach ($totals as $key => $total) { ?>
                <tr>
                    <td><strong><?php echo $total['title']; ?>:</strong></td>
                    <td class="total total-<?php echo $key; ?>"><?php echo $total['text']; ?></td>
                </tr>
                <?php } ?>
            </table>
            <?php } else { ?>
            <div class="buttons">
                <div class="center">
                    <a href="<?php echo $continue; ?>" class="button"><?php echo $button_shopping; ?></a>
                </div>
            </div>
            <?php } ?>
        </div>
    </div>
  </form>

  <?php if (!empty($related_products)) { ?>
      <div class="cart-info related-products">
          <div class="box-heading "><span><?php echo $tab_related; ?></span></div>
          <div class="box-content related-products">
              <div class="box-product product-grid clearafter">
                  <?php foreach ($related_products as $product) { ?>
                  <div class="related-product item" data-product-id="<?php echo $product['product_id']; ?>">
                      <?php if ($product['thumb']) { ?>
                      <div class="product-image"><a  ><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
                      <?php } else { ?>
                      <div class="product-image">
                        <span class="no-image"><img src="image/no_image.jpg" alt="<?php echo $product['name']; ?>" /></span>
                      </div>
                      <?php } ?>
                      <div class="shadow-bg" onclick="goToPage('<?php echo $product['href']; ?>')"></div>
                      <a href="<?php echo $product['href']; ?>">
                          <div class="info-wrapper">
                              <div class="name" ><?php echo $product['name']; ?></div>
                              <?php if ($product['rating']) { ?>
                              <div class="rating"><img
                                      src="catalog/view/theme/acceptus/image/icons/stars-<?php echo $product['rating']; ?>.png"
                                      alt="<?php echo $product['reviews']; ?>"/>
                              </div>
                              <?php } ?>
                            
                          </div>
                      </a>
                      
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
                      
                        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn-cart">
                            <span><?php echo $button_cart; ?></span>
                        </a>
                         
                  </div>
                  <?php } ?>
              </div>
          </div>
      </div>
  <?php } ?>
</div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('input[name=\'next\']').bind('change', function() {
	$('.cart-module > div').hide();
	$('#' + this.value).show();
});
//--></script>
<script type="text/javascript"><!--
$('.quantity-input').on('change', function(e) {
    var key = $(this).attr('data-product-key');
    var element = $(this).parent();
    var product_id = key.replace(/\D/g, '');
    var name = $(this).attr('name');
    var quantity = $(this).val();
    setToCart(key, quantity, element, product_id);
    function setToCart(key, quantity, element, product_id) {
        quantity = typeof(quantity) != 'undefined' ? quantity : 1;

        $.ajax({
            url: 'index.php?route=module/personal_cart/update',
            type: 'post',
            data: 'key=' + key + '&quantity=' + quantity + '&product_id=' + product_id,
            dataType: 'json',
            beforeSend: function() {
                $('.quantity-input').attr('disabled', true);
                $('.quantity-input').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('.quantity-input').attr('disabled', false);
                $('.wait').remove();
            },
            success: function(json) {
                $('.success, .warning, .attention, .information, .error').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['reload']) {
                    location = json['reload'];
                }

                if (json['success']) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.success').fadeIn('slow');

                    $('#cart-total').html(json['total']);

                    $.each(json['total_data'], function(index, value) {
                        $(".total-"+index).html(value['text']);
                    });

                    element.siblings(".total").html(json['total_product_price']);

                    //$('html, body').animate({ scrollTop: 0 }, 'slow');
                }
            }
        });
    }
});
//--></script>
<script type="text/javascript"><!--
$('.cart-img').on('click', function(e) {
    var product_tr = $(this).parent().parent();
    var product_id = product_tr.attr('data-product-id');
    var quantity = 1;
    if($(this).val()){
        quantity = $(this).val();
    }
    addProductToCart(product_id, quantity, e);

});
$('.related-product').on('click', function(e) {
    var product_id = $(this).attr('data-product-id');
    var quantity = 1;
    if($(this).val()){
        quantity = $(this).val();
    }
    addProductToCart(product_id, quantity, e);

});


function addProductToCart(product_id, quantity, element) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    $.ajax({
        url: 'index.php?route=module/personal_cart/add',
        type: 'post',
        data: 'product_id=' + product_id + '&quantity=' + quantity,
        dataType: 'json',
        beforeSend: function() {
            $(element).attr('disabled', true);
            $(element).before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },
        complete: function() {
            $(element).attr('disabled', false);
            $('.wait').remove();
        },
        success: function(json) {
            $('.success, .warning, .attention, .information, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['reload']) {
                location = json['reload'];
            }

            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                $('.success').fadeIn('slow');

                $('#cart-total').html(json['total']);
            }


/*

            function createTd (className) {
                return $('<td/>', {class: className});
            }

            var product = json['product'];
            var product_dom = $('<tr/>');

            var product_image_td = createTd('image');
            if (product['thumb']) {
                var img = $('<img/>', {
                    src: product['thumb'],
                    alt: product['name'],
                    title: product['name']
                });
                var a = $('<a/>', {
                    href: product['href']
                }).append(img);
                a.appendTo(product_image_td);
            }
            product_image_td.appendTo(product_dom);

            var product_name_td = createTd('name');
            $('<a/>', {
                href: product['href'],
                text: product['name']
            }).appendTo(product_name_td);

            product_name_td.appendTo(product_dom);


            var product_quantity_td = createTd('quantity');
            $('<input/>', {
                class: 'quantity-input',
                type: 'text',
                'data-product-key': product['key'],
                name: 'quantity' + product['key'],
                value: product['quantity'],
                size: 1
            }).appendTo(product_quantity_td);
            product_quantity_td.appendTo(product_dom);

            var product_price_td = createTd('price');
            product_price_td.append(product['price']);
            product_price_td.appendTo(product_dom);

            var product_total_td = createTd('total');
            product_total_td.append(product['total']);
            product_total_td.appendTo(product_dom);

            product_dom.appendTo('.order-products table:first tbody');
*/

        }
    });
}

//--></script>
<?php if ($shipping_status) { ?>
<script type="text/javascript"><!--
$('#button-quote').on('click', function() {
	$.ajax({
		url: 'index.php?route=module/personal_cart/quote',
		type: 'post',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-quote').attr('disabled', true);
			$('#button-quote').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-quote').attr('disabled', false);
			$('.wait').remove();
		},
		success: function(json) {
			$('.success, .warning, .attention, .error').remove();

			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

					$('.warning').fadeIn('slow');

					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}

				if (json['error']['country']) {
					$('select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}

				if (json['error']['zone']) {
					$('select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}

				if (json['error']['postcode']) {
					$('input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}
			}

			if (json['shipping_method']) {
				html  = '<h2><?php echo $text_shipping_method; ?></h2>';
				html += '<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">';
				html += '  <table class="radio">';

				for (i in json['shipping_method']) {
					html += '<tr>';
					html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
					html += '</tr>';

					if (!json['shipping_method'][i]['error']) {
						for (j in json['shipping_method'][i]['quote']) {
							html += '<tr class="highlight">';

							if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
							} else {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
							}

							html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
							html += '  <td style="text-align: right;"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
							html += '</tr>';
						}
					} else {
						html += '<tr>';
						html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
						html += '</tr>';
					}
				}

				html += '  </table>';
				html += '  <input type="hidden" name="next" value="shipping" />';

				<?php if ($shipping_method) { ?>
				html += '  <div class="buttons" align="center"><input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" /></div>';
				<?php } else { ?>
				html += '  <div class="buttons" align="center"><input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" disabled="disabled" /></div>';
				<?php } ?>

				html += '</form>';

				$.colorbox({
					overlayClose: true,
					opacity: 0.5,
					width: '600px',
					height: '400px',
					href: false,
					html: html
				});

				$('input[name=\'shipping_method\']').bind('change', function() {
					$('#button-shipping').attr('disabled', false);
				});
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}

	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>

<?php } ?>
<?php echo $footer; ?>
