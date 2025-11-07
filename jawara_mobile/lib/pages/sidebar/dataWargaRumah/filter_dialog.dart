import 'package:flutter/material.dart';
import '../../../theme.dart';

class FilterWargaDialog extends StatefulWidget {
  const FilterWargaDialog({super.key});

  @override
  State<FilterWargaDialog> createState() => _FilterWargaDialogState();
}

class _FilterWargaDialogState extends State<FilterWargaDialog> {
  String? selectedGender;
  String? selectedStatus;
  String? selectedFamily;

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Penerimaan Warga',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Nama
            const Text('Nama'),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Cari nama...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryBlue),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Jenis Kelamin
            const Text('Jenis Kelamin'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedGender,
              hint: const Text('-- Pilih Jenis Kelamin --'),
              items: const [
                DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
              ],
              onChanged: (value) => setState(() => selectedGender = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Status
            const Text('Status'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              hint: const Text('-- Pilih Status --'),
              items: const [
                DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                DropdownMenuItem(value: 'Nonaktif', child: Text('Nonaktif')),
              ],
              onChanged: (value) => setState(() => selectedStatus = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Keluarga
            const Text('Keluarga'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedFamily,
              hint: const Text('-- Pilih Keluarga --'),
              items: const [
                DropdownMenuItem(value: 'Keluarga A', child: Text('Keluarga A')),
                DropdownMenuItem(value: 'Keluarga B', child: Text('Keluarga B')),
              ],
              onChanged: (value) => setState(() => selectedFamily = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                  onPressed: () {
                    setState(() {
                      nameController.clear();
                      selectedGender = null;
                      selectedStatus = null;
                      selectedFamily = null;
                    });
                  },
                  child: const Text('Reset Filter'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      'nama': nameController.text,
                      'jenisKelamin': selectedGender,
                      'status': selectedStatus,
                      'keluarga': selectedFamily,
                    });
                  },
                  child: const Text('Terapkan'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}