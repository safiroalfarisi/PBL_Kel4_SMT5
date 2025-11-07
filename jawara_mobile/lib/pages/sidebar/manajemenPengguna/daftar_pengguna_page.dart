import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../theme.dart';

// --- Struktur Data ---
class Pengguna {
  int no;
  final String nama;
  final String email;
  final String status;

  Pengguna({required this.no, required this.nama, required this.email, required this.status});
}

// --- Data Dummy (20 data sesuai gambar) ---
List<Pengguna> allDummyData = [
  Pengguna(no: 1, nama: 'dor', email: 'krdtkhr@gmail.com', status: 'Diterima'),
  Pengguna(no: 2, nama: 'aliu', email: 'avi@gmail.com', status: 'Diterima'),
  Pengguna(no: 3, nama: 'mmin', email: 'mmin@gmail.com', status: 'Diterima'),
  Pengguna(no: 4, nama: 'Farhan', email: 'farhan@gmail.com', status: 'Diterima'),
  Pengguna(no: 5, nama: 'dewqediwddiv', email: 'admiweeven1@gmail.com', status: 'Diterima'),
  Pengguna(no: 6, nama: 'Rendha Putra Rahmadiya', email: 'rendhazuper@gmail.com', status: 'Diterima'),
  Pengguna(no: 7, nama: 'ibla', email: 'y@gmail.com', status: 'Diterima'),
  Pengguna(no: 8, nama: 'Anti Micin', email: 'antimicin3@gmail.com', status: 'Diterima'),
  Pengguna(no: 9, nama: 'ijat4', email: 'ijat4@gmail.com', status: 'Diterima'),
  Pengguna(no: 10, nama: 'ijat3', email: 'ijat3@gmail.com', status: 'Diterima'),
  Pengguna(no: 11, nama: 'ijat2', email: 'ijat2@gmail.com', status: 'Pending'),
  Pengguna(no: 12, nama: 'AFIFAN KHOIRUNNISA', email: 'afi@gmail.com', status: 'Pending'),
  Pengguna(no: 13, nama: 'Raudhir Firdaus Naufal', email: 'raudhirfirdaus@gmail.com', status: 'Ditolak'),
  Pengguna(no: 14, nama: 'vandey naddua rimta', email: 'afatata@gmail.com', status: 'Ditolak'),
  Pengguna(no: 15, nama: 'Vandey Naddua Rimta', email: 'vandeyir@gmail.com', status: 'Diterima'),
  Pengguna(no: 16, nama: 'ASDOPARI', email: 'ASDOPARI@GMAIL.COM', status: 'Pending'),
  Pengguna(no: 17, nama: 'FAJRUL', email: 'FAJRUL0@gmail.com', status: 'Diterima'),
  Pengguna(no: 18, nama: 'Mara Nunez', email: 'recug@mailinator.com', status: 'Ditolak'),
  Pengguna(no: 19, nama: 'Habibah Ed Dien', email: 'habibae.hd@gmail.com', status: 'Pending'),
  Pengguna(no: 20, nama: 'Tes', email: 'iham@gmail.com', status: 'Diterima'),
];

// Data yang akan ditampilkan (bisa difilter)
List<Pengguna> dummyData = List.from(allDummyData);

// Fungsi untuk menambah pengguna baru
void tambahPenggunaBaru(String nama, String email) {
  // Update nomor urut untuk semua pengguna yang ada
  for (var pengguna in allDummyData) {
    pengguna.no++;
  }
  for (var pengguna in dummyData) {
    pengguna.no++;
  }
  
  // Tambahkan pengguna baru di posisi pertama
  final penggunaBaru = Pengguna(no: 1, nama: nama, email: email, status: 'Diterima');
  allDummyData.insert(0, penggunaBaru);
  dummyData.insert(0, penggunaBaru);
}

// --- Status Badge Widget ---
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
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// --- Filter Dialog Widget ---
class FilterDialog extends StatefulWidget {
  final String? selectedStatus;
  final String? searchName;
  final Function(String?, String?) onApplyFilter;

