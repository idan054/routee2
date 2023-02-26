import 'dart:math';
import 'package:around/pages/category_page.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'common/constants.dart';
import 'common/models/event_category.dart';
import 'common/models/event_item.dart';
import 'package:intl/intl.dart' as intl;

OutlinedButton buildModeButton(bool isShowLastedEvents, {VoidCallback? onPressed}) {
  return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white12,
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

Widget buildEventCard(BuildContext context, EventItem eventItem) {
  var subSize = 12.0;
  var titleSize = 14.5;
  var eventCategory = eventItem.eventCategory;
  var time = timeFormat(eventItem.eventAt!).toString();

  return Card(
    color: Colors.white12,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    child: Column(
      children: [
        ListTile(
          title: eventItem.title.toString().toText(bold: true, fontSize: titleSize),
          // leading:
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),

              // 'היום, בשעה 21:00'.toText(color: Colors.grey, fontSize: subSize),
              time.toText(color: Colors.grey, fontSize: subSize),
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
                image: AssetImage('${eventCategory?.coverImagePath}'), fit: BoxFit.cover),
          ).rounded(radius: 7),
          // isThreeLine: true,
        )
            // .sizedBox(null, 60)
        ,
        Row(
          children: [
            const SizedBox(width: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                'הצטרף'.toText(color: Colors.grey, fontSize: subSize, bold: true),
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
                eventItem.address
                    .toString()
                    .toText(color: Colors.grey, fontSize: subSize)
                    .sizedBox(160, null),
                const SizedBox(width: 3),
                Icons.place_outlined.icon(color: Colors.grey, size: subSize),
              ],
            ),
            const SizedBox(width: 75),
          ],
        ),
      ],
    ).pOnly(bottom: 10),
  ).onTap(() {
    // Todo Add Go To Whatsapp
    print(eventItem.phone);
  }, radius: 5);
}

String? timeFormat(DateTime timestamp, {bool withDay = true}) {
  var time = intl.DateFormat(withDay
          ? 'EEEE ב '
              'HH:mm'
              ' (dd/MM)'
          : 'dd/MM ' 'ב HH:mm ')
      .format(timestamp);
  if (timestamp.day == DateTime.now().day &&
      timestamp.month == DateTime.now().month &&
      timestamp.year == DateTime.now().year) {
    time = intl.DateFormat(
      'היום ב ' 'HH:mm',
    ).format(timestamp);
    return time;
  }
  return time;
}
