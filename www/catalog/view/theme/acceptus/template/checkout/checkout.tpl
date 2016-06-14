<?php echo $header; ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
    <div class="box">
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>



        <div id="checkout">
            <div class="checkout-heading"><?php echo $text_checkout; ?></div>
            <form>
                <div class="customer-info">
                    <?php if (!$logged) { ?>
                    <div class="message"></div>
                    <table class="login-form">
                        <tr class="email">
                            <td class="width40"><?php echo $entry_email; ?><span class="required">*</span></td>
                            <td class="width60"><input id="email" type="text" name="email" value="" autofocus /></td>
                        </tr>
                        <tr class="password hidden">
                            <td class="width40"><?php echo $entry_password; ?><span class="required">*</span></td>
                            <td class="width60"><input type="password" id="password" name="password" value="" /></td>
                        </tr>
                    </table>
                    <table id="new-customer" class="login-form hidden">
                        <tr class="">
                            <td class="width40"></td>
                            <td class="width60"><span><?php echo $text_confirm_email; ?></span></td>
                        </tr>
                        <tr class="firstname">
                            <td class="width40"><?php echo $entry_firstname; ?><span class="required">*</span></td>
                            <td class="width60"><input id="firstname" type="text" name="firstname" value="" /></td>
                        </tr>
                        <tr class="telephone">
                            <td class="width40"><?php echo $entry_telephone; ?><span class="required">*</span></td>
                            <td class="width60"><input id="telephone" type="text" name="telephone" value="" /></td>
                        </tr>
                        <tr class="tax_id">
                            <td class="width40"><?php echo $entry_tax_id; ?></td>
                            <td class="width60"><input id="tax_id" type="text" name="tax_id" value="" /></td>
                        </tr>
                    </table>

                    <button type="button" id="button-next" style="display:block" class="button green">OK</button>
                    <button type="button" id="button-login" style="display:block" class="button green"><?php echo $button_login; ?></button>
                    <a id="forgotten" class="hidden" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>

                    <button type="button" id="button-create-new" style="display:block" class="button green"><?php echo $text_new_customer_order; ?></button>

                    <?php } else { ?>

                    <?php if ($addresses) { ?>
                    <div class="payment-address">
                        <?php foreach ($addresses as $address) { ?>
                        <?php if ($address['address_id'] == $address_id) { ?>
                        <p>Company: <?php echo $address['company']; ?></p>
                        <p>Company ID: <?php echo $address['company_id']; ?></p>
                        <p>Address: <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></p>
                        <p>Tax ID (VAT): <?php echo $address['tax_id']; ?></p>
                        <?php } ?>
                        <?php } ?>
                    </div>
                    <div class="shipping-address">
                        <p>
                            <input type="radio" name="shipping-address" value="1" checked="checked" /><span><?php echo $text_address_existing; ?></span>
                        </p>
                        <p><select name="address_id" size="1" id="address">
                                <?php foreach ($addresses as $address) { ?>
                                <?php if ($address['address_id'] == $shipping_address_id) echo 'selected'; ?>
                                <option <?php if ($address['address_id'] == $address_id) echo 'selected'; ?> value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                                <?php } ?>
                            </select>
                        </p>

                        <div class="new-address-toggle"><p><input type="radio" name="shipping-address" value="0" /><?php echo $text_address_new; ?> </p></div>
                        <table class="new-address hidden">
                            <tr>
                                <td><?php echo $entry_firstname; ?><span class="required">*</span></td>
                                <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" /></td>
                            </tr>
                            <?php if ($error_firstname) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_firstname; ?></span></td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td><?php echo $entry_lastname; ?><span class="required">*</span></td>
                                <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" /></td>
                            </tr>
                            <?php if ($error_lastname) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_lastname; ?></span></td>
                            </tr>
                            <?php } ?>

                            <tr>
                                <td><?php echo $entry_address_1; ?><span class="required">*</span></td>
                                <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" /></td>
                            </tr>
                            <?php if ($error_address_1) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_address_1; ?></span></td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td><?php echo $entry_city; ?><span class="required">*</span></td>
                                <td><input type="text" name="city" value="<?php echo $city; ?>" /></td>
                            </tr>
                            <?php if ($error_city) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_city; ?></span></td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td><?php echo $entry_postcode; ?><span id="postcode-required" class="required">*</span></td>
                                <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" /></td>
                            </tr>
                            <?php if ($error_postcode) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_postcode; ?></span></td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td><?php echo $entry_country; ?><span class="required">*</span></td>
                                <td><select name="country_id">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if ($country['country_id'] == $country_id) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            <?php if ($error_country) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_country; ?></span></td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td><?php echo $entry_zone; ?><span class="required">*</span></td>
                                <td><select name="zone_id"></select></td>
                            </tr>
                            <?php if ($error_zone) { ?>
                            <tr>
                                <td></td>
                                <td><span class="error"><?php echo $error_zone; ?></span></td>
                            </tr>
                            <?php } ?>

                        </table>

                    </div>

                    <?php } ?>
                    <p><label>Comments:</label><br>
                        <textarea name="comment" cols="52" rows="3" id="comment"></textarea></p>
                    <input type="button" value="<?php echo $heading_title; ?>" id="button-confirm" class="btn-continue green" />

                    <?php } ?>

                </div>
            </form>
        </div>

        <?php if ($products) { ?>
            <div class="checkout-product">
                <table>
                    <thead>
                    <tr>
                        <td class="name"><?php echo $column_name; ?></td>
                        <td class="model"><?php echo $column_model; ?></td>
                        <td class="quantity"><?php echo $column_quantity; ?></td>
                        <td class="price"><?php echo $column_price; ?></td>
                        <td class="total"><?php echo $column_total; ?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($products as $product) { ?>
                    <?php if($product['recurring']): ?>
                    <tr>
                        <td colspan="5" style="border:none;"><image src="catalog/view/theme/acceptus/image/icons/reorder.png" alt="" title="" style="float:left;" /><span style="float:left;line-height:18px; margin-left:10px;">
                    <strong><?php echo $text_recurring_item ?></strong>
                                <?php echo $product['profile_description'] ?>
                        </td>
                    </tr>
                    <?php endif; ?>
                    <tr>
                        <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                            <?php foreach ($product['option'] as $option) { ?>
                            <br />
                            &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                            <?php } ?>
                            <?php if($product['recurring']): ?>
                            <br />
                            &nbsp;<small><?php echo $text_payment_profile ?>: <?php echo $product['profile_name'] ?></small>
                            <?php endif; ?>
                        </td>
                        <td class="model"><?php echo $product['model']; ?></td>
                        <td class="quantity"><?php echo $product['quantity']; ?></td>
                        <td class="price"><?php echo $product['price']; ?></td>
                        <td class="total"><?php echo $product['total']; ?></td>
                    </tr>
                    <?php } ?>
                    <?php foreach ($vouchers as $voucher) { ?>
                    <tr>
                        <td class="name"><?php echo $voucher['description']; ?></td>
                        <td class="model"></td>
                        <td class="quantity">1</td>
                        <td class="price"><?php echo $voucher['amount']; ?></td>
                        <td class="total"><?php echo $voucher['amount']; ?></td>
                    </tr>
                    <?php } ?>
                    </tbody>
                    <tfoot>
                    <?php foreach ($totals as $total) { ?>
                    <tr>
                        <td colspan="2" class="collapse"></td>
                        <td colspan="2" class="price"><?php echo $total['title']; ?>:</td>
                        <td class="total"><?php echo $total['text']; ?></td>
                    </tr>
                    <?php } ?>
                    </tfoot>
                </table>
            </div>
        <?php } ?>

    </div>

    <?php echo $content_bottom; ?></div>

