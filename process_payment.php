<?php
session_start();

if (!isset($_SESSION['userLogin'])) {
    header("Location: login-form-2.php");
    exit();
}

function generatePaymentID() {
    $con = new mysqli('database1.cfs6wemgo5yu.us-east-1.rds.amazonaws.com', 'admin', 'Abcd1234', 'database1', '3306');

    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }
    $sqlRent = "SELECT * FROM payment ORDER BY paymentid DESC LIMIT 1";
    $result = mysqli_query($con, $sqlRent);
    $row = mysqli_fetch_assoc($result);
    $lastID = $row['paymentid'];

    $f_ID = null;
    while ($f_ID === null) {
        if ($lastID === null) {
            $f_ID = "P000001";
        } else {
            $nextid = substr($lastID, 1) + 1;
            $f_ID = "P" . sprintf('%06d', $nextid);
        }

        $check_query = "SELECT paymentid FROM payment WHERE paymentid = '$f_ID'";
        $check_result = mysqli_query($con, $check_query);

        if (mysqli_num_rows($check_result) > 0) {
            $f_ID = null; // Payment ID already exists, generate a new one
            $lastID = $f_ID; // Use the new Payment ID as the last ID to generate the next one
        }
    }
    mysqli_free_result($result);
    mysqli_free_result($check_result);

    return $f_ID;
}
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="Css/custom-2.css">
        <style>
            .center-box {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 400px;
            }
        </style>
    </head>
    <body>
        <?php include 'header-2.php'; ?>

        <div class="container center-box">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <?php
                    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                        try {
                            if (!isset($_POST['placeorder'])) {
                                throw new Exception('Invalid request.');
                            }

                            $studentID = $_POST['studentid'];
                            $products = $_POST['products'];
                            $quantities = $_POST['quantities'];
                            $prices = $_POST['prices'];
                            $orderIds = $_POST['orderid'];

                            $con = new mysqli('database1.cfs6wemgo5yu.us-east-1.rds.amazonaws.com', 'admin', 'Abcd1234', 'database1', '3306');
                            if ($con->connect_error) {
                                die("Connection failed: " . $con->connect_error);
                            }

                            $sql = 'INSERT INTO payment (paymentid, studentid, productid, totalamount, productqty) VALUES (?, ?, ?, ?, ?)';
                            $stmt = $con->prepare($sql);

                            $success = true;
                            for ($i = 0; $i < count($products); $i++) {
                                $paymentId = generatePaymentID();
                                $product_id = $products[$i];
                                $quantity = (int) $quantities[$i];
                                $product_price = (float) $prices[$i];
                                $total_amount = $product_price * $quantity;
                                $stmt->bind_param("sssdi", $paymentId, $studentID, $product_id, $total_amount, $quantity);

                                if ($stmt->execute()) {
                                    $order_id = $orderIds[$i];
                                    $deleteStmt = $con->prepare("DELETE FROM cart WHERE orderid = ?");
                                    $deleteStmt->bind_param("s", $order_id);
                                    $deleteStmt->execute();
                                    $deleteStmt->close();
                                } else {
                                    $success = false;
                                    break;
                                }
                            }

                            if ($success) {
                                echo "
                                    <div class='alert alert-success animate__animated animate__fadeIn' role='alert' style='padding: 25px;'>
                                        <h1 class='alert-heading' style='padding: 25px;'>Congratulations!</h1>
                                        <p>Your payment was successful.</p>
                                        <hr>
                                        <p class='mb-0'><a href='homepage-2.php' class='btn btn-success'>Continue Shopping</a></p>
                                    </div>";
                            } else {
                                echo "
                                    <div class='alert alert-danger animate__animated animate__shakeX' role='alert' style='padding: 25px;'>
                                        <h1 class='alert-heading' style='padding: 25px;'>Oh no! Payment failed.</h1>
                                        <p>There was an issue processing your payment. Please try again.</p>
                                        <hr>
                                        <p class='mb-0'><a href='cart-2.php' class='btn btn-danger'>Try Again</a></p>
                                    </div>";
                            }
                        } catch (Exception $e) {
                            if (isset($con) && $con->errno) {
                                $con->rollback();
                            }
                        } finally {
                            if (isset($con) && $con->errno) {
                                $con->close();
                            }
                        }
                    }
                    ?>
                </div>
            </div>
        </div>

        <?php include 'footer-2.php'; ?>
    </body>
</html>