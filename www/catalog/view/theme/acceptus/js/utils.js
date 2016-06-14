var _cartTimer;
function addToCart(product_id, quantity, data) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    clearTimeout(_cartTimer);
    if (!data) {
        data = 'product_id=' + product_id + '&quantity=' + quantity;
    }
    $.ajax({
        url: 'index.php?route=module/personal_cart/add',
        type: 'post',
        data: data,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            }

            if (json['success']) {
                $('#cart').addClass('filled');
                $('#cart-total').html(json['count']);
            }

            if (json['error']) {
                console.log('ERROR addToCart');
                console.error(json['error']);
            }
        }
    });
}
$('.btn-cart').on('click', function() {
    var product_id = $(this).data('product_id');
    var quantity = $(this).data('product_id') || 1;
    var data = $(this).data('product_id');
    if(product_id) {
        addToCart(product_id, quantity);
    }
});
/*var _wishListTimer;
function addToWishList(product_id) {
    clearTimeout(_wishListTimer);

    $.ajax({
        url: 'index.php?route=account/wishlist/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();

            if (json['success']) {
                $('#notification')
                    .html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>')
                    .addClass('active');

                $('.success').fadeIn('slow', function () {
                    _wishListTimer = setTimeout(function () {
                        $('#notification').removeClass('active');
                    }, 2500);
                });

                $('#wishlist-total').html(json['total']);
            }
        }
    });
}

var _compareTimer;
function addToCompare(product_id) {
    clearTimeout(_compareTimer);

    $.ajax({
        url: 'index.php?route=product/compare/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();

            if (json['success']) {
                $('#notification')
                    .html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>')
                    .addClass('active');

                $('.success').fadeIn('slow', function () {
                    _compareTimer = setTimeout(function () {
                        $('#notification').removeClass('active');
                    }, 2500);
                });

                $('#compare-total').html(json['total']);
            }
        }
    });
}
*/

function goToPage(url) {
    location = url;
}

function getURLVar(key) {
    var value = [];

    var query = String(document.location).split('?');

    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');

            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }

        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}



$(document).ready(function () {

    /* Search */
    $('.button-search').bind('click', function() {
        url = $('base').attr('href') + 'index.php?route=product/search';

        var search = $('input[name=\'search\']').val();

        if (search) {
            url += '&search=' + encodeURIComponent(search);
        }

        location = url;
    });

    $('#header input[name=\'search\']').bind('keydown', function(e) {
        if (e.keyCode == 13) {
            url = $('base').attr('href') + 'index.php?route=product/search';

            var search = $('input[name=\'search\']').val();

            if (search) {
                url += '&search=' + encodeURIComponent(search);
            }

            location = url;
        }
    });

    // Setup mobile main menu
    $('#btn-mobile-toggle').toggle(
        function() {
            $(this).removeClass('expand').next().slideUp();
        },
        function() {
            $(this).addClass('expand').next().slideDown();
        }
    );

    $('.btn-expand-menu').toggle(
        function() {
            $(this).next().slideUp().parent().removeClass('expand');
        },
        function() {
            $(this).next().slideDown().parent().addClass('expand');
        }
    );

    // set width for sub menu in mainmenu
    var width_aligned = false;
    $('.mainmenu .menu-li').hover(function(){
        if(!width_aligned){
            var menu_width = $('.mainmenu .menu-li:first').width();

            if(menu_width < 200){
                menu_width = 200;
            }

            $('.mainmenu .menu-li > .dropdown-container').width(menu_width);
            $('.menu-sub').width(menu_width);
            $('.menu-sub-sub').width(menu_width+100);
            $('.mainmenu .menu-li-sub > .dropdown-container').width(menu_width+100);

            width_aligned = true;
        }
    });


    var innerWidth = $(window).innerWidth();

    if (innerWidth < 768) {
        $('#btn-mobile-toggle').trigger('click');
        $('.btn-expand-menu').trigger('click');
    }

    // Setup mobile tabs
    $('#btn-tabs-toggle').toggle(
        function() {
            $(this).parent().removeClass('collapse').addClass('expand').find('.ui-state-default').slideDown();
        },
        function() {
            $(this).parent().removeClass('expand').addClass('collapse').find('.ui-state-default:not(.ui-state-active)').slideUp();
        }
    );

    //Smooth scroll to on page element
    $(".review a").click(function(event){
        event.preventDefault();
        //calculate destination place
        var dest=0;
        if($(this.hash).offset().top > $(document).height()-$(window).height()){
            dest=$(document).height()-$(window).height();
        } else {
            dest=$(this.hash).offset().top;
        }
        //go to destination
        $('html,body').animate({scrollTop:dest}, 500,'swing');
    });

    /* Ajax Cart */
    var done = false;
    $('body').append('<div id="cart-content" style="display: none"></div>');
    $("#cart").mouseenter(updateCart);

    function updateCart () {
        $('#cart-content').load('index.php?route=module/cart #cart > *', appendToCart);

        function appendToCart () {
            $('#cart .mini-cart-block').empty();
            $('#cart #cart-total').empty();

            $('#cart #cart-total').append($('#cart-content #cart-total').html());
            $('#cart .mini-cart-block').append($('#cart-content .mini-cart-block').html());

            $('#cart').addClass('active');
            ifFilledCart();
        }
    }

    $("#cart").mouseleave( function () {
        $('#cart').removeClass('active');
        ifFilledCart();
    });
    $('#cart').on('change', ifFilledCart);

    function ifFilledCart() {
        if($('#cart-total').text() == '0') {
            $('#cart').removeClass('filled');
        } else {
            $('#cart').addClass('filled');
        }
    }
    ifFilledCart();

    $('.custom-select').chosen({
        disable_search_threshold: 10
    });

});
