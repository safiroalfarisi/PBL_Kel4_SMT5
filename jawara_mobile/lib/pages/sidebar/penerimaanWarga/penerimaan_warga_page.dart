import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../theme.dart';
import 'detail_pendaftaran_warga_page.dart';
import 'verifikasi_warga_page.dart';

// Model data untuk warga
class WargaBaru {
  final int no;
  final String nama;
  final String nik;
  final String email;
  final String jenisKelamin;
  final String status;
  final String fotoKtp;
  final String alamatRumah;
  final String statusKepemilikanRumah;

  WargaBaru({
    required this.no,
    required this.nama,
    required this.nik,
    required this.email,
    required this.jenisKelamin,
    required this.status,
    required this.fotoKtp,
    this.alamatRumah = '',
    this.statusKepemilikanRumah = '',
  });
}

// Data dummy untuk testing - ditambah untuk pagination
final List<WargaBaru> dummyDataPenerimaan = [
  WargaBaru(no: 1, nama: 'farhan', nik: '3505111512040001', email: 'farhan@gmail.com', jenisKelamin: 'L', status: 'Diterima', fotoKtp: 'assets/images/ktp1.jpg'),
  WargaBaru(no: 2, nama: 'Rendha Putra Rahmadiya', nik: '3505111512040002', email: 'rendh.a@gmail.com', jenisKelamin: 'P', status: 'Diterima', fotoKtp: 'assets/images/ktp2.jpg'),
  WargaBaru(no: 3, nama: 'agus_pula', nik: '3505111512040003', email: 'agusku@gmail.com', jenisKelamin: 'L', status: 'Diterima', fotoKtp: 'assets/images/ktp3.jpg'),
  WargaBaru(no: 4, nama: 'sat', nik: '3505111512040004', email: 'sat@gmail.com', jenisKelamin: 'P', status: 'Ditolak', fotoKtp: 'assets/images/ktp4.jpg'),
  WargaBaru(no: 5, nama: 'taufik.dwi.hadi', nik: '3505111512040005', email: 'taufikdwi@gmail.com', jenisKelamin: 'L', status: 'Diterima', fotoKtp: 'assets/images/ktp5.jpg'),
  WargaBaru(no: 6, nama: 'Shelly.Natasha.Arista', nik: '3505111512040006', email: 'shelly@mail.com', jenisKelamin: 'P', status: 'Diterima', fotoKtp: 'assets/images/ktp6.jpg'),
  WargaBaru(no: 7, nama: 'Salfa.Fitri.Meizega', nik: '3505111512040007', email: 'salfa@gmail.com', jenisKelamin: 'P', status: 'Pending', fotoKtp: 'assets/images/ktp7.jpg'),
  WargaBaru(no: 8, nama: 'ijat4.raf', nik: '3505111512040008', email: 'ijat4@mail.com', jenisKelamin: 'L', status: 'Pending', fotoKtp: 'assets/images/ktp8.jpg'),
  WargaBaru(no: 9, nama: 'andyaydi', nik: '3505111512040009', email: 'andy@go.id', jenisKelamin: 'P', status: 'Ditolak', fotoKtp: 'assets/images/ktp9.jpg'),
  WargaBaru(no: 10, nama: 'Budi Santoso', nik: '3505111512040010', email: 'budi@mail.com', jenisKelamin: 'L', status: 'Pending', fotoKtp: 'assets/images/ktp10.jpg'),
  // Data tambahan untuk pagination
  WargaBaru(no: 11, nama: 'Maria Nunez', nik: '1234567890123456', email: 'tecuj@mailinator.com', jenisKelamin: 'L', status: 'Diterima', fotoKtp: 'assets/images/ktp11.jpg'),
  WargaBaru(no: 12, nama: 'Colette Irwin', nik: '1234567891234567', email: 'gokupopa@mailinator.com', jenisKelamin: 'L', status: 'Pending', fotoKtp: 'assets/images/ktp12.jpg'),
  WargaBaru(no: 13, nama: 'Habibie Ed Dien', nik: '2341123456756789', email: 'habibie.tk@gmail.com', jenisKelamin: 'L', status: 'Diterima', fotoKtp: 'assets/images/ktp13.jpg'),
  WargaBaru(no: 14, nama: 'Tes', nik: '2222222222222', email: 'ihan@gmail.com', jenisKelamin: 'L', status: 'Diterima', fotoKtp: 'assets/images/ktp14.jpg'),
  WargaBaru(no: 15, nama: 'Budi', nik: '2000000000000', email: 'budi@gmail.com', jenisKelamin: 'L', status: 'Pending', fotoKtp: 'assets/images/ktp15.jpg'),
  WargaBaru(no: 16, nama: 'Agus', nik: '2000000000002', email: 'agus@gmail.com', jenisKelamin: 'L', status: 'Pending', fotoKtp: 'assets/images/ktp16.jpg'),
  WargaBaru(no: 17, nama: 'Ana', nik: '2000000000001', email: 'ana@gmail.com', jenisKelamin: 'P', status: 'Pending', fotoKtp: 'assets/images/ktp17.jpg'),
  WargaBaru(no: 18, nama: 'Sari Dewi', nik: '3505111512040018', email: 'sari@gmail.com', jenisKelamin: 'P', status: 'Diterima', fotoKtp: 'assets/images/ktp18.jpg'),
  WargaBaru(no: 19, nama: 'Ahmad Yani', nik: '3505111512040019', email: 'ahmad@gmail.com', jenisKelamin: 'L', status: 'Ditolak', fotoKtp: 'assets/images/ktp19.jpg'),
  WargaBaru(no: 20, nama: 'Lina Sari', nik: '3505111512040020', email: 'lina@gmail.com', jenisKelamin: 'P', status: 'Pending', fotoKtp: 'assets/images/ktp20.jpg'),
];

