import 'dart:math';
import 'package:around/pages/category_page.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import 'common/constants.dart';
import 'common/models/event_category.dart';

OutlinedButton buildModeButton(bool isShowLastedEvents, {VoidCallback? onPressed}) {
  return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        // side: const BorderSide(width: 2.0, color: Colors.white),
        // foregroundColor: AppColors.darkOutline,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      icon: (isShowLastedEvents ? Icons.schedule : Icons.place_outlined)
          .icon(color: Colors.white, size: 20),
      label: (isShowLastedEvents ? 'קבוצות עדכניות' : 'קבוצות קרובות')
          .toText(fontSize: 13, color: Colors.white, bold: true),
      onPressed: onPressed);
}

Widget buildEventCard(
    BuildContext context, double titleSize, double subSize, EventCategory eventCategory) {
  return Card(
    color: Colors.black26,
    child: Column(
      children: [
        ListTile(
          title: 'באולינג בקניון רחובות באולינג בקניון רחובות תגיעו!'
              .toText(bold: true, fontSize: titleSize),
          // leading:
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              // const SizedBox(width: 30),
              'היום, בשעה 21:00'.toText(color: Colors.grey, fontSize: subSize),
              const SizedBox(width: 3),
              // Icons.date_range.icon(color: Colors.grey, size: subSize),
              Icons.schedule.icon(color: Colors.grey, size: subSize),
            ],
          ).py(3),
          trailing: Container(
            height: 45,
            width: 45,
            color: Colors.white,
            child: Image(
                image: AssetImage(eventCategory.coverImagePath.toString()),
                fit: BoxFit.cover),
          ).rounded(radius: 7),
          // isThreeLine: true,
        ),
        Row(
          children: [
            const SizedBox(width: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                'הצטרף'.toText(color: Colors.grey, fontSize: subSize, underline: true),
                const SizedBox(width: 5),
                // Icons.near_me_outlined.icon(color: Colors.grey, size: subSize),
                const Opacity(
                  opacity: 0.6,
                  child: SizedBox(
                    height: 13,
                    width: 13,
                    child: Image(
                        image: AssetImage('assets/whatsapp-xxl.png'), fit: BoxFit.cover),
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                'גדרה'.toText(color: Colors.grey, fontSize: subSize),
                const SizedBox(width: 3),
                Icons.place_outlined.icon(color: Colors.grey, size: subSize),
              ],
            ),
            const SizedBox(width: 75),
          ],
        ),
      ],
    ).pOnly(bottom: 10, top: 10),
  ).onTap(() {}, radius: 5);
}
