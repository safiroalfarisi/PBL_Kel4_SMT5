import 'dart:math' as math;

import 'package:flutter/material.dart';
import '/widgets/app_drawer.dart';
import '/theme.dart';

class KependudukanPage extends StatefulWidget {
  const KependudukanPage({super.key});

  @override
  State<KependudukanPage> createState() => _KependudukanPageState();
}

class _KependudukanPageState extends State<KependudukanPage> {
  int _selectedYear = 2025;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 380;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kependudukan'),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Kependudukan',
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
                          dropdownColor: Colors.blue.shade700,
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

              // Body padding for content after header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary (horizontal scroll)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          _SummaryCard(
                            icon: Icons.home,
                            title: 'Total Keluarga',
                            value: '7',
                            color: Color(0xFF3B82F6),
                            bgColor: Color(0xFFE0EDFF),
                          ),
                          SizedBox(width: 12),
                          _SummaryCard(
                            icon: Icons.groups,
                            title: 'Total Penduduk',
                            value: '9',
                            color: Color(0xFF10B981),
                            bgColor: Color(0xFFDFF7EE),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Status Penduduk
                    _ChartCard(
                      icon: Icons.stacked_line_chart,
                      iconColor: Colors.amber,
                      title: 'Status Penduduk',
                      bgColor: const Color(0xFFFFF7CC),
                      child: _PieBlock(
                        segments: const [
                          PieSegment('Aktif', 7, Color(0xFF16A34A)),
                          PieSegment('Nonaktif', 2, Color(0xFFEA580C)),
                        ],
                        compact: isCompact,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Jenis Kelamin
                    _ChartCard(
                      icon: Icons.female,
                      iconColor: Colors.purple,
                      title: 'Jenis Kelamin',
                      bgColor: const Color(0xFFF5EFFF),
                      child: _PieBlock(
                        segments: const [
                          PieSegment('Laki-laki', 8, Color(0xFF2563EB)),
                          PieSegment('Perempuan', 1, Color(0xFFEF4444)),
                        ],
                        compact: isCompact,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Pekerjaan Penduduk
                    _ChartCard(
                      icon: Icons.work,
                      iconColor: Colors.deepOrange,
                      title: 'Pekerjaan Penduduk',
                      bgColor: const Color(0xFFFFE7F0),
                      child: _PieBlock(
                        segments: const [
                          PieSegment('Lainnya', 9, Color(0xFF7C3AED)),
                        ],
                        compact: isCompact,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Peran dalam Keluarga
                    _ChartCard(
                      icon: Icons.family_restroom,
                      iconColor: Colors.blue,
                      title: 'Peran dalam Keluarga',
                      bgColor: const Color(0xFFEAF2FF),
                      child: _PieBlock(
                        segments: const [
                          PieSegment('Kepala Keluarga', 7, Color(0xFF2563EB)),
                          PieSegment('Anak', 1, Color(0xFFEF4444)),
                          PieSegment('Anggota Lain', 1, Color(0xFF22C55E)),
                        ],
                        compact: isCompact,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Agama
                    _ChartCard(
                      icon: Icons.local_fire_department,
                      iconColor: Colors.deepOrange,
                      title: 'Agama',
                      bgColor: const Color(0xFFFFEBEB),
                      child: _PieBlock(
                        segments: const [
                          PieSegment('Islam', 1, Color(0xFF2563EB)),
                          PieSegment('Katolik', 1, Color(0xFFEF4444)),
                        ],
                        compact: isCompact,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Pendidikan
                    _ChartCard(
                      icon: Icons.school,
                      iconColor: Colors.teal,
                      title: 'Pendidikan',
                      bgColor: const Color(0xFFE6FBF7),
                      child: _PieBlock(
                        segments: const [
                          PieSegment('Sarjana/Diploma', 9, Color(0xFF6B7280)),
                        ],
                        compact: isCompact,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Widgets ---

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.bgColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              height: 1.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.bgColor,
    required this.child,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Color bgColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PieBlock extends StatelessWidget {
  const _PieBlock({required this.segments, this.compact = false});

  final List<PieSegment> segments;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final total = segments.fold<double>(0, (p, e) => p + e.value);
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: compact ? 140 : 170,
            height: compact ? 140 : 170,
            child: CustomPaint(painter: _PieChartPainter(segments: segments)),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            for (final s in segments)
              _LegendDot(
                label: s.label,
                color: s.color,
                percent: s.value / total,
              ),
          ],
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.label,
    required this.color,
    required this.percent,
  });
  final String label;
  final Color color;
  final double percent;

  @override
  Widget build(BuildContext context) {
    final pct = (percent.isNaN || percent.isInfinite) ? 0.0 : percent;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label${pct > 0 ? ' ${(pct * 100).toStringAsFixed(0)}%' : ''}',
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}

class PieSegment {
  const PieSegment(this.label, this.value, this.color);
  final String label;
  final double value;
  final Color color;
}

class _PieChartPainter extends CustomPainter {
  _PieChartPainter({required this.segments});
  final List<PieSegment> segments;

  @override
  void paint(Canvas canvas, Size size) {
    final total = segments.fold<double>(0, (p, e) => p + e.value);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startRadian = -math.pi / 2; // start at top
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (final s in segments) {
      final sweep = total == 0 ? 0.0 : (s.value / total) * 2 * math.pi;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = s.color;
      canvas.drawArc(rect, startRadian, sweep, true, paint);

      // Draw percentage label if big enough
      final percent = total == 0 ? 0.0 : s.value / total;
      if (percent >= 0.08 && sweep > 0) {
        final mid = startRadian + sweep / 2;
        final labelRadius = radius * 0.55;
        final dx = center.dx + labelRadius * math.cos(mid);
        final dy = center.dy + labelRadius * math.sin(mid);
        textPainter.text = TextSpan(
          text: '${(percent * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
        textPainter.layout();
        final offset = Offset(
          dx - textPainter.width / 2,
          dy - textPainter.height / 2,
        );
        canvas.save();
        canvas.translate(1, 1);
        textPainter.paint(canvas, offset);
        canvas.restore();
        textPainter.paint(canvas, offset);
      }

      startRadian += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _PieChartPainter oldDelegate) => true;
}
