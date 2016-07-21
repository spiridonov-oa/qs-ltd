<div class="box">
  <div class="box-heading"><span><?php echo $heading_title; ?></span></div>
  <div class="box-content">
    <ul class="box-category treemenu">
      <?php foreach ($categories as $category) { ?>
      <li <?php if ($category['active']) { echo 'class="active"';} ?> >
        <a href="<?php echo $category['href']; ?>"  ><span><?php echo $category['name']; ?></span></a>
        <?php if ($category['children']) { ?>
        <ul>
          <?php foreach ($category['children'] as $child) { ?>
              <li <?php if ($child['active']) { echo 'class="active"';} ?> >
                <a href="<?php echo $child['href']; ?>"  ><span><?php echo $child['name']; ?></span></a>
                  <ul>
                      <?php foreach ($child['children'] as $sub_child) { ?>
                          <li <?php if ($sub_child['active']) { echo 'class="active"';} ?> >
                              <a href="<?php echo $sub_child['href']; ?>"><span><?php echo $sub_child['name']; ?></span></a>
                          </li>
                      <?php } ?>
                  </ul>
              </li>
          <?php } ?>
        </ul>
        <?php } ?>
      </li>
      <?php } ?>
    </ul>
  </div>
</div>
