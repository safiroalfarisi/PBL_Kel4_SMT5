import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class DaftarChannelPage extends StatefulWidget {
  const DaftarChannelPage({super.key});

  @override
  State<DaftarChannelPage> createState() => _DaftarChannelPageState();
}

class _DaftarChannelPageState extends State<DaftarChannelPage> {
  // Data statis untuk contoh, disesuaikan dengan gambar
  // Menambahkan data dummy untuk detail, edit, dan thumbnail
  final List<Map<String, dynamic>> channels = [
    {
      "id": "1",
      "no": 1,
      "nama": "QRIS Resmi RT 08",
      "tipe": "qris",
      "an": "RW 08 Karangploso",
      "catatan":
          "Scan QR di bawah untuk membayar. Kirim bukti setelah pembayaran.",
      "rekening": "1234567890", // Data dummy untuk form edit
      "thumbnailUrl":
          "https://upload.wikimedia.org/wikipedia/id/thumb/4/49/Politeknik_Negeri_Malang.png/640px-Politeknik_Negeri_Malang.png", // Logo Polinema
      "qrUrl":
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/purple-cappuccino-cincau-drink-logo-design-template-0414f5e3e3c04c665e121b6671d6f4d1_screen.jpg?ts=1680259882", // Logo Cappucino
    },
    {
      "id": "2",
      "no": 2,
      "nama": "BCA",
      "tipe": "bank",
      "an": "jose",
      "catatan": "Transfer sesama bank",
      "rekening": "9876543210",
      "thumbnailUrl":
          "https://ae01.alicdn.com/kf/S0b7f0e74f51e41118f6f5933615a61d8U/Boneka-Plush-Mainan-Anime-Hoshino-Rubi-Oshi-No-Ko-Kartun-Cosplay-Boneka-Kapas-Lembut-Hadiah.jpg_640x640.jpg", // Boneka
      "qrUrl": null,
    },
    {
      "id": "3",
      "no": 3,
      "nama": "234234",
      "tipe": "ewallet",
      "an": "23234",
      "catatan": "",
      "rekening": "234234",
      "thumbnailUrl": null,
      "qrUrl": null,
    },
    {
      "id": "4",
      "no": 4,
      "nama": "Transfer via BCA",
      "tipe": "bank",
      "an": "RT Jawara Karangploso",
      "catatan": "",
      "rekening": "111222333",
      "thumbnailUrl": null,
      "qrUrl": null,
    },
  ];

  // Gaya teks untuk header tabel
  final TextStyle headerStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  // Gaya teks untuk isi sel
  final TextStyle cellStyle = TextStyle(fontSize: 14, color: Colors.grey[800]);

  // --- FUNGSI UNTUK AKSI ---

  // 1. Menangani Pilihan Aksi (Detail, Edit, Hapus)
  void _handleAction(
    BuildContext context,
    String value,
    Map<String, dynamic> channel,
  ) {
    switch (value) {
      case 'detail':
        _showDetailDialog(context, channel);
        break;
      case 'edit':
        _showEditDialog(context, channel);
        break;
      case 'hapus':
        _showDeleteDialog(context, channel['nama']);
        break;
    }
  }