// Widget untuk status badge
class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case 'Diterima':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;
      case 'Pending':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        break;
      case 'Ditolak':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }
    
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class PenerimaanWargaPage extends StatefulWidget {
  const PenerimaanWargaPage({super.key});

  @override
  State<PenerimaanWargaPage> createState() => _PenerimaanWargaPageState();
}

class _PenerimaanWargaPageState extends State<PenerimaanWargaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _namaController = TextEditingController();
  String? _selectedJenisKelamin;
  String? _selectedStatus;
  String _selectedYear = '2025';
  List<WargaBaru> _filteredData = dummyDataPenerimaan;
  int _currentPage = 0;
  final int _rowsPerPage = 10; // 10 data per halaman

  @override
  void initState() {
    super.initState();
    _filteredData = dummyDataPenerimaan;
  }

  bool get _hasActiveFilter {
    return (_namaController.text.isNotEmpty) ||
           _selectedJenisKelamin != null ||
           _selectedStatus != null;
  }

  void _applyFilter() {
    setState(() {
      _filteredData = dummyDataPenerimaan.where((warga) {
        bool matchesNama = _namaController.text.isEmpty ||
            warga.nama.toLowerCase().contains(_namaController.text.toLowerCase());
        bool matchesJenisKelamin = _selectedJenisKelamin == null ||
            warga.jenisKelamin == _selectedJenisKelamin;
        bool matchesStatus = _selectedStatus == null ||
            warga.status == _selectedStatus;
        
        return matchesNama && matchesJenisKelamin && matchesStatus;
      }).toList();
      _currentPage = 0;
    });
  }

  void _resetFilter() {
    setState(() {
      _namaController.clear();
      _selectedJenisKelamin = null;
      _selectedStatus = null;
      _filteredData = dummyDataPenerimaan;
      _currentPage = 0;
    });
  }

  void _showFilterModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                width: double.maxFinite,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kPrimaryBlue,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt, color: Colors.white, size: 24),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Filter Penerimaan Warga',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama Field
                            const Text(
                              'Nama',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _namaController,
                              decoration: InputDecoration(
                                hintText: 'Cari nama warga...',
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                prefixIcon: const Icon(Icons.person_search, color: kPrimaryBlue, size: 20),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Jenis Kelamin Dropdown
                            const Text(
                              'Jenis Kelamin',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade50,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedJenisKelamin,
                                  hint: Row(
                                    children: [
                                      const Icon(Icons.wc, color: kPrimaryBlue, size: 20),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Pilih jenis kelamin...',
                                        style: TextStyle(color: Colors.grey.shade400),
                                      ),
                                    ],
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down, color: kPrimaryBlue),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'L',
                                      child: Row(
                                        children: [
                                          Icon(Icons.male, color: Colors.blue, size: 20),
                                          SizedBox(width: 12),
                                          Text('Laki-Laki'),
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'P',
                                      child: Row(
                                        children: [
                                          Icon(Icons.female, color: Colors.pink, size: 20),
                                          SizedBox(width: 12),
                                          Text('Perempuan'),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setModalState(() {
                                      _selectedJenisKelamin = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Status Dropdown
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade50,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedStatus,
                                  hint: Row(
                                    children: [
                                      const Icon(Icons.check_circle_outline, color: kPrimaryBlue, size: 20),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Pilih status...',
                                        style: TextStyle(color: Colors.grey.shade400),
                                      ),
                                    ],
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down, color: kPrimaryBlue),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Diterima',
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, color: Colors.green, size: 20),
                                          SizedBox(width: 12),
                                          Text('Diterima'),
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Pending',
                                      child: Row(
                                        children: [
                                          Icon(Icons.pending, color: Colors.orange, size: 20),
                                          SizedBox(width: 12),
                                          Text('Pending'),
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Ditolak',
                                      child: Row(
                                        children: [
                                          Icon(Icons.cancel, color: Colors.red, size: 20),
                                          SizedBox(width: 12),
                                          Text('Ditolak'),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setModalState(() {
                                      _selectedStatus = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Action Buttons - Fixed at bottom
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade200),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setModalState(() {
                                  _namaController.clear();
                                  _selectedJenisKelamin = null;
                                  _selectedStatus = null;
                                });
                                _resetFilter();
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _applyFilter();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Terapkan',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: kPrimaryBlue, size: 20),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Hitung data untuk halaman saat ini
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex = (startIndex + _rowsPerPage).clamp(0, _filteredData.length);
    final currentPageData = _filteredData.sublist(startIndex, endIndex);
    final totalPages = (_filteredData.length / _rowsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Penerimaan Warga',
        subtitle: 'Ringkasan Penerimaan Warga',
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onFilterPressed: _showFilterModal,
        hasActiveFilter: _hasActiveFilter,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // List View
          Expanded(
            child: currentPageData.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: currentPageData.length,
                    itemBuilder: (context, index) {
                      final warga = currentPageData[index];
                      return _buildExpandableWargaCard(warga);
                    },
                  ),
          ),
          
          // Pagination
          if (totalPages > 1) _buildPaginationWidget(totalPages),
        ],
      ),
    );
  }

  Widget _buildExpandableWargaCard(WargaBaru warga) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama (Paling dominan)
            Text(
              warga.nama,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Status sebagai badge
            _buildStatusBadge(warga.status),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon elipsis untuk Bottom Sheet Menu
            GestureDetector(
              onTap: () => _showBottomSheetMenu(warga),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          // Detail Tersembunyi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 8),
              _buildDetailRow('Email', warga.email, Icons.email),
              _buildDetailRow('NIK', warga.nik, Icons.credit_card),
              _buildDetailRow('Jenis Kelamin', warga.jenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan', Icons.person),
              const SizedBox(height: 12),
              // Foto Identitas
              Row(
                children: [
                  Icon(Icons.photo, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  const Text(
                    'Foto Identitas:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildFotoIdentitas(warga),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case 'Diterima':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;
      case 'Pending':
        backgroundColor = Colors.yellow.shade100;
        textColor = Colors.yellow.shade800;
        break;
      case 'Ditolak':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
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

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheetMenu(WargaBaru warga) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              Text(
                'Aksi untuk ${warga.nama}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Menu items
              ListTile(
                leading: const Icon(Icons.visibility, color: kPrimaryBlue),
                title: const Text('Detail'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPendaftaranWargaPage(warga: warga),
                    ),
                  );
                },
              ),
              if (warga.status == 'Pending' || warga.status == 'Ditolak')
                ListTile(
                  leading: const Icon(Icons.edit, color: kPrimaryBlue),
                  title: const Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifikasiWargaPage(warga: warga),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFotoIdentitas(WargaBaru warga) {
    // Simulasi beberapa data memiliki foto, beberapa tidak
    if (warga.no == 13 || warga.no == 14) {
      return Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: NetworkImage('https://via.placeholder.com/80x60/4CAF50/FFFFFF?text=KTP'),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (warga.no >= 15) {
      return Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Center(
          child: Text(
            'Foto\nIdentitas',
            style: TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Icon(Icons.image, size: 30, color: Colors.grey),
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada warga yang ditemukan',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba ubah filter pencarian Anda',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationWidget(int totalPages) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          IconButton(
            onPressed: _currentPage > 0
                ? () => setState(() => _currentPage--)
                : null,
            icon: const Icon(Icons.chevron_left),
            color: _currentPage > 0 ? kPrimaryBlue : Colors.grey,
          ),
          
          // Page numbers (limit to show max 5 pages)
          ...List.generate(
            totalPages > 5 ? 5 : totalPages,
            (index) {
              int pageIndex = _currentPage > 2 && totalPages > 5
                  ? _currentPage - 2 + index
                  : index;
              if (pageIndex >= totalPages) return const SizedBox.shrink();
              
              return GestureDetector(
                onTap: () => setState(() => _currentPage = pageIndex),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _currentPage == pageIndex ? kPrimaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _currentPage == pageIndex ? kPrimaryBlue : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    '${pageIndex + 1}',
                    style: TextStyle(
                      color: _currentPage == pageIndex ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Next button
          IconButton(
            onPressed: _currentPage < totalPages - 1
                ? () => setState(() => _currentPage++)
                : null,
            icon: const Icon(Icons.chevron_right),
            color: _currentPage < totalPages - 1 ? kPrimaryBlue : Colors.grey,
          ),
        ],
      ),
    );
  }
}