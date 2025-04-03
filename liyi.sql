-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2024 at 09:08 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `liyi`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `orderid` varchar(255) NOT NULL,
  `studentid` varchar(255) NOT NULL,
  `event_id` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`orderid`, `studentid`, `event_id`, `price`, `quantity`) VALUES
('O5e8b584', '', '', 0, 1),
('O60d363a', '21PBD07332', '1', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `event_id` varchar(6) NOT NULL,
  `event_name` varchar(50) NOT NULL,
  `event_description` varchar(500) NOT NULL,
  `event_price` double NOT NULL,
  `location` varchar(50) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` varchar(20) NOT NULL,
  `event_picture` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_id`, `event_name`, `event_description`, `event_price`, `location`, `event_date`, `event_time`, `event_picture`) VALUES
('1', 'Basketball Event 🏀', 'Its a team sport in which two teams of five active players compete to score points by hurling a ball through a 300 cm (10 ft) high hoop (the \'basket\') under organised regulations.', 10, 'TARMUT', '2023-05-21', '6pm-9pm', '645cabe9c2e14.png'),
('2', 'Bowling Event 🎳', 'Come to our bowling event and enjoy the pleasure and thrill of this traditional American activity. Our event will be a hit for everybody with friendly competition, wonderful music, and a welcoming atmosphere.', 15, 'TARMUT', '2023-05-26', '7pm-10pm', '645cac425aa59.png'),
('3', 'Gym Event 🏋', 'Don\'t miss out on our gym event for the ultimate exercise experience. Join us for a day of fun, sweat, and motivation as you strive to be the best version of yourself.', 15, 'TARMUT', '2023-06-10', '7pm-9pm', '645cac6e30238.png'),
('4', 'Running Event ‍🏃', 'Don\'t pass up the opportunity to put your endurance to the test, develop your body, and feel the excitement of crossing the finish line. Join up for our running event today and prepare to sprint towards your goals.', 6, 'TARMUT', '2023-06-20', '8am-10am', '645caca448d78.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `studentid` varchar(20) NOT NULL,
  `fullname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `phonenumber` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`studentid`, `fullname`, `email`, `gender`, `phonenumber`, `password`) VALUES
('21PBD07332', 'Lim Sze Mei', 'limsm-pb21@student.tarc.edu.my', 'F', '012-1234567', 'dsa'),
('21PBD07683', 'Chan Zhi Khang', 'chanzk-pb21@student.tarc.edu.my', 'M', '01118943864', 'chanzk584C'),
('21PBD09064', 'Kwek Rou Yu', 'kwekry-pb21@student.tarc.edu.my', 'F', '0168899988', 'kwekry6K'),
('21PBD09789', 'Joey Low Lee Joe', 'joeyllj-pb21@student.tarc.edu.my', 'F', '0162345292', 'joeyllj7BTS'),
('21PMD09348', 'Yeoh Zhi Chuin', 'yeohzc-pm21@student.tarc.edu.my', 'F', '0124568612', 'yeohzc7B'),
('21PMD10277', 'Alvin Leow Chun Chao', 'alvinlcc-pm21@student.tarc.edu.my', 'M', '0188867943', 'alvinlcc1M'),
('22PBD07345', 'Teoh Ming Hui', 'teohmh-pb22@student.tarc.edu.my', 'F', '0166688912', 'teohmh8C'),
('22PMD07800', 'Ng Kai Wen', 'abc123@gmail.com', 'F', '0123456444', '016UMlumyk'),
('22PMD07894', 'Ng Kai Wen', 'ngkw-pm22@student.tarc.edu.my', 'F', '0162469252', 'Abc12345'),
('22PMD09999', 'CHUNG LI YI', 'chungly-pm22@student.tarc.edu.my', 'F', '016457894', '9Mingsugab');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `OrderID` varchar(10) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `StudentID` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Gender` char(1) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  `PriceAmount` int(2) NOT NULL,
  `Event` varchar(30) NOT NULL,
  `Quantity` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`OrderID`, `Name`, `StudentID`, `Email`, `Gender`, `PhoneNumber`, `PriceAmount`, `Event`, `Quantity`) VALUES
