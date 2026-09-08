-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 08, 2026 at 04:51 PM
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
-- Database: `marketplace_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `description`, `price`, `stock`, `user_id`, `category_id`) VALUES
(1, 'Laptop Asus Vivobook', 'Laptop untuk kerja dan kuliah', 7500000.00, 10, 1, 1),
(2, 'Smartphone Samsung A55', 'HP Android terbaru', 5500000.00, 15, 2, 1),
(3, 'Mouse Logitech', 'Mouse wireless berkualitas', 350000.00, 30, 3, 1),
(4, 'Kaos Polos Premium', 'Kaos cotton combed 30s', 85000.00, 50, 5, 2),
(5, 'Jaket Hoodie Pria', 'Jaket casual pria', 250000.00, 20, 7, 2),
(6, 'Keripik Singkong', 'Makanan ringan khas daerah', 25000.00, 100, 1, 3),
(7, 'Kopi Arabica 250gr', 'Kopi bubuk premium', 75000.00, 40, 3, 3),
(8, 'Teh Celup Original', 'Minuman teh kemasan', 15000.00, 80, 5, 4),
(9, 'Kursi Kerja Minimalis', 'Kursi untuk kantor rumah', 900000.00, 12, 7, 5),
(10, 'Keyboard Mechanical', 'Keyboard gaming RGB', 650000.00, 25, 9, 6),
(11, 'Mouse Gaming RGB', 'Mouse gaming dengan sensor tinggi', 450000.00, 18, 9, 6),
(12, 'Sepatu Running', 'Sepatu olahraga pria', 500000.00, 20, 2, 7),
(13, 'Skincare Facial Wash', 'Sabun wajah pria dan wanita', 60000.00, 35, 5, 8),
(14, 'Buku Pemrograman JavaScript', 'Buku belajar coding', 120000.00, 15, 7, 9),
(15, 'Holder HP Motor', 'Holder smartphone kendaraan', 75000.00, 40, 9, 10);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`category_id`, `category_name`, `description`) VALUES
(1, 'Elektronik', 'Produk perangkat elektronik'),
(2, 'Fashion', 'Pakaian dan aksesoris'),
(3, 'Makanan', 'Produk makanan dan minuman'),
(4, 'Minuman', 'Berbagai jenis minuman'),
(5, 'Peralatan Rumah', 'Peralatan kebutuhan rumah'),
(6, 'Gaming', 'Perangkat gaming'),
(7, 'Olahraga', 'Peralatan olahraga'),
(8, 'Kecantikan', 'Produk perawatan tubuh'),
(9, 'Buku', 'Buku dan alat tulis'),
(10, 'Otomotif', 'Aksesoris kendaraan');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `status` enum('pending','paid','cancelled') NOT NULL DEFAULT 'pending'
) ;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `user_id`, `product_id`, `transaction_date`, `quantity`, `total_price`, `status`) VALUES
(1, 4, 1, '2026-09-01 09:15:00', 1, 7500000.00, 'paid'),
(2, 6, 3, '2026-09-01 10:20:00', 2, 700000.00, 'paid'),
(3, 8, 4, '2026-09-02 11:30:00', 3, 255000.00, 'paid'),
(4, 10, 5, '2026-09-02 14:10:00', 1, 250000.00, 'pending'),
(5, 4, 6, '2026-09-03 08:45:00', 5, 125000.00, 'paid'),
(6, 6, 7, '2026-09-03 13:20:00', 2, 150000.00, 'paid'),
(7, 8, 8, '2026-09-04 09:00:00', 4, 60000.00, 'cancelled'),
(8, 10, 9, '2026-09-04 15:30:00', 1, 900000.00, 'paid'),
(9, 4, 10, '2026-09-05 10:15:00', 1, 650000.00, 'paid'),
(10, 6, 11, '2026-09-05 12:40:00', 2, 900000.00, 'paid'),
(11, 8, 12, '2026-09-06 09:30:00', 1, 500000.00, 'pending'),
(12, 10, 13, '2026-09-06 11:00:00', 3, 180000.00, 'paid'),
(13, 4, 14, '2026-09-07 14:20:00', 1, 120000.00, 'paid'),
(14, 6, 15, '2026-09-07 16:10:00', 2, 150000.00, 'cancelled'),
(15, 8, 2, '2026-09-08 10:30:00', 1, 5500000.00, 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('buyer','seller') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `role`) VALUES
(1, 'Zidan Ulul', 'zidan@mail.com', '123456', 'seller'),
(2, 'Andi Pratama', 'andi@mail.com', '123456', 'seller'),
(3, 'Budi Santoso', 'budi@mail.com', '123456', 'seller'),
(4, 'Citra Ayu', 'citra@mail.com', '123456', 'buyer'),
(5, 'Dewi Lestari', 'dewi@mail.com', '123456', 'seller'),
(6, 'Eko Saputra', 'eko@mail.com', '123456', 'buyer'),
(7, 'Fajar Ramadhan', 'fajar@mail.com', '123456', 'seller'),
(8, 'Gita Maharani', 'gita@mail.com', '123456', 'buyer'),
(9, 'Hendra Wijaya', 'hendra@mail.com', '123456', 'seller'),
(10, 'Indah Permata', 'indah@mail.com', '123456', 'buyer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_product_user` (`user_id`),
  ADD KEY `fk_product_category` (`category_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `fk_transaction_user` (`user_id`),
  ADD KEY `fk_transaction_product` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_product_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transaction_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
