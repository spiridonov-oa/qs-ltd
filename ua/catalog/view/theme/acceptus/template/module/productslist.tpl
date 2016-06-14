<?php echo $header; ?>
<div id="content">
    <table id="productlist">
        <thead>
        <tr>
            <td>Id</td>
            <td>Name</td>
            <td>model</td>
            <td>Price</td>
            <td>Image</td>
            <td>Sort order</td>
        </tr>
        </thead>
        <?php foreach ($products as $product) { ?>
        <tbody>
            <tr>
                <td><?php echo $product['product_id']; ?></td>
                <td><?php echo $product['name']; ?></td>
                <td <?php if(!$product['model']) { echo 'class="red-color"';}; ?> ><?php echo $product['model']; ?></td>
                <td <?php if($product['price'] == 0) { echo 'class="red-color"';}; ?> ><?php echo number_format($product['price'], 2, ',', ' '); ?></td>
                <td <?php if(!$product['image']) { echo 'class="red-color"';}; ?> ><?php echo $product['image']; ?></td>
                <td><?php echo $product['sort_order']; ?></td>
            </tr>
        </tbody>
        <?php } ?>
    </table>
    <style>
        #productlist, #productlist td{
            border: 1px solid #888888;
            color: #666666;
            border-collapse: collapse;
        }
        #productlist td{
            padding: 0 10px;
        }
        #productlist td img{
            width: 50px;
        }
        .red-color{
            background-color: #ff9fab;
        }
    </style>
</div>
<?php echo $footer; ?>