import 'package:around/common/constants.dart';
import 'package:around/common/widget_ext.dart';
import 'package:around/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // path_provider no need on web
  if (!kIsWeb) {
    final dbDir = await getApplicationDocumentsDirectory();
    Hive.init(dbDir.path);
  }
  await Hive.openBox('uniBox');
  await initializeDateFormatting('he_IL', null);
  print('kIsWeb: $kIsWeb kDebugMode: $kDebugMode');
  // if (kDebugMode) await Hive.box('uniBox').clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        double width = size.maxWidth;

        if (size.maxWidth < 700) {
          // Mobile
          return materialApp;
        } else {
          // Web
          return Container(
            color: bgColorLight,
            child: materialApp.px(width * 0.25),
          );
        }
      },
    );
  }
}

Widget get materialApp => MaterialApp(
    locale: const Locale('he'),
    title: 'Around',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.purple),
    home: const MyHomePage());
