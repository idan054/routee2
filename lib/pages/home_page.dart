import 'dart:convert';
import 'dart:math';
import 'package:around/common/database.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../common/assets.gen.dart';
import '../common/constants.dart';
import '../common/models/address_result.dart';
import '../common/models/event_category.dart';
import '../common/models/event_item.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'category_page.dart';
import 'dart:math' as math; // import this
import 'create_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isShowLastedEvents = true;
  ScrollController tagsController = ScrollController();
  List<EventItem> events = [];
  List<String> titlesExist = [];
  UserData? user;
  bool splashLoad = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // tagsController.jumpTo(9999.0);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // tagsController.jumpTo(9999.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (mounted)
      setUserData();
    });
    super.didChangeDependencies();
  }

  void setUserData() async {
    var box = Hive.box('uniBox');
    var userAge = box.get('userAge');
    var userAddress = box.get('userAddress');
    print('appVersion: $appVersion');
    print('userAge: $userAge');
    print('userAddress: $userAddress');

    if (userAge == null || userAddress == null) {
      showUpdateDetailsDialog(
        context,
        onConfirm: (UserData? userData) {
          _onUpdateUserInfo(userData);
        },
      );
    } else {
      var jsonData = Map<String, dynamic>.from(userAddress);
      user = UserData(userAge, AddressResult.fromJson(jsonData));
      fetchEvents();
    }
  }

  void _onUpdateUserInfo(UserData? userData, {bool withLoader = false}) {
    if (userData != null) {
      print('userData ${userData.age}');
      print('userData ${userData.address?.name}');
      user = userData;
    }
    fetchEvents(withLoader: withLoader);
    // setState(() {});
  }

  void fetchEvents({bool withLoader = false}) async {
    if (withLoader) {
      splashLoad = true;
      setState(() {});
    }
    events = await FsAdvanced.getHomeEvents(user?.age ?? 0);

    // events = sortByDistance(events, user!);
    events = sortByType(events, user!);
    splashLoad = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    titlesExist = [];
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    if (user == null) const Scaffold(backgroundColor: bgColor);
    if (events.isEmpty && !splashLoad) {
      const Scaffold(backgroundColor: bgColor);
    } // App init

    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildHomeAppBar(),
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: bgColorDark,
        onRefresh: () async => fetchEvents(),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 15),
                buildHomeTitle(context),
                const SizedBox(height: 15),
                buildTagsRow(),
                events.isEmpty && !splashLoad
                    ? 'אין קבוצות לגלאי ${user?.age} ב${user?.address?.name}. צור קבוצה חדשה!'
                        .toText()
                        .center
                        .pOnly(top: 200)
                    : ListView.builder(
                        // reverse: true,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, i) {
                          // bool isShowTitle = (i ~/ 3) == (i / 3); // AKA Every 4 posts.

                          bool isAddTitle = true;
                          var categoryTitle = events[i].eventCategory?.categoryType?.name;
                          if (titlesExist.contains(categoryTitle)) {
                            isAddTitle = false;
                          } else {
                            titlesExist.add('$categoryTitle');
                          }

                          return Column(
                            children: [
                              if (isAddTitle) buildCategoryTitle(events[i]),
                              buildEventCard(context, events[i]).px(5),
                            ],
                          );
                        },
                      ),
                const SizedBox(height: 10),
                if (events.isEmpty && !splashLoad) const SizedBox(height: 300),
                if (!splashLoad)
                  'גרסא $appVersion'.toText(color: Colors.grey, fontSize: 12).center,
                const SizedBox(height: 5),
              ],
            ),
            if (splashLoad)
              Card(
                      color: bgColorDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const CircularProgressIndicator().pad(15))
                  .sizedBox(70, 70)
                  .center,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.symmetric(horizontal: 3),
        backgroundColor: bgColorDark,
        label: Row(
          children: [
            Assets.addOnlyWhite.image(height: 42).roundedFull,
            'קבוצה חדשה'.toText(bold: true).pOnly(left: 10).offset(5, 0),
          ],
        ),
        onPressed: () {
          _handleCreateEvent();
        },
      ).rtl,
    );
  }

  AppBar buildHomeAppBar() {
    return AppBar(
      // backgroundColor: bgColor,
      backgroundColor: bgColorDark,
      // backgroundColor: Colors.white70,
      elevation: 3,
      title: Row(
        children: [
          aroundLogo().pOnly(right: 7, left: 0),
          if (adminMode) 'Admin'.toText(fontSize: 12, medium: true).offset(0, 2),
          const Spacer(),
          'קבוצות מסביבך'.toText(bold: true, fontSize: 18),
        ],
      ).py(5).onTap(() {
        _showAdminDialog(context);
      }, longPressMode: true, radius: 5),
    );
  }

  Future<void> _showAdminDialog(
    BuildContext context,
  ) async {
    var passController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: 'האם למחוק את האירוע'.toText(bold: true),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                'יש להזין סיסמת מנהל בת 4 ספרות:'.toText(bold: true),
                TextField(
                  controller: passController,
                  keyboardType: TextInputType.number,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: 'מצב מנהל'.toText(bold: true, color: Colors.purple),
              onPressed: () {
                if (passController.text == '2003') {
                  adminMode = true;
                  setState(() {});
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: 'ביטול'.toText(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Column buildHomeTitle(BuildContext context) {
    // 'קבוצות שהזמינו אותך להצטרף אליהם (:'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
    // 'הזמנות קרובות אלייך לבני גיל 19'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
    // 'הזמנות לקבוצות עבורך'.toText(fontSize: 16),
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     // (isShowLastedEvents
        //     //         // ? 'קבוצות עדכניות אליהם הזמינו אותך'
        //     //         // ? 'קבוצות עדכניות בשבילך'
        //     //         // : 'קבוצות קרובות בשבילך')
        //     //         ? 'כל הקבוצות העדכניות בשבילך'
        //     //         : 'כל הקבוצות הקרובות בשבילך')
        //     'כל הקבוצות מסביבך'
        //         .toText(fontSize: 18, color: Colors.black, bold: true)
        //         .pOnly(right: 15),
        //     // .pOnly(right: 5),
        //     // (isShowLastedEvents ? Icons.schedule : Icons.place_outlined)
        //     //     .icon(color: Colors.black, size: 20).pOnly(right: 12),
        //   ],
        // ),
        Row(
          children: [
            'עדכון'
                .toText(fontSize: 12, color: Colors.black54, bold: false, underline: true)
                .px(15)
                .onTap(() {
              showUpdateDetailsDialog(
                context,
                fromUpdateButton: true,
                user: user,
                onConfirm: (UserData? userData) {
                  _onUpdateUserInfo(userData, withLoader: true);
                },
              );
            }),
            const Spacer(),
            if (user != null)
              'לגלאי ${user?.age}, באיזור ${user?.address?.name}'
                  .toText(fontSize: 14, color: Colors.black54, medium: true)
                  .px(15),
          ],
        ).px(7),
      ],
    );
  }

  Widget buildTagsRow() {
    int? sValue;
    // int? catIndex;
    EventCategory? selectedCategory;

    return SizedBox(
      // height: 50,
      child: Wrap(
        textDirection: TextDirection.rtl,
        runSpacing: 10, // up / down
        spacing: 5, // Left / right
        // scrollDirection: Axis.horizontal,
        // reverse: true,
        children: [
          // const SizedBox(width: 5),
          ...List<Widget>.generate(
            categories.length,
            (int i) {
              var cat = categories[i];
              return ChoiceChip(
                elevation: 1,
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                // labelPadding: const EdgeInsets.only(left: 7.5),
                // avatar:
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(backgroundColor: cat.categoryColor, radius: 3),
                    const SizedBox(width: 6),
                    '${cat.categoryName}'
                        .toText(fontSize: 13, medium: false, color: Colors.black),
                  ],
                ),
                // side: BorderSide(color: cat.categoryColor!, width: 2),
                selected: sValue == i,
                // backgroundColor: bgColor,
                backgroundColor: Colors.white,
                selectedColor: cat.categoryColor!,
                onSelected: (bool selected) {
                  // sValue = selected ? i : null;
                  selectedCategory = cat;
                  // setState(() {});
                  _handleGoToCategory(null, null, eventCategory: selectedCategory);
                },
              )
                  .sizedBox(null, 30)
                  // .px(3.5)
                  .rtl;
            },
          ).toList(),
          // const SizedBox(width: 5),
        ],
      ).px(15),
    );
  }

  Widget buildCategoryTitle(EventItem eventItem) {
    // var color = i < categoryColors.length
    //     ? categoryColors[i]
    //     : categoryColors[Random().nextInt(categoryColors.length)];

    var category = categories.firstWhereOrNull((cat) =>
            cat.categoryType?.name == eventItem.eventCategory?.categoryType?.name) ??
        eventItem.eventCategory;

    return Row(
      children: [
        const SizedBox(height: 50),
        Icons.keyboard_double_arrow_left.icon(color: Colors.black),
        const SizedBox(width: 5),
        // 'עוד'.toText(fontSize: 12.0, color: color, bold: true),
        const Spacer(),
        '${category?.categoryName}'
            // .toText(color: color, fontSize: 15, bold: true)
            .toText(fontSize: 15, bold: true)
            .centerRight,
        const SizedBox(width: 7),
        CircleAvatar(backgroundColor: category?.categoryColor, radius: 3).pOnly(top: 5)
      ],
    ).px(15).onTap(() {
      _handleGoToCategory(null, null, eventCategory: category);
    });
  }

  void _handleGoToCategory(int? i, Color? color, {EventCategory? eventCategory}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoryPage(
              user!, eventCategory ?? categories[i!].copyWith(categoryColor: color))),
    );
  }

  void _handleCreateEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePage()),
    );
  }
}

Widget aroundLogo() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      'Ar'.toText(bold: true, fontSize: 20, color: wtspGreen), // .offset(4, 0),
      // Assets.wtspLocationGroupIcon.image(height: 30).offset(0, 1),
      Assets.wtspLocationGroupIconSolid.image(height: 22).px(1).offset(0, 1),
      // const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
      'und'.toText(bold: true, fontSize: 20, color: wtspGreen), // .offset(-2, 0),
    ],
  ).ltr;
  // .sizedBox(100, null);
}
