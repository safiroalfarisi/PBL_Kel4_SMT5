import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../theme.dart';

// Model data untuk log aktivitas
class LogAktivitas {
  final int no;
  final String deskripsi;
  final String aktor;
  final String tanggal;

  LogAktivitas({
    required this.no,
    required this.deskripsi,
    required this.aktor,
    required this.tanggal,
  });
}

// Data dummy untuk log aktivitas (20 data)
final List<LogAktivitas> dummyDataLogAktivitas = [
  LogAktivitas(
    no: 1,
    deskripsi: 'Merugaskan tagihan : Bersih Desa periode Oktober 2025 sebesar Rp. 200,000',
    aktor: 'Admin Jawara',
    tanggal: '21 Oktober 2025',
  ),
  LogAktivitas(
    no: 2,
    deskripsi: 'Membuat broadcast baru: Pengumuman',
    aktor: 'Admin Jawara',
    tanggal: '21 Oktober 2025',
  ),
  LogAktivitas(
    no: 3,
    deskripsi: 'Merugaskan tagihan : Bersih Desa periode Oktober 2025 sebesar Rp. 200,000',
    aktor: 'Admin Jawara',
    tanggal: '21 Oktober 2025',
  ),
  LogAktivitas(
    no: 4,
    deskripsi: 'Mendownload laporan keuangan',
    aktor: 'Admin Jawara',
    tanggal: '21 Oktober 2025',
  ),
  LogAktivitas(
    no: 5,
    deskripsi: 'Menambahkan surat baru: asad',
    aktor: 'Admin Jawara',
    tanggal: '21 Oktober 2025',
  ),
  LogAktivitas(
    no: 6,
    deskripsi: 'Mengupdate data warga: Budi Santoso',
    aktor: 'Ketua RT',
    tanggal: '20 Oktober 2025',
  ),
  LogAktivitas(
    no: 7,
    deskripsi: 'Menambahkan pengeluaran: Pembelian alat kebersihan',
    aktor: 'Bendahara',
    tanggal: '20 Oktober 2025',
  ),
  LogAktivitas(
    no: 8,
    deskripsi: 'Verifikasi pendaftaran warga baru: Siti Aminah',
    aktor: 'Admin Jawara',
    tanggal: '19 Oktober 2025',
  ),
  LogAktivitas(
    no: 9,
    deskripsi: 'Membuat kegiatan baru: Gotong Royong Minggu',
    aktor: 'Ketua RW',
    tanggal: '19 Oktober 2025',
  ),
  LogAktivitas(
    no: 10,
    deskripsi: 'Mengirim pesan broadcast: Jadwal ronda malam',
    aktor: 'Sekretaris',
    tanggal: '18 Oktober 2025',
  ),
  LogAktivitas(
    no: 11,
    deskripsi: 'Mencatat pemasukan: Iuran bulanan Oktober',
    aktor: 'Bendahara',
    tanggal: '18 Oktober 2025',
  ),
  LogAktivitas(
    no: 12,
    deskripsi: 'Mengupdate status kepemilikan rumah: Jl. Merdeka No. 15',
    aktor: 'Admin Jawara',
    tanggal: '17 Oktober 2025',
  ),
  LogAktivitas(
    no: 13,
    deskripsi: 'Menambahkan data mutasi keluarga: Pindah alamat',
    aktor: 'Ketua RT',
    tanggal: '17 Oktober 2025',
  ),
  LogAktivitas(
    no: 14,
    deskripsi: 'Membuat laporan keuangan bulanan Oktober',
    aktor: 'Bendahara',
    tanggal: '16 Oktober 2025',
  ),
  LogAktivitas(
    no: 15,
    deskripsi: 'Menolak pendaftaran warga: Data tidak lengkap',
    aktor: 'Admin Jawara',
    tanggal: '16 Oktober 2025',
  ),
  LogAktivitas(
    no: 16,
    deskripsi: 'Mengupdate profil pengguna: Ahmad Yusuf',
    aktor: 'Sekretaris',
    tanggal: '15 Oktober 2025',
  ),
  LogAktivitas(
    no: 17,
    deskripsi: 'Menambahkan tagihan listrik: Periode Oktober 2025',
    aktor: 'Bendahara',
    tanggal: '15 Oktober 2025',
  ),
  LogAktivitas(
    no: 18,
    deskripsi: 'Backup data sistem ke cloud storage',
    aktor: 'Admin Jawara',
    tanggal: '14 Oktober 2025',
  ),
  LogAktivitas(
    no: 19,
    deskripsi: 'Mengirim reminder pembayaran iuran kepada warga',
    aktor: 'Sekretaris',
    tanggal: '14 Oktober 2025',
  ),
  LogAktivitas(
    no: 20,
    deskripsi: 'Mengupdate jadwal kegiatan bulanan November',
    aktor: 'Ketua RW',
    tanggal: '13 Oktober 2025',
  ),
];
class SemuaAktifitasPage extends StatefulWidget {
  const SemuaAktifitasPage({super.key});

  @override
  State<SemuaAktifitasPage> createState() => _SemuaAktifitasPageState();
}

