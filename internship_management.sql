-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 11, 2025 at 10:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `internship_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `internship_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `applied_on` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `internship_id`, `student_id`, `status`, `applied_on`) VALUES
(3, 2, 4, 'Accepted', '2025-09-11 12:05:05'),
(4, 1, 4, 'Pending', '2025-09-11 12:05:07'),
(5, 2, 5, 'Pending', '2025-09-11 12:07:09'),
(6, 1, 5, 'Pending', '2025-09-11 12:07:10'),
(7, 3, 5, 'Pending', '2025-09-11 12:48:08'),
(8, 3, 4, 'Pending', '2025-09-11 14:38:37'),
(9, 4, 4, 'Pending', '2025-09-11 14:39:59'),
(10, 4, 5, 'Pending', '2025-09-11 14:41:33'),
(11, 4, 6, 'Pending', '2025-09-11 14:57:26'),
(12, 3, 6, 'Pending', '2025-09-11 14:57:28'),
(13, 2, 6, 'Pending', '2025-09-11 14:57:29'),
(14, 4, 7, 'Pending', '2025-09-11 15:06:43');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `user_id`, `company_name`, `location`, `description`) VALUES
(1, 8, 'XYZ', NULL, 'abc'),
(2, 10, 'pqrs', NULL, '1234'),
(3, 14, 'Company2', NULL, 'Software company hiring interns as per the project needs'),
(4, 16, 'mnop', NULL, 'sbanjfbvghdn xmmdkjcj');

-- --------------------------------------------------------

--
-- Table structure for table `internships`
--

CREATE TABLE `internships` (
  `id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `stipend` varchar(50) DEFAULT NULL,
  `posted_on` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internships`
--

INSERT INTO `internships` (`id`, `company_id`, `title`, `description`, `location`, `duration`, `stipend`, `posted_on`) VALUES
(1, 2, 'Frontend dev ', 'YOE: 3+\r\n', 'Pune', '1yr', '30000', '2025-09-11 09:38:39'),
(2, 1, 'Fullstack dev', 'build Fullstack applications ', 'Bangalore', '3 months', '15000', '2025-09-11 11:55:52'),
(3, 3, 'Frontend developer', 'Skilled in HTML, CSS, JavaScript, React.js, Deploying websites, clean coding practices ', 'Bangalore', '3 months', '15000', '2025-09-11 12:47:42'),
(4, 1, 'abc', 'abc', 'India', '1yr', '10000', '2025-09-11 14:39:34');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `course` varchar(100) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `resume_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `course`, `year`, `skills`, `resume_link`) VALUES
(4, 13, 'Computer Engineering ', 3, 'HTML, CSS, JavaScript, React.js', 'https://google.com'),
(5, 7, 'test', 1, 'test', 'https://google.com'),
(6, 9, 'Computer Engineering ', 2, 'HTML CSS', 'https://google.com'),
(7, 15, 'Computer Engineering ', 1, 'HTML, CSS, JavaScript, React.js', 'https://google.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(128) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','student','company') NOT NULL DEFAULT 'student'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `role`) VALUES
(4, 'admin', 'admin@internship.com', '$2y$10$.nWND6EynGvwQ/h9MqQpkunBkInPE3pmAowzCMvYoSQPyzCCbZiFq', 'admin'),
(6, 'admin2', 'admin2@internship.com', '$2y$10$eXls/yBktjU2rM4sI/e1X.SWNxjTIB9CeV7FM9aeiuzSE1Eiunf/a', 'admin'),
(7, 'test', 'test@example.com', '$2y$10$BQefPwc3X7Zwcd67JjlBzuI3CuYYFShPbbQ8Yc2PhkHvKRgoZsKnW', 'student'),
(8, 'company', 'company@gmail.com', '$2y$10$ntvkY.fVP0uphzk5rxxlfOiGt7FrblPKjBACrHcTwODmLY5C.ZzMy', 'company'),
(9, 'test123', 'test123@example.com', '$2y$10$9cQo/4bssC54EnMwxBfYdubOYxVCqdyKC0sMsog2PVvvBtivlAfsG', 'student'),
(10, 'PQRS', 'pqrs@company.com', '$2y$10$R39kGy3zQdmuHXEyf.k6MO67DHDp9FMGewvC/75K4jsBiMziUU2x6', 'company'),
(13, 'vaishnavi', 'vaishnavi@gmail.com', '$2y$10$V7Ri74h7bSo4BqYo9avq.uWQEEy9Av0yZv8nSn2a9xePPoKUwuBje', 'student'),
(14, 'Company2', 'company2@gmail.com', '$2y$10$qgYBkRQhsWXwjsViCU2B5.r80Xy1IeAUDpyXzZV9MBQRvVI3JNoJW', 'company'),
(15, 'abc', 'abc@gmail.com', '$2y$10$um2EMZzoSNtWOJJQUb51deL20jCB27pb2iVT63KXroCbM7RIg.kAm', 'student'),
(16, 'mnop', 'mnop@gmail.com', '$2y$10$Tab4YJgeFNVfM0OQNF9JLO6WTxNGxHaZFn08qVBriFsV3j85hwIOS', 'company');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `internship_id` (`internship_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `internships`
--
ALTER TABLE `internships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `internships`
--
ALTER TABLE `internships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`internship_id`) REFERENCES `internships` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `internships`
--
ALTER TABLE `internships`
  ADD CONSTRAINT `internships_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
