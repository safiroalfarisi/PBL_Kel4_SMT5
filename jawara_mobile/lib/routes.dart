import 'package:flutter/material.dart';

// Auth pages
import 'pages/login_page.dart';
import 'pages/register_page.dart';

// Dashboard
import 'pages/dashboard_page.dart';
import 'pages/sidebar/dashboard/keuangan_page.dart';
import 'pages/sidebar/dashboard/kegiatan_page.dart';
import 'pages/sidebar/dashboard/kependudukan_page.dart';

// Data Warga & Rumah
import 'pages/sidebar/dataWargaRumah/warga_daftar_page.dart';
import 'pages/sidebar/dataWargaRumah/warga_tambah_page.dart';
import 'pages/sidebar/dataWargaRumah/keluarga_page.dart';
import 'pages/sidebar/dataWargaRumah/rumah_daftar_page.dart';
import 'pages/sidebar/dataWargaRumah/rumah_tambah_page.dart';
import 'pages/sidebar/dataWargaRumah/detail_keluarga_page.dart';

// Pemasukan
import 'pages/sidebar/pemasukan/kategori_iuran_page.dart';
import 'pages/sidebar/pemasukan/iuran_page.dart';
import 'pages/sidebar/pemasukan/tagihan_page.dart';
import 'pages/sidebar/pemasukan/pemasukan_lain_daftar_page.dart';
import 'pages/sidebar/pemasukan/pemasukan_lain_tambah_page.dart';

// Pengeluaran
import 'pages/sidebar/pengeluaran/pengeluaran_daftar_page.dart';
import 'pages/sidebar/pengeluaran/pengeluaran_tambah_page.dart';

// Laporan Keuangan
import 'pages/sidebar/laporanKeuangan/semua_pemasukan_page.dart';
import 'pages/sidebar/laporanKeuangan/semua_pengeluaran_page.dart';
import 'pages/sidebar/laporanKeuangan/cetak_laporan_page.dart';

// Kegiatan & Broadcast
import 'pages/sidebar/kegiatanBroadcast/kegiatan_daftar_page.dart';
import 'pages/sidebar/kegiatanBroadcast/kegiatan_tambah_page.dart';
import 'pages/sidebar/kegiatanBroadcast/broadcast_daftar_page.dart';
import 'pages/sidebar/kegiatanBroadcast/broadcast_tambah_page.dart';

// Pesan Warga
import 'pages/sidebar/pesanWarga/informasi_aspirasi_page.dart';

// Penerimaan Warga
import 'pages/sidebar/penerimaanWarga/penerimaan_warga_page.dart';

// Mutasi Keluarga
import 'pages/sidebar/mutasiKeluarga/mutasi_daftar_page.dart';
import 'pages/sidebar/mutasiKeluarga/mutasi_tambah_page.dart';

// Log Aktifitas
import 'pages/sidebar/logAktifitas/semua_aktifitas_page.dart';

// Manajemen Pengguna
import 'pages/sidebar/manajemenPengguna/daftar_pengguna_page.dart';
import 'pages/sidebar/manajemenPengguna/tambah_pengguna_page.dart';
import 'pages/sidebar/manajemenPengguna/detail_pengguna_page.dart';
import 'pages/sidebar/manajemenPengguna/edit_pengguna_page.dart';

// Channel Transfer
import 'pages/sidebar/channelTransfer/daftar_channel_page.dart';
import 'pages/sidebar/channelTransfer/tambah_channel_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  // Auth
  '/': (context) => const LoginPage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),

  // Dashboard
  '/dashboard': (context) => const DashboardPage(),
  '/keuangan': (context) => const KeuanganPage(),
  '/kegiatan': (context) => const KegiatanPage(),
  '/kependudukan': (context) => const KependudukanPage(),

  // Data Warga & Rumah
  '/warga/daftar': (context) => const WargaDaftarPage(),
  '/warga/tambah': (context) => const WargaTambahPage(),
  '/keluarga': (context) => const KeluargaPage(),
  '/rumah/daftar': (context) => const RumahDaftarPage(),
  '/rumah/tambah': (context) => const RumahTambahPage(),
  '/detail-keluarga': (context) => const DetailKeluargaPage(),

  // Pemasukan
  '/kategori/iuran': (context) => const KategoriIuranPage(),
  '/iuran': (context) => const IuranPage(),
  '/tagihan': (context) => const TagihanPage(),
  '/pemasukan_lain/daftar': (context) => const PemasukanLainDaftarPage(),
  '/pemasukan_lain/tambah': (context) => const PemasukanLainTambahPage(),

  // Pengeluaran
  '/daftar/pengeluaran': (context) => const PengeluaranDaftarPage(),
  '/tambah/pengeluaran': (context) => const PengeluaranTambahPage(),

  // Laporan Keuangan
  '/laporan/pemasukan': (context) => const SemuaPemasukanPage(),
  '/laporan/pengeluaran': (context) => const SemuaPengeluaranPage(),
  '/laporan/cetak': (context) => const CetakLaporanPage(),

  // Kegiatan & Broadcast
  '/daftar/kegiatan': (context) => const KegiatanDaftarPage(),
  '/tambah/kegiatan': (context) => const KegiatanTambahPage(),
  '/daftar/broadcast': (context) => const BroadcastDaftarPage(),
  '/tambah/broadcast': (context) => const BroadcastTambahPage(),

  // Pesan Warga
  '/informasi/aspirasi': (context) => const InformasiAspirasiPage(),

  // Penerimaan Warga
  '/penerimaan/warga': (context) => const PenerimaanWargaPage(),

  // Mutasi Keluarga
  '/mutasi/daftar': (context) => const MutasiDaftarPage(),
  '/mutasi/tambah': (context) => const MutasiTambahPage(),

  // Log Aktifitas
  '/log/aktifitas': (context) => const SemuaAktifitasPage(),

  // Manajemen Pengguna
  '/pengguna/daftar': (context) => const DaftarPenggunaPage(),
  '/pengguna/tambah': (context) => const TambahPenggunaPage(),
  '/detail-pengguna': (context) => const DetailPenggunaPage(),
  '/edit-pengguna': (context) => const EditPenggunaPage(),

  // Channel Transfer
  '/channel/daftar': (context) => const DaftarChannelPage(),
  '/channel/tambah': (context) => const TambahChannelPage(),
};