import 'package:flutter/material.dart';

// -----------------------------------------------------------------
// MOCK & THEME SETUP
// -----------------------------------------------------------------

// Asumsi: File ini menyediakan AppBar/Sidebar dan konstanta tema
// Ganti path import sesuai dengan struktur proyek Anda jika diperlukan
// ignore: unused_import
import '../../../widgets/app_drawer.dart';
// ignore: unused_import
import '../../../theme.dart';

const Color primaryColor = Color(0xFF6A5ACD);
const Color acceptedColor = Color(0xFF90EE90);
const Color pendingColor = Color(0xFFFFFACD);
const Color borderColor = Color(0xFFE0E0E0);
const Color textColor = Color(0xFF333333);
const Color tableHeaderColor = Color(0xFFFAFAFA);
const Color secondaryButtonColor = Color(0xFFE0E0E0);

List<Map<String, dynamic>> mockAspirasiData = [
  {
    'no': 1,
    'pengirim': 'Sesy Tana Lina Rahmatin',
    'judul': 'titootit',
    'status': 'Diterima',
    'tanggal': '16 Oktober 2025',
    'deskripsi': 'gatau',
  },
  {
    'no': 2,
    'pengirim': 'Habibie Ed Dien',
    'judul': 'tes',
    'status': 'Pending',
    'tanggal': '28 September 2025',
    'deskripsi': 'deskripsi tes',
  },
];
const List<String> statusList = ['Pending', 'Diterima', 'Ditolak'];

enum MenuAction { detail, edit, hapus }

// -----------------------------------------------------------------
// MAIN APP
// -----------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aspirasi Warga Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const InformasiAspirasiPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// -----------------------------------------------------------------
// 1. HALAMAN UTAMA (INFORMASI ASPIRASI)
// -----------------------------------------------------------------

