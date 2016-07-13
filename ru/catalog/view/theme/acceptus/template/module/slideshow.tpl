<div class="slideshow-wrapper">
    <div class="slideshow" style=" height: <?php echo $height; ?>">
        <div>New Slideshow</div>
      <div id="slideshow<?php echo $module; ?>" class="nivoSlider" >
        <?php foreach ($banners as $banner) { ?>
        <?php if ($banner['link']) { ?>
        <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
        <?php } else { ?>
        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
        <?php } ?>
        <?php } ?>
      </div>
    </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#slideshow<?php echo $module; ?>').nivoSlider();
    $('.slideshow-wrapper').height($('.slideshow').height());
});
--></script>