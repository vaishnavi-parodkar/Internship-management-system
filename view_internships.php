<?php
session_start();
require 'database.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'student') {
    header("Location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];

// Fetch all internships with company info
$sql = "SELECT i.id, i.title, i.description, i.location, i.duration, i.stipend, u.full_name AS company
        FROM internships i
        JOIN companies c ON i.company_id = c.id
        JOIN users u ON c.user_id = u.id
        ORDER BY i.posted_on DESC";
$result = $conn->query($sql);

// Handle Apply action
if (isset($_GET['apply'])) {
    $internship_id = intval($_GET['apply']);

    // Check if already applied
    $check = $conn->prepare("SELECT id FROM applications WHERE internship_id=? AND student_id=(SELECT id FROM students WHERE user_id=?)");
    $check->bind_param("ii", $internship_id, $user_id);
    $check->execute();
    $check_res = $check->get_result();

    if ($check_res->num_rows == 0) {
        $stmt = $conn->prepare("INSERT INTO applications (student_id, internship_id, status) 
                                VALUES ((SELECT id FROM students WHERE user_id=?), ?, 'Pending')");
        $stmt->bind_param("ii", $user_id, $internship_id);
        $stmt->execute();
        $message = "Applied successfully!";
    } else {
        $message = "You have already applied to this internship.";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Internships</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
    <h2>Available Internships</h2>
    <a href="student_dashboard.php" class="btn btn-secondary mb-3">Back to Dashboard</a>

    <?php if (!empty($message)): ?>
        <div class="alert alert-info"><?= htmlspecialchars($message) ?></div>
    <?php endif; ?>

    <table class="table table-bordered">
        <tr>
            <th>Title</th>
            <th>Company</th>
            <th>Location</th>
            <th>Duration</th>
            <th>Stipend</th>
            <th>Action</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?= htmlspecialchars($row['title']) ?></td>
            <td><?= htmlspecialchars($row['company']) ?></td>
            <td><?= htmlspecialchars($row['location']) ?></td>
            <td><?= htmlspecialchars($row['duration']) ?></td>
            <td><?= htmlspecialchars($row['stipend']) ?></td>
            <td><a href="?apply=<?= $row['id'] ?>" class="btn btn-primary btn-sm">Apply</a></td>
        </tr>
        <?php endwhile; ?>
    </table>
</body>
</html>
