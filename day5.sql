-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2022 at 03:33 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `day5`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(4, 'Humor', 'Books in the humor nonfiction genre are about jokes, people, or events that are humorous. The books in this genre are designed to amuse the reader and make them laugh. They can be joke books or be about a comedian whose life is written in a humorous manne'),
(5, 'Interior', 'Interior book design is the art of creating visually appealing layouts of text and images for the inside of a book. Much of this design work falls under typesetting, the process of arranging and formatting text.'),
(6, 'Novel', 'Novel is a type of book that is written in narrative form. It is fictional and constructed in such a way that it resembles reality. It enables writers to depict the social, political, and personal truths about a place or time which are otherwise avoided.'),
(7, 'Psychology', 'Books in the psychology nonfiction genre are about the applied discipline that involves the scientific study of mental function and behaviors. The books in this genre deal with the science of understanding individuals’ mind functions in an attempt to bene'),
(8, 'Supernatural', 'Supernatural fiction is a subset of fiction in which paranormal ideas are central to the plot. This can include ghosts, extraordinary human abilities, or fantasy creatures. A broad term, supernatural fiction can include horror fiction, fantasy, and even s');

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20221005063128', '2022-10-05 08:31:40', 45),
('DoctrineMigrations\\Version20221005064237', '2022-10-05 08:43:00', 96),
('DoctrineMigrations\\Version20221008155550', '2022-10-08 17:55:56', 71),
('DoctrineMigrations\\Version20221010051431', '2022-10-10 07:14:41', 44),
('DoctrineMigrations\\Version20221010052351', '2022-10-10 07:23:57', 77),
('DoctrineMigrations\\Version20221019061613', '2022-10-19 08:16:58', 53),
('DoctrineMigrations\\Version20221019084601', '2022-10-19 10:46:13', 460),
('DoctrineMigrations\\Version20221022021600', '2022-10-22 04:16:09', 131);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL,
  `imgurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `price`, `imgurl`, `owner_id`) VALUES
(27, 4, 'Cats in Hats', 12, '27.jpg', 4),
(28, 4, 'No Drama Llama', 12, '28.jpg', 4),
(29, 4, 'On Adventure With Dad', 25, '29.jpg', 4),
(30, 4, 'The Lies They Tell', 27, '30.jpg', 4),
(31, 4, 'Misadventures of a Little Soprano', 15, '31.jpg', 4),
(32, 5, 'Life\'s a Beach', 49, '32.jpg', 4),
(33, 5, 'Country and Cozy', 63, '33.jpg', 4),
(34, 5, 'The California Style', 49, '34.jpg', 4),
(35, 5, 'How To Get Away', 63, '35.jpg', 4),
(36, 5, 'Walls', 70, '36.jpg', 4),
(37, 6, 'Hendrix', 32, '37.jpg', 4),
(38, 6, 'Vagina Love', 20, '38.jpg', 4),
(39, 6, 'Frankenstein', 19, '39.jpg', 4),
(40, 6, 'It Won\'t Always Be Like This', 22, '40.jpg', 4),
(41, 6, 'Lady Murasakis Tale Of Genji', 17, '41.jpg', 4),
(42, 7, 'Baseless Hatred', 35, '42.jpg', 4),
(43, 7, 'CEO School', 49, '43.jpg', 4),
(44, 7, 'Strategic Learning', 35, '44.jpg', 4),
(45, 7, 'A Course in Rasch Measurement Theory', 98, '45.jpg', 4),
(46, 7, 'Mind Over Matter and Artificial Intelligence', 105, '46.jpg', 4),
(48, 8, 'No Longer Human', 35, '48.jpg', 4),
(49, 8, 'Love, Death + Robots', 14, '49.jpg', 4),
(50, 8, 'The Knock-Knock Man', 14, '50.jpg', 4),
(51, 8, 'The Writing in the Stone', 28, '51.jpg', 4),
(54, 8, 'The Loving and the Dead', 16, '54.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `lastname`, `firstname`) VALUES
(1, 'tester@gmail.com', '[\"ROLE_CUSTOMER\"]', '$2y$13$nuzGy89NMT9D/oOhDSa17O8leOR5YS9XDRpt/fhdDGDOM4tJzR3hO', 'Tester', NULL),
(2, 'admin@gmail.com', '[]', '$2y$13$CMb7UH3psL8NEDBWydxt6.5tkXquJGQFsRIsLBUkPQeyejl8aKHOC', 'Admin', NULL),
(4, 'nguyentuankiet@gmail.com', '[\"ROLE_SELLER\"]', '$2y$13$LoaeUhb/UsHMbaVUTA9YYO9Qylbm0OQ1Kwsj4z3Kara5jpZL8o2uK', 'Tuan Kiet', 'Nguyen');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`),
  ADD KEY `IDX_D34A04AD7E3C61F9` (`owner_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_D34A04AD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
