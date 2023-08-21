import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routee/common/constants.dart';
import 'package:routee/common/widget_ext.dart';
import 'package:routee/pages/create_page.dart';
import 'package:routee/pages/home_page.dart';

import 'common/database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseAnalytics.instance.logAppOpen();
  mixpanel =
      await Mixpanel.init('5def6b5a71bef4c9d148132ff4bcead2', trackAutomaticEvents: true);

  // path_provider no need on web
  if (!kIsWeb) {
    final dbDir = await getApplicationDocumentsDirectory();
    Hive.init(dbDir.path);
  }
  await Hive.openBox('uniBox');
  await initializeDateFormatting('he_IL', null);
  print('kIsWeb: $kIsWeb kDebugMode: $kDebugMode');
  // if (kDebugMode) await Hive.box('uniBox').clear();
  printTrackEvent(kDebugMode ? 'Debug Session start' : 'Live Session start');
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
          return buildMaterialApp(home: const MyHomePage());
        } else {
          // Web
          return Container(
            color: bgColorDark,
            child: buildMaterialApp(
                home: Scaffold(
              backgroundColor: bgColor,
              appBar: buildHomeAppBar(),
              body: Row(
                children: [
                  const MyHomePage(showAppBar: false).expanded(),
                  const CreatePage(showAppBar: false).expanded()
                  // MyHomePage().expanded(),
                ],
              ).px(width * 0.15),
            )),
          );
        }
      },
    );
  }
}

Widget buildMaterialApp({required Widget home}) => MaterialApp(
      locale: const Locale('he'),
      title: 'Around',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: home,
    );
