import 'dart:math';
import 'package:around/pages/category_page.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common/constants.dart';
import 'common/models/event_category.dart';
import 'common/models/event_item.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:io' show Platform;

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

Widget buildEventCard(BuildContext context, EventItem eventItem,
    {bool distanceMode = false}) {
  var subSize = 11.0;
  var titleSize = 14.0;
  var eventCategory = eventItem.eventCategory;
  var time = timeFormat(eventItem.eventAt!).toString();

  var distanceKm =
      ('${((eventItem.distanceFromUser ?? 10) / 1000).toString().substring(0, 4)} km');
  var ageRange = '${eventItem.ageRange?.first}-${eventItem.ageRange?.last}';

  return Card(
    color: Colors.white12,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    child: Column(
      children: [
        ListTile(
          title: eventItem.title.toString().toText(bold: true, fontSize: titleSize),
          leading: Container(
                  color: bgColor.withOpacity(0.5),
                  child: (distanceMode ? distanceKm : ageRange)
                      .toText(fontSize: subSize, color: Colors.grey)
                      .px(7)
                      .py(5))
              .roundedFull,
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
                // ('הצטרף ')
                ('לקבוצה ').toText(color: Colors.white70, fontSize: subSize, bold: true),
                const SizedBox(width: 5),
                // Icons.near_me_outlined.icon(color: Colors.grey, size: subSize),
                const Opacity(
                  opacity: 0.8,
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
                (distanceMode ? 'לגלאי $ageRange' : eventItem.address)
                    .toString()
                    .toText(color: Colors.grey, fontSize: subSize)
                    .sizedBox(120, null),
                const SizedBox(width: 3),
                (distanceMode ? Icons.group_outlined : Icons.place_outlined)
                    .icon(color: Colors.grey, size: distanceMode ? subSize + 3 : subSize),
              ],
            ),
            const SizedBox(width: 75),
          ],
        ),
      ],
    ).pOnly(bottom: 10),
  ).onTap(() {
    print(eventItem.phone);
    var phone = '+972${eventItem.phone?.substring(1)}';
    var time = timeFormat(eventItem.eventAt!, withDay: true);
    print('phone $phone');
    openWhatsapp(context, number: phone, text: '''
היי, ראיתי את הקבוצה *${eventItem.title}* שלך באפליקציית Around ואשמח להצטרף!

לפי הפרטים הקבוצה עבור בני ${eventItem.ageRange?.first}-${eventItem.ageRange?.last}
 ונפגש ב${eventItem.address} ב $time
    ''');
  }, radius: 5);
}

String? timeFormat(DateTime timestamp, {bool withDay = true}) {
  var time =
      intl.DateFormat(withDay ? 'EEEE ב ' 'HH:mm' ' (dd/MM)' : 'dd/MM ' 'ב HH:mm ', 'he')
          .format(timestamp);

  if (timestamp.day == DateTime.now().day + 1 &&
      timestamp.month == DateTime.now().month &&
      timestamp.year == DateTime.now().year) {
    time = intl.DateFormat('מחר (EEEE) ב ' 'HH:mm', 'he').format(timestamp);
    time = time.replaceAll('יום ', '');
    return time;
  }

  if (timestamp.day == DateTime.now().day &&
      timestamp.month == DateTime.now().month &&
      timestamp.year == DateTime.now().year) {
    time = intl.DateFormat('(EEEE) ב ' 'HH:mm', 'he').format(timestamp);
    time = time.replaceAll('יום ', '');
    time = 'היום $time';
    return time;
  }

  // var time = DateFormat('EEEE, dd MMMM yyyy, h:mm:ss a', 'he').format(timestamp);
  time = time.replaceAll('יום ', '');
  return time;
}

void openWhatsapp(BuildContext context,
    {required String text, required String number}) async {
  var whatsapp = number; //+92xx enter like this
  var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
  var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(
        whatsappURLIos,
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Whatsapp not installed")));
    }
  } else {
    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Whatsapp not installed")));
    }
  }
}