class InformasiAspirasiPage extends StatelessWidget {
  const InformasiAspirasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Aspirasi'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Header seperti halaman Keuangan
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
                children: const [
                  Text(
                    'Ringkasan Aspirasi',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Informasi Aspirasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.forum, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            // Konten utama
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16,
                ),
                child: const DataCardWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 2. WIDGET KARTU DATA (DATA CARD) - STATEFUL (Logika Inti)
// -----------------------------------------------------------------

class DataCardWidget extends StatefulWidget {
  const DataCardWidget({super.key});

  @override
  State<DataCardWidget> createState() => _DataCardWidgetState();
}

class _DataCardWidgetState extends State<DataCardWidget> {
  List<Map<String, dynamic>> _filteredData = [];
  String _currentFilterJudul = '';
  String? _currentFilterStatus;

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  void _reloadData() {
    setState(() {
      _filteredData = mockAspirasiData.where((item) {
        final matchesJudul =
            _currentFilterJudul.isEmpty ||
            item['judul'].toString().toLowerCase().contains(
              _currentFilterJudul.toLowerCase(),
            );

        final matchesStatus =
            _currentFilterStatus == null ||
            item['status'] == _currentFilterStatus;

        return matchesJudul && matchesStatus;
      }).toList();
    });
  }

  void _applyFilters({String? judul, String? status}) {
    if (judul != null) _currentFilterJudul = judul;
    if (status != null)
      _currentFilterStatus = status == 'Semua Status' ? null : status;
    _reloadData();
  }

  void _deleteData(int no) {
    final initialLength = mockAspirasiData.length;
    mockAspirasiData.removeWhere((item) => item['no'] == no);
    _reloadData();

    if (mockAspirasiData.length < initialLength) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Item No.$no berhasil dihapus.')));
    }
  }

  bool get _isMobile => MediaQuery.of(context).size.width < 700;

  // Tambahkan chip builder untuk versi mobile
  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color labelColor;

    switch (status) {
      case 'Diterima':
        bgColor = acceptedColor.withOpacity(0.5);
        labelColor = const Color(0xFF006400);
        break;
      case 'Pending':
        bgColor = pendingColor.withOpacity(0.8);
        labelColor = const Color(0xFFA0522D);
        break;
      case 'Ditolak':
        bgColor = Colors.red.shade100;
        labelColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.2);
        labelColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: labelColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // radius lebih halus
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          // Search + Filter bar (mobile friendly)
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (val) => _applyFilters(judul: val),
                  decoration: InputDecoration(
                    hintText: 'Cari judul...',
                    isDense: true,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _currentFilterJudul.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => _applyFilters(judul: ''),
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  final Map<String, String?>? result = await FilterDialog.show(
                    context,
                    currentJudul: _currentFilterJudul,
                    currentStatus: _currentFilterStatus,
                  );
                  if (result != null) {
                    _applyFilters(
                      judul: result['judul'],
                      status: result['status'],
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Icon(Icons.filter_alt, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Responsif: List (mobile) atau Tabel (desktop)
          Expanded(
            child: _filteredData.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.inbox, size: 40, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'Tidak ada data',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : (_isMobile
                      ? _buildMobileList()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DashboardDataTable(
                            data: _filteredData,
                            onDelete: _deleteData,
                            onEditComplete: _reloadData,
                          ),
                        )),
          ),

          if (!_isMobile)
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: PaginationControls(currentPage: 1, totalPages: 5),
            ),
        ],
      ),
    );
  }

  // List versi mobile: ringkas dan enak dipandang
  Widget _buildMobileList() {
    return ListView.separated(
      itemCount: _filteredData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = _filteredData[index];
        return Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['judul'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildStatusChip(item['status']),
                      const SizedBox(height: 8),
                      Text(
                        item['pengirim'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['tanggal'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ActionMenuButton(
                  itemData: item,
                  onDelete: () => _deleteData(item['no']),
                  onEditComplete: _reloadData,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------
// 3. WIDGET TABEL DATA (DATATABLE)
// -----------------------------------------------------------------

class DashboardDataTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(int) onDelete;
  final VoidCallback onEditComplete;

  const DashboardDataTable({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      _buildColumn('NO', width: 50),
      _buildColumn('PENGIRIM', width: 200),
      _buildColumn('JUDUL', width: 150),
      _buildColumn('STATUS', width: 100),
      _buildColumn('TANGGAL DIBUAT', width: 150),
      _buildColumn('AKSI', width: 50),
    ];

    final List<DataRow> rows = data.map((item) {
      return DataRow(
        cells: [
          DataCell(
            Text('${item['no']}', style: const TextStyle(color: textColor)),
          ),
          DataCell(
            Text(item['pengirim'], style: const TextStyle(color: textColor)),
          ),
          DataCell(
            Text(item['judul'], style: const TextStyle(color: textColor)),
          ),
          DataCell(_buildStatusChip(item['status'])),
          DataCell(
            Text(item['tanggal'], style: const TextStyle(color: textColor)),
          ),
          DataCell(
            ActionMenuButton(
              itemData: item,
              onDelete: () => onDelete(item['no']),
              onEditComplete: onEditComplete,
            ),
          ),
        ],
      );
    }).toList();

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 800),
      child: DataTable(
        columnSpacing: 40,
        dataRowMinHeight: 50,
        dataRowMaxHeight: 50,
        headingRowHeight: 40,
        headingRowColor: MaterialStateProperty.all(tableHeaderColor),
        border: const TableBorder(
          horizontalInside: BorderSide(color: borderColor, width: 1),
          bottom: BorderSide(color: borderColor, width: 1),
        ),
        columns: columns,
        rows: rows,
      ),
    );
  }

  DataColumn _buildColumn(String label, {double width = 100}) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Diterima':
        bgColor = acceptedColor.withOpacity(0.5);
        textColor = const Color(0xFF006400);
        break;
      case 'Pending':
        bgColor = pendingColor.withOpacity(0.8);
        textColor = const Color(0xFFA0522D);
        break;
      case 'Ditolak':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.2);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 4. WIDGET KONTROL PAGINASI
// -----------------------------------------------------------------

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.keyboard_arrow_left, color: Colors.grey, size: 30),
        const SizedBox(width: 5),

        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '$currentPage',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),

        const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30),
      ],
    );
  }
}

// -----------------------------------------------------------------
// 5. WIDGET POP-UP MENU AKSI (Detail, Edit, Hapus)
// -----------------------------------------------------------------

class ActionMenuButton extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final VoidCallback onDelete;
  final VoidCallback onEditComplete;

  const ActionMenuButton({
    super.key,
    required this.itemData,
    required this.onDelete,
    required this.onEditComplete,
  });

  Future<void> _confirmDelete(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Anda yakin ingin menghapus aspirasi dari ${itemData['pengirim']}?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      onDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      icon: const Icon(Icons.more_horiz, color: Colors.grey),
      onSelected: (MenuAction result) {
        switch (result) {
          case MenuAction.detail:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailAspirasiPage(data: itemData),
              ),
            );
            break;
          case MenuAction.edit:
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => EditAspirasiPage(data: itemData),
                  ),
                )
                .then((_) {
                  onEditComplete();
                });
            break;
          case MenuAction.hapus:
            _confirmDelete(context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
        const PopupMenuItem<MenuAction>(
          value: MenuAction.detail,
          child: Text('Detail', style: TextStyle(fontSize: 16)),
        ),
        const PopupMenuItem<MenuAction>(
          value: MenuAction.edit,
          child: Text('Edit', style: TextStyle(fontSize: 16)),
        ),
        const PopupMenuItem<MenuAction>(
          value: MenuAction.hapus,
          child: Text('Hapus', style: TextStyle(fontSize: 16)),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      padding: EdgeInsets.zero,
    );
  }
}

