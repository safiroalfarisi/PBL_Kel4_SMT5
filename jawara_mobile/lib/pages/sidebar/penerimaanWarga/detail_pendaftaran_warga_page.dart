import 'package:flutter/material.dart';
import '../../../widgets/custom_detail_app_bar.dart';
import '../../../theme.dart';
import 'penerimaan_warga_page.dart';

class DetailPendaftaranWargaPage extends StatefulWidget {
  final WargaBaru warga;

  const DetailPendaftaranWargaPage({super.key, required this.warga});

  @override
  State<DetailPendaftaranWargaPage> createState() => _DetailPendaftaranWargaPageState();
}

class _DetailPendaftaranWargaPageState extends State<DetailPendaftaranWargaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDetailAppBar(
        title: 'Detail Pendaftaran Warga',
        subtitle: 'Informasi Lengkap Pendaftaran',
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
                              widget.warga.nama,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Calon Warga',
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
                  _buildDetailItem('NIK', widget.warga.nik),
                  _buildDetailItem('Email', widget.warga.email),
                  _buildDetailItem('Nomor HP', '0812-3456-7890'),
                  _buildDetailItem('Jenis Kelamin', widget.warga.jenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan'),
                  _buildDetailItem('Alamat Lengkap', widget.warga.alamatRumah.isNotEmpty ? widget.warga.alamatRumah : 'Jl. Merdeka No. 456, RT 02/RW 03, Kelurahan Makmur'),
                  _buildDetailItem('Status Kepemilikan Rumah', widget.warga.statusKepemilikanRumah.isNotEmpty ? widget.warga.statusKepemilikanRumah : 'Milik Sendiri'),
                  _buildDetailItem('Tanggal Pendaftaran', '20 Oktober 2025'),
                  
                  const SizedBox(height: 24),
                  
                  // Status Pendaftaran
                  Row(
                    children: [
                      Text(
                        'Status Pendaftaran',
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
                          color: _getStatusColor(widget.warga.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.warga.status,
                          style: TextStyle(
                            color: _getStatusTextColor(widget.warga.status),
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