import 'dart:math';

import 'package:around/common/string_ext.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';

import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../common/models/event_category.dart';
import '../main.dart';
import '../widgets.dart';

class CategoryPage extends StatefulWidget {
  final EventCategory eventCategory;

  const CategoryPage(this.eventCategory, {Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isShowLastedEvents = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          // centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 30),
              // 'Around'.toText(bold: true, fontSize: 14),
              // const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
              const Spacer(),
              buildModeButton(
                isShowLastedEvents,
                onPressed: () {
                  isShowLastedEvents = !isShowLastedEvents;
                  setState(() {});
                },
              ).rtl,
              // const SizedBox(width: 5),
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
            children: [
              const SizedBox(height: 15),
              // (isShowLastedEvents
              // // ? 'קבוצות עדכניות אליהם הזמינו אותך'
              //     ? 'הצטרף לקבוצות עדכניות שמיועדות לך (גיל 18)'
              //     : 'הצטרף לקבוצות קרובות שמיועדות לך (גיל 18)')
              //     .toText(fontSize: 14, color: Colors.grey, bold: true)
              //     .px(15),
              Row(
                children: [
                  const Spacer(),
                  'כל הקבוצות '
                          '${widget.eventCategory.categoryName}'
                      .toText(fontSize: 16, color: Colors.white, bold: true).px(5),
                  const SizedBox(width: 5),
                  CircleAvatar(backgroundColor: widget.eventCategory.categoryColor, radius: 3).pOnly(top: 5),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: 9,
                itemBuilder: (context, i) {

                  return buildEventCard(context, sampleEvent);
                },
              ),
              const SizedBox(height: 15),
            ],
          ).px(15),
        ),
      ),
    );
  }
}
