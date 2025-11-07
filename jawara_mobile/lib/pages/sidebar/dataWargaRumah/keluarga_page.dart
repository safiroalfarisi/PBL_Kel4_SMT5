import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class KeluargaPage extends StatefulWidget {
  const KeluargaPage({super.key});

  @override
  State<KeluargaPage> createState() => _KeluargaPageState();
}

class _KeluargaPageState extends State<KeluargaPage> {
  final List<Map<String, dynamic>> keluargaList = [
    {
      'nama': 'Keluarga Varizky Naldiba Rimra',
      'kepala': 'Varizky Naldiba Rimra',
      'alamat': 'Jl. Merpati No. 21',
      'statusKepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'nama': 'Keluarga Tes',
      'kepala': 'Tes',
      'alamat': 'Jl. Mawar No. 15',
      'statusKepemilikan': 'Penyewa',
      'status': 'Aktif',
    },
    {
      'nama': 'Keluarga Farhan',
      'kepala': 'Farhan',
      'alamat': 'Griyashanta L.203',
      'statusKepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
  ];

  String filterNama = '';
  String? filterStatus;
  String? filterRumah;

  void _openFilterModal() {
    final TextEditingController namaController = TextEditingController(
      text: filterNama,
    );
    String? selectedStatus = filterStatus;
    String? selectedRumah = filterRumah;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filter Keluarga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Nama'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: namaController,
                        decoration: InputDecoration(
                          hintText: 'Cari nama...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Status'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        decoration: InputDecoration(
                          hintText: '-- Pilih Status --',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Aktif',
                            child: Text('Aktif'),
                          ),
                          DropdownMenuItem(
                            value: 'Nonaktif',
                            child: Text('Nonaktif'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => selectedStatus = value);
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text('Rumah'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: selectedRumah,
                        decoration: InputDecoration(
                          hintText: '-- Pilih Rumah --',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Rumah 1',
                            child: Text('Rumah 1'),
                          ),
                          DropdownMenuItem(
                            value: 'Rumah 2',
                            child: Text('Rumah 2'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => selectedRumah = value);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                namaController.clear();
                                selectedStatus = null;
                                selectedRumah = null;
                              });
                            },
                            child: const Text('Reset Filter'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                filterNama = namaController.text;
                                filterStatus = selectedStatus;
                                filterRumah = selectedRumah;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBlue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Terapkan'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  bool get _isMobile => MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    final filteredList = keluargaList.where((keluarga) {
      final matchNama = keluarga['nama'].toLowerCase().contains(
        filterNama.toLowerCase(),
      );
      final matchStatus =
          filterStatus == null ||
          keluarga['status'].toLowerCase() == filterStatus!.toLowerCase();
      final matchRumah =
          filterRumah == null ||
          keluarga['alamat'].toLowerCase().contains(filterRumah!.toLowerCase());
      return matchNama && matchStatus && matchRumah;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Keluarga'),
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
                      'Data Keluarga',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Daftar Keluarga',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.family_restroom, color: Colors.white),
              ],
            ),
          ),
          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Daftar Keluarga',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _openFilterModal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _isMobile
                          ? _buildMobileList(filteredList)
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('NO')),
                                    DataColumn(label: Text('NAMA KELUARGA')),
                                    DataColumn(label: Text('KEPALA KELUARGA')),
                                    DataColumn(label: Text('ALAMAT RUMAH')),
                                    DataColumn(
                                      label: Text('STATUS KEPEMILIKAN'),
                                    ),
                                    DataColumn(label: Text('STATUS')),
                                    DataColumn(label: Text('AKSI')),
                                  ],
                                  rows: List.generate(filteredList.length, (
                                    index,
                                  ) {
                                    final keluarga = filteredList[index];
                                    return DataRow(
                                      cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(keluarga['nama'])),
                                        DataCell(Text(keluarga['kepala'])),
                                        DataCell(Text(keluarga['alamat'])),
                                        DataCell(
                                          Text(keluarga['statusKepemilikan']),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              keluarga['status'],
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/detail-keluarga',
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                            ),
                                            child: const Text("Detail"),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList(List<Map<String, dynamic>> list) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final k = list[i];
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
              k['nama'],
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kepala: ${k['kepala']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Alamat: ${k['alamat']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          k['status'],
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          k['statusKepemilikan'],
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/detail-keluarga'),
          ),
        );
      },
    );
  }
}
