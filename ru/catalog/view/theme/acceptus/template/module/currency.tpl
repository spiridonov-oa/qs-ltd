<?php if (count($currencies) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div id="currency">
      <div class="dropdown">
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] == $currency_code) { ?>
    <?php if ($currency['symbol_left']) { ?>

    <a class="current" title="<?php echo $currency['title']; ?>"><?php echo $currency['symbol_left']; ?></a>
    <?php } else { ?>
    <a class="current" title="<?php echo $currency['title']; ?>"><?php echo $currency['symbol_right']; ?></a>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] != $currency_code) { ?>
    <?php if ($currency['symbol_left']) { ?>
    <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().parent().submit();"><?php echo $currency['symbol_left']; ?></a>
    <?php } else { ?>
    <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().parent().submit();"><?php echo $currency['symbol_right']; ?></a>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
     </div>
  </div>
</form>
<?php } ?>
