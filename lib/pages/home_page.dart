import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:routee/common/string_ext.dart';
import 'package:routee/common/widget_ext.dart';

import '../common/assets.gen.dart';
import '../common/constants.dart';
import '../common/database.dart';
import '../common/models/address_result.dart';
import '../common/models/event_category.dart';
import '../common/models/event_item.dart';
import '../main.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'create_page.dart';

class MyHomePage extends StatefulWidget {
  final bool showAppBar;

  const MyHomePage({this.showAppBar = true, Key? key}) : super(key: key);

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
  bool isShowAdminRequest = false;

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
      _setUserData();
    });
    super.didChangeDependencies();
  }

  void _setUserData() async {
    var box = Hive.box('uniBox');
    var userAge = box.get('userAge');
    var userAddress = box.get('userAddress');
    // adminMode = box.get('adminMode') ?? false;
    print('appVersion: $appVersion');
    print('userAge: $userAge');
    print('userAddress: $userAddress');

    if (userAge == null || userAddress == null) {
      _onUpdateUserInfo(null);
      // showUpdateDetailsDialog(
      //   context,
      //   onConfirm: (UserData? userData) {
      //     _onUpdateUserInfo(userData);
      //   },
      // );
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
    } else {
      final defaultUser = UserData(
          null,
          const AddressResult(
            name: 'תל אביב',
            lat: '32.0852999',
            placeId: 'ChIJH3w7GaZMHRURkD-WwKJy-8E',
            lng: '34.78176759999999',
          ));
      user = defaultUser;
    }
    fetchEvents(withLoader: withLoader);
    // setState(() {});
  }

  void fetchEvents({bool withLoader = false}) async {
    if (withLoader) {
      splashLoad = true;
      setState(() {});
    }
    events = await FsAdvanced.getHomeEvents();

    // events = [
    //   sampleEvent,
    //   sampleEvent,
    //   sampleEvent,
    // ];

    // events = sortByType(events, user!);
    splashLoad = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    titlesExist = [];
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    if (user == null) Scaffold(backgroundColor: bgColor);
    if (events.isEmpty && !splashLoad) {
      Scaffold(backgroundColor: bgColor);
    } // App init

    return widget.showAppBar
        ? Scaffold(
            backgroundColor: bgColor,
            appBar: widget.showAppBar
                ? buildHomeAppBar(context, onHoldTap: () {
                    // var box = Hive.box('uniBox');
                    // if (adminMode) {
                    //   adminMode = false;
                    //   box.put('adminMode', adminMode);
                    //   setState(() {});
                    // } else {
                    //   isShowAdminRequest = !isShowAdminRequest;
                    //   box.put('adminMode', isShowAdminRequest);
                    //   setState(() {});
                    // }
                  })
                : null,
            body: _body())
        : _body();
  }

  Widget _body() => RefreshIndicator(
        color: Colors.purple,
        backgroundColor: bgColorDark,
        onRefresh: () async => fetchEvents(),
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              physics: const ScrollPhysics(),
              children: [
                const SizedBox(height: 15),
                // buildHomeTitle(context, isShowAdminRequest),
                // const SizedBox(height: 15),
                // buildTagsRow(),
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
                          // not needed
                          // bool isShowTitle = (i ~/ 3) == (i / 3); // AKA Every 4 posts.

                          // needed
                          bool isAddTitle = true;
                          var categoryTitle = events[i].truckType;
                          if (titlesExist.contains(categoryTitle)) {
                            isAddTitle = false;
                          } else {
                            titlesExist.add('$categoryTitle');
                          }

                          return Column(
                            children: [
                              if (isAddTitle) buildCategoryTitle(events[i]),
                              buildEventCard(context, events[i], user!).px(5),
                            ],
                          );
                        },
                      ),
                const SizedBox(height: 10),
                if (events.isEmpty && !splashLoad) const SizedBox(height: 300),
                // if (!splashLoad)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 'צור קשר'
                    //     .toText(color: Colors.grey, fontSize: 12, underline: true)
                    //     .px(10)
                    //     .py(5)
                    //     .onTap(() {
                    //   openWhatsapp(context,
                    //       text: 'היי, הגעתי אלייך מהאתר Around',
                    //       whatsapp: '+972584770076');
                    // }).center,
                    // const SizedBox(width: 10),
                    'גרסא $appVersion'.toText(color: Colors.grey, fontSize: 12).center,
                  ],
                ),
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
                  .py(75)
                  .center,
          ],
        ),
      );

  Column buildHomeTitle(BuildContext context, bool showAdmin) {
    // 'קבוצות שהזמינו אותך להצטרף אליהם (:'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
    // 'הזמנות קרובות אלייך לבני גיל 19'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
    // 'הזמנות לקבוצות עבורך'.toText(fontSize: 16),
    var passController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // if (isShowAdminRequest)
        //   ListBody(
        //     children: <Widget>[
        //       'יש להזין סיסמת מנהל בת 4 ספרות:'.toText(bold: true),
        //       TextField(
        //         controller: passController,
        //         keyboardType: TextInputType.number,
        //       ),
        //       TextButton(
        //         child: 'הפעל מצב מנהל'.toText(bold: true, color: Colors.purple),
        //         onPressed: () {
        //           if (passController.text == '2003') {
        //             adminMode = true;
        //             isShowAdminRequest = false;
        //             setState(() {});
        //           }
        //         },
        //       ).centerRight,
        //       const SizedBox(height: 20),
        //     ],
        //   ).px(20),

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
            Builder(builder: (context) {
              final boldMode = events.isNotEmpty && user?.age == null;
              return 'עדכון'
                  .toText(
                      fontSize: boldMode ? 13 : 12,
                      color: boldMode ? Colors.purple : Colors.black54,
                      bold: boldMode,
                      underline: true)
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
              }, radius: 5);
            }),
            const Spacer(),
            // if (user != null)
            //   '${(adminMode || user?.age == null) ? 'כל הגילאים ' : 'לגלאי ${user?.age}'}'
            //           ', באיזור ${user?.address?.name}'
            //       .toText(fontSize: 14, color: Colors.black54, medium: true)
            //       .px(15),
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
    // no needed
    // var color = i < categoryColors.length
    //     ? categoryColors[i]
    //     : categoryColors[Random().nextInt(categoryColors.length)];

    // needed
    var currTruck = trucks.firstWhereOrNull((truck) => truck == eventItem.truckType) ??
        eventItem.truckType;

    return Row(
      children: [
        // const SizedBox(height: 50),
        // Icons.keyboard_double_arrow_left.icon(color: Colors.black54),
        // 'לפי מרחק'
        //     .toText(fontSize: 12, color: Colors.black54, medium: true)
        //     .offset(0, -1)
        //     .px(4),
        const SizedBox(width: 5),
        // 'עוד'.toText(fontSize: 12.0, color: color, bold: true),
        const Spacer(),
        '$currTruck'
            // .toText(color: color, fontSize: 15, bold: true)
            .toText(fontSize: 15, bold: true)
            .centerRight,
        const SizedBox(width: 7),
        const CircleAvatar(backgroundColor: darkMain, radius: 3).pOnly(top: 5)
      ],
    ).px(15).py(10)
        // .onTap(() {
        // _handleGoToCategory(null, null, eventCategory: currTruck);
        // })
        ;
  }

  void _handleGoToCategory(int? i, Color? color, {EventCategory? eventCategory}) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => CategoryPage(
    //           user!, eventCategory ?? categories[i!].copyWith(categoryColor: color))),
    // );
  }

  void _handleCreateEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePage()),
    );
  }
}

AppBar buildHomeAppBar(BuildContext context, {GestureTapCallback? onHoldTap}) {
  ;
  return AppBar(
    // backgroundColor: bgColor,
    backgroundColor: bgColorDark,
    // backgroundColor: Colors.white70,
    elevation: 2,
    leading: const Offstage(),
    // elevation: 0,
    title: Row(
      children: [
        logo(context),
        const Spacer(),
        adminModeV2
            ? 'יציאה'.toText(underline: true).onTap(() {
                var box = Hive.box('uniBox');
                box.put('adminMode', null);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              }, radius: 5).px(5)
            : 'איתך בכל הובלה'.toText(fontSize: 18),
      ],
    ).py(5),
  );
}

Widget logo(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Assets.routee.image(height: 45).px(1).offset(0, 1),
      const SizedBox(width: 5),
      if (adminModeV2) '(פאנל ניהול)'.toText(fontSize: 14, medium: true).offset(0, 1),
      const SizedBox(width: 5),
    ],
  ).offset(-50, 0).ltr;
  // .sizedBox(100, null);
}