  // 2. Menampilkan Dialog Hapus (Gambar 4)
  void _showDeleteDialog(BuildContext context, String channelName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah kamu yakin ingin menghapus item ini? Aksi ini tidak dapat dibatalkan.',
            style: TextStyle(color: Colors.grey[700]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Hapus'),
              onPressed: () {
                // --- Logika Hapus Data Sebenarnya ---
                // (Contoh: panggil API, update state)
                debugPrint('Menghapus $channelName');
                Navigator.of(dialogContext).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  // 3. Menampilkan Dialog Detail (Gambar 2)
  void _showDetailDialog(BuildContext context, Map<String, dynamic> channel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar bisa scroll
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6, // Tampil 60% layar
          maxChildSize: 0.9, // Bisa ditarik hingga 90%
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: _DetailContent(channel: channel),
            );
          },
        );
      },
    );
  }

  // 4. Menampilkan Dialog Edit (Gambar 3)
  void _showEditDialog(BuildContext context, Map<String, dynamic> channel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // PENTING agar bottom sheet bisa full height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) {
        // Gunakan Padding agar tidak mentok dengan status bar
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
          ),
          child: DraggableScrollableSheet(
            expand: true, // Langsung full
            initialChildSize: 0.95, // Hampir full
            maxChildSize: 0.95,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return _EditContent(
                channel: channel,
                scrollController: scrollController,
              );
            },
          ),
        );
      },
    );
  }

  bool get _isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Channel Transfer'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ringkasan Channel',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Daftar Channel Transfer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Total: ${channels.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Konten utama: responsif
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _isMobile
                        ? _buildMobileList()
                        : Column(
                            children: [
                              // Tabel desktop (existing)
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowColor: MaterialStateProperty.all(
                                    Colors.grey[100],
                                  ),
                                  columns: [
                                    DataColumn(
                                      label: Text('NO', style: headerStyle),
                                    ),
                                    DataColumn(
                                      label: Text('NAMA', style: headerStyle),
                                    ),
                                    DataColumn(
                                      label: Text('TIPE', style: headerStyle),
                                    ),
                                    DataColumn(
                                      label: Text('A/N', style: headerStyle),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'THUMBNAIL',
                                        style: headerStyle,
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('AKSI', style: headerStyle),
                                    ),
                                  ],
                                  rows: channels.map((channel) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            channel['no'].toString(),
                                            style: cellStyle,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            channel['nama'].toString(),
                                            style: cellStyle,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            channel['tipe'].toString(),
                                            style: cellStyle,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            channel['an'].toString(),
                                            style: cellStyle,
                                          ),
                                        ),
                                        DataCell(
                                          _buildThumbnailCell(channel),
                                        ), // gunakan helper baru
                                        DataCell(
                                          PopupMenuButton<String>(
                                            onSelected: (value) =>
                                                _handleAction(
                                                  context,
                                                  value,
                                                  channel,
                                                ),
                                            itemBuilder:
                                                (
                                                  BuildContext context,
                                                ) => <PopupMenuEntry<String>>[
                                                  const PopupMenuItem<String>(
                                                    value: 'detail',
                                                    child: Text('Detail'),
                                                  ),
                                                  const PopupMenuItem<String>(
                                                    value: 'edit',
                                                    child: Text('Edit'),
                                                  ),
                                                  const PopupMenuItem<String>(
                                                    value: 'hapus',
                                                    child: Text('Hapus'),
                                                  ),
                                                ],
                                            icon: Icon(
                                              Icons.more_horiz,
                                              color: Colors.grey[600],
                                            ),
                                            tooltip: "Aksi",
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              // Pagination (existing)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.chevron_left),
                                      onPressed: () {},
                                      color: Colors.grey[400],
                                      splashRadius: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kPrimaryBlue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        '1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.chevron_right),
                                      onPressed: () {},
                                      color: Colors.grey[600],
                                      splashRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper baru untuk sel thumbnail agar aman null-safety/tipe
  Widget _buildThumbnailCell(Map<String, dynamic> channel) {
    final String? thumb = channel['thumbnailUrl'] as String?;
    if (thumb != null && thumb.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Image.network(
          thumb,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, color: Colors.grey),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          },
        ),
      ); // <- tutup Padding
    } // <- tutup if
    return Text('-', style: cellStyle);
  }

  // List mobile-friendly
  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: channels.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final ch = channels[index];
        final String? thumb = ch['thumbnailUrl'] as String?;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: kPrimaryBlue.withOpacity(0.1),
              backgroundImage: (thumb != null && thumb.isNotEmpty)
                  ? NetworkImage(thumb)
                  : null, // cast aman
              child: (thumb == null || thumb.isEmpty)
                  ? const Icon(Icons.image_not_supported, color: Colors.grey)
                  : null,
            ),
            title: Text(
              ch['nama'],
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTypeChip(ch['tipe']),
                  const SizedBox(height: 6),
                  Text(
                    'A/N: ${ch['an']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) => _handleAction(context, value, ch),
              itemBuilder: (BuildContext context) =>
                  const <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'detail',
                      child: Text('Detail'),
                    ),
                    PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
                    PopupMenuItem<String>(value: 'hapus', child: Text('Hapus')),
                  ],
              icon: const Icon(Icons.more_horiz, color: Colors.grey),
              tooltip: "Aksi",
            ),
            onTap: () => _handleAction(context, 'detail', ch),
          ),
        );
      },
    );
  }

  Widget _buildTypeChip(String tipeRaw) {
    final tipe = tipeRaw.toString().toUpperCase();
    Color bg;
    Color fg;
    switch (tipe) {
      case 'BANK':
        bg = Colors.blue.shade50;
        fg = Colors.blue.shade700;
        break;
      case 'EWALLET':
      case 'E-WALLET':
        bg = Colors.green.shade50;
        fg = Colors.green.shade700;
        break;
      case 'QRIS':
      case 'QR':
        bg = Colors.purple.shade50;
        fg = Colors.purple.shade700;
        break;
      default:
        bg = Colors.grey.shade200;
        fg = Colors.grey.shade700;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tipe,
        style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 11),
      ),
    );
  }
} // <-- tutup _DaftarChannelPageState di sini

