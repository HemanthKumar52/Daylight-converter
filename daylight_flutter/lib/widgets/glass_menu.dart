import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class GlassMenu extends StatelessWidget {
  final VoidCallback onAddTimeZone;
  final VoidCallback onSettings;

  const GlassMenu({
    super.key,
    required this.onAddTimeZone,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final isLargeScreen = Responsive.isTabletOrLarger(context);
    final menuWidth = isLargeScreen ? 260.0 : 220.0;
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Close when tapping outside
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Positioned menu (Top Right)
          Positioned(
            top: MediaQuery.of(context).padding.top + (isLargeScreen ? 70 : 60),
            right: horizontalPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isLargeScreen ? 24 : 20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  width: menuWidth,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1C1C1E).withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(isLargeScreen ? 24 : 20),
                    border: Border.all(
                      color: isDark ? Colors.white.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.4),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMenuItem(
                        context,
                        icon: CupertinoIcons.plus,
                        text: "Add Timezone",
                        onTap: () {
                          Navigator.pop(context);
                          onAddTimeZone();
                        },
                        textColor: textColor,
                        isLargeScreen: isLargeScreen,
                      ),
                      Divider(
                        height: 1,
                        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)
                      ),
                      _buildMenuItem(
                        context,
                        icon: CupertinoIcons.gear_alt,
                        text: "Settings",
                        onTap: () {
                          Navigator.pop(context);
                          onSettings();
                        },
                        textColor: textColor,
                        isLargeScreen: isLargeScreen,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color textColor,
    required bool isLargeScreen,
  }) {
    final iconSize = isLargeScreen ? 24.0 : 22.0;
    final fontSize = isLargeScreen ? 18.0 : 17.0;
    final padding = isLargeScreen ? 18.0 : 16.0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: Row(
          children: [
            Icon(icon, size: iconSize, color: textColor.withValues(alpha: 0.9)),
            SizedBox(width: isLargeScreen ? 16 : 14),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