// -----------------------------------------------------------------
// 6. WIDGET MODAL FILTER (DIALOG) (Sesuai image_d7595d.png)
// -----------------------------------------------------------------

class FilterDialog extends StatefulWidget {
  final String currentJudul;
  final String? currentStatus;

  const FilterDialog({
    super.key,
    required this.currentJudul,
    this.currentStatus,
  });

  static Future<Map<String, String?>?> show(
    BuildContext context, {
    required String currentJudul,
    String? currentStatus,
  }) {
    return showDialog<Map<String, String?>?>(
      context: context,
      builder: (context) => FilterDialog(
        currentJudul: currentJudul,
        currentStatus: currentStatus,
      ),
    );
  }

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedStatus;
  late TextEditingController _judulController;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.currentJudul);
    _selectedStatus = widget.currentStatus;
  }

  @override
  void dispose() {
    _judulController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    Navigator.of(
      context,
    ).pop({'judul': _judulController.text, 'status': _selectedStatus});
  }

  void _resetFilter() {
    setState(() {
      _judulController.clear();
      _selectedStatus = null;
    });

    Navigator.of(context).pop({'judul': '', 'status': null});
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownStatusList = ['Semua Status', ...statusList];

    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 10, 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      actionsPadding: const EdgeInsets.all(24),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Filter Pesan Warga',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: primaryColor, width: 1.5),
              ),
              child: TextField(
                controller: _judulController,
                decoration: const InputDecoration(
                  hintText: 'Cari judul...',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedStatus == null ? 'Semua Status' : _selectedStatus,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: primaryColor, width: 1.5),
                ),
              ),
              items: dropdownStatusList.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue == 'Semua Status'
                      ? null
                      : newValue;
                });
              },
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: _resetFilter,
          style: TextButton.styleFrom(
            backgroundColor: secondaryButtonColor.withOpacity(0.5),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Reset Filter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: _applyFilter,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Terapkan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------
// 7. HALAMAN DETAIL INFORMASI ASPIRASI (Sesuai Screenshot 2025-10-19 205145.png)
// -----------------------------------------------------------------

class DetailAspirasiPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailAspirasiPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Aspirasi'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        // mobile friendly
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ), // padding mobile
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 16, color: primaryColor),
                      SizedBox(width: 8),
                      Text(
                        'Kembali',
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const Text(
                'Detail Informasi / Aspirasi Warga',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              _buildDetailItem('Judul:', data['judul']),
              _buildDetailItem('Deskripsi:', data['deskripsi'] ?? '-'),
              _buildDetailItem('Status:', data['status']),
              _buildDetailItem('Dibuat oleh:', data['pengirim']),
              _buildDetailItem('Tanggal Dibuat:', data['tanggal']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 8. HALAMAN EDIT INFORMASI ASPIRASI (Sesuai image_d742f9.png)
// -----------------------------------------------------------------

class EditAspirasiPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditAspirasiPage({super.key, required this.data});

  @override
  State<EditAspirasiPage> createState() => _EditAspirasiPageState();
}

class _EditAspirasiPageState extends State<EditAspirasiPage> {
  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.data['judul']);
    _deskripsiController = TextEditingController(
      text: widget.data['deskripsi'] ?? '',
    );
    _selectedStatus = widget.data['status'];
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    final index = mockAspirasiData.indexWhere(
      (item) => item['no'] == widget.data['no'],
    );

    if (index != -1) {
      mockAspirasiData[index]['judul'] = _judulController.text;
      mockAspirasiData[index]['deskripsi'] = _deskripsiController.text;
      mockAspirasiData[index]['status'] = _selectedStatus;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diperbarui (Simulasi)')),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal: Data tidak ditemukan.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Aspirasi'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        // mobile friendly
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ), // padding mobile
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 16, color: primaryColor),
                      SizedBox(width: 8),
                      Text(
                        'Kembali',
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const Text(
                'Edit Informasi Aspirasi Warga',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              _buildFormLabel('Judul Pesan'),
              _buildTextField(_judulController),
              const SizedBox(height: 20),

              _buildFormLabel('Deskripsi Pesan'),
              _buildTextField(_deskripsiController, maxLines: 5),
              const SizedBox(height: 20),

              _buildFormLabel('Status'),
              _buildStatusDropdown(),
              const SizedBox(height: 30),

              // Tombol update full-width agar nyaman di mobile
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    int? maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedStatus,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        labelText: null,
      ),
      items: statusList.map((String status) {
        return DropdownMenuItem<String>(value: status, child: Text(status));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedStatus = newValue!;
        });
      },
    );
  }
}
