import 'dart:html' as html;

import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
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
      await Mixpanel.init('5664c39fdf1da3a6f3e3ff3d716ebcfc', trackAutomaticEvents: true);

  // final remoteConfig = FirebaseRemoteConfig.instance;
  // await remoteConfig.ensureInitialized();
  // await remoteConfig.setConfigSettings(
  //     RemoteConfigSettings(fetchTimeout: 1.minutes, minimumFetchInterval: 1.minutes));
  // await remoteConfig.fetchAndActivate();

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
    return MaterialApp(
      locale: const Locale('he'),
      title: 'Routee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void didChangeDependencies() {
    _isAdminMode();
    super.didChangeDependencies();
  }

  void _isAdminMode() async {
    print('START: _isAdminMode()');

    String hash = html.window.location.href.split('?').last;
    print('hash $hash');
    Uri uri = Uri.parse('http://Whatever/?$hash');
    Map<String?, String?> queryParams = uri.queryParameters;
    print('queryParams ${queryParams}');

    // final remoteConfig = FirebaseRemoteConfig.instance;
    // final adminPass = remoteConfig.getString('admin_password');

    final queryAdminPass = queryParams['admin_password'].toString();
    var box = Hive.box('uniBox');
    adminModeV2 = box.get('adminMode') ?? kDebugMode || (queryAdminPass == '180218');
    if (adminModeV2) box.put('adminMode', true);
    print('adminModeV2 $adminModeV2');
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> webWidgets = [
      const MyHomePage(showAppBar: false),
      const SizedBox(width: 15),
      const CreatePage(showAppBar: false),
    ];

    return kIsWeb

        // WEB MODE:
        ? Scaffold(
            backgroundColor: bgColor,
            appBar: buildHomeAppBar(context),
            body: LayoutBuilder(builder: (context, size) {
              double width = size.maxWidth;
              if (size.maxWidth < 600) {
                return ListView(
                  children: [
                    if (adminModeV2) webWidgets[2],
                    webWidgets[1],
                    webWidgets[0],
                  ],
                );
              } else {
                // Wide
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    webWidgets[0].expanded(flex: 60),
                    webWidgets[1],
                    if (adminModeV2) webWidgets[2].expanded(flex: 40),
                  ],
                ).px(width < 1000 ? 0 : width * 0.15);
              }
            }),
          )

        // APP MODE:
        : const MyHomePage();
  }
}
