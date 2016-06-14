<?php echo $header; ?>
<div class="breadcrumb">
<?php foreach ($breadcrumbs as $breadcrumb) { ?>
<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
<?php } ?>
</div>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php //echo $column_left; ?><?php //echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="box">
  <h1><?php echo $heading_title; ?></h1>
  <div class="login-content clearafter">
    <div class="left">
      <?php //echo $text_new_customer; ?>
      <div class="content">
        <h2><?php echo $text_register; ?></h2>
        <p><?php echo $text_register_account; ?></p>
      </div>
      <div class="buttons">
            <a href="<?php echo $register; ?>" class="button"><?php echo $button_continue; ?></a>
      </div>
    </div>
    <div class="right">
      <?php //echo $text_returning_customer; ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="content">
          <h2><?php echo $text_i_am_returning_customer; ?></h2>
          <p class="clearafter">
          <label><?php echo $entry_email; ?></label>
          <input type="text" name="email" value="<?php echo $email; ?>" />
          </p>
          <p class="clearafter">
          <label><?php echo $entry_password; ?></label>
          <input type="password" name="password" value="<?php echo $password; ?>" />
          </p>
        </div>
          <div class="buttons">
                <a href="<?php echo $forgotten; ?>" class="forgot"><?php echo $text_forgotten; ?></a>
                    <button type="submit" class="button btn-login"><?php echo $button_login; ?></button>
          <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <?php } ?>
        </div>
      </form>
    </div>
  </div>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
<?php echo $footer; ?>