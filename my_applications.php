<?php
session_start();
require 'database.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'student') {
    header("Location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];

$sql = "SELECT a.id, i.title, u.full_name AS company, a.status
        FROM applications a
        JOIN internships i ON a.internship_id = i.id
        JOIN companies c ON i.company_id = c.id
        JOIN users u ON c.user_id = u.id
        WHERE a.student_id = (SELECT id FROM students WHERE user_id = ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
    <h2>My Applications</h2>
    <a href="student_dashboard.php" class="btn btn-secondary mb-3">Back to Dashboard</a>

    <table class="table table-bordered">
        <tr>
            <th>ID</th>
            <th>Internship</th>
            <th>Company</th>
            <th>Status</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?= $row['id'] ?></td>
            <td><?= htmlspecialchars($row['title']) ?></td>
            <td><?= htmlspecialchars($row['company']) ?></td>
            <td><?= htmlspecialchars($row['status']) ?></td>
        </tr>
        <?php endwhile; ?>
    </table>
</body>
</html>
