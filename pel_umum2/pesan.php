<?php
require_once "cek_unit.php";
include "../fungsi/koneksi.php";
$tgl = date('Y-m-d');

define('KS', true);
require_once '../fungsi.php'; //14-07-2020



$query =  "INSERT INTO permintaan SELECT * FROM sementara ";
$query2 = "DELETE FROM sementara WHERE tgl_permintaan='$tgl'";



if (mysqli_query($koneksi, $query)) {
	mysqli_query($koneksi, $query2);
	header("Location:index.php?p=datapesanan");
	$chatid = "xxx";
	$text = "Hai kak silahkan cek aplikasi e-Order, karena ada request permintaan barang dari Unit";
	sendApiMsg($chatid, $text);
} else {
	echo "gagal" . mysqli_error($koneksi);
}
?>
