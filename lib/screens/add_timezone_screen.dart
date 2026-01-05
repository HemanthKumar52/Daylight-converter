import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/timezone_store.dart';
import '../models/timezone_item.dart';
import '../models/available_timezones.dart';
import '../utils/theme_colors.dart';

class AddTimeZoneScreen extends StatefulWidget {
  const AddTimeZoneScreen({super.key});

  @override
  State<AddTimeZoneScreen> createState() => _AddTimeZoneScreenState();
}

class _AddTimeZoneScreenState extends State<AddTimeZoneScreen> {
  String searchText = "";
  final TextEditingController _searchController = TextEditingController();

  List<AvailableTimeZone> get filteredTimeZones {
    if (searchText.isEmpty) {
      return AvailableTimeZone.all;
    }
    return AvailableTimeZone.all.where((tz) {
      return tz.cityName.toLowerCase().contains(searchText.toLowerCase()) ||
          tz.abbreviation.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  bool isAlreadyAdded(TimeZoneStore store, AvailableTimeZone tz) {
    return store.timeZones.any((item) => item.cityName == tz.cityName);
  }

  void addTimeZone(BuildContext context, AvailableTimeZone tz) {
    final store = Provider.of<TimeZoneStore>(context, listen: false);
    final newItem = TimeZoneItem(
      identifier: tz.identifier,
      cityName: tz.cityName,
      abbreviation: tz.abbreviation,
      isHome: false,
    );
    store.addTimeZone(newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // We want the theme for the list, generally following system or app setting
    // But since this is a modal, it inherits from app usually.
    // Let's use standard scaffold.
    final store = Provider.of<TimeZoneStore>(context);
    
    // We can access brightness from Theme.of(context) if set up correctly in main
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Timezone"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0, 
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Done", style: TextStyle(color: Color(0xFFFF9900))),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search cities",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? const Color(0xFF1C1C1D) : const Color(0xFFE5E5EA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTimeZones.length,
              itemBuilder: (context, index) {
                final tz = filteredTimeZones[index];
                final added = isAlreadyAdded(store, tz);
                
                return ListTile(
                  title: Text(tz.cityName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(tz.abbreviation, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                  trailing: added 
                      ? const Icon(Icons.check_circle, color: Color(0xFFFF9900)) 
                      : null,
                  onTap: added ? null : () => addTimeZone(context, tz),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
