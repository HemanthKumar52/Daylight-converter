import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive.dart';
import 'bouncing_button.dart';

class GlassBottomSheet extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;
  final VoidCallback? onAdd;
  final Widget child;
  final bool expandContent;

  final bool isFullScreen;

  const GlassBottomSheet({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
    this.onAdd,
    required this.child,
    this.expandContent = false,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLargeScreen = Responsive.isTabletOrLarger(context);

    // Define semi-transparent colors for glass effect
    final glassColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1C1C1E).withValues(alpha: 0.7) // Dark Glass
        : const Color(0xFFF2F2F7).withValues(alpha: 0.65); // Light Glass

    // Define solid colors for full screen mode
    final solidColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;

    final backgroundColor = isFullScreen ? solidColor : glassColor;

    // Responsive padding and sizing
    final horizontalPadding = isLargeScreen ? 24.0 : 12.0;
    final titleFontSize = isLargeScreen ? 19.0 : 17.0;
    final actionFontSize = isLargeScreen ? 16.0 : 15.0;

    Widget sheetContent = ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          clipBehavior: Clip.none,
          child: Column(
            mainAxisSize: expandContent ? MainAxisSize.max : MainAxisSize.min,
            children: [
              // Header
              Stack(
                alignment: Alignment.center,
                children: [
                  // Handle Bar
                  Container(
                    width: 36,
                    height: 5,
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey.withValues(alpha: 0.3)
                          : Colors.grey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 4, horizontalPadding, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Centered Title
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // Right-aligned Actions using Positioned
                      Positioned(
                        right: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (onAdd != null) ...[
                              BouncingButton(
                                onTap: onAdd!,
                                child: Icon(
                                  Icons.add,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  size: isLargeScreen ? 32 : 28,
                                ),
                              ),
                              SizedBox(width: isLargeScreen ? 24 : 20),
                            ],
                            if (actionText != null) ...[
                              BouncingButton(
                                onTap: onAction!,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isLargeScreen ? 18 : 14,
                                      vertical: isLargeScreen ? 10 : 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.1)
                                          : Colors.black.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(
                                        color: isDark
                                            ? Colors.white.withValues(alpha: 0.2)
                                            : Colors.black.withValues(alpha: 0.15),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      actionText!,
                                      style: GoogleFonts.outfit(
                                        color: isDark ? Colors.white : Colors.black,
                                        fontSize: actionFontSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              expandContent ? Expanded(child: child) : Flexible(child: child),
            ],
          ),
        ),
      ),
    );

    // On large screens, center the sheet with max width
    if (isLargeScreen) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxSheetWidth,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              MediaQuery.of(context).padding.top + 24,
              horizontalPadding,
              MediaQuery.of(context).padding.bottom + 24,
            ),
            child: sheetContent,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.of(context).padding.top + 12,
        12,
        MediaQuery.of(context).padding.bottom + 4,
      ),
      child: sheetContent,
    );
  }
}
