import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/app_settings.dart';
import '../utils/responsive.dart';

class AppearancePopup extends StatefulWidget {
  final Rect triggerRect;
  const AppearancePopup({super.key, required this.triggerRect});

  @override
  State<AppearancePopup> createState() => _AppearancePopupState();
}

class _AppearancePopupState extends State<AppearancePopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // Bouncy effect like iOS
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLargeScreen = Responsive.isTabletOrLarger(context);

    final double menuWidth = isLargeScreen ? 280.0 : 250.0;
    final rowCenter = widget.triggerRect.center;
    final leftPos = rowCenter.dx - (menuWidth / 2);
    final topPos = widget.triggerRect.top - (isLargeScreen ? 70 : 60);
    final borderRadius = isLargeScreen ? 24.0 : 20.0;

    return Stack(
      children: [
        // Dismiss tap
        Positioned.fill(
          child: GestureDetector(
            onTap: () async {
              await _controller.reverse();
              if (context.mounted) Navigator.pop(context);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(color: Colors.transparent),
          ),
        ),

        Positioned(
          top: topPos,
          left: leftPos,
          child: ScaleTransition(
            scale: _scaleAnimation,
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      width: menuWidth,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1C1C1E).withValues(alpha: 0.8) : const Color(0xFFF2F2F7).withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(borderRadius),
                        border: Border.all(
                          color: isDark ? Colors.white.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 40,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildOption(context, settings, ThemeMode.system, "System", isDark, isLargeScreen, isFirst: true),
                          Divider(height: 1, thickness: 1, color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.2)),
                          _buildOption(context, settings, ThemeMode.light, "Light", isDark, isLargeScreen),
                          Divider(height: 1, thickness: 1, color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.2)),
                          _buildOption(context, settings, ThemeMode.dark, "Dark", isDark, isLargeScreen, isLast: true),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(BuildContext context, AppSettings settings, ThemeMode mode, String label, bool isDark, bool isLargeScreen, {bool isFirst = false, bool isLast = false}) {
    final isSelected = settings.themeMode == mode;
    final textColor = isDark ? Colors.white : Colors.black;
    final borderRadius = isLargeScreen ? 24.0 : 20.0;
    final fontSize = isLargeScreen ? 18.0 : 17.0;
    final padding = isLargeScreen ? 18.0 : 16.0;
    final iconSize = isLargeScreen ? 22.0 : 20.0;

    return InkWell(
      onTap: () async {
        settings.themeMode = mode;
        await Future.delayed(const Duration(milliseconds: 150));
        await _controller.reverse();
        if (context.mounted) Navigator.pop(context);
      },
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(borderRadius) : Radius.zero,
        bottom: isLast ? Radius.circular(borderRadius) : Radius.zero,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: Row(
          children: [
            SizedBox(
              width: isLargeScreen ? 28 : 24,
              child: isSelected
                  ? Icon(Icons.check, color: textColor, size: iconSize)
                  : null,
            ),
            SizedBox(width: isLargeScreen ? 14 : 12),
            Text(
              label,
              style: GoogleFonts.outfit(
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
