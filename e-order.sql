-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 02, 2020 at 05:58 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e-order`
--

-- --------------------------------------------------------

--
-- Table structure for table `jenis_barang`
--

CREATE TABLE `jenis_barang` (
  `id_jenis` varchar(50) NOT NULL,
  `jenis_brg` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jenis_barang`
--

INSERT INTO `jenis_barang` (`id_jenis`, `jenis_brg`) VALUES
('1', 'Barang Cetakan'),
('2', 'Barang Non Cetakan');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id` int(11) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `kode_brg` varchar(5) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tgl_keluar` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `pengeluaran`
--
DELIMITER $$
CREATE TRIGGER `TG_STOK_UPDATE` AFTER INSERT ON `pengeluaran` FOR EACH ROW BEGIN
	update stokbarang SET keluar=keluar + NEW.jumlah, 
	sisa=stok-keluar WHERE 
	kode_brg = NEW.kode_brg;

	update permintaan SET status=1 WHERE kode_brg=NEW.kode_brg AND 
	unit=NEW.unit;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `permintaan`
--

CREATE TABLE `permintaan` (
  `id_permintaan` int(100) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `kode_brg` varchar(5) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `nama_tukang` varchar(20) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sementara`
--

CREATE TABLE `sementara` (
  `id_sementara` int(100) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `kode_brg` varchar(5) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `nama_tukang` varchar(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stokbarang`
--

CREATE TABLE `stokbarang` (
  `kode_brg` varchar(5) NOT NULL,
  `id_jenis` int(2) NOT NULL,
  `nama_brg` varchar(30) NOT NULL,
  `satuan` varchar(50) DEFAULT NULL,
  `harga_item` float NOT NULL,
  `stok` int(11) NOT NULL,
  `keluar` int(11) DEFAULT '0',
  `sisa` int(11) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `suplier` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('pen_sdm&umum','pen_umkm','pen_admin','pen_uppk','pen_ukkp','pen_tiak','pen_prospek','pen_kmr','pel_umum','pel_umkm','pel_admin','pel_ukkp','pel_uppk','pel_prospek','pel_tiak','pel_kmr','pblo_pblo','pel_layanan','pen_layanan','pel_umum2') NOT NULL,
  `manajer` varchar(50) NOT NULL,
  `asmen` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `level`, `manajer`, `asmen`) VALUES
(15, 'pel_umum', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_umum', 'Wahyu Winarti', 'Muammer'),
(18, 'pen_sdm&umum', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_sdm&umum', 'Wahyu Winarti', 'Muammer'),
(19, 'pel_umkm', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_umkm', 'Wahyu Winarti', 'Muammer'),
(20, 'pen_umkm', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_umkm', 'Wahyu Winarti', 'Muammer'),
(23, 'pblo', '827ccb0eea8a706c4c34a16891f84e7b', 'pblo_pblo', 'Wahyu Winarti', 'Muammer'),
(24, 'pen_admin', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_admin', 'Wahyu Winarti', 'Muammer'),
(25, 'pel_admin', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_admin', 'Wahyu Winarti', 'Muammer'),
(26, 'pel_uppk', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_uppk', 'Wahyu Winarti', 'Muammer'),
(27, 'pen_uppk', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_uppk', 'Wahyu Winarti', 'Muammer'),
(28, 'pen_prospek', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_prospek', 'Wahyu Winarti', 'Muammer'),
(29, 'pel_prospek', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_prospek', 'Wahyu Winarti', 'Muammer'),
(30, 'pel_tiak', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_tiak', 'Wahyu Winarti', 'Muammer'),
(31, 'pen_tiak', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_tiak', 'Wahyu Winarti', 'Muammer'),
(32, 'pen_layanan', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_layanan', 'Wahyu Winarti', 'Muammer'),
(33, 'pel_layanan', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_layanan', 'Wahyu Winarti', 'Muammer'),
(34, 'pel_ukkp', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_ukkp', 'Wahyu Winarti', 'Muammer'),
(35, 'pen_ukkp', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_ukkp', 'Wahyu Winarti', 'Muammer'),
(36, 'pel_kmr', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_kmr', 'Wahyu Winarti', 'Muammer'),
(37, 'pen_kmr', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_kmr', 'Wahyu Winarti', 'Muammer'),
(38, 'pel_umum2', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_umum2', 'Wahyu Winarti', 'Muammer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jenis_barang`
--
ALTER TABLE `jenis_barang`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permintaan`
--
ALTER TABLE `permintaan`
  ADD PRIMARY KEY (`id_permintaan`);

--
-- Indexes for table `sementara`
--
ALTER TABLE `sementara`
  ADD PRIMARY KEY (`id_sementara`);

--
-- Indexes for table `stokbarang`
--
ALTER TABLE `stokbarang`
  ADD PRIMARY KEY (`kode_brg`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `permintaan`
--
ALTER TABLE `permintaan`
  MODIFY `id_permintaan` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `sementara`
--
ALTER TABLE `sementara`
  MODIFY `id_sementara` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
