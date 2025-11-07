import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _go(String route) => Navigator.of(context).pushNamed(route);

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    Color? bgColor,
  }) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 6),
          Text(
            value,
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

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.grid_view_rounded, color: kPrimaryBlue, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = kPrimaryBlue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label),
        avatar: Icon(icon, size: 18, color: Colors.white),
        backgroundColor: color.withOpacity(0.12),
        shape: StadiumBorder(side: BorderSide(color: color.withOpacity(0.35))),
        labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
        onPressed: onTap,
      ),
    );
  }

  // --- Progress helpers ---
  String _formatCompact(num n) {
    final v = n.abs();
    String s;
    if (v >= 1000000000) {
      s = (n / 1000000000).toStringAsFixed(1).replaceAll('.0', '') + ' M';
    } else if (v >= 1000000) {
      s = (n / 1000000).toStringAsFixed(1).replaceAll('.0', '') + ' jt';
    } else if (v >= 1000) {
      s = (n / 1000).toStringAsFixed(1).replaceAll('.0', '') + ' rb';
    } else {
      s = n.toStringAsFixed(0);
    }
    return s;
  }

  Widget _progressCard({
    required String title,
    required num current,
    required num limit,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
    double? width,
  }) {
    final pct = limit == 0 ? 0.0 : (current / limit).clamp(0, 1).toDouble();
    final danger = pct >= 0.9;
    final warn = pct >= 0.7 && pct < 0.9;
    final barColor = danger ? Colors.red : (warn ? Colors.orange : color);

    final card = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatCompact(current),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: barColor,
                  ),
                ),
                Text(
                  '${(pct * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: pct,
                minHeight: 8,
                color: barColor,
                backgroundColor: barColor.withOpacity(0.15),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'dari ${_formatCompact(limit)}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );

    return width == null ? card : SizedBox(width: width, child: card);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            final horizontalPadding = isWide ? 24.0 : 12.0;
            final children = <Widget>[
              // Header banner
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ringkasan Aplikasi',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Overview singkat & aksi cepat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Quick actions
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _quickAction(
                        icon: Icons.add_task,
                        label: 'Tambah Kegiatan',
                        onTap: () => _go('/tambah/kegiatan'),
                      ),
                      _quickAction(
                        icon: Icons.campaign,
                        label: 'Broadcast',
                        onTap: () => _go('/daftar/broadcast'),
                      ),
                      _quickAction(
                        icon: Icons.person_add_alt_1,
                        label: 'Tambah Warga',
                        onTap: () => _go('/warga/tambah'),
                      ),
                      _quickAction(
                        icon: Icons.receipt_long,
                        label: 'Tagih Iuran',
                        onTap: () => _go('/tagihan'),
                      ),
                      _quickAction(
                        icon: Icons.trending_down,
                        label: 'Tambah Pengeluaran',
                        onTap: () => _go('/tambah/pengeluaran'),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),

              // Summary cards row (horizontal scroll)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _summaryCard(
                      icon: Icons.groups,
                      title: 'Total Penduduk',
                      value: '9',
                      color: const Color(0xFF10B981),
                      bgColor: const Color(0xFFDFF7EE),
                    ),
                    const SizedBox(width: 12),
                    _summaryCard(
                      icon: Icons.home,
                      title: 'Total Keluarga',
                      value: '7',
                      color: const Color(0xFF3B82F6),
                      bgColor: const Color(0xFFE0EDFF),
                    ),
                    const SizedBox(width: 12),
                    _summaryCard(
                      icon: Icons.event,
                      title: 'Total Kegiatan',
                      value: '1',
                      color: Colors.orange,
                      bgColor: Colors.orange.shade50,
                    ),
                    const SizedBox(width: 12),
                    _summaryCard(
                      icon: Icons.receipt,
                      title: 'Transaksi Bulan Ini',
                      value: '5',
                      color: Colors.purple,
                      bgColor: Colors.purple.shade50,
                    ),
                  ],
                ),
              ),

              // Navigations grouped
              _sectionCard(
                title: 'Data Warga & Rumah',
                children: [
                  LayoutBuilder(
                    builder: (context, c) {
                      const spacing = 12.0;
                      final w = c.maxWidth;
                      final small = (w - spacing) / 2;
                      return Column(
                        children: [
                          Row(
                            children: [
                              _progressCard(
                                width: small,
                                title: 'Penduduk',
                                current: 9,
                                limit: 100,
                                icon: Icons.groups,
                                color: const Color(0xFF10B981),
                                onTap: () => _go('/kependudukan'),
                              ),
                              const SizedBox(width: spacing),
                              _progressCard(
                                width: small,
                                title: 'Keluarga',
                                current: 7,
                                limit: 30,
                                icon: Icons.family_restroom,
                                color: const Color(0xFF3B82F6),
                                onTap: () => _go('/keluarga'),
                              ),
                            ],
                          ),
                          const SizedBox(height: spacing),
                          _progressCard(
                            title: 'Rumah',
                            current: 7,
                            limit: 30,
                            icon: Icons.house,
                            color: Colors.indigo,
                            onTap: () => _go('/rumah/daftar'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              _sectionCard(
                title: 'Keuangan',
                children: [
                  LayoutBuilder(
                    builder: (context, c) {
                      const spacing = 12.0;
                      final w = c.maxWidth;
                      final small = (w - spacing) / 2;
                      return Column(
                        children: [
                          Row(
                            children: [
                              _progressCard(
                                width: small,
                                title: 'Pemasukan',
                                current: 50000000, // 50 jt
                                limit: 100000000, // target 100 jt
                                icon: Icons.trending_up,
                                color: Colors.blue,
                                onTap: () => _go('/keuangan'),
                              ),
                              const SizedBox(width: spacing),
                              _progressCard(
                                width: small,
                                title: 'Pengeluaran',
                                current: 2100, // 2.1 rb
                                limit: 10000000, // budget 10 jt
                                icon: Icons.trending_down,
                                color: Colors.red,
                                onTap: () => _go('/keuangan'),
                              ),
                            ],
                          ),
                          const SizedBox(height: spacing),
                          _progressCard(
                            title: 'Transaksi Bulan Ini',
                            current: 5,
                            limit: 50,
                            icon: Icons.receipt,
                            color: Colors.purple,
                            onTap: () => _go('/keuangan'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              _sectionCard(
                title: 'Kegiatan & Broadcast',
                children: [
                  LayoutBuilder(
                    builder: (context, c) {
                      const spacing = 12.0;
                      final w = c.maxWidth;
                      final small = (w - spacing) / 2;
                      return Column(
                        children: [
                          Row(
                            children: [
                              _progressCard(
                                width: small,
                                title: 'Kegiatan',
                                current: 1,
                                limit: 5,
                                icon: Icons.event,
                                color: Colors.orange,
                                onTap: () => _go('/daftar/kegiatan'),
                              ),
                              const SizedBox(width: spacing),
                              _progressCard(
                                width: small,
                                title: 'Broadcast',
                                current: 0,
                                limit: 10,
                                icon: Icons.campaign,
                                color: Colors.teal,
                                onTap: () => _go('/daftar/broadcast'),
                              ),
                            ],
                          ),
                          const SizedBox(height: spacing),
                          _progressCard(
                            title: 'Dashboard Kegiatan',
                            current: 1,
                            limit: 5,
                            icon: Icons.dashboard_customize,
                            color: Colors.amber,
                            onTap: () => _go('/kegiatan'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // Section 'Laporan dan Lainnya' dihapus sesuai permintaan
            ];

            // Make header full-bleed; pad the rest to match layout
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
    );
  }
}

// _NavTile class dihapus karena tidak dipakai lagi setelah transformasi menjadi grafik cards
