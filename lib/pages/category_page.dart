import 'dart:math';

import 'package:around/common/string_ext.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'dart:convert';
import 'dart:math';
import 'package:around/common/database.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:around/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../common/constants.dart';
import '../common/models/address_result.dart';
import '../common/models/event_category.dart';
import '../common/models/event_item.dart';
import '../common/assets.gen.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'category_page.dart';
import 'create_page.dart';

import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../common/models/event_category.dart';
import '../main.dart';
import '../widgets.dart';

// 1) Compare every location to user > 5KM Away..
// 2) Sort by distance

class CategoryPage extends StatefulWidget {
  final UserData user;
  final EventCategory eventCategory;

  const CategoryPage(this.user, this.eventCategory, {Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<EventItem> events = [];
  bool isShowLastedEvents = true;
  bool splashLoad = true;
  bool longDistanceShowed = false;

  @override
  void initState() {
    fetchEvents();
    super.initState();
  }

  void fetchEvents({bool withLoader = false}) async {
    if (withLoader) {
      splashLoad = true;
      setState(() {});
    }
    events = await FsAdvanced.getCategoryEvents(
      adminMode ? null : widget.user.age,
      widget.eventCategory,
    );
    events = sortByDistance(events, widget.user);
    splashLoad = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColorDark,
          leading: Icons.arrow_back
              .icon(size: 25, color: Colors.black)
              .onTap(() => Navigator.pop(context)),
          title: aroundLogo().pOnly(right: 7, left: 0).centerLeft,
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              ListView(
                children: [
                  const SizedBox(height: 15),
                  // (isShowLastedEvents
                  // // ? 'קבוצות עדכניות אליהם הזמינו אותך'
                  //     ? 'הצטרף לקבוצות עדכניות שמיועדות לך (גיל 18)'
                  //     : 'הצטרף לקבוצות קרובות שמיועדות לך (גיל 18)')
                  //     .toText(fontSize: 14, color: Colors.grey, bold: true)
                  //     .px(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          'כל הקבוצות '
                                  // 'קבוצות מסביבך '
                                  '${widget.eventCategory.categoryName}'
                                  '${adminMode ? ' (${events.length})' : ''}'
                              .toText(fontSize: 18, color: Colors.black, bold: true)
                              .px(5),
                          const SizedBox(width: 5),
                          CircleAvatar(
                                  backgroundColor: widget.eventCategory.categoryColor,
                                  radius: 3)
                              .pOnly(top: 5),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          'לפי מרחק'
                              .toText(fontSize: 12, color: Colors.black54, bold: false)
                              .px(15),
                          const Spacer(),
                          '${adminMode ? 'לכל הגילאים' : 'לגלאי ${widget.user.age}'}'
                                  ', באיזור ${widget.user.address?.name}'
                              .toText(fontSize: 14, color: Colors.black54, medium: true)
                              .px(15),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  if (splashLoad == false && events.isEmpty)
                    'לא נמצאו קבוצות ${widget.eventCategory.categoryName} \n'
                            'לגלאי ${widget.user.age} ב${widget.user.address?.name}. צור קבוצה חדשה!'
                        .toText(textAlign: TextAlign.center)
                        .center
                        .pOnly(top: 200),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, i) {
                      var distance = events[i].distanceFromUser;
                      var distanceKm = ((distance ?? 10) / 1000).toString();
                      if (distanceKm.length < 4) distanceKm += '.01';
                      distanceKm = '${distanceKm.substring(0, 4)} ק"מ';

                      return Column(
                        children: [
                          if (distance != null &&
                              distance > 30000 &&
                              longDistanceShowed == false)
                            Builder(builder: (context) {
                              longDistanceShowed = true;
                              return 'קבוצות רחוקות מ 30 ק"מ'
                                  .toText(
                                      fontSize: 14, color: Colors.black54, medium: true)
                                  .centerRight
                                  .px(15)
                                  .pOnly(top: 10, bottom: 10);
                            }),
                          buildEventCard(context, events[i], widget.user,
                                  distanceMode: !isShowLastedEvents)
                              .px(5),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ).px(12),
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
      ),
    );
  }
}

// List<EventItem> sortByStartSoon(List<EventItem> events, UserData user) {
//   var updatedEvents = <EventItem>[];
//   for (var event in [...events]) {
//     var updatedEvnt = setDistance(user, event);
//     updatedEvents.add(updatedEvnt);
//   }
//   updatedEvents.sort((a, b) => a.eventAt!.compareTo(b.eventAt!));
//   return updatedEvents;
// }

List<EventItem> sortByType(List<EventItem> events, UserData user) {
  var updatedEvents = <EventItem>[];
  for (var event in [...events]) {
    var updatedEvnt = setDistance(user, event);
    updatedEvents.add(updatedEvnt);
  }
  return updatedEvents;
}

List<EventItem> sortByTypeOld(List<EventItem> events, UserData user) {
  var updatedEvents = <EventItem>[];
  for (var event in [...events]) {
    var updatedEvnt = setDistance(user, event);
    updatedEvents.add(updatedEvnt);
  }
  updatedEvents.sort(
      (a, b) => a.eventCategory!.categoryName!.compareTo(b.eventCategory!.categoryName!));
  updatedEvents = updatedEvents.reversed.toList();
  return updatedEvents;
}

List<EventItem> sortByDistance(List<EventItem> events, UserData user) {
  var updatedEvents = <EventItem>[];
  for (var event in [...events]) {
    var updatedEvnt = setDistance(user, event);
    updatedEvents.add(updatedEvnt);
  }
  updatedEvents.sort((a, b) => a.distanceFromUser!.compareTo(b.distanceFromUser!));

  return updatedEvents;
}
