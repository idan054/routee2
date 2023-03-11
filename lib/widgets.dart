import 'dart:math';
import 'package:around/common/database.dart';
import 'package:around/pages/category_page.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common/assets.gen.dart';
import 'common/constants.dart';
import 'common/models/event_category.dart';
import 'common/models/event_item.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:io' show Platform;

import '../common/assets.gen.dart';

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
  bool showDeleteOption = false;
  var subSize = 11.0;
  var titleSize = 14.0;
  var eventCategory = eventItem.eventCategory;
  // var time = timeFormat(eventItem.eventAt!).toString();

  var distanceKm = ((eventItem.distanceFromUser ?? 10) / 1000).toString();
  if (distanceKm.length < 4) distanceKm += '.01'; // Needed when user distance = 0
  distanceKm = '${distanceKm.substring(0, 4)} ק"מ';
  var ageRange = '${eventItem.ageRange?.first}-${eventItem.ageRange?.last}';
  if (eventItem.ageRange?.last == 60) {
    ageRange = '${eventItem.ageRange?.first}+';
  }
  if (eventItem.ageRange?.first == 10 && eventItem.ageRange?.last == 60) {
    ageRange = '- כולם מוזמנים!';
  }

  return StatefulBuilder(builder: (context, cardSetState) {
    return Column(
      children: [
        if (showDeleteOption) ...[
          const SizedBox(height: 5),
          Row(
            children: [
              'מחק קבוצה'.toText(bold: true, color: Colors.red).py(15).px(10).onTap(() {
                Database.deleteDoc(collection: 'events', docName: eventItem.id);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: 'הקבוצה נמחקה בהצלחה!'.toText(bold: true, color: Colors.white)));
              }, radius: 10),
              const Spacer(),
              'האם למחוק את הקבוצה?'.toText().px(10)
            ],
          ),
        ],
        InkWell(
          onTap: () {
            print(eventItem.phone);
            var phone = eventItem.phone.toString();
            if (eventItem.phone?.length == 10) {
              phone = '+972${eventItem.phone?.substring(1)}';
            }
            // var time = timeFormat(eventItem.eventAt!, withDay: true);
            print('phone $phone');
            openWhatsapp(context, whatsapp: phone, text: '''
היי, ראיתי את הקבוצה *${eventItem.title}* שלך באתר Around 
 https://around-proj.web.app

לפי הפרטים הקבוצה עבור בני ${eventItem.ageRange?.first}-${eventItem.ageRange?.last}
 ונפגש ב${eventItem.address}
אשמח להצטרף!''');
          },
          onLongPress: adminMode
              ? () {
                  print('START: onLongPress()');
                  showDeleteOption = !showDeleteOption;
                  cardSetState(() {});
                }
              : null,
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
            child: Column(
              children: [
                ListTile(
                  title: eventItem.title.toString().toText(
                        medium: true,
                        fontSize: titleSize,
                        color: Colors.black,
                      ),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                              color: bgColor.withOpacity(0.8),
                              // child: (distanceMode ? distanceKm : ageRange)
                              child: (distanceKm)
                                  .toText(
                                    fontSize: subSize - 2,
                                    medium: true,
                                    color: Colors.black54,
                                  )
                                  .px(7)
                                  .py(5))
                          .rounded(radius: 20),
                    ],
                  ),
                ),
                buildAddressText(eventItem, subSize, distanceMode)
                    // .pOnly(right: 75)
                    .pOnly(right: 15),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    if (!distanceMode) buildWhatsappJoin(subSize),
                    const Spacer(),
                    buildAgeText(ageRange, subSize, distanceMode).py(3),
                  ],
                  // ).pOnly(right: 75, top: 2),
                ).pOnly(right: 15, top: 2),
              ],
            ).pOnly(bottom: 10, top: 5),
          ),
          // .onTap(() {}, radius: 5),
        ),
      ],
    );
  });
}

Row buildAgeText(String ageRange, double subSize, bool distanceMode) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      'גילאים $ageRange'
          .toString()
          .toText(color: Colors.grey, fontSize: subSize)
          .sizedBox(110, null),
      const SizedBox(width: 3),
      Icons.group_outlined
          .icon(color: Colors.grey, size: distanceMode ? subSize + 3 : subSize),
    ],
  );
}

Widget buildAddressText(EventItem eventItem, double subSize, bool distanceMode) {
  var address = eventItem.address.toString();

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    // mainAxisSize: MainAxisSize.min,
    children: [
      address.toText(color: Colors.grey, fontSize: subSize, maxLines: 1),
      // .sizedBox(130, null),
      const SizedBox(width: 3),
      Icons.place_outlined
          .icon(color: Colors.grey, size: distanceMode ? subSize + 3 : subSize),
    ],
  );
}

Widget buildWhatsappJoin(double subSize) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // ('הצטרף ')
      // if (distanceMode)
      //   '($ageRange)'.toText(color: Colors.grey, fontSize: subSize),
      ('לקבוצה').toText(color: wtspGreen, fontSize: subSize, bold: true),
      const SizedBox(width: 5),
      // Icons.near_me_outlined.icon(color: Colors.grey, size: subSize),
      Assets.svg.whatsappOutline.svg(color: wtspGreen, height: 18)
      // const Opacity(
      //   opacity: 0.6,
      //   child: SizedBox(
      //     height: 13,
      //     width: 13,
      //     child: Image(image: AssetImage('assets/whatsapp-xxl.png'), fit: BoxFit.cover),
      //   ),
      // )
    ],
  );
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
    {required String text, required String whatsapp}) async {
  print('START: openWhatsapp()');

  // WhatsApp group link
  if (whatsapp.contains('chat.whatsapp')) {
    print('whatsapp ${whatsapp}');
    print('Uri.parse(whatsapp) ${Uri.parse(whatsapp)}');
    await launchUrl(Uri.parse(whatsapp), mode: LaunchMode.externalApplication);
    return;
  }

  // var whatsapp = whtsapp; //+92xx enter like this
  var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
  var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";

  if (kIsWeb || Platform.isAndroid) {
    print('START: != IOS');
    // android , web
    await launchUrl(Uri.parse(whatsappURlAndroid));
  } else {
    print('START: == IOS');
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(
        whatsappURLIos,
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Whatsapp not installed")));
    }
  }
}
