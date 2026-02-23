import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/timezone_store.dart';
import '../utils/responsive.dart';

class EditListScreen extends StatelessWidget {
  const EditListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<TimeZoneStore>(context);
    final isLargeScreen = Responsive.isTabletOrLarger(context);
    final titleFontSize = isLargeScreen ? 18.0 : 16.0;
    final subtitleFontSize = isLargeScreen ? 15.0 : 14.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit List", style: TextStyle(fontSize: isLargeScreen ? 20 : 18)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Done", style: TextStyle(color: const Color(0xFFFF9900), fontSize: isLargeScreen ? 17 : 15)),
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.maxSheetWidth),
          child: ReorderableListView.builder(
            padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 24 : 16),
            itemCount: store.timeZones.length,
            itemBuilder: (context, index) {
              final tz = store.timeZones[index];
              return ListTile(
                key: ValueKey(tz.id),
                leading: tz.isHome
                    ? Icon(Icons.home, color: const Color(0xFFFF9900), size: isLargeScreen ? 28 : 24)
                    : Icon(Icons.drag_handle, color: Colors.transparent, size: isLargeScreen ? 28 : 24),
                title: Text(tz.cityName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)),
                subtitle: Text(tz.abbreviation, style: TextStyle(fontSize: subtitleFontSize)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!tz.isHome)
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red, size: isLargeScreen ? 26 : 24),
                        onPressed: () {
                          store.removeTimeZone(tz);
                        },
                      ),
                  ],
                ),
                onTap: () {},
              );
            },
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final item = store.timeZones.removeAt(oldIndex);
              store.timeZones.insert(newIndex, item);
              store.saveAfterReorder();
            },
          ),
        ),
      ),
    );
  }
}
