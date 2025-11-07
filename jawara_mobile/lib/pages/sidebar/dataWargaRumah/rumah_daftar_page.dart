import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class RumahDaftarPage extends StatefulWidget {
  const RumahDaftarPage({super.key});

  @override
  State<RumahDaftarPage> createState() => _RumahDaftarPageState();
}

class _RumahDaftarPageState extends State<RumahDaftarPage> {
  final List<Map<String, String>> rumahList = [
    {'no': '1', 'alamat': 'ssss', 'status': 'Ditempati'},
    {'no': '2', 'alamat': 'jalan suhat', 'status': 'Ditempati'},
    {'no': '3', 'alamat': 'I', 'status': 'Ditempati'},
    {'no': '4', 'alamat': 'Tes', 'status': 'Ditempati'},
    {'no': '5', 'alamat': 'Jl. Merbabu', 'status': 'Tersedia'},
    {'no': '6', 'alamat': 'Malang', 'status': 'Ditempati'},
  ];

  String? filterAlamat;
  String? filterStatus;

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? tempAlamat = filterAlamat;
        String? tempStatus = filterStatus;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Filter Rumah'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  hintText: 'Cari nama...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => tempAlamat = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: tempStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Ditempati',
                    child: Text('Ditempati'),
                  ),
                  DropdownMenuItem(value: 'Tersedia', child: Text('Tersedia')),
                ],
                onChanged: (value) => tempStatus = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  filterAlamat = null;
                  filterStatus = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Reset Filter'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  filterAlamat = tempAlamat;
                  filterStatus = tempStatus;
                });
                Navigator.pop(context);
              },
              child: const Text('Terapkan'),
            ),
          ],
        );
      },
    );
  }

  bool get _isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    final filteredList = rumahList.where((rumah) {
      final matchAlamat = filterAlamat == null || filterAlamat!.isEmpty
          ? true
          : rumah['alamat']!.toLowerCase().contains(
              filterAlamat!.toLowerCase(),
            );
      final matchStatus = filterStatus == null || filterStatus!.isEmpty
          ? true
          : rumah['status'] == filterStatus;
      return matchAlamat && matchStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Rumah'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Header
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
                      'Data Rumah',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Daftar Rumah',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.home_work, color: Colors.white),
              ],
            ),
          ),
          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: _openFilterDialog,
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _isMobile
                        ? _buildMobileList(filteredList)
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('NO')),
                                DataColumn(label: Text('ALAMAT')),
                                DataColumn(label: Text('STATUS')),
                                DataColumn(label: Text('AKSI')),
                              ],
                              rows: filteredList.map((rumah) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(rumah['no']!)),
                                    DataCell(Text(rumah['alamat']!)),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: rumah['status'] == 'Ditempati'
                                              ? Colors.blue.shade50
                                              : Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          rumah['status']!,
                                          style: TextStyle(
                                            color:
                                                rumah['status'] == 'Ditempati'
                                                ? Colors.blue
                                                : Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.more_horiz),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => RumahDetailPage(
                                                alamat: rumah['alamat']!,
                                                status: rumah['status']!,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList(List<Map<String, String>> list) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final item = list[i];
        final isOccupied = item['status'] == 'Ditempati';
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
              item['alamat']!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isOccupied
                          ? Colors.blue.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['status']!,
                      style: TextStyle(
                        color: isOccupied ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RumahDetailPage(
                      alamat: item['alamat']!,
                      status: item['status']!,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class RumahDetailPage extends StatelessWidget {
  final String alamat;
  final String status;

  const RumahDetailPage({
    super.key,
    required this.alamat,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Rumah'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Rumah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Alamat: $alamat'),
                    Text('Status: $status'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Riwayat Penghuni',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Belum ada riwayat penghuni.',
                      style: TextStyle(color: Colors.grey),
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
}
