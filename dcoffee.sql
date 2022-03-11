-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2022 at 02:48 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dcoffee`
--

-- --------------------------------------------------------

--
-- Table structure for table `mst_employee`
--

CREATE TABLE `mst_employee` (
  `id_employee` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `salary` double(20,2) DEFAULT NULL,
  `total_sale` double(20,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_employee`
--

INSERT INTO `mst_employee` (`id_employee`, `name`, `surname`, `position`, `salary`, `total_sale`) VALUES
(1, 'สุขใจ', 'ไทยเดิม', 'พนักงาน', 5000.00, 30000.00),
(2, 'มานี', 'รักถิ่นไทย', 'เจ้าของร้าน', 6000.00, 50000.00);

-- --------------------------------------------------------

--
-- Table structure for table `mst_security`
--

CREATE TABLE `mst_security` (
  `id_security` int(11) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `id_employee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_security`
--

INSERT INTO `mst_security` (`id_security`, `user`, `password`, `id_employee`) VALUES
(1, 'sutgai.t@gmail.com', 'qw123', 1),
(2, 'manee.r@gmail.com', 'as123', 2);

-- --------------------------------------------------------

--
-- Table structure for table `trn_login`
--

CREATE TABLE `trn_login` (
  `id_login` int(11) NOT NULL,
  `datetime_login` datetime DEFAULT NULL,
  `id_employee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trn_login`
--

INSERT INTO `trn_login` (`id_login`, `datetime_login`, `id_employee`) VALUES
(1, '2021-02-03 08:08:11', 1),
(2, '2021-02-03 12:08:11', 2),
(3, '2021-02-04 08:08:11', 1),
(4, '2021-02-04 08:08:11', 2),
(5, '2021-02-05 08:08:11', 2),
(6, '2021-02-06 08:08:11', 2);

-- --------------------------------------------------------

--
-- Table structure for table `trn_logout`
--

CREATE TABLE `trn_logout` (
  `id_logout` int(11) NOT NULL,
  `datetime_logout` datetime DEFAULT NULL,
  `id_employee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trn_logout`
--

INSERT INTO `trn_logout` (`id_logout`, `datetime_logout`, `id_employee`) VALUES
(1, '2021-02-03 16:08:11', 1),
(2, '2021-02-03 18:08:11', 2),
(3, '2021-02-04 16:08:11', 1),
(4, '2021-02-04 12:08:11', 2),
(5, '2021-02-05 16:08:11', 2),
(6, '2021-02-06 12:08:11', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mst_employee`
--
ALTER TABLE `mst_employee`
  ADD PRIMARY KEY (`id_employee`);

--
-- Indexes for table `mst_security`
--
ALTER TABLE `mst_security`
  ADD PRIMARY KEY (`id_security`),
  ADD KEY `id_employee` (`id_employee`);

--
-- Indexes for table `trn_login`
--
ALTER TABLE `trn_login`
  ADD PRIMARY KEY (`id_login`),
  ADD KEY `id_employee` (`id_employee`);

--
-- Indexes for table `trn_logout`
--
ALTER TABLE `trn_logout`
  ADD PRIMARY KEY (`id_logout`),
  ADD KEY `id_employee` (`id_employee`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mst_employee`
--
ALTER TABLE `mst_employee`
  MODIFY `id_employee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mst_security`
--
ALTER TABLE `mst_security`
  MODIFY `id_security` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trn_login`
--
ALTER TABLE `trn_login`
  MODIFY `id_login` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `trn_logout`
--
ALTER TABLE `trn_logout`
  MODIFY `id_logout` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mst_security`
--
ALTER TABLE `mst_security`
  ADD CONSTRAINT `mst_security_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `mst_employee` (`id_employee`);

--
-- Constraints for table `trn_login`
--
ALTER TABLE `trn_login`
  ADD CONSTRAINT `trn_login_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `mst_employee` (`id_employee`);

--
-- Constraints for table `trn_logout`
--
ALTER TABLE `trn_logout`
  ADD CONSTRAINT `trn_logout_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `mst_employee` (`id_employee`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
