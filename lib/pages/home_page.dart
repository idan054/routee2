import 'dart:convert';
import 'dart:math';
import 'package:around/common/database.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../common/constants.dart';
import '../common/models/address_result.dart';
import '../common/models/event_category.dart';
import '../common/models/event_item.dart';
import '../gen/assets.gen.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'category_page.dart';
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
      tagsController.jumpTo(999.0);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
    print('userAge $userAge');
    print('userAddress $userAddress');

    if (userAge == null || userAddress == null) {
      showUpdateDetailsDialog(
        context,
        onConfirm: (UserData userData) => _onUpdateUserInfo(userData),
      );
    } else {
      var jsonData = Map<String, dynamic>.from(userAddress);
      user = UserData(userAge, AddressResult.fromJson(jsonData));
      fetchEvents();
    }
  }

  void fetchEvents({bool withLoader = false}) async {
    if (withLoader) {
      splashLoad = true;
      setState(() {});
    }
    events = await FsAdvanced.getHomeEvents(user?.age ?? 0);
    splashLoad = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    titlesExist = [];

    if (user == null) const Scaffold(backgroundColor: bgColor);
    if (events.isEmpty && !splashLoad) {
      const Scaffold(backgroundColor: bgColor);
    } // App init

    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildHomeAppBar(),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.white38,
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
                const SizedBox(height: 15),
              ],
            ),
            if (splashLoad)
              Card(
                      color: bgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const CircularProgressIndicator().pad(15))
                  .sizedBox(70, 70)
                  .center,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bgColor,
        child: Container(
                color: Colors.white.withOpacity(0.04), child: Assets.addOnlyWhite.image())
            .roundedFull,
        onPressed: () {
          _handleCreateEvent();
        },
      ),
    );
  }

  AppBar buildHomeAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      // centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // buildModeButton(
          //   isShowLastedEvents,
          //   onPressed: () {
          //     isShowLastedEvents = !isShowLastedEvents;
          //     setState(() {});
          //   },
          // ).rtl,

          // 'קבוצות מסביבך'.toText(bold: true, fontSize: 18),
          const Spacer(),
          const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
          'Around'.toText(bold: true, fontSize: 18),
          // 'קבוצות עדכניות'.toText(bold: true, fontSize: 18),
          // const SizedBox(width: 5),
          //
        ],
      ),
    );
  }

  Column buildHomeTitle(BuildContext context) {
    // 'קבוצות שהזמינו אותך להצטרף אליהם (:'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
    // 'הזמנות קרובות אלייך לבני גיל 19'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
    // 'הזמנות לקבוצות עבורך'.toText(fontSize: 16),
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (isShowLastedEvents
                    // ? 'קבוצות עדכניות אליהם הזמינו אותך'
                    // ? 'קבוצות עדכניות בשבילך'
                    // : 'קבוצות קרובות בשבילך')
                    ? 'כל הקבוצות העדכניות בשבילך'
                    : 'כל הקבוצות הקרובות בשבילך')
                .toText(fontSize: 18, color: Colors.white, bold: true)
                .pOnly(right: 15),
                // .pOnly(right: 5),
            // (isShowLastedEvents ? Icons.schedule : Icons.place_outlined)
            //     .icon(color: Colors.white, size: 20).pOnly(right: 12),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            'עדכון'
                .toText(fontSize: 14, color: Colors.white54, bold: true, underline: false)
                .px(15)
                .onTap(() {
              showUpdateDetailsDialog(
                context,
                fromUpdateButton: true,
                user: user,
                onConfirm: (UserData userData) =>
                    _onUpdateUserInfo(userData, withLoader: true),
              );
            }),
            const Spacer(),
            if (user != null)
              'לגלאי ${user?.age}, באיזור ${user?.address?.name}'
                  .toText(fontSize: 14, color: Colors.white38, bold: false)
                  .px(15),
          ],
        ),
      ],
    );
  }

  void _onUpdateUserInfo(UserData userData, {bool withLoader = false}) {
    print('userData ${userData.age}');
    print('userData ${userData.address?.name}');
    user = userData;
    fetchEvents(withLoader: withLoader);
    // setState(() {});
  }

  SingleChildScrollView buildTagsRow() {
    int? sValue;
    // int? catIndex;
    EventCategory? selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: tagsController,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List<Widget>.generate(
            categories.length,
            (int i) {
              var cat = categories[i];
              return ChoiceChip(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                label: '${cat.categoryName}'
                    .toText(fontSize: 14, bold: true, color: Colors.white),
                side: BorderSide(color: cat.categoryColor!, width: 2),
                selected: sValue == i,
                backgroundColor: bgColor,
                selectedColor: cat.categoryColor!,
                onSelected: (bool selected) {
                  // sValue = selected ? i : null;
                  selectedCategory = cat;
                  // setState(() {});
                  _handleGoToCategory(null, null, eventCategory: selectedCategory);
                },
              ).px(3.5);
            },
          ).toList(),
        ).px(15),
      ),
    );
  }

  Widget buildCategoryTitle(EventItem eventItem) {
    // var color = i < categoryColors.length
    //     ? categoryColors[i]
    //     : categoryColors[Random().nextInt(categoryColors.length)];

    return Row(
      children: [
        const SizedBox(height: 50),
        Icons.keyboard_double_arrow_left.icon(),
        const SizedBox(width: 5),
        // 'עוד'.toText(fontSize: 12.0, color: color, bold: true),
        const Spacer(),
        '${eventItem.eventCategory?.categoryName}'
            // .toText(color: color, fontSize: 15, bold: true)
            .toText(color: Colors.white, fontSize: 15, bold: true)
            .centerRight,
        const SizedBox(width: 7),
        CircleAvatar(backgroundColor: eventItem.eventCategory?.categoryColor, radius: 3)
            .pOnly(top: 5)
      ],
    ).px(15).onTap(() {
      _handleGoToCategory(null, null, eventCategory: eventItem.eventCategory);
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
