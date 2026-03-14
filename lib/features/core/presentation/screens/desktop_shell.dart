import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DesktopShell extends StatefulWidget {
  final Widget child;
  
  const DesktopShell({super.key, required this.child});

  @override
  State<DesktopShell> createState() => _DesktopShellState();
}

class _DesktopShellState extends State<DesktopShell> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/new_project');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/'); // Using dashboard for "My Projects" for now
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine active index based on route, though manual tracking could work
    final route = ModalRoute.of(context)?.settings.name;
    if (route == '/') _selectedIndex = 0;
    if (route == '/new_project') _selectedIndex = 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(
            child: Column(
              children: [
                _buildTopAppBar(context),
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 72,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          right: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _sidebarIcon(Icons.grid_view_rounded, isSelected: _selectedIndex == 0, onTap: () => _onItemTapped(0)),
          const SizedBox(height: 24),
          _sidebarIcon(Icons.add_box, isSelected: _selectedIndex == 1, onTap: () => _onItemTapped(1)),
          const SizedBox(height: 24),
          _sidebarIcon(Icons.folder, isSelected: _selectedIndex == 2, onTap: () => _onItemTapped(2)),
          const SizedBox(height: 24),
          _sidebarIcon(Icons.ondemand_video, onTap: () => Navigator.pushNamed(context, '/preview')),
          const Spacer(),
          _sidebarIcon(Icons.settings),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sidebarIcon(IconData icon, {bool isSelected = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceLight : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          const Text(
            "GenMobi.Studio",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 24),
          _headerTextBtn("Project Selector", Icons.keyboard_arrow_down),
          const Spacer(),
          // Search bar
          Container(
            width: 360,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 12),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search architecture, modules, or logs...",
                      hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.help, color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/prompt_panel'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent.withOpacity(0.2),
                foregroundColor: AppColors.accent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text(
                "Generate App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceLight,
            child: Icon(Icons.person, size: 20, color: AppColors.accent),
          ),
        ],
      ),
    );
  }

  Widget _headerTextBtn(String text, IconData icon) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(icon, size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