<script type="text/javascript">
//spiridonov.oa

$(document).ready(function() {

    <?php if (!$logged) { ?>

        goToEnterEmail ();

        $('#email').on('change blur', function() {
            var email = $(this).val();
            hideAll();
            goToEnterEmail ();

            if (!email) {
                return false;
            }

            if (isEmailValid(email)) {
                isAlreadyRegistered(email);
            }

            function isAlreadyRegistered(email) {
                $.ajax({
                    url: 'index.php?route=checkout/checkout/isEmailRegistered',
                    type: 'post',
                    data: 'email=' + email,
                    dataType: 'json',
                    success: function(json) {
                        if (json['redirect']) {
                            location = json['redirect'];
                        } else if (json['registered']){
                            goToEnterPassword();
                        } else {
                            goToCreateNew();
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        });

        function goToEnterEmail () {
            hideAll();
            $('#button-next').show();
        }

        function goToEnterPassword () {
            hideAll();
            $('#checkout .login-form .password').show();
            $('#button-login').show();
        }

        function goToCreateNew () {
            hideAll();
            $('#button-create-new').show();
            $('#new-customer').show();
        }

        function hideAll () {
            $('#checkout .login-form .password').hide();
            $('#button-login').hide();
            $('#button-create-new').hide();
            $('#new-customer').hide();
            $('#button-next').hide();
            $('#forgotten').hide();
            $('.warning, .error').remove();
        }

        function isEmailValid(email) {
            if (email != '') {
                var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
                if(pattern.test(email)){
                    $('#email').removeClass('error-input');
                    return true;
                } else {
                    $('#email').addClass('error-input');
                    $('#notification').prepend('<div class="warning" style="display: none;"> <?php echo $error_registration_email; ?> </div>');
                    $('.warning').fadeIn('slow');
                    return false;
                }
            }
            $('#email').addClass('error-input');
            $('#notification').prepend('<div class="warning" style="display: none;"> <?php echo $error_registration_login; ?> </div>');
            $('.warning').fadeIn('slow');
            return false;
        }

        function isFirstnameValid(firstname) {
            if (firstname != '' && firstname.length < 32) {
                $('#firstname').removeClass('error-input');
                return true;
            }
            $('#firstname').addClass('error-input');
            $('#notification').prepend('<div class="warning" style="display: none;"> <?php echo $error_registration_firstname; ?> </div>');
            $('.warning').fadeIn('slow');
            return false;
        }

        function isTelephoneValid(telephone) {
            if (telephone.length >= 3 && telephone.length < 32) {
                var pattern = /^[0-9-+]+$/;
                if(pattern.test(telephone)){
                    $('#telephone').removeClass('error-input');
                    return true;
                }
            }
            $('#telephone').addClass('error-input');
            $('#notification').prepend('<div class="warning" style="display: none;"> <?php echo $error_registration_telephone; ?> </div>');
            $('.warning').fadeIn('slow');
            return false;
        }

        function isTaxIdValid(tax_id) {
            if (tax_id.length < 24) {
                $('#tax_id').removeClass('error-input');
                return true;
            }
            $('#tax_id').addClass('error-input');
            $('#notification').prepend('<div class="warning" style="display: none;"> <?php echo $error_registration_tax_id; ?> </div>');
            $('.warning').fadeIn('slow');
            return false;
        }




        function submit () {
            $.ajax({
                url: 'index.php?route=checkout/checkout/submit',
                type: 'post',
                data: $('form').serialize(),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-create-new').attr('disabled', true);
                    $('#button-create-new').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('#button-create-new').attr('disabled', false);
                    $('.wait').remove();
                },
                success: function(json) {
                    $('.warning, .error').remove();

                    if (json['redirect']) {
                        location = json['redirect'];
                    } else if (json['error']) {
                        $('#notification').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
                        $('.warning').fadeIn('slow');
                        $('#forgotten').css({display:'block'});
                        console.log(json['error']);
                    }

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    console.log(xhr, ajaxOptions, thrownError);
                }
            });
        }

        $('#button-create-new').on('click', function(){
            $('.warning, .error').remove();
            var comment = '';
            if(!isEmailValid($('#email').val()) || !isFirstnameValid($('#firstname').val()) || !isTelephoneValid($('#telephone').val()) || !isTaxIdValid($('#tax_id').val())) {
                return false;
            }
            submit();
        });

        function login () {
            $.ajax({
                url: 'index.php?route=checkout/login/validate',
                type: 'post',
                data: "email=" + $('#checkout .login-form .email input').val() + "&password=" + $('#checkout .login-form .password input').val(),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-login').attr('disabled', true);
                    $('#button-login').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('#button-login').attr('disabled', false);
                    $('.wait').remove();
                },
                success: function(json) {
                    $('.warning, .error').remove();

                    if (json['redirect']) {
                        location = json['redirect'];
                    } else if (json['error']) {
                        $('#notification').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
                        $('.warning').fadeIn('slow');
                        $('#forgotten').css({display:'block'});
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        }

        $('#button-login').on('click', function() {
            login();
        });
        $('#password').on('keydown', function(e) {
            if (e.keyCode == 13) {
                login();
            }
        });

    <?php } else { ?> // End if not logged


    $('#button-confirm').on('click', function() {
        $.ajax({
            type: 'post',
            data: $('form').serialize() + '&company=&address_2=',
            dataType: 'json',
            url: 'index.php?route=checkout/checkout/submit',
            beforeSend: function() {
                $('#button-confirm').attr('disabled', true);
                $('#button-confirm').before('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('#button-confirm').attr('disabled', false);
                $('.wait').remove();
            },
            success: function(json) {
                $('.new-address input').removeClass('error-input');
                if (json['redirect']) {
                    location = json['redirect'];
                }
                if (json['error']) {
                    for(var name in json['error']){
                        $('.new-address input[name='+name+']').addClass('error-input');
                    }
                }
            }
        });
    });

    <?php } ?>

    $('.shipping-address select[name=\'address_id\']').on('change', function() {
        var newAddressId = $(this).val();
        $.ajax({
            url: 'index.php?route=checkout/checkout/changeAddress',
            type: 'post',
            data: "address_id=" + newAddressId,
            dataType: 'json',
            success: function(json) {
                $('.warning, .error').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });

    });

    $('.shipping-address input[name=\'shipping-address\']:radio').on('change', function() {
         $('.new-address').toggleClass('hidden');
    });

    var new_address;
    function validateAddress(parameter) {
        if($('.shipping-address input[name='+parameter+']').val() && $('.shipping-address input[name='+parameter+']').val().length < 200 ) {
            new_address[parameter] = $('.shipping-address input[name='+parameter+']').val();
        }
    }
    var parameters = ['firstname', 'lastname', 'address_1', 'city', 'postcode', 'country_id', 'zone_id'];
    parameters.forEach(validateAddress);



    $('select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=account/address/country&country_id=' + this.value,
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

});

</script>
<?php echo $footer; ?>