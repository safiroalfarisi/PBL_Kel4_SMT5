import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

// =================================================================
// Variabel Konstanta & Dummy Data (Dipindahkan ke file ini agar mudah diakses)
// =================================================================
// Gunakan kPrimaryBlue dari theme.dart untuk konsistensi tema
final List<String> dummyStatuses = [
  'Pindah Rumah',
  'Keluar Wilayah',
  'Meninggal Dunia',
];
final List<String> dummyKeluargas = [
  'Keluarga Ijat',
  'Keluarga Mara Nunez',
  'Keluarga Raudhil Firdaus Naufal',
];
final List<Map<String, dynamic>> mutationData = const [
  {
    'no': 1,
    'tanggal': '15 Oktober 2025',
    'keluarga': 'Keluarga Ijat',
    'jenis_mutasi': 'Keluar Wilayah',
    'mutasi_color': Colors.red,
    'alamat_lama': 'Blok A3 No. 12',
    'alamat_baru': 'Jalan Mawar No. 5, Kota Sebelah',
    'keterangan': 'Pindah domisili ke luar kota karena pekerjaan baru.',
  },
  {
    'no': 2,
    'tanggal': '30 September 2025',
    'keluarga': 'Keluarga Mara Nunez',
    'jenis_mutasi': 'Pindah Rumah',
    'mutasi_color': Colors.green,
    'alamat_lama': 'Blok C2 No. 05',
    'alamat_baru': 'Blok G1 No. 08 (Masih dalam perumahan)',
    'keterangan':
        'Pindah ke rumah yang lebih besar di dalam perumahan yang sama.',
  },
  {
    'no': 3,
    'tanggal': '24 Oktober 2026',
    'keluarga': 'Keluarga Ijat',
    'jenis_mutasi': 'Pindah Rumah',
    'mutasi_color': Colors.green,
    'alamat_lama': 'Blok B1 No. 01',
    'alamat_baru': 'Blok B5 No. 01 (Masih dalam perumahan)',
    'keterangan': 'Tukar rumah dengan tetangga.',
  },
];

// =================================================================
// 1. Mutasi Daftar Page (Halaman Utama dengan Tabel dan FAB)
// =================================================================