// --- WIDGET HELPER UNTUK DIALOG DETAIL (dipindah ke top-level) ---
class _DetailContent extends StatelessWidget {
  final Map<String, dynamic> channel;
  const _DetailContent({required this.channel});

  Widget _buildDetailRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailImage(String label, String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, color: Colors.grey, size: 100),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detail Transfer Channel',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          _buildDetailRow('Nama Channel', channel['nama']),
          _buildDetailRow('Tipe Channel', channel['tipe']),
          _buildDetailRow('Nama Pemilik', channel['an']),
          _buildDetailRow('Catatan', channel['catatan']),
          _buildDetailImage('Thumbnail:', channel['thumbnailUrl']),
          _buildDetailImage('QR:', channel['qrUrl']),
        ],
      ),
    );
  }
}

// --- WIDGET HELPER UNTUK DIALOG EDIT (dipindah ke top-level) ---
class _EditContent extends StatefulWidget {
  final Map<String, dynamic> channel;
  final ScrollController scrollController;
  const _EditContent({required this.channel, required this.scrollController});

  @override
  State<_EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<_EditContent> {
  late TextEditingController _namaChannelController;
  late TextEditingController _nomorRekeningController;
  late TextEditingController _namaPemilikController;
  late TextEditingController _catatanController;
  String? _selectedTipe;

  final List<String> _tipeOptions = ['Bank', 'E-Wallet', 'Qris', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    _namaChannelController = TextEditingController(
      text: widget.channel['nama'],
    );
    _nomorRekeningController = TextEditingController(
      text: widget.channel['rekening'],
    );
    _namaPemilikController = TextEditingController(text: widget.channel['an']);
    _catatanController = TextEditingController(text: widget.channel['catatan']);
    _selectedTipe = widget.channel['tipe'];
  }

  @override
  void dispose() {
    _namaChannelController.dispose();
    _nomorRekeningController.dispose();
    _namaPemilikController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  // Helper widget untuk input teks
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
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

  // Helper widget untuk kotak file upload
  Widget _buildFileUploadBox({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
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
                  hint,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
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

  // Helper untuk menampilkan gambar saat ini
  Widget _buildCurrentPreview(String label, String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(
            imageUrl,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, color: Colors.grey, size: 100),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Transfer Channel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(height: 32),

            // Form
            _buildTextField(
              label: 'Nama Channel',
              controller: _namaChannelController,
              hintText: 'Contoh: BCA, Dana, QRIS RT',
            ),
            const SizedBox(height: 20),

            const Text(
              'Tipe',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedTipe,
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
                hintText: '-- Pilih Tipe --',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              items: _tipeOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value.toLowerCase(), // Sesuaikan dengan data
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

            _buildTextField(
              label: 'Nomor Rekening / Akun',
              controller: _nomorRekeningController,
              hintText: 'Contoh: 1234567890',
            ),
            const SizedBox(height: 20),

            _buildTextField(
              label: 'Nama Pemilik',
              controller: _namaPemilikController,
              hintText: 'Contoh: John Doe',
            ),
            const SizedBox(height: 20),

            _buildCurrentPreview(
              'Thumbnail saat ini:',
              widget.channel['thumbnailUrl'],
            ),
            _buildFileUploadBox(
              label: 'Ganti Thumbnail',
              hint: 'Upload thumbnail baru jika ingin mengganti',
            ),
            const SizedBox(height: 20),

            _buildCurrentPreview('QR saat ini:', widget.channel['qrUrl']),
            _buildFileUploadBox(
              label: 'Ganti QR',
              hint: 'Upload qr baru jika ingin mengganti',
            ),
            const SizedBox(height: 20),

            _buildTextField(
              label: 'Catatan (Opsional)',
              controller: _catatanController,
              hintText: 'Contoh: Transfer hanya dari bank yang sama',
            ),
            const SizedBox(height: 40),

            // Tombol Aksi
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Logika reset form
                    _namaChannelController.text = widget.channel['nama'];
                    _nomorRekeningController.text = widget.channel['rekening'];
                    _namaPemilikController.text = widget.channel['an'];
                    _catatanController.text = widget.channel['catatan'];
                    setState(() {
                      _selectedTipe = widget.channel['tipe'];
                    });
                  },
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
                  child: const Text('Reset', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // --- Logika Simpan Perubahan ---
                      debugPrint('Data Tersimpan');
                      Navigator.pop(context); // Tutup bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: const Text('Simpan', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40), // Spasi ekstra di bawah
          ],
        ),
      ),
    );
  }
}
