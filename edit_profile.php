<?php
session_start();
require 'database.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'student') {
    header("Location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];

// Fetch existing student info
$stmt = $conn->prepare("SELECT * FROM students WHERE user_id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$student = $result->fetch_assoc();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $course = $_POST['course'];
    $year = $_POST['year'];
    $skills = $_POST['skills'];

    if ($student) {
        // Update existing record
        $stmt = $conn->prepare("UPDATE students SET course=?, year=?, skills=? WHERE user_id=?");
        $stmt->bind_param("sssi", $course, $year, $skills, $user_id);
        $stmt->execute();
    } else {
        // Insert new record
        $stmt = $conn->prepare("INSERT INTO students (user_id, course, year, skills) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("isss", $user_id, $course, $year, $skills);
        $stmt->execute();
    }

    $student = ['course'=>$course, 'year'=>$year, 'skills'=>$skills]; // refresh data
    $message = "Profile updated successfully!";
}
?>

<h2>Edit Profile</h2>
<?php if(isset($message)) echo "<p style='color:green;'>$message</p>"; ?>

<form method="POST">
    <label>Course:</label><br>
    <input type="text" name="course" value="<?= $student['course'] ?? '' ?>"><br><br>

    <label>Year:</label><br>
    <input type="text" name="year" value="<?= $student['year'] ?? '' ?>"><br><br>

    <label>Skills:</label><br>
    <input type="text" name="skills" value="<?= $student['skills'] ?? '' ?>"><br><br>

    <input type="submit" value="Save">
</form>

<a href='student_dashboard.php'>Back to Dashboard</a>
