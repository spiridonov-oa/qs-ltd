<?php echo $header; ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="contact-page"><?php echo $content_top; ?>
    <div class="box">
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>

        <div>
            <div class="right">
                <p><?php echo $text_call_us; ?></p>
                <?php if ($telephone) { ?>
                <p><div class="icon-phone"></div><span class="contact-data"><?php echo $telephone; ?></span></p>
                <?php } ?>
                <?php if ($fax) { ?>
                <b><?php echo $text_fax; ?></b><br />
                <?php echo $fax; ?>
                <?php } ?>
                <?php if ($config_email) { ?>
                <p><div class="icon-email"></div><a class="contact-data" href="mailto:<?php echo $config_email; ?>"><?php echo $config_email; ?></a></p>
                <?php } ?>
            </div>
        </div>

        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

            <div class="contact-info">
                <div class="content">
                    <div class="">
                        <h2 class="box-heading"><?php echo $text_contact; ?></h2>
                        <b><?php echo $text_email; ?></b><br />
                        <p><a href="mailto:<?php echo $config_email; ?>"><?php echo $config_email; ?></a></p>
                        <b><?php echo $entry_name; ?></b><br />
                        <input type="text" name="name" style="width: 400px;" value="<?php echo $name; ?>" />
                        <br />
                        <?php if ($error_name) { ?>
                        <span class="error"><?php echo $error_name; ?></span>
                        <?php } ?>
                        <br />
                        <b><?php echo $entry_email; ?></b><br />
                        <input type="text" name="email" style="width: 400px;" value="<?php echo $email; ?>" />
                        <br />
                        <?php if ($error_email) { ?>
                        <span class="error"><?php echo $error_email; ?></span>
                        <?php } ?>
                        <br />
                        <b><?php echo $entry_enquiry; ?></b><br />
                        <textarea name="enquiry" cols="40" rows="10" style="max-width: 390px; width: 390px;"><?php echo $enquiry; ?></textarea>
                        <br />
                        <?php if ($error_enquiry) { ?>
                        <span class="error"><?php echo $error_enquiry; ?></span>
                        <?php } ?>
                        <br />
                        <p><?php echo $entry_captcha; ?></p>
                        <p>
                            <input  class="captcha" type="text" name="captcha" value="<?php echo $captcha; ?>" />

                            <img src="index.php?route=information/contact/captcha" alt="" />
                            <?php if ($error_captcha) { ?>
                            <span class="error"><?php echo $error_captcha; ?></span>
                            <?php } ?>
                        </p>
                    </div>
                </div>
            </div>
            <div class="buttons">
                <div class="right"><button type="submit" class="button"><?php echo $button_continue; ?></button></div>
            </div>
        </form>
    </div>
    <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>