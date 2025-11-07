import 'package:flutter/material.dart';
import '../../../widgets/app_drawer.dart';
import '../../../theme.dart';

class WargaTambahPage extends StatefulWidget {
  const WargaTambahPage({super.key});

  @override
  State<WargaTambahPage> createState() => _WargaTambahPageState();
}

class _WargaTambahPageState extends State<WargaTambahPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedKeluarga;
  String? selectedJenisKelamin;
  String? selectedAgama;
  String? selectedGolDarah;
  String? selectedPeranKeluarga;
  String? selectedPendidikan;
  String? selectedPekerjaan;
  String? selectedStatus;

  DateTime? tanggalLahir;

  // Tambah helper dekorasi input agar konsisten tema
  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: kPrimaryBlue, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final double formWidth = w < 860 ? w - 32.0 : 800.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Warga'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header bertema
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
                        'Form Warga',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Tambah Warga',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.person_add_alt_1, color: Colors.white),
                ],
              ),
            ),

            // Konten form responsif
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  width: formWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tambah Warga",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Keluarga
                        const Text("Pilih Keluarga"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedKeluarga,
                          hint: const Text("-- Pilih Keluarga --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Keluarga Mara Nunez",
                              child: Text("Keluarga Mara Nunez"),
                            ),
                            DropdownMenuItem(
                              value: "Keluarga Tes",
                              child: Text("Keluarga Tes"),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => selectedKeluarga = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Nama
                        const Text("Nama"),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: _inputDecoration(
                            hint: "Masukkan nama lengkap",
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? "Nama wajib diisi"
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // NIK
                        const Text("NIK"),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: _inputDecoration(
                            hint: "Masukkan NIK sesuai KTP",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) => (v == null || v.isEmpty)
                              ? "NIK wajib diisi"
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Nomor Telepon
                        const Text("Nomor Telepon"),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: _inputDecoration(hint: "08xxxxxx"),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),

                        // Tempat Lahir
                        const Text("Tempat Lahir"),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: _inputDecoration(
                            hint: "Masukkan tempat lahir",
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tanggal Lahir
                        const Text("Tanggal Lahir"),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null)
                              setState(() => tanggalLahir = picked);
                          },
                          child: InputDecorator(
                            decoration: _inputDecoration(
                              hint: "-- Pilih Tanggal Lahir --",
                            ),
                            child: Text(
                              tanggalLahir == null
                                  ? "--/--/----"
                                  : "${tanggalLahir!.day}/${tanggalLahir!.month}/${tanggalLahir!.year}",
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Jenis Kelamin
                        const Text("Jenis Kelamin"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedJenisKelamin,
                          hint: const Text("-- Pilih Jenis Kelamin --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Laki-laki",
                              child: Text("Laki-laki"),
                            ),
                            DropdownMenuItem(
                              value: "Perempuan",
                              child: Text("Perempuan"),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => selectedJenisKelamin = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Agama
                        const Text("Agama"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedAgama,
                          hint: const Text("-- Pilih Agama --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Islam",
                              child: Text("Islam"),
                            ),
                            DropdownMenuItem(
                              value: "Kristen",
                              child: Text("Kristen"),
                            ),
                            DropdownMenuItem(
                              value: "Hindu",
                              child: Text("Hindu"),
                            ),
                            DropdownMenuItem(
                              value: "Budha",
                              child: Text("Budha"),
                            ),
                          ],
                          onChanged: (v) => setState(() => selectedAgama = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Golongan Darah
                        const Text("Golongan Darah"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedGolDarah,
                          hint: const Text("-- Pilih Golongan Darah --"),
                          items: const [
                            DropdownMenuItem(value: "A", child: Text("A")),
                            DropdownMenuItem(value: "B", child: Text("B")),
                            DropdownMenuItem(value: "AB", child: Text("AB")),
                            DropdownMenuItem(value: "O", child: Text("O")),
                          ],
                          onChanged: (v) =>
                              setState(() => selectedGolDarah = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Peran Keluarga
                        const Text("Peran Keluarga"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedPeranKeluarga,
                          hint: const Text("-- Pilih Peran Keluarga --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Ayah",
                              child: Text("Ayah"),
                            ),
                            DropdownMenuItem(value: "Ibu", child: Text("Ibu")),
                            DropdownMenuItem(
                              value: "Anak",
                              child: Text("Anak"),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => selectedPeranKeluarga = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Pendidikan Terakhir
                        const Text("Pendidikan Terakhir"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedPendidikan,
                          hint: const Text("-- Pilih Pendidikan Terakhir --"),
                          items: const [
                            DropdownMenuItem(value: "SD", child: Text("SD")),
                            DropdownMenuItem(value: "SMP", child: Text("SMP")),
                            DropdownMenuItem(value: "SMA", child: Text("SMA")),
                            DropdownMenuItem(value: "S1", child: Text("S1")),
                          ],
                          onChanged: (v) =>
                              setState(() => selectedPendidikan = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Pekerjaan
                        const Text("Pekerjaan"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedPekerjaan,
                          hint: const Text("-- Pilih Jenis Pekerjaan --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Pelajar",
                              child: Text("Pelajar"),
                            ),
                            DropdownMenuItem(
                              value: "Karyawan",
                              child: Text("Karyawan"),
                            ),
                            DropdownMenuItem(
                              value: "Wiraswasta",
                              child: Text("Wiraswasta"),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => selectedPekerjaan = v),
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 16),

                        // Status
                        const Text("Status"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedStatus,
                          hint: const Text("-- Pilih Status --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Aktif",
                              child: Text("Aktif"),
                            ),
                            DropdownMenuItem(
                              value: "Nonaktif",
                              child: Text("Nonaktif"),
                            ),
                          ],
                          onChanged: (v) => setState(() => selectedStatus = v),
                          decoration: _inputDecoration(),
                        ),

                        const SizedBox(height: 24),

                        // Tombol Submit dan Reset
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Data berhasil disubmit!"),
                                    ),
                                  );
                                }
                              },
                              child: const Text("Submit"),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(color: Colors.grey.shade400),
                                foregroundColor: Colors.grey.shade800,
                              ),
                              onPressed: () {
                                _formKey.currentState!.reset();
                                setState(() {
                                  selectedKeluarga = null;
                                  selectedJenisKelamin = null;
                                  selectedAgama = null;
                                  selectedGolDarah = null;
                                  selectedPeranKeluarga = null;
                                  selectedPendidikan = null;
                                  selectedPekerjaan = null;
                                  selectedStatus = null;
                                  tanggalLahir = null;
                                });
                              },
                              child: const Text("Reset"),
                            ),
                          ],
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
}
