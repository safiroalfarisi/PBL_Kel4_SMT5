import 'package:flutter/material.dart';
import '../theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback onMenuPressed;
  final VoidCallback? onFilterPressed;
  final bool hasActiveFilter;
  final bool showFilter;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onMenuPressed,
    this.onFilterPressed,
    this.hasActiveFilter = false,
    this.showFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryBlue,
      foregroundColor: Colors.white,
      elevation: 2,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      title: Row(
        children: [
          // Menu Button tanpa kotak
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Title Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Button tanpa kotak (hanya tampil jika showFilter true)
          if (showFilter && onFilterPressed != null)
            Stack(
              children: [
                IconButton(
                  onPressed: onFilterPressed,
                  icon: const Icon(
                    Icons.filter_alt,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                if (hasActiveFilter)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}