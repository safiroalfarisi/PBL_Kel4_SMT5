import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/app_drawer.dart'; // tambah import drawer

class TambahChannelPage extends StatefulWidget {
  const TambahChannelPage({super.key});

  @override
  State<TambahChannelPage> createState() => _TambahChannelPageState();
}

class _TambahChannelPageState extends State<TambahChannelPage> {
  // State variables untuk form baru
  String? _selectedTipe;
  final TextEditingController _namaChannelController = TextEditingController();
  final TextEditingController _nomorRekeningController =
      TextEditingController();
  final TextEditingController _namaPemilikController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();

  // Opsi untuk dropdown 'Tipe' (bisa Anda sesuaikan)
  final List<String> _tipeOptions = ['Bank', 'E-Wallet', 'QRIS'];

  @override
  void dispose() {
    // Pastikan dispose semua controller
    _namaChannelController.dispose();
    _nomorRekeningController.dispose();
    _namaPemilikController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  // Fungsi untuk mereset form
  void _resetForm() {
    setState(() {
      _selectedTipe = null;
      _namaChannelController.clear();
      _nomorRekeningController.clear();
      _namaPemilikController.clear();
      _catatanController.clear();
      // Tambahkan logika reset file upload jika ada
    });
  }

  // Helper widget untuk input teks agar tidak berulang
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: kPrimaryBlue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadBox({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ), // <-- Gunakan parameter 'label'
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  hint, // Parameter 'hint' tetap dipakai di sini
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  textAlign: TextAlign.center, // Tambahan agar hint rapi
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  'Powered by PCJNA',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Transfer Channel'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // hindari back button
        leading: Builder(
          // paksa hamburger untuk membuka drawer
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(), // tampilkan sidebar
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header bertema (konsisten)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimaryBlue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form Channel',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Buat Transfer Channel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.add_card, color: Colors.white),
                  ],
                ),
              ),
              // Konten form
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hapus judul duplikat di dalam card agar tidak dobel dengan header
                        // const Text('Buat Transfer Channel', ... ),
                        // const SizedBox(height: 24),

                        // 1. NAMA CHANNEL
                        _buildTextField(
                          label: 'Nama Channel',
                          controller: _namaChannelController,
                          hintText: 'Contoh: BCA, Dana, QRIS RT',
                        ),
                        const SizedBox(height: 20),

                        // 2. TIPE
                        const Text(
                          'Tipe',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedTipe,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              // tambahkan ini
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: kPrimaryBlue),
                            ),
                            hintText: '-- Pilih Tipe --',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          ),
                          items: _tipeOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedTipe = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // 3. NOMOR REKENING / AKUN
                        _buildTextField(
                          label: 'Nomor Rekening / Akun',
                          controller: _nomorRekeningController,
                          hintText: 'Contoh: 1234567890',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),

                        // 4. NAMA PEMILIK
                        _buildTextField(
                          label: 'Nama Pemilik',
                          controller: _namaPemilikController,
                          hintText: 'Contoh: John Doe',
                        ),
                        const SizedBox(height: 20),

                        // 5. QR
                        _buildFileUploadBox(
                          label: 'QR',
                          hint: 'Upload foto QR (jika ada) png/jpeg/jpg',
                        ),
                        const SizedBox(height: 20),

                        // 6. THUMBNAIL
                        _buildFileUploadBox(
                          label: 'Thumbnail',
                          hint: 'Upload thumbnail (jika ada) png/jpeg/jpg',
                        ),
                        const SizedBox(height: 20),

                        // 7. CATATAN (OPSIONAL)
                        _buildTextField(
                          label: 'Catatan (Opsional)',
                          controller: _catatanController,
                          hintText:
                              'Contoh: Transfer hanya dari bank yang sama agar instan',
                          maxLines: 3, // TextArea
                        ),
                        const SizedBox(height: 40),

                        // Tombol Aksi
                        Row(
                          children: [
                            // Tombol Reset disesuaikan
                            OutlinedButton(
                              onPressed: _resetForm,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey.shade700,
                                backgroundColor: Colors.grey.shade100,
                                side: BorderSide(color: Colors.grey.shade300),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 32,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Tombol Simpan
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logika Simpan Data di sini
                                  debugPrint('Data Tersimpan');
                                  // Navigator.pop(context); // Kembali ke halaman daftar
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryBlue,
                                  foregroundColor: Colors.white, // Teks putih
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(fontSize: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}
