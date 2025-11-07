import 'package:flutter/material.dart';
import '../../../widgets/custom_detail_app_bar.dart';
import '../../../theme.dart';
import 'penerimaan_warga_page.dart';

class VerifikasiWargaPage extends StatefulWidget {
  final WargaBaru warga;

  const VerifikasiWargaPage({super.key, required this.warga});

  @override
  State<VerifikasiWargaPage> createState() => _VerifikasiWargaPageState();
}

class _VerifikasiWargaPageState extends State<VerifikasiWargaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _nikController;
  late TextEditingController _alamatController;
  late TextEditingController _nomorHpController;
  String _selectedJenisKelamin = 'L';
  String _selectedStatusKepemilikan = 'Penyewa';


  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController();
    _emailController = TextEditingController();
    _nikController = TextEditingController();
    _alamatController = TextEditingController();
    _nomorHpController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mengisi data dari widget.warga
    _namaController.text = widget.warga.nama;
    _emailController.text = widget.warga.email;
    _nikController.text = widget.warga.nik;
    _alamatController.text = widget.warga.alamatRumah.isNotEmpty ? widget.warga.alamatRumah : 'Jl. Merdeka No. 456, RT 02/RW 03';
    _nomorHpController.text = '0812-3456-7890';
    _selectedJenisKelamin = widget.warga.jenisKelamin;
    _selectedStatusKepemilikan = widget.warga.statusKepemilikanRumah.isNotEmpty ? widget.warga.statusKepemilikanRumah : 'Penyewa';
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nikController.dispose();
    _alamatController.dispose();
    _nomorHpController.dispose();
    super.dispose();
  }

  void _approveWarga() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pendaftaran ${widget.warga.nama} berhasil disetujui'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  void _rejectWarga() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pendaftaran ${widget.warga.nama} ditolak'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pop(context);
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool readOnly = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
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
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly ? Colors.grey.shade200 : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: readOnly ? Colors.grey.shade400 : Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kPrimaryBlue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDetailAppBar(
        title: 'Verifikasi Warga',
        subtitle: 'Proses Verifikasi Pendaftaran',
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Lengkap
                    _buildFormField(
                      label: 'Nama Lengkap',
                      controller: _namaController,
                      readOnly: true,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Email
                    _buildFormField(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // NIK
                    _buildFormField(
                      label: 'NIK',
                      controller: _nikController,
                      readOnly: true,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Nomor HP
                    _buildFormField(
                      label: 'Nomor HP',
                      controller: _nomorHpController,
                      keyboardType: TextInputType.phone,
                      readOnly: true,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Jenis Kelamin Dropdown (Read-only)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            _selectedJenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Alamat Lengkap
                    _buildFormField(
                      label: 'Alamat Lengkap',
                      controller: _alamatController,
                      readOnly: true,
                      maxLines: 3,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Status Kepemilikan Rumah (Read-only)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Kepemilikan Rumah',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            _selectedStatusKepemilikan,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
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
                    
                    const SizedBox(height: 32),
                    
                    // Tombol Aksi
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _approveWarga,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Setujui',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _rejectWarga,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Tolak',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
      ),
    );
  }
}
