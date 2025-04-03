<?php
session_start();
if (!isset($_SESSION['userLogin'])) {
    header("Location: login-form-2.php");
}
// Connect to database
$conn = new mysqli('database1.cfs6wemgo5yu.us-east-1.rds.amazonaws.com', 'admin', 'Abcd1234', 'database1', '3306');

if (isset($_POST['action']) && $_POST['action'] == 'delete') {
    $orderId = $_POST['id'];
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    $deleteCartSql = "DELETE FROM cart WHERE orderid = ?";
    $stmt = $conn->prepare($deleteCartSql);
    $stmt->bind_param('s', $orderId);
    $stmt->execute();

    // Check if the cart is empty
    $sql = "SELECT COUNT(*) as count FROM cart WHERE studentid = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('s', $_SESSION['studentId']);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();

    $response = ['cartEmpty' => $row['count'] == 0];
    echo json_encode($response);
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Cart Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="Css/custom-2.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
        <style>
            .hover-effect:hover {
                background-color: lightblue !important;
                color: black !important;
            }
            .hover-effect {
                background-color: blue !important;
                color: white !important;
                padding: 10px !important;
            }
            .table-bordered table, .table-bordered td, .table-bordered th {
                border: solid 1px lightgray;
                padding: 10px;
                text-align: center;
                vertical-align: middle;
            }
        </style>
    </head>

    <body>
        <?php include 'header-2.php' ?>
        <div class="container mt-5" style="height: auto;">
            <div class="container-fluid mt-5">
                <h2 style="text-align: center; margin-bottom: 25px;">Shopping Cart</h2>
                <form action='payment-2.php' method='POST'>
                    <table class="table table-bordered table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Student Id</th>
                                <th>Product Name</th>
                                <th>Unit Price (RM)</th>
                                <th>Quantity</th>
                                <th>Subtotal (RM)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            // Retrieve cart items from database
                            $sql = "select c.orderid, c.studentid, p.product_name, p.product_stock, c.product_id, c.price, c.quantity from cart c left join product p on c.product_id = p.product_id WHERE c.studentid = '" . $_SESSION['studentId'] . "'";
                            $result = mysqli_query($conn, $sql);
                            $total_price = 0;
                            $success = true;
                            // Display cart items
                            if (mysqli_num_rows($result) > 0) {
                                while ($row = mysqli_fetch_assoc($result)) {
                                    $orderid = $row['orderid'];
                                    $studentid = $row['studentid'];
                                    $product_name = $row['product_name'];
                                    $product_stock = $row['product_stock'];
                                    $product_id = $row['product_id'];
                                    $price = $row['price'];
                                    $quantity = $row['quantity'];
                                    $total = $price * $quantity;
                                    $total_price += $total;

                                    echo "<tr data-id='" . $product_id . "' data-studentid='" . $studentid . "'>";
                                    echo "<td>" . $studentid . "</td>";
                                    echo "<td style='text-align: left;'>" . $product_name . "</td>";
                                    echo "<td class='unit-price'>" . number_format($price, 2) . "</td>";
                                    echo "<td><input type='number' class='form-control quantity' style='width: 90px;' min='1' max='" . $product_stock . "' value='" . $quantity . "' oninput='checkMaxValue(this, " . $product_stock . ")'></td>";
                                    echo "<td class='subtotal'>" . number_format($total, 2) . "</td>";
                                    echo "<td><button class='btn btn-danger' data-orderid='" . $orderid . "'>Delete</button></td>";
                                    echo "</tr>";
                                    printf('
                                    <input type="hidden" name="ids[]" value="%s">
                                    <input type="hidden" name="checked[]" value="%s">
                                    <input type="hidden" name="price[]" value=%s>
                                    <input type="hidden" name="quantity[]" value=%s>
                                    <input type="hidden" name="orderid[]" value=%s>
                                    <input type="hidden" name="studentid" value=%s>
                                ', $product_id, $product_name, $price, $quantity, $orderid, $studentid);
                                }
                            } else {
                                echo "<tr><td colspan='6' class='text-center'>No record found</td></tr>";
                                $success = false;
                            }

                            // Close database connection
                            mysqli_close($conn);
                            ?>

                        </tbody>
                        <tfoot>
                        <td colspan="4" style="text-align: right; margin: 30px 0px !important;">
                            <h5>
                                Total Price (RM) :
                            </h5>
                        </td>
                        <td colspan="2" style="text-align: left; margin: 30px 0px !important;">
                            <h5 class="total-price">
                                <?php echo number_format($total_price, 2) ?>
                            </h5>
                        </td>
                        </tfoot>
                    </table>

                    <div class="text-right">
                        <div class="row">
                            <div class="col-2">
                                <a href="homepage-2.php" class="btn btn-primary hover-effect">Back to Homepage</a>
                            </div>
                            <div class="col-2">   
                                <?php
                                if ($success) {
                                    printf('<input type="submit" name="doPayment" value="Checkout" class="btn btn-success hover-effect">');
                                } else {
                                    printf('<input type="submit" disabled value="Checkout" class="btn btn-success hover-effect" style="display: none;">');
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="mt-5">
            <?php include 'footer-2.php' ?>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function checkMaxValue(input, max) {
                if (parseInt(input.value) > max) {
                    input.value = max;
                }
            }

            function calculateTotalPrice() {
                var subtotal = 0;
                $('tbody tr').each(function () {
                    var price = parseFloat($(this).find('.unit-price').text());
                    var quantity = parseInt($(this).find('.quantity').val());
                    var total = price * quantity;
                    subtotal += total;
                    $(this).find('.subtotal').text(total.toFixed(2));
                });
                $('.total-price').text(subtotal.toFixed(2));
            }

            // Function to update item quantity in cart
            function updateQuantity(id, quantity, studentId) {
                console.log({
                    product_id: id,
                    quantity: quantity,
                    studentID: studentId
                });
                $.ajax({
                    url: "add-to-cart-2.php",
                    method: "GET",
                    data: {
                        product_id: id,
                        quantity: quantity,
                        studentID: studentId
                    },
                    success: function (response) {
                        // Update quantity in the UI
                        var row = $('tbody tr[data-orderid="' + id + '"]');
                        row.find('.quantity').val(quantity); // Update input field value
                        var price = parseFloat(row.find('.unit-price').text());
                        var total = price * quantity;
                        row.find('.subtotal').text(total.toFixed(2));
                        calculateTotalPrice(); // Update subtotal and total price
                    }
                });
            }

            $(document).ready(function () {
                // Calculate total price on page load
                calculateTotalPrice();

                // Bind event to quantity input change
                $('tbody').on('input', '.quantity', function () {
                    var id = $(this).closest('tr').data('id');
                    var studentId = $(this).closest('tr').data('studentid');
                    var quantity = parseInt($(this).val());
                    updateQuantity(id, quantity, studentId);
                });
            });

            // Function to delete item from cart
            function deleteItem(id) {
                if (confirm("Are you sure you want to delete this item?")) {
                    $.ajax({
                        url: "cart-2.php",
                        method: "POST",
                        data: {
                            id: id,
                            action: "delete",
                        },
                        success: function (response) {
                            var result = JSON.parse(response);
                            if (result.cartEmpty) {
                                // Display an alert and reload the page to show "No record found"
                                alert('The cart is empty, please shop to add items into the cart.');
                                window.location.href = 'event-details-2.php';
                            } else {
                                // Reload the page to show the updated cart
                                location.reload();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log("Error: " + textStatus + " - " + errorThrown);
                        }
                    });
                }
            }

            // Attach the delete function to the button using event delegation
            $(document).on('click', '.btn-danger', function (event) {
                event.preventDefault();
                var orderId = $(this).data('orderid');
                deleteItem(orderId);
            });

            (function ($) {
                $(window).scroll(function () {
                    if ($(document).scrollTop() > 300) {
                        // Navigation Bar
                        $('.navbar').removeClass('fadeIn');
                        $('.navbar').addClass('fixed-top animated fadeInDown');
                    } else {
                        $('.navbar').removeClass('fadeInDown');
                        $('.navbar').removeClass('fixed-top');
                        $('body').removeClass('shrink');
                        $('.navbar').addClass('animated fadeIn');
                    }
                });
            })(jQuery);
        </script>

    </body>

</html>