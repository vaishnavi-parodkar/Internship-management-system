<?php
session_start();
if(isset($_SESSION["user_id"])){
    header("Location: index.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <?php
        if(isset($_POST["login"])){
            $email = $_POST["email"];
            $password = $_POST["password"];

            require_once "database.php";

            // Admin login check
            if($email === "admin@internship.com" && $password === "admin1234") {
                $_SESSION["user_id"] = 1; // dummy ID for admin
                $_SESSION["role"] = "admin";
                $_SESSION["full_name"] = "Admin";
                header("Location: admin.php");
                exit();
            }

            // Normal users
            $sql ="SELECT * FROM users WHERE email = ?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "s", $email);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            $user = mysqli_fetch_assoc($result);

            if($user){
                if(password_verify($password, $user["password"])){
                    $_SESSION["user_id"] = $user["id"];
                    $_SESSION["role"] = $user["role"]; // make sure your `users` table has a 'role' column
                    $_SESSION["full_name"] = $user["full_name"];

                    header("Location: index.php");
                    exit();
                } else {
                    echo "<div class='alert alert-danger'>Password does not match</div>";
                }
            } else {
                echo "<div class='alert alert-danger'>Email does not match</div>";
            }
        }
        ?>
        <form action="login.php" method="post">
            <h1>LOGIN</h1>
            <div class="form-group">
                <input type="email" placeholder="Enter Email: " name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <input type="password" placeholder="Enter Password: " name="password" class="form-control" required>
            </div>
            <div class="form-btn">
                <input type="submit" value="Login" name="login" class="btn btn-primary">
            </div>
        </form>
        <div>
           <p class="form-footer">Not registered yet?<a href="registration.php">Register Here</a></p>
        </div>
    </div>
</body>
</html>
