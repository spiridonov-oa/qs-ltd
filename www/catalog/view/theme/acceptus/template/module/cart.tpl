<div id="cart">
    <div class="heading">
        <a href="<?php echo $cart; ?>"><span><?php echo $heading_title; ?></span> (<span id="cart-total"><?php echo $text_count_products; ?></span>)</a>
    </div>
    <div class="mini-cart-block">
	<?php if ($products || $vouchers) { ?>
        <div class="mini-cart-info">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="image"><?php if ($product['thumb']) { ?>
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                  <?php } ?>
                </td>
                <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                    <?php foreach ($product['option'] as $option) { ?>
                    <span>- <?php echo $option['name']; ?> <?php echo $option['value']; ?></span>
                    <?php } ?>
                    <?php if ($product['recurring']): ?>
                    - <small><?php echo $text_payment_profile ?> <?php echo $product['profile']; ?></small><br />
                    <?php endif; ?>
                </td>
                <td class="quantity">x&nbsp;<?php echo $product['quantity']; ?></td>
                <td class="total"><?php echo $product['total']; ?></td>
                <td class="remove"><img src="catalog/view/theme/acceptus/image/icons/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="removeProduct('<?php echo $product['key']; ?>')" /></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <!--<td class="image"></td>-->
                <td class="name"><?php echo $voucher['description']; ?></td>
                <td class="quantity">x&nbsp;1</td>
                <td class="total"><?php echo $voucher['amount']; ?></td>
                <td class="remove"><img src="catalog/view/theme/acceptus/image/icons/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="removeProduct('<?php echo $voucher['key']; ?>')" /></td>
              </tr>
              <?php } ?>
            </table>
        </div>
        <div class="mini-cart-total">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
              <?php foreach ($totals as $total) { ?>
              <tr>
                <td class="name"><?php echo $total['title']; ?>:</td>
                <td class="total"><?php echo $total['text']; ?></td>
              </tr>
              <?php } ?>
            </table>
        </div>
        <div class="checkout">
            <a class="button" href="<?php echo $cart; ?>"><span><?php echo $text_cart; ?></span></a>&nbsp;&nbsp;
            <a class="button green" href="<?php echo $checkout; ?>"><span><?php echo $text_checkout; ?></span></a>
	    </div>
        <?php } else { ?>
            <div class="empty"><?php echo $text_empty; ?></div>
        <?php } ?>
    </div>
</div>

<script type="text/javascript">

    function removeProduct (product_key) {
        if(getURLVar('route') == 'module/personal_cart' || getURLVar('route') == 'checkout/checkout'){
            location = 'index.php?route=checkout/cart&remove=' + product_key;
        } else {
            $('#cart').load('index.php?route=module/cart&remove=' + product_key + ' #cart > *', function() {
                $('#cart').addClass('active');
            });
        }
    }

</script>