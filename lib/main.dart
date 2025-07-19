import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/milk_provider.dart';
import 'utils/hive_boxes.dart';
import 'models/milk_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(MilkEntryAdapter());
  await Hive.openBox<MilkEntry>(milkBoxName);
  await Hive.openBox<double>('settings');

  runApp(const MilkTrackerApp());
}

class MilkTrackerApp extends StatelessWidget {
  const MilkTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MilkProvider(),
      child: MaterialApp(
        title: 'Milk Tracker',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}