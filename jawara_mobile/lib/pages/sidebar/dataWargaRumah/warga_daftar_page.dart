import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class WargaDaftarPage extends StatefulWidget {
  const WargaDaftarPage({super.key});

  @override
  State<WargaDaftarPage> createState() => _WargaDaftarPageState();
}

class _WargaDaftarPageState extends State<WargaDaftarPage> {
  // Data warga contoh
  final List<Map<String, dynamic>> warga = [
    {
      'nama': 'yyyyy',
      'nik': '1234567891234567',
      'keluarga': 'Keluarga Mara Nunez',
      'jenisKelamin': 'Perempuan',
      'statusDomisili': 'Aktif',
      'statusHidup': 'Hidup',
    },
    {
      'nama': 'Varizky Naldiba Rimra',
      'nik': '1371111011030005',
      'keluarga': 'Keluarga Varizky Naldiba Rimra',
      'jenisKelamin': 'Laki-laki',
      'statusDomisili': 'Aktif',
      'statusHidup': 'Hidup',
    },
    {
      'nama': 'Tes',
      'nik': '2222222222222222',
      'keluarga': 'Keluarga Tes',
      'jenisKelamin': 'Laki-laki',
      'statusDomisili': 'Aktif',
      'statusHidup': 'Wafat',
    },
  ];

  // Filter aktif
  String? selectedGender;
  String? selectedStatus;
  String? selectedFamily;
  String searchName = '';

  bool get _isMobile => MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan input
    final filteredWarga = warga.where((item) {
      final matchName = item['nama']
          .toString()
          .toLowerCase()
          .contains(searchName.toLowerCase());
      final matchGender =
          selectedGender == null || item['jenisKelamin'] == selectedGender;
      final matchStatus =
          selectedStatus == null || item['statusDomisili'] == selectedStatus;
      final matchFamily =
          selectedFamily == null || item['keluarga'] == selectedFamily;
      return matchName && matchGender && matchStatus && matchFamily;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Warga'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Header Info
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Warga',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Daftar Warga',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.groups, color: Colors.white, size: 30),
              ],
            ),
          ),

          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul + tombol filter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Warga',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final result = await showDialog<Map<String, dynamic>>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext dialogContext) {
                              return Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: const FilterWargaDialog(),
                                ),
                              );
                            },
                          );

                          if (result != null) {
                            setState(() {
                              searchName = result['nama'] ?? '';
                              selectedGender = result['jenisKelamin'];
                              selectedStatus = result['status'];
                              selectedFamily = result['keluarga'];
                            });
                          }
                        },
                        icon: const Icon(Icons.filter_list),
                        label: const Text('Filter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tabel daftar warga
                  Expanded(
                    child: _isMobile
                        ? _buildMobileList(filteredWarga)
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('No')),
                                  DataColumn(label: Text('Nama')),
                                  DataColumn(label: Text('NIK')),
                                  DataColumn(label: Text('Keluarga')),
                                  DataColumn(label: Text('Jenis Kelamin')),
                                  DataColumn(label: Text('Status Domisili')),
                                  DataColumn(label: Text('Status Hidup')),
                                  DataColumn(label: Text('Aksi')),
                                ],
                                rows: List.generate(filteredWarga.length,
                                    (index) {
                                  final wargaItem = filteredWarga[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(Text('${index + 1}')),
                                      DataCell(Text(wargaItem['nama'])),
                                      DataCell(Text(wargaItem['nik'])),
                                      DataCell(Text(wargaItem['keluarga'])),
                                      DataCell(
                                          Text(wargaItem['jenisKelamin'])),
                                      DataCell(_buildStatusChip(
                                          wargaItem['statusDomisili'])),
                                      DataCell(_buildStatusChip(
                                          wargaItem['statusHidup'])),
                                      DataCell(
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kPrimaryBlue,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Detail',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
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

  // Untuk tampilan mobile
  Widget _buildMobileList(List<Map<String, dynamic>> list) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final w = list[i];
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
              w['nama'],
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NIK: ${w['nik']}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text('Keluarga: ${w['keluarga']}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildStatusChip(w['jenisKelamin']),
                      _buildStatusChip(w['statusDomisili']),
                      _buildStatusChip(w['statusHidup']),
                    ],
                  ),
                ],
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child:
                  const Text('Detail', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }

  // Badge status
  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;

    if (status == 'Aktif' || status == 'Hidup') {
      bgColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else {
      bgColor = Colors.grey.shade200;
      textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: TextStyle(color: textColor)),
    );
  }
}

class FilterWargaDialog extends StatefulWidget {
  const FilterWargaDialog({super.key});

  @override
  State<FilterWargaDialog> createState() => _FilterWargaDialogState();
}

class _FilterWargaDialogState extends State<FilterWargaDialog> {
  final TextEditingController _namaController = TextEditingController();
  String? _selectedGender;
  String? _selectedStatus;
  String? _selectedFamily;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Filter Warga',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  hintText: 'Masukkan nama warga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: _selectedGender,
                items: const [
                  DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (val) => setState(() => _selectedGender = val),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Status Domisili',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: _selectedStatus,
                items: const [
                  DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                  DropdownMenuItem(
                      value: 'Tidak Aktif', child: Text('Tidak Aktif')),
                ],
                onChanged: (val) => setState(() => _selectedStatus = val),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Keluarga',
                  hintText: 'Masukkan nama keluarga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (val) => _selectedFamily = val,
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
            Navigator.pop(context, {
              'nama': _namaController.text,
              'jenisKelamin': _selectedGender,
              'status': _selectedStatus,
              'keluarga': _selectedFamily,
            });
          },
          child: const Text('Terapkan', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}