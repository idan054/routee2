import 'dart:math';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import '../common/constants.dart';
import '../common/models/event_category.dart';
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
  int? sValue;
  int? catIndex;
  EventCategory? selectedCategory;
  ScrollController tagsController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => tagsController.jumpTo(999.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        // centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildModeButton(
              isShowLastedEvents,
              onPressed: () {
                isShowLastedEvents = !isShowLastedEvents;
                setState(() {});
              },
            ).rtl,
            // 'קבוצות מסביבך'.toText(bold: true, fontSize: 18),
            const Spacer(),
            const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
            'Around'.toText(bold: true, fontSize: 18),
            // 'קבוצות עדכניות'.toText(bold: true, fontSize: 18),
            // const SizedBox(width: 5),
            //
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),

          (isShowLastedEvents
                  // ? 'קבוצות עדכניות אליהם הזמינו אותך'
                  ? 'קבוצות עדכניות בשבילך'
                  : 'קבוצות קרובות בשבילך')
              .toText(fontSize: 22, color: Colors.white38, bold: true)
              .px(15),

          Row(
            children: [
              'עדכון'
                  .toText(
                      fontSize: 14, color: Colors.white38, bold: true, underline: false)
                  .px(15)
                  .onTap(() {
                showUpdateDetailsDialog(context);
              }),
              const Spacer(),
              'לגלאי 18, באיזור גדרה'
                  .toText(fontSize: 14, color: Colors.white38, bold: false)
                  .px(15),
            ],
          ),

          // 'קבוצות שהזמינו אותך להצטרף אליהם (:'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
          // 'הזמנות קרובות אלייך לבני גיל 19'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
          // 'הזמנות לקבוצות עבורך'.toText(fontSize: 16),
          const SizedBox(height: 15),

          SingleChildScrollView(
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
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              // var color = ;
              var color = i < categoryColors.length
                  ? categoryColors[i]
                  : categoryColors[Random().nextInt(categoryColors.length)];

              bool isShowTitle = (i ~/ 3) == (i / 3); // AKA Every 4 posts.

              return Column(
                children: [
                  // if (isShowTitle)
                  Row(
                    children: [
                      const SizedBox(height: 50),
                      Icons.keyboard_double_arrow_left.icon(),
                      const SizedBox(width: 5),
                      // 'עוד'.toText(fontSize: 12.0, color: color, bold: true),
                      const Spacer(),
                      '${categories[i].categoryName}'
                          // .toText(color: color, fontSize: 15, bold: true)
                          .toText(color: Colors.white, fontSize: 15, bold: true)
                          .centerRight,
                      const SizedBox(width: 7),
                      CircleAvatar(backgroundColor: color, radius: 3).pOnly(top: 5)
                    ],
                  ).px(15).onTap(() {
                    _handleGoToCategory(i, color);
                  }),
                  buildEventCard(context, sampleEvent).px(5),
                  buildEventCard(context, sampleEvent).px(5),
                  buildEventCard(context, sampleEvent).px(5),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bgColor,
        child: Assets.addOnlyWhite.image(),
        onPressed: () {
          _handleCreateEvent();
        },
      ),
    );
  }

  void _handleGoToCategory(int? i, Color? color, {EventCategory? eventCategory}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoryPage(
              eventCategory ?? categories[i!].copyWith(categoryColor: color))),
    );
  }

  void _handleCreateEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePage()),
    );
  }
}
