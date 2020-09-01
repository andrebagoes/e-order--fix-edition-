-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 31, 2020 at 01:27 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e-req`
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
('1', 'Barang1'),
('2', 'Barang2'),
('3', 'Barang3'),
('4', 'Barang4'),
('5', 'Barang5'),
('6', 'Barang6'),
('7', 'Barang7');

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

--
-- Dumping data for table `permintaan`
--

INSERT INTO `permintaan` (`id_permintaan`, `unit`, `kode_brg`, `id_jenis`, `jumlah`, `tgl_permintaan`, `nama_tukang`, `status`) VALUES
(30, 'umkm_nasrul', 'BR001', 1, 25, '2020-07-27', 'dbasj', 1),
(31, 'umkm_nasrul', 'BR001', 1, 23, '2020-07-30', 'Waduh', 77),
(32, 'umkm_nasrul', 'BR001', 1, 4, '2020-07-30', 'admin kredit', 77),
(33, 'umkm_nasrul', 'BR002', 1, 36, '2020-07-30', 'admin kredit', 77);

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

--
-- Dumping data for table `sementara`
--

INSERT INTO `sementara` (`id_sementara`, `unit`, `kode_brg`, `id_jenis`, `jumlah`, `tgl_permintaan`, `nama_tukang`, `status`) VALUES
(41, 'umkm_nasrul', 'BR001', 1, 222, '2020-07-31', 'lukman', 1),
(42, 'admin_ev', 'BR001', 1, 15, '2020-07-31', 'gcgh', 4);

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

--
-- Dumping data for table `stokbarang`
--

INSERT INTO `stokbarang` (`kode_brg`, `id_jenis`, `nama_brg`, `satuan`, `harga_item`, `stok`, `keluar`, `sisa`, `tgl_masuk`, `suplier`) VALUES
('BR001', 1, 'Kertas A4', 'RIM', 45000, 300, 532, -232, '2020-07-01', 'SINDU'),
('BR002', 1, 'Kertas Karton', 'Roll', 12000, 20, 0, 20, '2020-07-02', 'Haraoan teguh');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('pel_unit','pel_umum','pen_sdm&umum','penyelia','pen_umkm','pel_admin') NOT NULL,
  `manajer` varchar(50) NOT NULL,
  `asmen` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `level`, `manajer`, `asmen`) VALUES
(15, 'umum_tayo', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_umum', 'Wahyu Winarti', 'Muammer'),
(18, 'umum_amer', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_sdm&umum', 'Wahyu Winarti', 'Wahyu Winarti'),
(19, 'umkm_nasrul', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_unit', 'Wahyu Winarti', 'Juli Pardiansyah'),
(20, 'penyelia_umkm', '827ccb0eea8a706c4c34a16891f84e7b', 'pen_umkm', 'Wahyu Winarti', 'Dediek Priyosantoso'),
(21, 'admin_ev', '827ccb0eea8a706c4c34a16891f84e7b', 'pel_admin', 'Wahyu Winarti', 'Juli Pardiansyah');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `permintaan`
--
ALTER TABLE `permintaan`
  MODIFY `id_permintaan` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `sementara`
--
ALTER TABLE `sementara`
  MODIFY `id_sementara` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
