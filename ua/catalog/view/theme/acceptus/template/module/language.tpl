<?php if (count($languages) > 1) { ?>
<form id="language-form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <div id="language">
        <div class="dropdown">
            <ul>
                <?php foreach ($languages as $language) { ?>
                    <li><a href="<?php echo $language['link']; ?>"><?php echo $language['name']; ?></a></li>
                <?php } ?>
            </ul>
            <input type="hidden" name="language_code" value=""/>

            <input type="hidden" name="redirect" value=""/>
        </div>
    </div>
</form>
<?php } ?>
