import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';
import 'package:intl/intl.dart';

class _Pemasukan {
  final int no;
  final String nama;
  final String jenis;
  final String tanggal;
  final String nominal;

  _Pemasukan({
    required this.no,
    required this.nama,
    required this.jenis,
    required this.tanggal,
    required this.nominal,
  });
}

class PemasukanLainDaftarPage extends StatefulWidget {
  const PemasukanLainDaftarPage({super.key});

  @override
  State<PemasukanLainDaftarPage> createState() =>
      _PemasukanLainDaftarPageState();
}

class _PemasukanLainDaftarPageState extends State<PemasukanLainDaftarPage> {
  final List<_Pemasukan> _dataPemasukan = [
    _Pemasukan(
      no: 1,
      nama: 'Uang Kaget',
      jenis: 'Dana Bantuan Pemerintah',
      tanggal: '26 Oktober 2025',
      nominal: 'Rp 2.000.000,00',
    ),
    _Pemasukan(
      no: 2,
      nama: 'aaaaa',
      jenis: 'Dana Bantuan Pemerintah',
      tanggal: '15 Oktober 2025',
      nominal: 'Rp 11,00',
    ),
    _Pemasukan(
      no: 3,
      nama: 'Joki by firman',
      jenis: 'Pendapatan Lainnya',
      tanggal: '13 Oktober 2025',
      nominal: 'Rp 49.999.997,00',
    ),
    _Pemasukan(
      no: 4,
      nama: 'tes',
      jenis: 'Pendapatan Lainnya',
      tanggal: '12 Agustus 2025',
      nominal: 'Rp 10.000,00',
    ),
  ];

  int _currentPage = 1;

  Future<void> _showFilterModal(BuildContext context) async {
    final TextEditingController _namaController = TextEditingController();
    String? _selectedKategori;
    final TextEditingController _dariTanggalController =
        TextEditingController();
    final TextEditingController _sampaiTanggalController =
        TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              insetPadding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter Pemasukan',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        label: 'Nama',
                        hint: 'Cari nama...',
                        controller: _namaController,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(
                        label: 'Kategori',
                        hint: '-- Pilih Kategori --',
                        value: _selectedKategori,
                        items: [
                          'Dana Bantuan Pemerintah',
                          'Pendapatan Lainnya'
                        ],
                        onChanged: (val) {
                          setModalState(() => _selectedKategori = val);
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildDatePicker(
                        context: context,
                        label: 'Dari Tanggal',
                        controller: _dariTanggalController,
                      ),
                      const SizedBox(height: 16),
                      _buildDatePicker(
                        context: context,
                        label: 'Sampai Tanggal',
                        controller: _sampaiTanggalController,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                _namaController.clear();
                                _selectedKategori = null;
                                _dariTanggalController.clear();
                                _sampaiTanggalController.clear();
                              });
                            },
                            child: const Text('Reset Filter'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              backgroundColor: Colors.grey[100],
                              side: BorderSide(color: Colors.grey[400]!),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Terapkan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: '-- / -- / ----',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    controller.clear();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today_outlined, size: 20),
                  onPressed: _selectDate,
                ),
              ],
            ),
          ),
          onTap: _selectDate,
        ),
      ],
    );
  }

  bool get _isMobile => MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pemasukan Lain'),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemasukan',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Daftar Pemasukan Lain',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.attach_money, color: Colors.white),
              ],
            ),
          ),

          // Konten
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showFilterModal(context),
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _isMobile ? _buildMobileList() : _buildDesktopTable(),
                      const SizedBox(height: 16),
                      _buildPagination(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 800),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
          columns: const [
            DataColumn(label: Text('NO')),
            DataColumn(label: Text('NAMA')),
            DataColumn(label: Text('JENIS PEMASUKAN')),
            DataColumn(label: Text('TANGGAL')),
            DataColumn(label: Text('NOMINAL')),
            DataColumn(label: Text('AKSI')),
          ],
          rows: _dataPemasukan.map((p) {
            return DataRow(
              cells: [
                DataCell(Text(p.no.toString())),
                DataCell(Text(p.nama)),
                DataCell(Text(p.jenis)),
                DataCell(Text(p.tanggal)),
                DataCell(Text(p.nominal)),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _dataPemasukan.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final p = _dataPemasukan[i];
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
              p.nama,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jenis: ${p.jenis}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('Tanggal: ${p.tanggal}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(p.nominal,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
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

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _currentPage == 1
              ? null
              : () => setState(() => _currentPage--),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: kPrimaryBlue,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            _currentPage.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => setState(() => _currentPage++),
        ),
      ],
    );
  }
}