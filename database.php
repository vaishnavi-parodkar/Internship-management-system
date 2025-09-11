<?php
$host = "localhost";
$user = "root";
$pass = "";
$db   = "internship_management"; // ✅ correct database name

$conn = new mysqli("localhost", "root", "", "internship_management");


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
