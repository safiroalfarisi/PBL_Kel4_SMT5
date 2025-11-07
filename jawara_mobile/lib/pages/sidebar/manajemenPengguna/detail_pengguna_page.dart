import 'package:flutter/material.dart';
import '../../../widgets/custom_detail_app_bar.dart';
import '../../../theme.dart';
import 'daftar_pengguna_page.dart';

class DetailPenggunaPage extends StatefulWidget {
  const DetailPenggunaPage({super.key});

  @override
  State<DetailPenggunaPage> createState() => _DetailPenggunaPageState();
}

class _DetailPenggunaPageState extends State<DetailPenggunaPage> {
  String _selectedYear = '2025';

  @override
  Widget build(BuildContext context) {
    final Pengguna pengguna = ModalRoute.of(context)!.settings.arguments as Pengguna;

    return Scaffold(
      appBar: CustomDetailAppBar(
        title: 'Detail Pengguna',
        subtitle: 'Informasi Lengkap Pengguna',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header dengan avatar
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: kPrimaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: kPrimaryBlue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pengguna.nama,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sekretaris',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Informasi Detail
                  _buildDetailItem('NIK', '3674072257025008'),
                  _buildDetailItem('Email', pengguna.email),
                  _buildDetailItem('Nomor HP', '0821211112'),
                  _buildDetailItem('Jenis Kelamin', 'Laki-laki'),
                  _buildDetailItem('Alamat Lengkap', 'Jl. Merdeka No. 123, RT 01/RW 02, Kelurahan Sukamaju'),
                  _buildDetailItem('Nomor Telepon', '021-12345678'),
                  _buildDetailItem('Tanggal Registrasi', '15 Oktober 2025'),
                  _buildDetailItem('Terakhir Login', '21 Oktober 2025, 14:30 WIB'),
                  
                  const SizedBox(height: 24),
                  
                  // Status Registrasi
                  Row(
                    children: [
                      Text(
                        'Status Registrasi',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(pengguna.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pengguna.status,
                          style: TextStyle(
                            color: _getStatusTextColor(pengguna.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Foto Identitas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Foto Identitas',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 200,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diterima':
        return Colors.green.shade100;
      case 'Pending':
        return Colors.orange.shade100;
      case 'Ditolak':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Diterima':
        return Colors.green.shade700;
      case 'Pending':
        return Colors.orange.shade700;
      case 'Ditolak':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}