  const FilterDialog({
    super.key,
    this.selectedStatus,
    this.searchName,
    required this.onApplyFilter,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedStatus;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
    _nameController.text = widget.searchName ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: 500,
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
                      'Filter Manajemen Pengguna',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Field
                    _buildFilterField(
                      label: 'Nama',
                      controller: _nameController,
                      hintText: 'Cari nama pengguna...',
                      icon: Icons.person_search,
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
                    DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      hint: Text(
                        'Pilih status...',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.check_circle_outline, color: kPrimaryBlue, size: 20),
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
                      items: const [
                        DropdownMenuItem(value: 'Diterima', child: Text('Diterima')),
                        DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                        DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedStatus = null;
                                _nameController.clear();
                              });
                              widget.onApplyFilter(null, null);
                              Navigator.of(context).pop();
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
                              widget.onApplyFilter(_selectedStatus, _nameController.text.trim());
                              Navigator.of(context).pop();
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
}


// --- Data Source untuk PaginatedDataTable ---
class PenggunaDataSource extends DataTableSource {
  final List<Pengguna> data;
  final BuildContext context;

  PenggunaDataSource(this.data, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final user = data[index];
    
    return DataRow(
      cells: [
        DataCell(
          Text(
            user.no.toString(),
            style: const TextStyle(fontSize: 14),
          ),
        ),
        DataCell(
          Text(
            user.nama,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        DataCell(
          Text(
            user.email,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        DataCell(StatusBadge(status: user.status)),
        DataCell(
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            onSelected: (String value) {
              if (value == 'detail') {
                Navigator.pushNamed(context, '/detail-pengguna', arguments: user);
              } else if (value == 'edit') {
                Navigator.pushNamed(context, '/edit-pengguna', arguments: user);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'detail',
                child: Text('Detail'),
              ),
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}


// --- Custom Pagination Widget ---
class CustomPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        IconButton(
          onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left),
          color: currentPage > 1 ? Colors.grey.shade600 : Colors.grey.shade300,
        ),
        
        // Page numbers
        for (int i = 1; i <= totalPages; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => onPageChanged(i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: i == currentPage ? kPrimaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  i.toString(),
                  style: TextStyle(
                    color: i == currentPage ? Colors.white : Colors.grey.shade600,
                    fontWeight: i == currentPage ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        
        // Next button
        IconButton(
          onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          icon: const Icon(Icons.chevron_right),
          color: currentPage < totalPages ? Colors.grey.shade600 : Colors.grey.shade300,
        ),
      ],
    );
  }
}

// --- Halaman Utama ---
class DaftarPenggunaPage extends StatefulWidget {
  const DaftarPenggunaPage({super.key});

  @override
  State<DaftarPenggunaPage> createState() => _DaftarPenggunaPageState();
}

class _DaftarPenggunaPageState extends State<DaftarPenggunaPage> {
  String? _selectedStatusFilter;
  String? _searchNameFilter;
  String _selectedYear = '2025';
  List<Pengguna> _filteredData = List.from(dummyData);
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  int get _totalPages => (_filteredData.length / _itemsPerPage).ceil();
  
  List<Pengguna> get _currentPageData {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return _filteredData.sublist(
      startIndex,
      endIndex > _filteredData.length ? _filteredData.length : endIndex,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  bool get _hasActiveFilter {
    return (_searchNameFilter != null && _searchNameFilter!.isNotEmpty) ||
           _selectedStatusFilter != null;
  }

  void _applyFilter(String? status, String? name) {
    setState(() {
      _selectedStatusFilter = status;
      _searchNameFilter = name;
      _currentPage = 1; // Reset to first page when filtering
      
      _filteredData = allDummyData.where((pengguna) {
        bool matchStatus = status == null || pengguna.status == status;
        bool matchName = name == null || name.isEmpty || 
                        pengguna.nama.toLowerCase().contains(name.toLowerCase());
        return matchStatus && matchName;
      }).toList();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        selectedStatus: _selectedStatusFilter,
        searchName: _searchNameFilter,
        onApplyFilter: _applyFilter,
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Widget _buildExpandableUserCard(Pengguna user) {
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
              user.nama,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Status sebagai badge
            _buildStatusBadge(user.status),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon elipsis untuk Bottom Sheet Menu
            GestureDetector(
              onTap: () => _showBottomSheetMenu(user),
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
              _buildDetailRow('Email', user.email, Icons.email),
              _buildDetailRow('NIK', '3674072257025008', Icons.credit_card), // Data dummy
              _buildDetailRow('Jenis Kelamin', 'Laki-laki', Icons.person),
              _buildDetailRow('Nomor HP', '0821211112', Icons.phone),
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
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
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

  void _showBottomSheetMenu(Pengguna user) {
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
                'Aksi untuk ${user.nama}',
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
                  Navigator.pushNamed(context, '/detail-pengguna', arguments: user);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: kPrimaryBlue),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/edit-pengguna', arguments: user);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Expandable Card List untuk Daftar Pengguna
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _currentPageData.length,
            itemBuilder: (context, index) {
              final user = _currentPageData[index];
              return _buildExpandableUserCard(user);
            },
          ),
        ),
        
        // Pagination
        if (_totalPages > 1)
          Container(
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
            child: CustomPagination(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onPageChanged: _onPageChanged,
            ),
          ),
      ],
    );
  }

  Widget _buildWebLayout() {
    return Column(
      children: [
        // Filter button di luar container
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kPrimaryBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.white, size: 20),
                  onPressed: _showFilterDialog,
                  tooltip: 'Filter Data',
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ),
        
        // Container utama
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                // Header tanpa filter
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'NO',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'NAMA',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'EMAIL',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'STATUS REGISTRASI',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'AKSI',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
          
                // Data rows
                Expanded(
                  child: ListView.builder(
                    itemCount: _currentPageData.length,
                    itemBuilder: (context, index) {
                      final user = _currentPageData[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade100),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                user.no.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                user.nama,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                user.email,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: StatusBadge(status: user.status),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  ),
                                  onSelected: (String value) {
                                    if (value == 'detail') {
                                      Navigator.pushNamed(context, '/detail-pengguna', arguments: user);
                                    } else if (value == 'edit') {
                                      Navigator.pushNamed(context, '/edit-pengguna', arguments: user);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'detail',
                                      child: Text('Detail'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          
                // Pagination
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: CustomPagination(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                    onPageChanged: _onPageChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Manajemen Pengguna',
        subtitle: 'Ringkasan Manajemen Pengguna',
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onFilterPressed: _showFilterDialog,
        hasActiveFilter: _hasActiveFilter,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // List View
          Expanded(
            child: _currentPageData.isEmpty
                ? Center(
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
                          'Tidak ada pengguna yang ditemukan',
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
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _currentPageData.length,
                    itemBuilder: (context, index) {
                      final user = _currentPageData[index];
                      return _buildExpandableUserCard(user);
                    },
                  ),
          ),
          
          // Pagination
          if (_totalPages > 1)
            Container(
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
              child: CustomPagination(
                currentPage: _currentPage,
                totalPages: _totalPages,
                onPageChanged: _onPageChanged,
              ),
            ),
        ],
      ),
    );
  }



}