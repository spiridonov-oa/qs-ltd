</div>
</div>
<div class="footer-push"></div>
</div>
<div id="footer">
    <div class="wrapper clearafter">
        <?php if ($informations) { ?>
        <div class="column grid-4">
            <h3><span><?php echo $text_information; ?></span></h3>
            <ul>
                <?php foreach ($informations as $information) { ?>
                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
        <?php } ?>
        <div class="column grid-4">
            <h3><span><?php echo $text_service; ?></span></h3>
            <ul>
                <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
            </ul>
        </div>
        <div class="column grid-4">
            <h3><span><?php echo $text_extra; ?></span></h3>
            <ul>
                <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
              <!--  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li> -->
            </ul>
        </div>
        <div class="column grid-4">
            <h3><span><?php echo $text_account; ?></span></h3>
            <ul>
                <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
            </ul>
        </div>
    </div>
    <div id="powered">
        <div class="wrapper">
            <!-- <?php echo $powered; ?> -->
            <!-- Please do not remove following code or we can not support you with this product ! -->
            <p class="powered">Powered by <a href="#" title="Spiridonov" target="_blank">Oleg Spiridonov</a></p>
        </div>
    </div>
</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->


<script>
    $('.btn-cart').on('click', function() {
        var cart = $('#cart');
        var imgtodrag = $(this).parent('.item').find("img").eq(0);
        if (imgtodrag) {
            var imgclone = imgtodrag.clone()
                    .offset({
                        top: imgtodrag.offset().top,
                        left: imgtodrag.offset().left
                    })
                    .css({
                        'opacity': '0.5',
                        'position': 'absolute',
                        'height': '225px',
                        'width': '225px',
                        'z-index': '100'
                    })
                    .appendTo($('body'))
                    .animate({
                        'top': cart.offset().top + 10,
                        'left': cart.offset().left + 10,
                        'width': 40,
                        'height': 40
                    }, 1000, 'easeInOutExpo');

            setTimeout(function() {
                cart.effect("shake", {
                    times: 2
                }, 200);
            }, 1500);

            imgclone.animate({
                'width': 0,
                'height': 0
            }, function() {
                $(this).detach()
            });
        }
    });
</script>




<!-- BEGIN JIVOSITE CODE {literal} -->
<script type='text/javascript'>
    /*(function(){ var widget_id = '168886';
        var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);})();
*/</script>
<!-- {/literal} END JIVOSITE CODE -->

</body>

</html>
