import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhomepage/l10n/l10n.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required String path,
    required IconData icon,
    required String currentPath,
  }) {
    final isSelected = currentPath == path;
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.of(context).pop(); // ドロワーを閉じる
        if (currentPath == path) return;
        context.go(path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final currentPath = GoRouterState.of(context).uri.path;
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Kishi",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Portfolio",
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          _buildDrawerItem(
            context: context,
            title: l10n.titleA,
            path: '/home',
            icon: Icons.person_outline,
            currentPath: currentPath,
          ),
          _buildDrawerItem(
            context: context,
            title: l10n.titleB,
            path: '/study',
            icon: Icons.school_outlined,
            currentPath: currentPath,
          ),
          _buildDrawerItem(
            context: context,
            title: l10n.titleC,
            path: '/works',
            icon: Icons.grid_view_outlined,
            currentPath: currentPath,
          ),
          _buildDrawerItem(
            context: context,
            title: l10n.titleD,
            path: '/others',
            icon: Icons.category_outlined,
            currentPath: currentPath,
          ),
        ],
      ),
    );
  }
}
