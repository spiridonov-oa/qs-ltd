<?php
        $option = $this->config->get('featured_module');
        if($option && is_array($option)) {
        $option = array_shift($option);
        }
        ?>
<div class="box clearafter">
    <h2 class="box-heading"><span><?php echo $heading_title; ?></span></h2>
        <div class="box-product product-grid">
            <?php foreach ($products as $product) { ?>
            <div class="item">
                <?php if ($product['thumb']) { ?>
                <div class="image"><a href="<?php echo $product['href']; ?>"
                                      style="<?php echo ($option['image_height'] < 224) ? 'line-height: 224px' : ''; ?>"><img
                        src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/></a></div>
                <?php } else { ?>
                <div class="image">
			<span class="no-image" style="<?php echo ($option['image_width'] < 224) ? 'width: 224px' : 'width: '.$option['image_width'].'px'; ?>; <?php echo ($option['image_height'] < 224) ? 'line-height: 224px' : 'line-height: '.$option['image_height'].'px;'; ?>">
			<img src="image/no_image.jpg" alt="<?php echo $product['name']; ?>"/></span>
                </div>
                <?php } ?>
                <div class="shadow-bg" onclick="goToPage('<?php echo $product['href']; ?>')"></div>
                <a href="<?php echo $product['href']; ?>">
                    <div class="info-wrapper">
                        <div class="name"><?php echo $product['name']; ?></div>
                        <?php if ($product['rating']) { ?>
                        <div class="rating"><img
                                src="catalog/view/theme/acceptus/image/icons/stars-<?php echo $product['rating']; ?>.png"
                                alt="<?php echo $product['reviews']; ?>"/></div>
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