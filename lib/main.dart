import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:recrutment_blueray/app/binding.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Abaikan log error tertentu
    if (details.exceptionAsString().contains('Failed host lookup')) {
      // Hanya log pesan khusus
      log.d('Failed host lookup: ${details.exceptionAsString()}');
    } else {
      // Tampilkan error lainnya seperti biasa
      FlutterError.dumpErrorToConsole(details);
    }
  };
  //untuk hit api
  HttpOverrides.global = MyHttpOverrides();

  //ini untuk function asychronus
  WidgetsFlutterBinding.ensureInitialized();

  //inisiasi tanggal
  await initializeDateFormatting('id_ID', null);
  
  await dotenv.load(fileName: '.env');
  await StorageProvider.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: 'Recrutment Blueray',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: GlobalBindings(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Constants.get.primaryColor,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