('o1', 'Alvin Leow Chun Chao', '21PMD10277', 'alvinicc-pm21@student.tarc.edu.my', 'M', '0188867943', 5, 'Running', 1),
('o10', 'Teoh Ming Hui', '22PBD07345', 'teohmh-pb22@student.tarc.edu.my', 'F', '0166688912', 5, 'Gym', 1),
('o2', 'Lim Sze Mei', ' 21PBD07332', 'limsm-pb21@sludenl.tarc.edu.my', 'F', '0125678947', 10, 'Basketball', 1),
('o3', 'Chan Zhi Khang', '21PBD07683', 'chanzk-pb21@sludent.tarc.edu.my', 'M', '01118943864', 10, 'Bowling', 1),
('o4', 'Kwek Rou Yu', '21PBD09064', 'kwekry-pb21@sludent.tarc.edu.my', 'F', '0168899988', 5, 'Running', 1),
('o5', 'Joey Low Lee Joe', ' 21PBD09789', 'joeyllj-pb21@student.tarc.edu.my', 'F', '0162345292', 5, 'Gym', 1),
('o6', 'Yeoh Zhi Chuin', '21PMD09348', 'yeohzc-pm21@student.tarc.edu.my', 'F', '0124568612', 10, 'Basketball', 1),
('o7', 'Ng Kai Wen', '22PMD07894', 'ngkw-pm22@student.tarc.edu.my', 'F', '0162469252', 5, 'Running', 1),
('o8', 'Ng Hong Ze', '22PMD07994', 'nghz-pm22@student.tarc.edu.my', 'M', '0168889898', 10, 'Gym', 1),
('o9', 'Tan Yee Thern', '22PMD09586', 'tanyt-pm22@student.tarc.edu.my', 'F', '016789456', 5, 'Gym', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `fullname` varchar(30) DEFAULT NULL,
  `paymentid` varchar(20) NOT NULL,
  `studentid` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `event` varchar(50) DEFAULT NULL,
  `ticketprice` double DEFAULT NULL,
  `totalamount` double DEFAULT NULL,
  `ticketquantity` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`fullname`, `paymentid`, `studentid`, `email`, `event`, `ticketprice`, `totalamount`, `ticketquantity`) VALUES
('Wong', '64650967d29aa', '21PBD07337', 'abc123@gmail.com', 'Basketball Event 🏀', 10, 10, 1),
('Wong', '64650ab5e373c', '21PBD07337', 'abc123@gmail.com', 'Bowling Event 🎳', 15, 15, 1),
('Alvin Leow Chun Chao', 'P000001', '21PMD10277', 'alvinlcc-pm21@student.tarc.edu.my', 'Running', 5, 5, 1),
('Lim Sze Mei', 'P000002', '21PBD07332', 'limsm-pb21@student.tarc.edu.my', 'Basketball', 10, 10, 1),
('Chan Zhi Khang', 'P000003', '21PBD07683', 'chanzk-pb21@student.tarc.edu.my', 'Bowling', 10, 10, 1),
('Kwek Rou Yu', 'P000004', '21PMD09064', 'kwekry-pb21@student.tarc.edu.my', 'Running', 5, 5, 1),
('Joey Low Lee Joe', 'P000005', '21PBD09789', 'joeyllj-pb21@student.tarc.edu.my', 'Gym', 5, 5, 1),
('Yeoh Zhi Chuin', 'P000006', '21PMD09348', 'yeohzc-pm21@student.tarc.edu.my', 'Basketball', 10, 10, 1),
('Ng Kai Wen', 'P000007', '22PMD07894', 'ngkw-pm22@student.tarc.edu.my', 'Running', 5, 5, 1),
('Ng Hong Ze', 'P000008', '22PMD07994', 'nghz-pm22@student.tarc.edu.my', 'Gym', 10, 10, 1),
('Tan Yee Thern', 'P000009', '22PMD09586', 'tanyt-pm22@student.tarc.edu.my', 'Gym', 10, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `ReviewID` varchar(30) NOT NULL,
  `StudentID` varchar(30) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Event` varchar(20) NOT NULL,
  `Categories` varchar(60) NOT NULL,
  `StarRate` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`ReviewID`, `StudentID`, `Name`, `Event`, `Categories`, `StarRate`) VALUES
('1', '21PBD07332', 'Lim Sze Mei', '🤸Gym', 'Worker Attitude(Customer Service)', 4),
('3', '22PMD09999', 'CHUNG LI YI', '🎳Bowling', 'Worker Attitude(Customer Service)', 5),
('4', '21PBD07332', 'Lim Sze Mei', '🎳Bowling', 'Worker Responsive(Customer Service)', 5),
('5', '21PBD07332', 'Lim Sze Mei', '🏃️Running', 'Overall Experience', 3);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staffID` varchar(30) NOT NULL,
  `staffName` varchar(40) NOT NULL,
  `staffEmail` varchar(70) NOT NULL,
  `staffPH` varchar(13) NOT NULL,
  `staffGender` varchar(6) NOT NULL,
  `staffPass` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffID`, `staffName`, `staffEmail`, `staffPH`, `staffGender`, `staffPass`) VALUES
('1', 'CHUNG LI YI', 'abc123@gmail.com', '01262511111', 'F', 'password1'),
('2', 'CHUNG LI JING', 'abc123@gmail.com', '0123456', 'F', 'password2'),
('3', 'CHUNG LI LING', 'abc123@gmail.com', '0123456', 'F', 'password3');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Name` varchar(30) NOT NULL,
  `Course` char(2) NOT NULL,
  `StudentID` varchar(10) NOT NULL,
  `Gender` char(1) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  `Event` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Name`, `Course`, `StudentID`, `Gender`, `Email`, `PhoneNumber`, `Event`) VALUES
('Wong Junyi', 'AC', '22PMD00007', 'M', 'junyi@gmail.com', '0194430012', 'BL'),
('Wong Yunqi', 'IS', '22PMD01311', 'F', 'qiqiwong@gmail.com', '01234567', 'RN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`orderid`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`studentid`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentid`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`ReviewID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staffID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StudentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
