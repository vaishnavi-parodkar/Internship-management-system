<?php
session_start();
if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'company') {
    header("Location: login.php");
    exit;
}
echo "<h1>Welcome Company: ".$_SESSION['full_name']."</h1>";
?>
<ul>
  <li><a href='post_internship.php'>Post Internship</a></li>
  <li><a href='view_applicants.php'>View Applicants</a></li>
</ul>
<a href='logout.php'>Logout</a>
