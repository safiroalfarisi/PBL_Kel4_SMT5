import 'package:flutter/material.dart';
import '../theme.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
  int? _openIndex;
  final Map<String, bool> _nestedOpen = {};

  List<Widget> _buildSubMenuItems(
    List<Map<String, dynamic>> items,
    BuildContext context,
    String? currentRoute,
  ) {
    return items.map((it) {
      final String label = it['label'] as String;
      final IconData? icon = it['icon'] as IconData?;
      final String? route = it['route'] as String?;
      final List<Map<String, dynamic>>? children =
          it['children'] as List<Map<String, dynamic>>?;

      final bool isActive = route != null && route == currentRoute;

      if (children != null && children.isNotEmpty) {
        // nested expansion: persist state per-label so animation and open
        // state survive parent rebuilds
        final bool hasActiveChild = children.any(
          (c) => (c['route'] as String?) == currentRoute,
        );
        final key = 'nested_$label';
        final bool expandedLocal = _nestedOpen[key] ?? hasActiveChild;

        return AnimatedBuilder(
          animation: const AlwaysStoppedAnimation(0),
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: expandedLocal
                    ? kPrimaryBlue.withOpacity(0.03)
                    : Colors.transparent,
                border: expandedLocal
                    ? Border(
                        left: BorderSide(
                          color: kPrimaryBlue.withOpacity(0.3),
                          width: 3,
                        ),
                      )
                    : null,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: kPrimaryBlue.withOpacity(0.05),
                  highlightColor: kPrimaryBlue.withOpacity(0.02),
                ),
                child: ExpansionTile(
                  key: PageStorageKey('nested_$label'),
                  initiallyExpanded: expandedLocal,
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  childrenPadding: const EdgeInsets.only(left: 20, bottom: 8),
                  leading: icon != null
                      ? Icon(icon, color: kPrimaryBlue, size: 20)
                      : null,
                  title: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: expandedLocal ? kPrimaryBlue : Colors.black87,
                    ),
                  ),
                  trailing: AnimatedRotation(
                    turns: expandedLocal ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: expandedLocal ? kPrimaryBlue : Colors.black54,
                    ),
                  ),
                  children: _buildSubMenuItems(children, context, currentRoute),
                  onExpansionChanged: (open) {
                    setState(() {
                      _nestedOpen[key] = open;
                    });
                  },
                ),
              ),
            );
          },
        );
      }

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            Navigator.pop(context);
            if (route != null) Navigator.pushNamed(context, route);
          },
          splashColor: kPrimaryBlue.withOpacity(0.1),
          highlightColor: kPrimaryBlue.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: isActive ? kPrimaryBlue.withOpacity(0.08) : null,
              border: isActive
                  ? Border(left: BorderSide(color: kPrimaryBlue, width: 3))
                  : null,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isActive ? kPrimaryBlue : Colors.black54,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isActive ? kPrimaryBlue : Colors.black87,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    final menuStructure = <Map<String, dynamic>>[
      {
        'icon': Icons.dashboard_outlined,
        'label': 'Dashboard',
        'children': [
          {
            'label': 'Overview',
            'route': '/dashboard',
            'icon': Icons.dashboard_outlined,
          },
          {
            'label': 'Keuangan',
            'route': '/keuangan',
            'icon': Icons.account_balance_wallet_outlined,
          },
          {
            'label': 'Kegiatan',
            'route': '/kegiatan',
            'icon': Icons.event_note_outlined,
          },
          {
            'label': 'Kependudukan',
            'route': '/kependudukan',
            'icon': Icons.people_outline,
          },
        ],
      },
      {
        'icon': Icons.people_outline,
        'label': 'Data Warga & Rumah',
        'children': [
          {
            'label': 'Warga - Daftar',
            'route': '/warga/daftar',
            'icon': Icons.people_outline,
          },
          {
            'label': 'Warga - Tambah',
            'route': '/warga/tambah',
            'icon': Icons.person_add_alt_1_outlined,
          },
          {
            'label': 'Keluarga',
            'route': '/keluarga',
            'icon': Icons.group_outlined,
          },
          {
            'label': 'Rumah - Daftar',
            'route': '/rumah/daftar',
            'icon': Icons.home_outlined,
          },
          {
            'label': 'Rumah - Tambah',
            'route': '/rumah/tambah',
            'icon': Icons.home_outlined,
          },
        ],
      },
      {
        'icon': Icons.attach_money_outlined,
        'label': 'Pemasukan',
        'children': [
          {
            'label': 'Kategori Iuran',
            'route': '/kategori/iuran',
            'icon': Icons.category_outlined,
          },
          {
            'label': 'Tagih Iuran',
            'route': '/iuran',
            'icon': Icons.receipt_long_outlined,
          },
          {
            'label': 'Tagihan',
            'route': '/tagihan',
            'icon': Icons.receipt_outlined,
          },
          {
            'label': 'Pemasukan Lain - Daftar',
            'route': '/pemasukan_lain/daftar',
            'icon': Icons.list_alt,
          },
          {
            'label': 'Pemasukan Lain - Tambah',
            'route': '/pemasukan_lain/tambah',
            'icon': Icons.add,
          },
        ],
      },
      {
        'icon': Icons.money_off_outlined,
        'label': 'Pengeluaran',
        'children': [
          {
            'label': 'Daftar',
            'route': '/daftar/pengeluaran',
            'icon': Icons.list_alt,
          },
          {
            'label': 'Tambah',
            'route': '/tambah/pengeluaran',
            'icon': Icons.add,
          },
        ],
      },
      {
        'icon': Icons.insert_drive_file_outlined,
        'label': 'Laporan Keuangan',
        'children': [
          {
            'label': 'Semua Pemasukan',
            'route': '/laporan/pemasukan',
            'icon': Icons.bar_chart,
          },
          {
            'label': 'Semua Pengeluaran',
            'route': '/laporan/pengeluaran',
            'icon': Icons.bar_chart,
          },
          {
            'label': 'Cetak Laporan',
            'route': '/laporan/cetak',
            'icon': Icons.print_outlined,
          },
        ],
      },
      {
        'icon': Icons.event_outlined,
        'label': 'Kegiatan & Broadcast',
        'children': [
          {
            'label': 'Kegiatan - Daftar',
            'route': '/daftar/kegiatan',
            'icon': Icons.event_note_outlined,
          },
          {
            'label': 'Kegiatan - Tambah',
            'route': '/tambah/kegiatan',
            'icon': Icons.add,
          },
          {
            'label': 'Broadcast - Daftar',
            'route': '/daftar/broadcast',
            'icon': Icons.campaign_outlined,
          },
          {
            'label': 'Broadcast - Tambah',
            'route': '/tambah/broadcast',
            'icon': Icons.campaign_outlined,
          },
        ],
      },
      {
        'icon': Icons.message_outlined,
        'label': 'Pesan Warga',
        'children': [
          {
            'label': 'Informasi Aspirasi',
            'route': '/informasi/aspirasi',
            'icon': Icons.message_outlined,
          },
        ],
      },
      {
        'icon': Icons.inbox_outlined,
        'label': 'Penerimaan Warga',
        'children': [
          {
            'label': 'Penerimaan Warga',
            'route': '/penerimaan/warga',
            'icon': Icons.inbox_outlined,
          },
        ],
      },
      {
        'icon': Icons.swap_horiz_outlined,
        'label': 'Mutasi Keluarga',
        'children': [
          {
            'label': 'Daftar',
            'route': '/mutasi/daftar',
            'icon': Icons.list_alt,
          },
          {'label': 'Tambah', 'route': '/mutasi/tambah', 'icon': Icons.add},
        ],
      },
      {
        'icon': Icons.history,
        'label': 'Log Aktifitas',
        'children': [
          {
            'label': 'Semua Aktifitas',
            'route': '/log/aktifitas',
            'icon': Icons.history,
          },
        ],
      },
      {
        'icon': Icons.manage_accounts_outlined,
        'label': 'Manajemen Pengguna',
        'children': [
          {
            'label': 'Daftar Pengguna',
            'route': '/pengguna/daftar',
            'icon': Icons.supervisor_account_outlined,
          },
          {
            'label': 'Tambah Pengguna',
            'route': '/pengguna/tambah',
            'icon': Icons.person_add,
          },
        ],
      },
      {
        'icon': Icons.swap_calls_outlined,
        'label': 'Channel Transfer',
        'children': [
          {
            'label': 'Daftar Channel',
            'route': '/channel/daftar',
            'icon': Icons.swap_horiz_outlined,
          },
          {
            'label': 'Tambah Channel',
            'route': '/channel/tambah',
            'icon': Icons.add,
          },
        ],
      },
    ];

    // Compute default open index when current route is inside a top-level menu
    int? defaultOpen;
    for (var i = 0; i < menuStructure.length; i++) {
      final children =
          menuStructure[i]['children'] as List<Map<String, dynamic>>?;
      if (children != null) {
        final hasActiveChild = children.any((c) {
          if ((c['route'] as String?) == currentRoute) return true;
          final sub = c['children'] as List<Map<String, dynamic>>?;
          return sub != null &&
              sub.any((s) => (s['route'] as String?) == currentRoute);
        });
        if (hasActiveChild) {
          defaultOpen = i;
          break;
        }
      }
    }

    // prefer explicit state if user has already interacted, otherwise use defaultOpen
    final activeOpenIndex = _openIndex ?? defaultOpen;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: kPrimaryBlue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Jawara',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'admin1@gmail.com',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: menuStructure.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final it = entry.value;
                  final String label = it['label'] as String;
                  final IconData? icon = it['icon'] as IconData?;
                  final String? route = it['route'] as String?;
                  final List<Map<String, dynamic>>? children =
                      it['children'] as List<Map<String, dynamic>>?;

                  final bool hasActiveChild =
                      children != null &&
                      children.any((c) {
                        if ((c['route'] as String?) == currentRoute)
                          return true;
                        final sub =
                            c['children'] as List<Map<String, dynamic>>?;
                        return sub != null &&
                            sub.any(
                              (s) => (s['route'] as String?) == currentRoute,
                            );
                      });

                  if (children != null && children.isNotEmpty) {
                    final bool userInteracted = _openIndex != null;
                    final bool initiallyExpanded = userInteracted
                        ? (_openIndex == idx)
                        : (activeOpenIndex == idx || hasActiveChild);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: initiallyExpanded
                            ? kPrimaryBlue.withOpacity(0.04)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: initiallyExpanded
                            ? Border.all(
                                color: kPrimaryBlue.withOpacity(0.2),
                                width: 1,
                              )
                            : null,
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          splashColor: kPrimaryBlue.withOpacity(0.08),
                          highlightColor: kPrimaryBlue.withOpacity(0.03),
                        ),
                        child: ExpansionTile(
                          // include _openIndex in the key so tiles rebuild when user
                          // opens a different top-level tile -> closes previous ones
                          key: ValueKey('exp_${idx}_${_openIndex ?? -1}'),
                          initiallyExpanded: initiallyExpanded,
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          childrenPadding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 8,
                            top: 4,
                          ),
                          leading: icon != null
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: initiallyExpanded
                                        ? kPrimaryBlue.withOpacity(0.12)
                                        : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    icon,
                                    color: initiallyExpanded
                                        ? kPrimaryBlue
                                        : Colors.black54,
                                    size: 20,
                                  ),
                                )
                              : null,
                          title: Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: initiallyExpanded
                                  ? kPrimaryBlue
                                  : Colors.black87,
                            ),
                          ),
                          trailing: AnimatedRotation(
                            turns: initiallyExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubic,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: initiallyExpanded
                                    ? kPrimaryBlue.withOpacity(0.1)
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: initiallyExpanded
                                    ? kPrimaryBlue
                                    : Colors.black54,
                                size: 24,
                              ),
                            ),
                          ),
                          children: _buildSubMenuItems(
                            children,
                            context,
                            currentRoute,
                          ),
                          onExpansionChanged: (open) {
                            setState(() {
                              _openIndex = open ? idx : null;
                            });
                          },
                        ),
                      ),
                    );
                  }

                  final bool isActive = route != null && route == currentRoute;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        if (route != null) Navigator.pushNamed(context, route);
                      },
                      borderRadius: BorderRadius.circular(8),
                      splashColor: kPrimaryBlue.withOpacity(0.1),
                      highlightColor: kPrimaryBlue.withOpacity(0.05),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? kPrimaryBlue.withOpacity(0.1)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          border: isActive
                              ? Border.all(
                                  color: kPrimaryBlue.withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            if (icon != null) ...[
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? kPrimaryBlue.withOpacity(0.15)
                                      : Colors.grey.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  icon,
                                  color: isActive
                                      ? kPrimaryBlue
                                      : Colors.black54,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: isActive
                                      ? kPrimaryBlue
                                      : Colors.black87,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text('Logout'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryBlue,
                        side: BorderSide(color: kPrimaryBlue.withOpacity(0.2)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
