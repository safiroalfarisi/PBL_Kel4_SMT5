import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class KategoriIuranPage extends StatefulWidget {
  const KategoriIuranPage({super.key});

  @override
  State<KategoriIuranPage> createState() => _KategoriIuranPageState();
}

class _KategoriIuranPageState extends State<KategoriIuranPage> {
  final List<Map<String, dynamic>> _iuranList = [
    {'no': 1, 'nama': 'Asad', 'jenis': 'Iuran Khusus', 'nominal': 3000},
    {'no': 2, 'nama': 'YYY', 'jenis': 'Iuran Bulanan', 'nominal': 5000},
    {'no': 3, 'nama': 'Harian', 'jenis': 'Iuran Khusus', 'nominal': 2},
    {'no': 4, 'nama': 'Kerja Bakti', 'jenis': 'Iuran Khusus', 'nominal': 5},
    {
      'no': 5,
      'nama': 'Bersih Desa',
      'jenis': 'Iuran Khusus',
      'nominal': 200000,
    },
  ];

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  String? _selectedKategori;

  bool get _isMobile => MediaQuery.of(context).size.width < 900;

  void _showAddModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Buat Iuran Baru',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 350,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Masukkan data iuran baru dengan lengkap.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama Iuran',
                      hintText: 'Masukkan nama iuran',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: kPrimaryBlue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Jumlah',
                      hintText: 'Masukkan nominal',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: kPrimaryBlue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Kategori Iuran',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: kPrimaryBlue, width: 2),
                      ),
                    ),
                    value: _selectedKategori,
                    items: const [
                      DropdownMenuItem(
                        value: 'Iuran Bulanan',
                        child: Text('Iuran Bulanan'),
                      ),
                      DropdownMenuItem(
                        value: 'Iuran Khusus',
                        child: Text('Iuran Khusus'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedKategori = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (_namaController.text.isNotEmpty &&
                    _jumlahController.text.isNotEmpty &&
                    _selectedKategori != null) {
                  setState(() {
                    _iuranList.add({
                      'no': _iuranList.length + 1,
                      'nama': _namaController.text,
                      'jenis': _selectedKategori!,
                      'nominal': int.tryParse(_jumlahController.text) ?? 0,
                    });
                  });
                  _namaController.clear();
                  _jumlahController.clear();
                  _selectedKategori = null;
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatRupiah(int number) {
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Kategori Iuran'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Header bertema
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
                      'Pemasukan',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Kategori Iuran',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.category, color: Colors.white),
              ],
            ),
          ),
          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Aksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                        onPressed: _showAddModal,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Tambah Iuran',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_list,
                          color: kPrimaryBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Responsif
                  Expanded(
                    child: _isMobile
                        ? _buildMobileList()
                        : _buildDesktopTable(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tabel desktop existing dibungkus card
  Widget _buildDesktopTable() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 24,
            headingRowColor: MaterialStateProperty.all(
              Colors.blue.shade50.withOpacity(0.5),
            ),
            columns: const [
              DataColumn(label: Text('NO')),
              DataColumn(label: Text('NAMA IURAN')),
              DataColumn(label: Text('JENIS IURAN')),
              DataColumn(label: Text('NOMINAL')),
              DataColumn(label: Text('AKSI')),
            ],
            rows: _iuranList.map((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item['no'].toString())),
                  DataCell(Text(item['nama'])),
                  DataCell(_buildJenisChip(item['jenis'])),
                  DataCell(Text(formatRupiah(item['nominal']))),
                  const DataCell(Icon(Icons.more_horiz)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // List mobile-friendly
  Widget _buildMobileList() {
    return ListView.separated(
      itemCount: _iuranList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final item = _iuranList[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              item['nama'],
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  _buildJenisChip(item['jenis']),
                  const SizedBox(width: 8),
                  Text(
                    formatRupiah(item['nominal']),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            trailing: const Icon(Icons.more_horiz, color: Colors.grey),
            onTap: () {},
          ),
        );
      },
    );
  }

  // Chip jenis iuran
  Widget _buildJenisChip(String jenis) {
    final isBulanan = jenis.toLowerCase().contains('bulanan');
    final bg = isBulanan ? Colors.green.shade50 : Colors.indigo.shade50;
    final fg = isBulanan ? Colors.green.shade700 : Colors.indigo.shade700;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        jenis,
        style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