class _SemuaAktifitasPageState extends State<SemuaAktifitasPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _aktorController = TextEditingController();
  final TextEditingController _dariTanggalController = TextEditingController();
  final TextEditingController _sampaiTanggalController = TextEditingController();
  
  String? _filterDeskripsi;
  String? _filterAktor;
  DateTime? _filterDariTanggal;
  DateTime? _filterSampaiTanggal;
  String _selectedYear = '2025';
  
  List<LogAktivitas> _filteredData = dummyDataLogAktivitas;
  int _currentPage = 0;
  final int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _filteredData = dummyDataLogAktivitas;
  }

  DateTime? _parseLogDate(String dateString) {
    try {
      final parts = dateString.split(' ');
      if (parts.length != 3) return null;
      
      final day = int.parse(parts[0]);
      final year = int.parse(parts[2]);
      
      final monthMap = {
        'Januari': 1, 'Februari': 2, 'Maret': 3, 'April': 4,
        'Mei': 5, 'Juni': 6, 'Juli': 7, 'Agustus': 8,
        'September': 9, 'Oktober': 10, 'November': 11, 'Desember': 12,
      };
      
      final month = monthMap[parts[1]];
      if (month == null) return null;
      
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  void _applyFilter() {
    setState(() {
      _filteredData = dummyDataLogAktivitas.where((log) {
        bool matchesDeskripsi = _filterDeskripsi == null || _filterDeskripsi!.isEmpty ||
            log.deskripsi.toLowerCase().contains(_filterDeskripsi!.toLowerCase());
        bool matchesAktor = _filterAktor == null || _filterAktor!.isEmpty ||
            log.aktor.toLowerCase().contains(_filterAktor!.toLowerCase());
        
        bool matchesDateRange = true;
        if (_filterDariTanggal != null || _filterSampaiTanggal != null) {
          final logDate = _parseLogDate(log.tanggal);
          if (logDate != null) {
            if (_filterDariTanggal != null && matchesDateRange) {
              if (logDate.isBefore(DateTime(_filterDariTanggal!.year, _filterDariTanggal!.month, _filterDariTanggal!.day))) {
                matchesDateRange = false;
              }
            }
            
            if (_filterSampaiTanggal != null && matchesDateRange) {
              if (logDate.isAfter(DateTime(_filterSampaiTanggal!.year, _filterSampaiTanggal!.month, _filterSampaiTanggal!.day, 23, 59, 59))) {
                matchesDateRange = false;
              }
            }
          } else {
            matchesDateRange = false;
          }
        }

        return matchesDeskripsi && matchesAktor && matchesDateRange;
      }).toList();
      _currentPage = 0;
    });
  }

  void _resetFilter() {
    setState(() {
      _deskripsiController.clear();
      _aktorController.clear();
      _dariTanggalController.clear();
      _sampaiTanggalController.clear();
      _filterDeskripsi = null;
      _filterAktor = null;
      _filterDariTanggal = null;
      _filterSampaiTanggal = null;
      _filteredData = dummyDataLogAktivitas;
      _currentPage = 0;
    });
  }

  Future<void> _selectDate(bool isFromDate) async {
    DateTime initialDate = DateTime.now();
    if (isFromDate && _filterDariTanggal != null) {
      initialDate = _filterDariTanggal!;
    } else if (!isFromDate && _filterSampaiTanggal != null) {
      initialDate = _filterSampaiTanggal!;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF2196F3),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2196F3),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _filterDariTanggal = picked;
          _dariTanggalController.text = '${picked.day}/${picked.month}/${picked.year}';
        } else {
          _filterSampaiTanggal = picked;
          _sampaiTanggalController.text = '${picked.day}/${picked.month}/${picked.year}';
        }
      });
    }
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
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: 500,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                              'Filter Log Aktivitas',
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
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFilterField(
                              label: 'Deskripsi',
                              controller: _deskripsiController,
                              hintText: 'Cari deskripsi aktivitas...',
                              icon: Icons.description,
                            ),
                            const SizedBox(height: 20),
                            _buildFilterField(
                              label: 'Aktor',
                              controller: _aktorController,
                              hintText: 'Cari nama aktor...',
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Rentang Tanggal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDateField(
                                    controller: _dariTanggalController,
                                    hintText: 'Dari tanggal',
                                    onTap: () => _selectDate(true),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildDateField(
                                    controller: _sampaiTanggalController,
                                    hintText: 'Sampai tanggal',
                                    onTap: () => _selectDate(false),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setModalState(() {
                                        _deskripsiController.clear();
                                        _aktorController.clear();
                                        _dariTanggalController.clear();
                                        _sampaiTanggalController.clear();
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
                                      _filterDeskripsi = _deskripsiController.text.trim();
                                      _filterAktor = _aktorController.text.trim();
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
                          ],
                        ),
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

  Widget _buildDateField({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: const Icon(Icons.calendar_today, color: kPrimaryBlue, size: 20),
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
    );
  }

  bool get _hasActiveFilter {
    return (_filterDeskripsi != null && _filterDeskripsi!.isNotEmpty) ||
           (_filterAktor != null && _filterAktor!.isNotEmpty) ||
           _filterDariTanggal != null ||
           _filterSampaiTanggal != null;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada data log aktivitas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Data akan muncul setelah ada aktivitas',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogCard(LogAktivitas log) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${log.no}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log.deskripsi,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            log.aktor,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            log.tanggal,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
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

  @override
  Widget build(BuildContext context) {
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex = (startIndex + _rowsPerPage).clamp(0, _filteredData.length);
    final currentPageData = _filteredData.sublist(startIndex, endIndex);
    final totalPages = (_filteredData.length / _rowsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Log Aktivitas',
        subtitle: 'Ringkasan Log Aktivitas',
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onFilterPressed: _showFilterModal,
        hasActiveFilter: _hasActiveFilter,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Expanded(
            child: currentPageData.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: currentPageData.length,
                    itemBuilder: (context, index) {
                      final log = currentPageData[index];
                      return _buildLogCard(log);
                    },
                  ),
          ),
          if (totalPages > 1) _buildPagination(totalPages),
        ],
      ),
    );
  }}
