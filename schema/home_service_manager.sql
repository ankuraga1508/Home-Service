-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2016 at 11:52 PM
-- Server version: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `home_service_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `caregiver`
--

CREATE TABLE `caregiver` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` varchar(1) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `zipcode` int(10) NOT NULL,
  `contact_number` bigint(20) UNSIGNED NOT NULL,
  `alter_contact_num` bigint(20) UNSIGNED DEFAULT NULL,
  `dob` date NOT NULL,
  `manager_id` bigint(20) UNSIGNED DEFAULT NULL,
  `freetext1` varchar(255) DEFAULT NULL,
  `freetext2` varchar(255) DEFAULT NULL,
  `freetext3` varchar(255) DEFAULT NULL,
  `freetext4` varchar(255) DEFAULT NULL,
  `freetext5` varchar(255) DEFAULT NULL,
  `freetext6` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `contact_number` bigint(20) NOT NULL,
  `alter_contact_num` bigint(20) DEFAULT NULL,
  `dob` date NOT NULL,
  `freetext1` varchar(255) DEFAULT NULL,
  `freetext2` varchar(255) DEFAULT NULL,
  `freetext3` varchar(255) DEFAULT NULL,
  `freetext4` varchar(255) DEFAULT NULL,
  `freetext5` varchar(255) DEFAULT NULL,
  `freetext6` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `request_id` bigint(20) UNSIGNED NOT NULL,
  `requested_by` bigint(20) UNSIGNED NOT NULL,
  `assigned_to` bigint(20) UNSIGNED NOT NULL,
  `service_id` int(10) UNSIGNED NOT NULL,
  `status_id` varchar(3) NOT NULL,
  `freetext1` varchar(1) NOT NULL,
  `freetext2` varchar(1) NOT NULL,
  `freetext3` varchar(1) NOT NULL,
  `freetext4` varchar(1) NOT NULL,
  `comments` text,
  `cre_user_id` bigint(20) UNSIGNED NOT NULL,
  `cre_time` datetime NOT NULL,
  `lchg_user_id` bigint(20) UNSIGNED NOT NULL,
  `lchg_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` varchar(1) NOT NULL,
  `role_desc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_desc`) VALUES
('A', 'Administrator'),
('C', 'Customer'),
('G', 'Caregiver');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(10) UNSIGNED NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `service_desc` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `service_name`, `service_desc`, `is_active`) VALUES
(1, 'CLEANING', 'General house cleaning service', 1),
(2, 'COOKING', 'Breakfast. lunch and dinner cooking', 1),
(3, 'PLUMBING', 'Plumbing services for home', 1),
(4, 'MOWING', 'Lawn mowing service', 1),
(5, 'MEDICAL HELP 1', 'Provide help for taking medicine', 1);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` varchar(3) NOT NULL,
  `status_desc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_desc`) VALUES
('ACK', 'Service has been acknowledged by admin'),
('ASN', 'Service has been assigned to caregiver'),
('CAN', 'Service has been cancelled'),
('COM', 'Service has been completed'),
('REJ', 'Service has been rejected'),
('REQ', 'Service has been requested by customer and needs to be acknowledged');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `role_id` varchar(1) NOT NULL,
  `reg_complete` tinyint(1) NOT NULL DEFAULT '0',
  `cre_user_id` bigint(20) UNSIGNED NOT NULL,
  `cre_time` datetime NOT NULL,
  `lchg_user_id` bigint(20) UNSIGNED NOT NULL,
  `lchg_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `caregiver`
--
ALTER TABLE `caregiver`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_roleid_caregiver_constraint` (`role_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `fk_requestedby_request_constraint` (`requested_by`),
  ADD KEY `fk_assignedto_request_constraint` (`assigned_to`),
  ADD KEY `fk_serviceid_request_constraint` (`service_id`),
  ADD KEY `fk_statusid_request_constraint` (`status_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`),
  ADD UNIQUE KEY `idx_servicename_unique` (`service_name`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `idx_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `request_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `caregiver`
--
ALTER TABLE `caregiver`
  ADD CONSTRAINT `fk_roleid_caregiver_constraint` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_userid_caregiver_constraint` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_userid_customer_constraint` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `fk_assignedto_request_constraint` FOREIGN KEY (`assigned_to`) REFERENCES `caregiver` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_requestedby_request_constraint` FOREIGN KEY (`requested_by`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_serviceid_request_constraint` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_statusid_request_constraint` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
