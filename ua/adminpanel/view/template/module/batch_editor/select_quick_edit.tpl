<select class="select-<?php echo $action; ?>-<?php echo $id; ?>">
 <?php if ($action == 'manufacturer' || $action == 'tax_class') { ?>
 <option value="0"></option>
 <?php } ?>
 <?php foreach (${$actions[$action]} as ${$action}) { ?>
 <?php if (${$action}['name'] == $name) { ?>
 <option value="<?php echo ${$action}[$action . '_id']; ?>" selected="selected"><?php echo ${$action}['name']; ?></option>
 <?php } else { ?>
 <option value="<?php echo ${$action}[$action . '_id']; ?>"><?php echo ${$action}['name']; ?></option>
 <?php } ?>
 <?php } ?>
</select>