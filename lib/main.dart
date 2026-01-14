import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vendor_application/features/splash_screen/splash_screen.dart';
import 'package:vendor_application/theme/values.dart';

void main() async {
  try {
    // var path = Directory.current.path;
    // Hive.init(path);
    // Hive.registerAdapter(VendorAdapter());
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    await Hive.openBox(Values.dbName);
  } catch (e) {
    logger.i('Exception details:\n $e');
  }

  runApp(const MainApp());
}

class VendorAdapter {}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        fontFamily: "Roboto",
      ),
      home: const SplashScreen(title: 'Vendoors'),
    );
  }
}
