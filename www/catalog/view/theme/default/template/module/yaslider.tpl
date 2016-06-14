<!-- yaslider -->
<?php if ($show_heading) { ?>
<h3 class="ys-heading"><?php echo $heading; ?></h3>
<?php } ?>
<div class="yaslider <?php echo $slider_style; ?> <?php echo $slider_color; ?>">
  <div id="yaslider-<?php echo $module; ?>" class="yaslider-box" >
  <?php foreach ($products as $product) { ?>
    <div class="ys-slide ys-clear">
    <?php if ($product['thumb']) { ?>
      <div class="ys-p-image">
        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
      </div>
    <?php } ?>
      <div class="ys-p-name">
        <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
        <?php if ($show_description) { ?>
        <span><?php echo $product['description']; ?></span>
        <?php } ?>
      </div>
    <?php if ($product['price']) { ?>
      <div class="ys-p-price">
      <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
      <?php } else { ?>
        <span class="ys-p-price-old"><?php echo $product['price']; ?></span>
        <span class="ys-p-price-new"><?php echo $product['special']; ?></span>
      <?php } ?>
      </div>
    <?php } ?>
    <?php if ($product['rating']) { ?>
      <div class="ys-p-rating">
        <img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
      </div>
    <?php } ?>
      <div class="ys-p-buy">
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $btn_buy; ?></a>
      </div>
      <div class="ys-p-details">
        <a href="<?php echo $product['href']; ?>"><?php echo $btn_details; ?></a>
      </div>
    </div>
  <?php } ?>
  </div>
  <a href="javascript: void(0);" id="yaslider-<?php echo $module; ?>-larr" class="ys-larr"></a>
  <a href="javascript: void(0);" id="yaslider-<?php echo $module; ?>-rarr" class="ys-rarr"></a>
  <div class="ys-badge <?php echo $slider_badge; ?>"></div>
</div>

<script type="text/javascript">
$(document).ready(function(){
  var ys_slider = $('#yaslider-'+<?php echo $module; ?>);
  var larr = $('#yaslider-'+<?php echo $module; ?>+'-larr');
  var rarr = $('#yaslider-'+<?php echo $module; ?>+'-rarr');
  var img_w = <?php echo $image_width; ?>+60;
  var img_h = <?php echo $image_height; ?>/2;
  var sl_w = <?php echo $slider_width; ?>;
  var sl_h = <?php echo $slider_height; ?>;

  $('.ys-p-image', ys_slider).css({'width':'<?php echo $image_width; ?>', 'height':'<?php echo $image_height; ?>', 'margin-top' : -img_h, 'margin-left' : -img_w});
  ys_slider.css({'width': sl_w, 'height': sl_h});
  ys_slider.parent().css({'width': sl_w, 'height': sl_h});
  $('.ys-slide', ys_slider).css({'width': sl_w, 'height': sl_h});
  $('.ys-p-rating').css({'margin-left': -img_w/2-72});

  ys_slider.cycle({
    fx:      '<?php echo $slider_effect; ?>', 
    timeout: <?php echo $slider_timeout; ?>,
    random:  <?php echo $slider_random; ?>,
    pause:   true,
    next:    rarr,
    prev:    larr
  });
  
  larr.add(rarr).hide();
  ys_slider.closest('.yaslider').hover(function(){
      larr.add(rarr).show();
    }, function(){
      larr.add(rarr).hide();
  });
});
</script>
<!-- /yaslider -->