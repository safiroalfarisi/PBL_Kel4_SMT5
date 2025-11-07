import 'package:flutter/material.dart';
import '/widgets/app_drawer.dart';
import '/theme.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  int _selectedYear = 2025;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Keuangan'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan tahun
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ringkasan Keuangan',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tahun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DropdownButton<int>(
                        value: _selectedYear,
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedYear = newValue;
                            });
                          }
                        },
                        dropdownColor: kPrimaryBlue, // konsisten tema
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        items: [2023, 2024, 2025].map((year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards - Always in Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: _buildSummaryCard(
                        icon: Icons.trending_up,
                        title: 'Total Pemasukan',
                        amount: '50 jt',
                        color: kPrimaryBlue, // konsisten tema
                        bgColor: kPrimaryBlue.withOpacity(0.08),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 150,
                      child: _buildSummaryCard(
                        icon: Icons.trending_down,
                        title: 'Total Pengeluaran',
                        amount: '2.1 rb',
                        color: Colors.red, // kontras dan umum untuk pengeluaran
                        bgColor: Colors.red.withOpacity(0.08),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 150,
                      child: _buildSummaryCard(
                        icon: Icons.receipt,
                        title: 'Jumlah Transaksi',
                        amount: '5',
                        color: kPrimaryBlue, // konsisten tema
                        bgColor: kPrimaryBlue.withOpacity(0.08),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Charts Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          child: _buildChartCard(
                            title: 'Pemasukan per Bulan',
                            height: 250,
                            icon: Icons.trending_up,
                            iconColor: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildChartCard(
                            title: 'Pengeluaran per Bulan',
                            height: 250,
                            icon: Icons.trending_down,
                            iconColor: Colors.red,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildChartCard(
                          title: 'Pemasukan per Bulan',
                          height: 250,
                          icon: Icons.trending_up,
                          iconColor: Colors.blue,
                        ),
                        const SizedBox(height: 16),
                        _buildChartCard(
                          title: 'Pengeluaran per Bulan',
                          height: 250,
                          icon: Icons.trending_down,
                          iconColor: Colors.red,
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 16),

            // Category Charts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          child: _buildPieChartCard(
                            title: 'Pemasukan Berdasarkan Kategori',
                            bgColor: Colors.blue.shade50,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildPieChartCard(
                            title: 'Pengeluaran Berdasarkan Kategori',
                            bgColor: Colors.green.shade50,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildPieChartCard(
                          title: 'Pemasukan Berdasarkan Kategori',
                          bgColor: Colors.blue.shade50,
                        ),
                        const SizedBox(height: 16),
                        _buildPieChartCard(
                          title: 'Pengeluaran Berdasarkan Kategori',
                          bgColor: Colors.green.shade50,
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String amount,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required double height,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(height: height, child: _buildSimpleBarChart(iconColor)),
        ],
      ),
    );
  }

  Widget _buildSimpleBarChart(Color color) {
    final months = ['Agu', 'Sep', 'Okt'];
    final values = [30, 45, 50];
    final maxValue = 60.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(months.length, (index) {
          final barHeight = (values[index] / maxValue) * 120;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: barHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                months[index],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPieChartCard({required String title, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pie_chart, color: kPrimaryBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimaryBlue.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegend('Kategori 1', kPrimaryBlue),
                      const SizedBox(width: 16),
                      _buildLegend('Kategori 2', Colors.indigo),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
