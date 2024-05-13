-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2023 at 08:32 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `chat_id` varchar(50) NOT NULL,
  `message` text DEFAULT NULL,
  `user_id 1` varchar(25) NOT NULL,
  `user_id 2` varchar(25) NOT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` varchar(50) NOT NULL,
  `comment_date` date DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  `post_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment_likes`
--

CREATE TABLE `comment_likes` (
  `comment_id` varchar(35) NOT NULL,
  `user_id` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `friend`
--

CREATE TABLE `friend` (
  `user_id_1` varchar(50) NOT NULL,
  `friend_user_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `has_post`
--

CREATE TABLE `has_post` (
  `user_id` varchar(50) NOT NULL,
  `post_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `make_chat`
--

CREATE TABLE `make_chat` (
  `user_id` varchar(50) NOT NULL,
  `chat_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE `page` (
  `page_id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date_of_creation` date DEFAULT NULL,
  `company_email` varchar(50) DEFAULT NULL,
  `total_likes` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_likes`
--

CREATE TABLE `page_likes` (
  `user_like_id` varchar(50) NOT NULL,
  `page_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `post_id` varchar(50) NOT NULL,
  `Created by` varchar(225) NOT NULL,
  `title` text DEFAULT NULL,
  `date_of_creation` date DEFAULT NULL,
  `likes` varchar(50) DEFAULT NULL,
  `total_share` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_likes`
--

CREATE TABLE `post_likes` (
  `post_id` varchar(35) NOT NULL,
  `user_id` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share`
--

CREATE TABLE `share` (
  `user_id` varchar(50) NOT NULL,
  `post_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `user_id` varchar(225) NOT NULL,
  `Fname` varchar(225) DEFAULT NULL,
  `Lname` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  `universty` varchar(50) DEFAULT NULL,
  `martia_status` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `photo` blob DEFAULT NULL,
  `vidoes` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_mobile_number`
--

CREATE TABLE `user_mobile_number` (
  `user_id` varchar(25) NOT NULL,
  `mobile_number` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `Chat_ibfk_1` (`user_id 1`),
  ADD KEY `Chat_ibfk_2` (`user_id 2`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `comment_likes`
--
ALTER TABLE `comment_likes`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `comment_id` (`comment_id`);

--
-- Indexes for table `friend`
--
ALTER TABLE `friend`
  ADD PRIMARY KEY (`user_id_1`),
  ADD UNIQUE KEY `friend_user_id` (`friend_user_id`);

--
-- Indexes for table `has_post`
--
ALTER TABLE `has_post`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `post_id` (`post_id`);

--
-- Indexes for table `make_chat`
--
ALTER TABLE `make_chat`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `chat_id` (`chat_id`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`page_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `page_likes`
--
ALTER TABLE `page_likes`
  ADD PRIMARY KEY (`user_like_id`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `Created by` (`Created by`);

--
-- Indexes for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `share`
--
ALTER TABLE `share`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_mobile_number`
--
ALTER TABLE `user_mobile_number`
  ADD PRIMARY KEY (`mobile_number`),
  ADD KEY `user_id` (`user_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `Chat_ibfk_1` FOREIGN KEY (`user_id 1`) REFERENCES `user_info` (`user_id`),
  ADD CONSTRAINT `Chat_ibfk_2` FOREIGN KEY (`user_id 2`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`);

--
-- Constraints for table `comment_likes`
--
ALTER TABLE `comment_likes`
  ADD CONSTRAINT `comment_likes_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`),
  ADD CONSTRAINT `comment_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `friend`
--
ALTER TABLE `friend`
  ADD CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`friend_user_id`) REFERENCES `user_info` (`user_id`),
  ADD CONSTRAINT `friend_ibfk_2` FOREIGN KEY (`user_id_1`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `has_post`
--
ALTER TABLE `has_post`
  ADD CONSTRAINT `has_post_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  ADD CONSTRAINT `has_post_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `make_chat`
--
ALTER TABLE `make_chat`
  ADD CONSTRAINT `make_chat_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`chat_id`),
  ADD CONSTRAINT `make_chat_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `page`
--
ALTER TABLE `page`
  ADD CONSTRAINT `page_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `page_likes`
--
ALTER TABLE `page_likes`
  ADD CONSTRAINT `page_likes_ibfk_1` FOREIGN KEY (`user_like_id`) REFERENCES `user_info` (`user_id`),
  ADD CONSTRAINT `page_likes_ibfk_2` FOREIGN KEY (`page_id`) REFERENCES `page` (`page_id`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`Created by`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD CONSTRAINT `post_likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  ADD CONSTRAINT `post_likes_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `share`
--
ALTER TABLE `share`
  ADD CONSTRAINT `share_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  ADD CONSTRAINT `share_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `user_mobile_number`
--
ALTER TABLE `user_mobile_number`
  ADD CONSTRAINT `user_mobile_number_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
