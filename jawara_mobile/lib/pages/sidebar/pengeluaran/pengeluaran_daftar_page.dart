import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pastikan package intl ditambahkan di pubspec.yaml
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class PengeluaranDaftarPage extends StatefulWidget {
  const PengeluaranDaftarPage({super.key});

  @override
  State<PengeluaranDaftarPage> createState() => _PengeluaranDaftarPageState();
}

class _PengeluaranDaftarPageState extends State<PengeluaranDaftarPage> {
  // Data statis untuk contoh, dengan tambahan data detail
  final List<Map<String, dynamic>> pengeluaranData = [
    {
      "no": 1,
      "nama": "Kerja Bakti",
      "jenis": "Kegiatan Warga",
      "tanggal": "19 Oktober 2025",
      "nominal": "Rp 100.000,00",
      "tanggal_verifikasi": "19 Oct 2025 20:26",
      "verifikator": "Admin Jawara",
    },
    {
      "no": 2,
      "nama": "Kerja Bakti",
      "jenis": "Pemeliharaan Fasilitas",
      "tanggal": "19 Oktober 2025",
      "nominal": "Rp 50.000,00",
      "tanggal_verifikasi": "19 Oct 2025 20:27",
      "verifikator": "Admin Jawara",
    },
    {
      "no": 3,
      "nama": "Arka",
      "jenis": "Operasional RT/RW",
      "tanggal": "17 Oktober 2025",
      "nominal": "Rp 6,00",
      "tanggal_verifikasi": "17 Oct 2025 10:00",
      "verifikator": "Bendahara RT",
    },
    {
      "no": 4,
      "nama": "adsad",
      "jenis": "Pemeliharaan Fasilitas",
      "tanggal": "02 Oktober 2025",
      "nominal": "Rp 2.112,00",
      "tanggal_verifikasi": "02 Oct 2025 08:30",
      "verifikator": "Bendahara RT",
    },
  ];

  // Gaya teks untuk header tabel
  final TextStyle headerStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  // Gaya teks untuk isi sel
  final TextStyle cellStyle = TextStyle(fontSize: 14, color: Colors.grey[800]);

  // --- FUNGSI AKSI ---

  // 1. Menampilkan Dialog Detail (Gambar Detail)
  void _showDetailDialog(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar bisa full screen
      useSafeArea: true, // Agar tidak tertimpa status bar
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) {
        // Menggunakan Scaffold untuk AppBar "Kembali"
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(sheetContext).pop(),
            ),
            title: const Text(
              'Kembali',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            leadingWidth: 100, // Agar "Kembali" dan ikon muat
            titleSpacing: 0,
          ),
          body: _DetailContent(item: item),
        );
      },
    );
  }

  // 3. Menampilkan Dialog Filter (Gambar Filter)
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: _FilterDialogContent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengeluaran'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Biru seperti di KeuanganPage
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ringkasan Pengeluaran',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showFilterDialog(context),
                        icon: const Icon(Icons.filter_list, size: 20),
                        label: const Text('Filter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Konten Utama
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPengeluaranList(),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BARU UNTUK DAFTAR PENGELUARAN ---
  Widget _buildPengeluaranList() {
    if (pengeluaranData.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'Tidak ada data pengeluaran.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pengeluaranData.length,
      itemBuilder: (context, index) {
        final item = pengeluaranData[index];
        return _buildPengeluaranCard(item);
      },
    );
  }

  Widget _buildPengeluaranCard(Map<String, dynamic> item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showDetailDialog(context, item),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['nama'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    item['nominal'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item['jenis'],
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                item['tanggal'],
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGET HELPER UNTUK DIALOG DETAIL ---
class _DetailContent extends StatelessWidget {
  final Map<String, dynamic> item;
  const _DetailContent({required this.item});

  // Helper untuk membuat baris detail
  Widget _buildDetailRow(
    String label,
    String value, {
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detail Pengeluaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          _buildDetailRow('Nama Pengeluaran', item['nama']),
          _buildDetailRow('Kategori', item['jenis']),
          _buildDetailRow('Tanggal Transaksi', item['tanggal']),
          _buildDetailRow('Nominal', item['nominal'], valueColor: Colors.red),
          _buildDetailRow('Tanggal Terverifikasi', item['tanggal_verifikasi']),
          _buildDetailRow('Verifikator', item['verifikator']),
        ],
      ),
    );
  }
}

// --- WIDGET HELPER UNTUK DIALOG FILTER ---
class _FilterDialogContent extends StatefulWidget {
  const _FilterDialogContent();

  @override
  _FilterDialogContentState createState() => _FilterDialogContentState();
}

class _FilterDialogContentState extends State<_FilterDialogContent> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _dariTanggalController = TextEditingController();
  final TextEditingController _sampaiTanggalController =
      TextEditingController();

  String? _selectedKategori;
  final List<String> _kategoriOptions = [
    'Operasional RT/RW',
    'Kegiatan Sosial',
    'Pemeliharaan Fasilitas',
    'Pembangunan',
    'Kegiatan Warga',
    'Lain Lain',
  ];

  DateTime? _dariTanggal;
  DateTime? _sampaiTanggal;

  @override
  void dispose() {
    _namaController.dispose();
    _dariTanggalController.dispose();
    _sampaiTanggalController.dispose();
    super.dispose();
  }

  // Fungsi untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context, bool isDariTanggal) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        // Menggunakan theme color dari kPrimaryBlue
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        if (isDariTanggal) {
          _dariTanggal = picked;
          _dariTanggalController.text = formattedDate;
        } else {
          _sampaiTanggal = picked;
          _sampaiTanggalController.text = formattedDate;
        }
      });
    }
  }

  // Helper untuk input teks
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
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
          ),
        ),
      ],
    );
  }

  // Helper untuk Date Picker
  Widget _buildDatePicker({
    required String label,
    required TextEditingController controller,
    required bool isDariTanggal,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: '-- / -- / ----',
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
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min, // Agar ikon rapat
              children: [
                if (controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                        if (isDariTanggal) {
                          _dariTanggal = null;
                        } else {
                          _sampaiTanggal = null;
                        }
                      });
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.grey),
                  onPressed: () => _selectDate(context, isDariTanggal),
                ),
              ],
            ),
          ),
          onTap: () => _selectDate(context, isDariTanggal),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContextg) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // Batasi lebar dialog
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Dialog
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Pengeluaran',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const Divider(height: 24),

            // Form Filter
            _buildTextField(
              label: 'Nama',
              controller: _namaController,
              hintText: 'Cari nama...',
            ),
            const SizedBox(height: 16),

            const Text(
              'Kategori',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                hintText: '-- Pilih Kategori --',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              items: _kategoriOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedKategori = newValue;
                });
              },
            ),
            const SizedBox(height: 16),

            _buildDatePicker(
              label: 'Dari Tanggal',
              controller: _dariTanggalController,
              isDariTanggal: true,
            ),
            const SizedBox(height: 16),

            _buildDatePicker(
              label: 'Sampai Tanggal',
              controller: _sampaiTanggalController,
              isDariTanggal: false,
            ),
            const SizedBox(height: 24),

            // Tombol Terapkan
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // --- Logika Terapkan Filter ---
                  debugPrint('Filter Diterapkan:');
                  debugPrint('Nama: ${_namaController.text}');
                  debugPrint('Kategori: $_selectedKategori');
                  debugPrint('Dari: ${_dariTanggalController.text}');
                  debugPrint('Sampai: ${_sampaiTanggalController.text}');
                  Navigator.of(context).pop(); // Tutup dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 15,
                  ),
                ),
                child: const Text('Terapkan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
