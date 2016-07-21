<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />

        <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
        <meta name="keywords" content="<?php echo $keywords; ?>" />
        <?php } ?>

        <?php if ($icon) { ?>
        <link href="<?php echo $icon; ?>" rel="icon" />
        <?php } ?>
        <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
        <?php } ?>
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/acceptus/build/css/app.css" />

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>

        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />

        <script type="text/javascript" src="catalog/view/theme/acceptus/build/js/final.js"></script>

        <script type="text/javascript" src="catalog/view/javascript/fractionslider/jquery.fractionslider.js"></script>
        <link rel="stylesheet" type="text/css" href="catalog/view/javascript/fractionslider/css/fractionslider.css" />

        <?php foreach ($scripts as $script) { ?>
        <script type="text/javascript" src="<?php echo $script; ?>"></script>
        <?php } ?>
        <!--[if lte IE 8]>
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/acceptus/build/css/ie.css" />
        <![endif]-->
        <?php if ($stores) { ?>
        <script type="text/javascript"><!--
        $(document).ready(function() {
            < ?php foreach ($stores as $store) { ? >
                    $('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
                    < ?php } ? >
            });
                    //--></script>
        <?php } ?>
        <?php echo $google_analytics; ?>
    </head>
    <body class="primary-define color-red<?php if (preg_match('#MSIE (.+?);#', $this->request->server['HTTP_USER_AGENT'], $matches) && intval($matches[1]) < 9) echo ' is-ie'; ?>">
        <div class="container-wrap">
            <div id="header" class="clearafter">
                <div id="topbar">
                    <div class="wrapper clearafter">

                        <?php echo $language; ?>
                        <div class="links">
                            <div id="welcome">
                                <?php if (!$logged) { ?>
                                <?php echo $text_welcome; ?>
                                <?php } else { ?>
                                <a href="<?php echo $account; ?>" id="link-account" class="icon-user"><?php echo $text_account; ?></a>
                                <div class="dropdown">
                                    <ul>
                                        <li><a href="<?php echo $shopping_cart; ?>" id="link-cart" class="icon-cart"><?php echo $text_shopping_cart; ?></a></li>
                                        <li><a href="<?php echo $checkout; ?>" id="link-checkout" class="icon-checkout"><?php echo $text_checkout; ?></a></li>
                                        <li><a href="<?php echo $logout; ?>" id="link-logout" class="icon-logout"><?php echo $text_logout; ?></a></li>
                                    </ul>
                                </div>
                                <?php } ?>
                            </div>
                        </div>

                        <?php if ($logo) { ?>
                        <div id="logo"><a href="<?php echo $home; ?>">Quality System</a></div>
                        <?php } ?>





                        <div id="search">
                            <div id="search-inner">
                                <div class="button-search"></div>
                                <input type="text" name="search" placeholder=" Search" value="" />
                            </div>
                        </div>

                    </div>
                </div>
                <?php echo $main_menu; ?>
            </div>
            <?php echo $content_header; ?>
            <div id="container">

                <div id="container-inner" class="wrapper clearafter">
                    <div id="notification"></div>

                    <div class="hidden">
                    <script type="text/javascript">
                        $(document).ready(function() {
                            $('#header').height(106);
                            $(window).scroll(function() {
                                //Main Menu onScroll
                                var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                                if (scrollTop >= $('#topbar').outerHeight(true))  {
                                    $('#menu').addClass('fixed');
                                    $('#logo').addClass('fixed');

                                } else{
                                    $('#menu').removeClass('fixed');
                                    $('#logo').removeClass('fixed');
                                }
                            });

                            // remove onclick event for dropdown in main menu for mobile devices
                            if($(window).width() < 960){
                                $('.mainmenu .menu-li > a').on('click', function(event){
                                    if($(this).parent().find('.dropdown-container').length !== 0){
                                        event.preventDefault();
                                        //console.log('event.preventDefault();');
                                    }
                                })
                            }
                        });
                    </script>
                    </div>