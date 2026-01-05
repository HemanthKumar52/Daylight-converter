import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/timezone_store.dart';
import '../models/timezone_item.dart';
import '../utils/app_settings.dart';
import '../utils/theme_colors.dart';
import '../widgets/timezone_card.dart';
import '../widgets/time_slider.dart';
import 'add_timezone_screen.dart';
import 'edit_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double hourOffset = 0;

  TimeZoneItem? get homeTimeZone {
    final store = Provider.of<TimeZoneStore>(context, listen: false);
    try {
      return store.timeZones.firstWhere((element) => element.isHome);
    } catch (e) {
      if (store.timeZones.isNotEmpty) return store.timeZones.first;
      return null;
    }
  }

  List<TimeZoneItem> get sortedTimeZones {
    final store = Provider.of<TimeZoneStore>(context);
    final home = homeTimeZone;
    if (home == null) return store.timeZones;

    final homeOffset = home.secondsFromGMT;
    
    final sorted = List<TimeZoneItem>.from(store.timeZones);
    sorted.sort((a, b) {
       final offset1 = a.secondsFromGMT - homeOffset;
       final offset2 = b.secondsFromGMT - homeOffset;
       return offset1.compareTo(offset2);
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    // Determine brightness based on settings
    final brightness = settings.themeMode == ThemeMode.dark ? Brightness.dark : 
                       (settings.themeMode == ThemeMode.light ? Brightness.light : MediaQuery.of(context).platformBrightness);
                       
    final theme = ThemeColors(brightness);

    return Scaffold(
      backgroundColor: theme.background,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
             children: [
               // Header
               _buildHeader(theme, context),
               
               // List
               Expanded(
                 child: ListView.builder(
                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 180), // Bottom padding for slider
                   itemCount: sortedTimeZones.length,
                   itemBuilder: (context, index) {
                     final tzItem = sortedTimeZones[index];
                     return Padding(
                       padding: const EdgeInsets.only(bottom: 2),
                       child: TimeZoneCard(
                         timeZone: tzItem,
                         hourOffset: hourOffset,
                         homeTimeZone: homeTimeZone,
                         showCenterLine: settings.showCenterLine,
                         theme: theme,
                       ),
                     );
                   },
                 ),
               ),
             ],
          ),
          
          // Slider Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TimeSlider(
              hourOffset: hourOffset,
              onHourOffsetChanged: (val) {
                setState(() {
                  hourOffset = val;
                });
              },
              homeTimeZone: homeTimeZone,
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeColors theme, BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            Text(
              "Daylight",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900, // Black weight
                color: theme.headerText,
              ),
            ),
            const Spacer(),
            PopupMenuButton<String>(
               icon: Container(
                 width: 48, height: 48,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: theme.background == Colors.black ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.08),
                   border: Border.all(color: Colors.white.withOpacity(0.1)),
                   boxShadow: [
                     BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))
                   ],
                 ),
                 // Using a simple icon for brand since we don't have the image asset
                 child: Icon(Icons.wb_sunny_outlined, color: theme.headerText, size: 24),
               ),
               onSelected: (value) {
                 if (value == 'Add') {
                    showModalBottomSheet(
                      context: context, 
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (c) => const AddTimeZoneScreen()
                    );
                 } else if (value == 'Edit') {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (c) => const EditListScreen()
                    );
                 } else if (value == 'Settings') {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Full screen effect often used for settings
                      useSafeArea: true,
                      builder: (c) => const SettingsScreen()
                    );
                 }
               },
               itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                 const PopupMenuItem<String>(
                   value: 'Add',
                   child: ListTile(
                     leading: Icon(Icons.add),
                     title: Text('Add Timezone'),
                   ),
                 ),
                 const PopupMenuItem<String>(
                   value: 'Edit',
                   child: ListTile(
                     leading: Icon(Icons.edit),
                     title: Text('Edit List'),
                   ),
                 ),
                 const PopupMenuDivider(),
                 const PopupMenuItem<String>(
                   value: 'Settings',
                   child: ListTile(
                     leading: Icon(Icons.settings),
                     title: Text('Settings'),
                   ),
                 ),
               ],
            ),
          ],
        ),
      ),
    );
  }
}
