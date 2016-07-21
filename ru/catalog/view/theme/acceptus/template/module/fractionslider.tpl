<div class="slideshow-wrapper">

    <?php   $sorted_banners = array();
            foreach($banners as $banner) {
                if(isset($banner['link']) && $banner['link'] == 'http://qs-ltd.com/ndt/penetrant-testing/') {
                    $sorted_banners[] = $banner;
                }
            }

            foreach($banners as $banner) {
                if(isset($banner['link']) && $banner['link'] == 'http://qs-ltd.com/ndt/uv-sources/') {
                    $sorted_banners[] = $banner;
                }
            }

            foreach($banners as $banner) {
                if(isset($banner['link']) && $banner['link'] == 'http://qs-ltd.com/ndt/magnetic-particle-testing/') {
                    $sorted_banners[] = $banner;
                }
            }

            ?>

    <?php $i=1; foreach ($sorted_banners as $banner) { ?>
        <div class="slide slide-<?php echo $i;?>" data-in="none">
            
            <?php if ($banner['link']) { ?>
                <a data-in="fade" data-out="fade" href="<?php echo $banner['link']; ?>">
                    <img class="slider-bg" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
                </a>
            <?php } else { ?>
                <img class="slider-bg" data-in="fade" data-out="fade" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
            <?php } ?>
            <?php /*
            <div class="shadow fs-bg" data-in="fade" data-step="4" data-time="3000"></div>

            <a href="http://qs-ltd.com/en/Penetrant-testing/NORD-TEST-Kontrastrot-U88-Penetrant-p51c59.html" class="text-bg" data-in="right" data-out="right" data-position="35%,7%" data-step="1">NORD-TEST Kontrastrot U 88</a>
            <a href="http://qs-ltd.com/en/NORD-TEST-Cleaner-U87-p50.html" class="text-bg" data-in="right" data-out="right" data-position="50%,6%" data-step="2">NORD-TEST Cleaner U 87</a>
            <a href="http://qs-ltd.com/en/NORD-TEST-Rot-3000-Penetrant-p52.html"  class="text-bg" data-in="right" data-out="right" data-position="65%,5%" data-step="3">NORD-TEST Developer U 89</a>
                    */?>
            <?php $item_names  =  $banner['banner_link_description'];

            if ($i == 1) {

            $position[0] = "210,140";
             $position[1] = "35,500";
              $position[2] = "75,800";
               $position[3] = "210,970";
                $position[4] = "410,1450";

                $title[1] = "140,1300"; /* title */
            }
            if ($i == 2) {

            $position[0] = "330,250";
             $position[1] = "110,1400";
              $position[2] = "310,1450";
              $title[1] = "80,200";
         
            }
            if ($i == 3) {

             $position[0] = "200,1300";
             $position[1] = "250,1300";
             $position[2] = "300,1300";
             $position[3] = "350,1300";
             $position[4] = "400,1300";
             $position[5] = "450,1300";
             $title[1] = "50,400";

            }
                 
           
            ?>
            <?php if(count($item_names) > 0){ ?>
                <?php $j=0; foreach ($item_names as $name) { ?>
                <p class="slider-desc slider-desc-<?php echo $j; ?>" data-position="<?php echo $position[$j]; ?>" data-in="fade">
                    <a href="<?php echo $name['link']; ?>">
                    <?php echo $name['text']; ?>
                <?php //if ($i == 3) { ?>
                        <!--<span class="overlay-<?php echo $j; ?>"><img data-in="fade" data-out="fade" src="http://qs-ltd.com/catalog/view/theme/acceptus/image/baner-shadow-<?php echo $j+1; ?>.png" alt="" /></span>-->
               <?php // } ?>
                    </a>
                </p>
                
                <?php $j=$j+1;} ?>
            <?php } ?>


            <a class="slider-title" data-in="fade" data-out="none" data-position="<?php echo $title[1]; ?>" style="width:50%"><span class="skew"><span><?php echo $banner['title']; ?></span></span></a>

        </div>

    <?php $i=$i+1; } ?>
    <!-- and so on -->
    <div class="fs_loader"><!-- shows a loading .gif while the slider is getting ready --></div>
</div>
<div id="button-scroll"></div>


    <!--<?php foreach ($banners as $banner) { ?>
        <?php var_dump($banner); ?>
        <?php echo $banner['image']; ?>
        <?php echo $banner['link']; ?>
        <?php echo $banner['title']; ?>
        <?php $item_names  =  $banner['banner_link_description'];?>
        <?php if(count($item_names) > 0){ ?>
            <?php foreach ($item_names as $name) { ?>
                <?php echo $name['text']; ?>
                <?php echo $name['link']; ?>
            <?php } ?>
        <?php } ?>
    <?php } ?>-->


<script type="text/javascript"><!--
$(document).ready(function() {
    $('.slideshow-wrapper').fractionSlider({
		'fullWidth': false,
		'controls': true,
                'pager': true,
                'responsive':  			true,
		'dimensions':  			'2000,750',


	});
    var slider_height = $(window).width()*(600/1600);
    //var sliderHeight = Math.ceil($(window).width()*0.4);
    $('#button-scroll').hide();
    //var height = $(window).height() - $('#topbar').outerHeight(true)/* - $('#button-scroll').outerHeight(true)*/;
    //$('#button-scroll').css('top',height+ $('#topbar').outerHeight(true));
    $('.slideshow-wrapper').height(slider_height);
    $('#container').css('marginTop', 20);
    $(window).resize(function() {
        var slider_height = $(window).width()*(600/1600);
        //var height = $(window).height() - $('#topbar').outerHeight(true)/* - $('#button-scroll').outerHeight(true)*/;
        //$('#button-scroll').css('top',height + $('#topbar').outerHeight(true));
        $('.slideshow-wrapper').height(slider_height);
        $('#container').css('marginTop', 20);
    });

    $('#button-scroll').click(function() {
        $('body,html').animate({scrollTop: $(window).height()-50}, 500);
    });
    //fade on scroll
    $(window).scroll(function () {
        var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        if (scrollTop > 100) {
            var opacityScroll = ( scrollTop-100)/($(window).height() - 100);
            if(opacityScroll < 1){
                var opacity = 1 - opacityScroll;
                changeOpacity(opacity);
            } else {
                changeOpacity(0);
            }
        } else {
            changeOpacity(1);
        }
        function changeOpacity (value) {
            $('#button-scroll').css('opacity', value);
        }
    });
});
--></script>