class MutasiDaftarPage extends StatelessWidget {
  const MutasiDaftarPage({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: FilterMutasiKeluargaSheet(
                scrollController: scrollController,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = kPrimaryBlue;

    // Header banner bergaya full-bleed seperti halaman lain
    Widget headerBanner() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Mutasi Keluarga',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Daftar mutasi & filter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () => _showFilterSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.15),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.white.withOpacity(0.35)),
                ),
                padding: const EdgeInsets.all(10),
                minimumSize: const Size(44, 40),
                elevation: 0,
              ),
              child: const Icon(Icons.filter_list, size: 22),
            ),
          ],
        ),
      );
    }

    final tableCard = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildTableHeader(),
          ...List.generate(mutationData.length, (index) {
            final row = _buildTableRow(context, mutationData[index]);
            return Column(
              children: [
                row,
                if (index != mutationData.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF0F0F0),
                  ),
              ],
            );
          }),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
          _buildPagination(primaryColor),
        ],
      ),
    );

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Daftar Mutasi Keluarga'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            final horizontalPadding = isWide ? 24.0 : 16.0;
            final children = <Widget>[
              headerBanner(),
              // Konten utama: kartu tabel
              tableCard,
            ];

            final paddedChildren = <Widget>[
              children.first,
              ...children
                  .skip(1)
                  .map(
                    (w) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: w,
                    ),
                  )
                  .toList(),
            ];

            return ListView.separated(
              padding: const EdgeInsets.only(top: 0, bottom: 12),
              itemCount: paddedChildren.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => paddedChildren[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/mutasi/tambah');
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTableHeader() {
    const headerStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 13,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: const [
          Expanded(flex: 1, child: Text('NO', style: headerStyle)),
          Expanded(flex: 3, child: Text('TANGGAL', style: headerStyle)),
          Expanded(flex: 3, child: Text('KELUARGA', style: headerStyle)),
          Expanded(flex: 3, child: Text('JENIS MUTASI', style: headerStyle)),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('AKSI', style: headerStyle),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Map<String, dynamic> data) {
    const textStyle = TextStyle(fontSize: 14, color: Colors.black87);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('${data['no']}', style: textStyle)),
          Expanded(flex: 3, child: Text(data['tanggal'], style: textStyle)),
          Expanded(flex: 3, child: Text(data['keluarga'], style: textStyle)),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildMutationBadge(
                data['jenis_mutasi'],
                data['mutasi_color'],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: MutasiOptionsPopup(data: data),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMutationBadge(String text, Color color) {
    Color textColor;
    Color backgroundColor;

    if (color == Colors.red) {
      textColor = const Color(0xFFEF5350);
      backgroundColor = const Color(0xFFFFEBEE);
    } else {
      textColor = const Color(0xFF66BB6A);
      backgroundColor = const Color(0xFFE8F5E9);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildPagination(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPaginationButton(
            icon: Icons.chevron_left,
            onTap: () {},
            isActive: false,
          ),
          const SizedBox(width: 8),
          _buildPageNumber(1, isActive: true, primaryColor: primaryColor),
          const SizedBox(width: 8),
          _buildPaginationButton(
            icon: Icons.chevron_right,
            onTap: () {},
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return InkWell(
      onTap: isActive ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? Colors.grey[600] : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildPageNumber(
    int page, {
    required bool isActive,
    required Color primaryColor,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isActive ? primaryColor : const Color(0xFFE0E0E0),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        page.toString(),
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 2. Mutasi Options Popup (Widget AKSI)
// -----------------------------------------------------------------

class MutasiOptionsPopup extends StatelessWidget {
  final Map<String, dynamic> data;

  const MutasiOptionsPopup({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, color: Colors.grey, size: 20),
      onSelected: (String result) {
        if (result == 'Detail') {
          // Navigasi ke Halaman Detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MutasiDetailPage(data: data),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Detail',
          child: Row(
            children: const [
              Icon(Icons.info_outline, color: kPrimaryBlue, size: 20),
              SizedBox(width: 10),
              Text('Detail'),
            ],
          ),
        ),
      ],
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

// -----------------------------------------------------------------
// 3. Mutasi Detail Page (Contoh Halaman Detail)
// -----------------------------------------------------------------

class MutasiDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const MutasiDetailPage({super.key, required this.data});

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text(
          'Detail Mutasi Keluarga',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['keluarga'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryBlue,
                  ),
                ),
                const Divider(height: 25, thickness: 1.5),
                _buildDetailItem('Tanggal Mutasi', data['tanggal']),
                _buildDetailItem('Jenis Mutasi', data['jenis_mutasi']),
                _buildDetailItem('Alamat Lama', data['alamat_lama']),
                _buildDetailItem('Alamat Baru', data['alamat_baru']),
                _buildDetailItem('Keterangan', data['keterangan'] ?? '-'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 5. Filter Mutasi Keluarga Sheet (Modal Filter)
// -----------------------------------------------------------------

class FilterMutasiKeluargaSheet extends StatefulWidget {
  final ScrollController scrollController;

  const FilterMutasiKeluargaSheet({super.key, required this.scrollController});

  @override
  State<FilterMutasiKeluargaSheet> createState() =>
      _FilterMutasiKeluargaSheetState();
}

class _FilterMutasiKeluargaSheetState extends State<FilterMutasiKeluargaSheet> {
  String? selectedStatus;
  String? selectedKeluarga;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = kPrimaryBlue;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      child: ListView(
        controller: widget.scrollController,
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Data Mutasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildFilterLabel('Status'),
          const SizedBox(height: 8),
          _buildCustomDropdown(
            primaryColor: primaryColor,
            value: selectedStatus,
            hint: '-- Pilih Status --',
            items: dummyStatuses,
            onSelected: (newValue) {
              setState(() {
                selectedStatus = newValue;
              });
            },
          ),
          const SizedBox(height: 20),

          _buildFilterLabel('Keluarga'),
          const SizedBox(height: 8),
          _buildCustomDropdown(
            primaryColor: primaryColor,
            value: selectedKeluarga,
            hint: '-- Pilih Keluarga --',
            items: dummyKeluargas,
            onSelected: (newValue) {
              setState(() {
                selectedKeluarga = newValue;
              });
            },
          ),
          const SizedBox(height: 40),

          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedStatus = null;
                    selectedKeluarga = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Reset', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint(
                      'Terapkan filter: Status=$selectedStatus, Keluarga=$selectedKeluarga',
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Terapkan Filter',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildCustomDropdown({
    required Color primaryColor,
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onSelected,
  }) {
    return InkWell(
      onTap: () {
        _showCustomOptions(
          context: context,
          currentValue: value,
          items: items,
          onSelected: onSelected,
          primaryColor: primaryColor,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: value != null ? primaryColor : const Color(0xFFE0E0E0),
            width: value != null ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value ?? hint,
                style: TextStyle(
                  color: value != null ? Colors.black : const Color(0xFF9E9E9E),
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9E9E9E)),
          ],
        ),
      ),
    );
  }

  void _showCustomOptions({
    required BuildContext context,
    required String? currentValue,
    required List<String> items,
    required ValueChanged<String?> onSelected,
    required Color primaryColor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildOptionTile(
                  text: item,
                  isSelected: currentValue == item,
                  onTap: () {
                    onSelected(item);
                    Navigator.pop(context);
                  },
                  primaryColor: primaryColor,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionTile({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    final Color lightPrimaryColor = Color.alphaBlend(
      primaryColor.withOpacity(0.1),
      Colors.white,
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        color: isSelected ? lightPrimaryColor : Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? primaryColor : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
