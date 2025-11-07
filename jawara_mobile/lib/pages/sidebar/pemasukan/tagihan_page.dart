import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class _Tagihan {
  final int no;
  final String namaKeluarga;
  final String statusKeluarga;
  final String iuran;
  final String kodeTagihan;
  final String nominal;
  final String periode;
  final String statusPembayaran;

  _Tagihan({
    required this.no,
    required this.namaKeluarga,
    required this.statusKeluarga,
    required this.iuran,
    required this.kodeTagihan,
    required this.nominal,
    required this.periode,
    required this.statusPembayaran,
  });
}

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  final List<_Tagihan> _dataTagihan = [
    _Tagihan(
      no: 1,
      namaKeluarga: 'Keluarga Habibie Ed Dien',
      statusKeluarga: 'Aktif',
      iuran: 'Mingguan',
      kodeTagihan: 'IR175458A501',
      nominal: 'Rp 10,00',
      periode: '8 Oktober 2025',
      statusPembayaran: 'Belum Dibayar',
    ),
    _Tagihan(
      no: 2,
      namaKeluarga: 'Keluarga Habibie Ed Dien',
      statusKeluarga: 'Aktif',
      iuran: 'Mingguan',
      kodeTagihan: 'IR185702KX01',
      nominal: 'Rp 10,00',
      periode: '15 Oktober 2025',
      statusPembayaran: 'Belum Dibayar',
    ),
    _Tagihan(
      no: 3,
      namaKeluarga: 'Keluarga Habibie Ed Dien',
      statusKeluarga: 'Aktif',
      iuran: 'Mingguan',
      kodeTagihan: 'IR223936NM01',
      nominal: 'Rp 10,00',
      periode: '30 September 2025',
      statusPembayaran: 'Belum Dibayar',
    ),
    _Tagihan(
      no: 4,
      namaKeluarga: 'Keluarga Mara Nunez',
      statusKeluarga: 'Aktif',
      iuran: 'Mingguan',
      kodeTagihan: 'IR223936ZJ02',
      nominal: 'Rp 10,00',
      periode: '30 September 2025',
      statusPembayaran: 'Belum Dibayar',
    ),
    _Tagihan(
      no: 5,
      namaKeluarga: 'Keluarga Habibie Ed Dien',
      statusKeluarga: 'Aktif',
      iuran: 'Agustusan',
      kodeTagihan: 'IR2244069O01',
      nominal: 'Rp 15,00',
      periode: '10 Oktober 2025',
      statusPembayaran: 'Belum Dibayar',
    ),
    _Tagihan(
      no: 6,
      namaKeluarga: 'Keluarga Mara Nunez',
      statusKeluarga: 'Aktif',
      iuran: 'Agustusan',
      kodeTagihan: 'IR224406BC02',
      nominal: 'Rp 15,00',
      periode: '10 Oktober 2025',
      statusPembayaran: 'Belum Dibayar',
    ),
  ];

  Future<void> _showFilterModal(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        String? _selectedStatusPembayaran;
        String? _selectedStatusKeluarga;
        String? _selectedKeluarga;
        String? _selectedIuran;
        final TextEditingController _periodeController =
            TextEditingController();

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: StatefulBuilder(
                builder: (context, setModalState) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Modal
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Filter Tagihan Warga',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        _buildDropdown(
                          context: context,
                          label: 'Status Pembayaran',
                          hint: '-- Pilih Status --',
                          value: _selectedStatusPembayaran,
                          items: ['Belum Dibayar', 'Sudah Dibayar'],
                          onChanged: (val) {
                            setModalState(
                                () => _selectedStatusPembayaran = val);
                          },
                        ),
                        const SizedBox(height: 14),

                        _buildDropdown(
                          context: context,
                          label: 'Status Keluarga',
                          hint: '-- Pilih Status Keluarga --',
                          value: _selectedStatusKeluarga,
                          items: ['Aktif', 'Non-Aktif'],
                          onChanged: (val) {
                            setModalState(() => _selectedStatusKeluarga = val);
                          },
                        ),
                        const SizedBox(height: 14),

                        _buildDropdown(
                          context: context,
                          label: 'Keluarga',
                          hint: '-- Pilih Keluarga --',
                          value: _selectedKeluarga,
                          items: [
                            'Keluarga Habibie Ed Dien',
                            'Keluarga Mara Nunez',
                          ],
                          onChanged: (val) {
                            setModalState(() => _selectedKeluarga = val);
                          },
                        ),
                        const SizedBox(height: 14),

                        _buildDropdown(
                          context: context,
                          label: 'Iuran',
                          hint: '-- Pilih Iuran --',
                          value: _selectedIuran,
                          items: ['Mingguan', 'Agustusan', 'Bersih Desa'],
                          onChanged: (val) {
                            setModalState(() => _selectedIuran = val);
                          },
                        ),
                        const SizedBox(height: 14),

                        _buildDatePicker(
                          context: context,
                          label: 'Periode (Bulan & Tahun)',
                          controller: _periodeController,
                        ),
                        const SizedBox(height: 28),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setModalState(() {
                                  _selectedStatusPembayaran = null;
                                  _selectedStatusKeluarga = null;
                                  _selectedKeluarga = null;
                                  _selectedIuran = null;
                                  _periodeController.clear();
                                });
                              },
                              child: const Text('Reset'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlue,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Terapkan'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: '-- / ----',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  controller.text = "${picked.month}/${picked.year}";
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  bool get _isMobile => MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                    Text('Pemasukan',
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('Tagihan Warga',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Icon(Icons.receipt_long, color: Colors.white, size: 28),
              ],
            ),
          ),

          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.picture_as_pdf_outlined),
                            label: const Text('Cetak PDF'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kPrimaryBlue,
                              side: BorderSide(color: kPrimaryBlue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            _isMobile ? _buildMobileList() : _buildDesktopTable(),
                      ),
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
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
        columns: const [
          DataColumn(label: Text('NO')),
          DataColumn(label: Text('NAMA KELUARGA')),
          DataColumn(label: Text('STATUS KELUARGA')),
          DataColumn(label: Text('IURAN')),
          DataColumn(label: Text('KODE TAGIHAN')),
          DataColumn(label: Text('NOMINAL')),
          DataColumn(label: Text('PERIODE')),
          DataColumn(label: Text('STATUS')),
          DataColumn(label: Text('AKSI')),
        ],
        rows: _dataTagihan.map((t) {
          return DataRow(
            cells: [
              DataCell(Text(t.no.toString())),
              DataCell(Text(t.namaKeluarga)),
              DataCell(_StatusChip(text: t.statusKeluarga, color: Colors.green)),
              DataCell(Text(t.iuran)),
              DataCell(Text(t.kodeTagihan)),
              DataCell(Text(t.nominal)),
              DataCell(Text(t.periode)),
              DataCell(
                  _StatusChip(text: t.statusPembayaran, color: Colors.orange)),
              const DataCell(Icon(Icons.more_horiz)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.builder(
      itemCount: _dataTagihan.length,
      itemBuilder: (context, i) {
        final t = _dataTagihan[i];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(t.namaKeluarga,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      children: [
                        _StatusChip(text: t.statusKeluarga, color: Colors.green),
                        _StatusChip(
                            text: t.statusPembayaran, color: Colors.orange),
                      ],
                    ),
                    Text('Iuran: ${t.iuran}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('Periode: ${t.periode}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ]),
            ),
            trailing: const Icon(Icons.more_horiz, color: Colors.grey),
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  final MaterialColor color;

  const _StatusChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style:
            TextStyle(color: color.shade700, fontWeight: FontWeight.w500),
      ),
    );
  }
}