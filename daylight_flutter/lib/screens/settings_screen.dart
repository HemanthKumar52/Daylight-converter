import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_settings.dart';
import '../utils/responsive.dart';
import 'appearance_popup.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  
  final GlobalKey _appearanceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLargeScreen = Responsive.isTabletOrLarger(context);
    // Matching the glass container from Image
    final cardColor = isDark ? Colors.white.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.5);

    final horizontalPadding = isLargeScreen ? 24.0 : 16.0;
    final titleFontSize = isLargeScreen ? 18.0 : 17.0;
    final descFontSize = isLargeScreen ? 15.0 : 14.0;

    return Theme(
      data: Theme.of(context),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 40 + MediaQuery.of(context).padding.bottom),
        children: [
          // Theme Section
          _buildSectionHeader(context, "Theme"),

          Container(
            key: _appearanceKey,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              title: Text(
                  "Appearance",
                  style: GoogleFonts.outfit(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w400
                  )
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                     _getThemeLabel(settings.themeMode),
                     style: GoogleFonts.outfit(
                       color: isDark ? Colors.white.withValues(alpha: 0.6) : Colors.black.withValues(alpha: 0.6),
                       fontSize: titleFontSize,
                       fontWeight: FontWeight.w400,
                     ),
                   ),
                   const SizedBox(width: 4),
                   Icon(
                     Icons.unfold_more,
                     color: isDark ? Colors.white.withValues(alpha: 0.6) : Colors.black.withValues(alpha: 0.6),
                     size: isLargeScreen ? 18 : 16,
                   ),
                ],
              ),
              onTap: () {
                 final RenderBox renderBox = _appearanceKey.currentContext!.findRenderObject() as RenderBox;
                 final offset = renderBox.localToGlobal(Offset.zero);
                 final rect = offset & renderBox.size;

                 Navigator.of(context).push(
                   PageRouteBuilder(
                     opaque: false,
                     transitionDuration: const Duration(milliseconds: 300),
                     reverseTransitionDuration: const Duration(milliseconds: 200),
                     barrierColor: Colors.transparent,
                     pageBuilder: (context, animation, secondaryAnimation) => AppearancePopup(triggerRect: rect),
                   ),
                 );
              },
            ),
          ),

          // Display Section
          _buildSectionHeader(context, "Display"),

          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: SwitchListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              title: Text("Show Center Line", style: GoogleFonts.outfit(color: isDark ? Colors.white : Colors.black, fontSize: titleFontSize, fontWeight: FontWeight.normal)),
              value: settings.showCenterLine,
              onChanged: (bool value) {
                settings.showCenterLine = value;
              },
              activeThumbColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 8.0, left: horizontalPadding + 4, right: horizontalPadding + 4),
            child: Text(
              "Shows a vertical line at the center of timezone cards to indicate current time position",
              style: GoogleFonts.outfit(
                  color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.6),
                  fontSize: descFontSize,
                  height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.6),
          fontSize: 14,
          fontWeight: FontWeight.w400, 
        ),
      ),
    );
  }

  String _getThemeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return "System";
      case ThemeMode.light: return "Light";
      case ThemeMode.dark: return "Dark";
    }
  }
}
