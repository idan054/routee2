// ignore_for_file: use_build_context_synchronously

import 'dart:io' show File, Platform;

import 'package:another_flushbar/flushbar.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:routee/common/database.dart';
import 'package:routee/common/num_extensions.dart';
import 'package:routee/common/string_ext.dart';
import 'package:routee/common/widget_ext.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'common/constants.dart';
import 'common/models/event_item.dart';
import 'main.dart';

Widget flushBar(BuildContext context, String text,
    {Color bgColor = Colors.blueGrey,
    Color textColor = Colors.white,
    int? duration,
    bool withShadow = false,
    bool isShimmer = false}) {
  return Flushbar(
    backgroundColor: bgColor,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.only(left: 30, right: 30, top: 40),
    borderRadius: BorderRadius.all(10.circular),
    isDismissible: true,
    duration: (duration ?? 3).seconds,
    boxShadows: withShadow
        ? const [
            BoxShadow(
              blurRadius: 1.3,
              spreadRadius: 1.3,
              color: Colors.black26,
            )
          ]
        : null,
    messageText: Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: textColor,
        highlightColor: isShimmer ? Colors.grey[200]! : textColor,
        child: text.toText(color: textColor, medium: true, fontSize: 14)),
  )..show(context);
}

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

Widget buildEventCard(BuildContext context, EventItem eventItem, UserData user,
    {bool distanceMode = false}) {
  WidgetsToImageController controller = WidgetsToImageController();
  // bool showDeleteOption = false;
  var subSize = 11.0;
  var titleSize = 14.0;

  // var distanceKm = ((eventItem.distanceFromUser ?? 10) / 1000).toString();
  // distanceKm = distanceKm.split('.').first;
  // if (distanceKm == '0') distanceKm = '115';
  //
  // distanceKm += '₪';

  return WidgetsToImage(
    controller: controller,
    child: StatefulBuilder(builder: (context, cardSetState) {
      return Row(
        children: [
          // if (showDeleteOption) ...[
          if (kIsWeb && adminModeV2) ...[
            Icons.delete_forever_rounded
                .icon(color: Colors.red.shade300)
                .py(10)
                .px(10)
                .onTap(() {
              Database.deleteDoc(collection: 'events', docName: eventItem.id);

              flushBar(
                context,
                'ההובלה נוספת לאפליקצייה בהצלחה!',
                withShadow: true,
                isShimmer: true,
                duration: 4,
                textColor: Colors.white,
                // bgColor: bgColorDark,
                bgColor: Colors.purple[500]!,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );

              flushBar(
                context,
                'ההובלה "${eventItem.title}" נמחקה בהצלחה!',
                withShadow: true,
                isShimmer: true,
                duration: 4,
                textColor: Colors.white,
                // bgColor: bgColorDark,
                bgColor: Colors.purple[500]!,
              );
            }, radius: 10),
          ],
          InkWell(
            onTap: kIsWeb
                ? null
                //     flushBar(
                //       context,
                //       'ל',
                //       withShadow: true,
                //       isShimmer: true,
                //       duration: 4,
                //       textColor: Colors.white,
                //       // bgColor: bgColorDark,
                //       bgColor: Colors.purple[500]!,
                //     );

                : () async {
                    // region onTap

                    // final remoteConfig = FirebaseRemoteConfig.instance;
                    // final phone = remoteConfig.getString('wtsp_admin_phone');

                    openWhatsapp(context,
                        // whatsapp: phone,
                        whatsapp: '+972542015649', // NIR
                        text: 'היי, ראיתי את ההובלה '
                            '*${eventItem.title}*'
                            ' ב Routee '
                            '\n'
                            // 'https://routee.web.app'
                            // '\n'
                            '\n'
                            'לפי הפרטים זה הובלה'
                            ' בשווי '
                            '₪${eventItem.price}'
                            ' שמיועדת ל'
                            '${eventItem.truckType}'
                            '\n'
                            'מ'
                            '${eventItem.originAddress?.replaceAll(', ישראל', '')}'
                            ' עד '
                            '${eventItem.destinationAddress?.replaceAll(', ישראל', '')}'
                            '\n'
                            'אשמח לעשות את הובלה הזו (:');

                    print('START: logEvent()');

                    //> variables can be String / numbers ONLY
                    var createdAt = timeFormat(eventItem.createdAt!, withDay: true);
                    // var analyticsItem = {
                    //   'id': 'eventItem.id',
                    //   'title': 'eventItem.title',
                    //   'phone': 'eventItem.phone',
                    //   'minAge': 'eventItem.ageRange?.first',
                    //   'maxAge': 'eventItem.ageRange?.last',
                    //   'address': 'eventItem.address',
                    //   'latitude': 'eventItem.latitude',
                    //   'longitude': 'eventItem.longitude',
                    //   'createdAt': 'createdAt',
                    //   'categoryName': 'eventItem.eventCategory?.categoryName',
                    //   'categoryType': 'eventItem.eventCategory?.categoryType?.name',
                    //   'currUserAge': user.age,
                    //   'currUserAddress': user.address?.toJson()
                    // };

                    // var name = eventItem.title.toString();
                    // name = name + (' ') + (eventItem.phone.toString().length == 10
                    //   ? eventItem.phone.toString()
                    //   : eventItem.phone?.split('.com/')[1]).toString();

                    // FirebaseAnalytics.instance.logJoinGroup(groupId: eventItem.id.toString());

                    // Unhandled Exception: Invalid argument: Instance of 'Timestamp'
                    var eventWithoutCreateAt = eventItem.toJson();
                    eventWithoutCreateAt['createdAt'] = '';
                    printTrackEvent(eventItem.title.toString(),
                        properties: eventWithoutCreateAt);

                    // endregion onTap
                  },
            child: Card(
              color: Colors.white,
              // color: bgColorLight,
              // color: bgColorDark,
              elevation: 2,
              // elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
              child: Column(
                children: [
                  ListTile(
                    title: eventItem.title.toString().toText(
                          medium: true,
                          fontSize: titleSize,
                          color: Colors.black,
                        ),
                    leading: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                                // color: bgColor?.withOpacity(0.8),
                                color: bgColorDark,
                                // child: (distanceMode ? distanceKm : ageRange)
                                child: ('₪${eventItem.price}')
                                    .toText(
                                      // fontSize: subSize - 2,
                                      fontSize: subSize,
                                      medium: true,
                                      color: Colors.black54,
                                    )
                                    .px(7)
                                    .py(5))
                            .rounded(radius: 20),
                        const SizedBox(width: 4),
                        // if (adminMode)
                        //   buildShareButton(context, controller, eventItem, subSize),

                        // if (!distanceMode) buildShareButton(subSize).offset(0, 2),
                      ],
                    ),
                  ),
                  // if (adminModeV2)
                  //   buildInfo(eventItem, subSize, distanceMode)
                  //       .pOnly(right: 15, bottom: 5),

                  // Text(eventItem.truckType.toString()),
                  buildOriginAddressText(eventItem, subSize, distanceMode)
                      .pOnly(right: 15),
                  // buildCreatedAt(eventItem, subSize, distanceMode).pOnly(right: 15),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      if (!distanceMode) buildWhatsappJoin(subSize),
                      const Spacer(),
                      buildDestinationText(eventItem, subSize, distanceMode).py(3),
                    ],
                    // ).pOnly(right: 75, top: 2),
                  ).pOnly(right: 15, top: 2),
                ],
              ).pOnly(bottom: 10, top: 5),
            ),
            // .onTap(() {}, radius: 5),
          ).expanded(),
        ],
      );
    }),
  );
}

Widget buildInfo(EventItem eventItem, double subSize, bool distanceMode) {
  var date = timeFormat(eventItem.createdAt!, withDay: true);
  var createdBy = eventItem.price.toString().length == 10
      ? eventItem.price?.substring(6, 10)
      : eventItem.price?.split('.com/')[1].substring(0, 4);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    // mainAxisSize: MainAxisSize.min,
    children: [
      'נוצר '
              '${date.toString().contains('היום') ? '' : 'ב'}'
              '$date'
              ' - '
              'ע"י $createdBy'
              // ' - '
              '${eventItem.price != null ? '(בתשלום)' : ''}'
          .toText(color: Colors.grey, fontSize: subSize, maxLines: 1),
      // .sizedBox(130, null),
      const SizedBox(width: 3),
      Icons.info_outlined
          .icon(color: Colors.grey, size: distanceMode ? subSize + 3 : subSize),
    ],
  );
}

Row buildDestinationText(EventItem eventItem, double subSize, bool distanceMode) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      eventItem.destinationAddress
          .toString()
          .toText(color: Colors.grey, fontSize: subSize)
          .sizedBox(200, null),
      const SizedBox(width: 3),
      Icons.flag.icon(color: Colors.grey, size: distanceMode ? subSize + 3 : subSize),
    ],
  );
}

Widget buildOriginAddressText(EventItem eventItem, double subSize, bool distanceMode) {
  // var diff = DateTime.now().difference(eventItem.createdAt!).inDays;
  // var ago = '';
  // if (diff == 0) ago = 'נוסף היום!';
  // if (diff == 1) ago = 'נוסף אתמול!';
  // if (diff != 0 && diff != 1) ago = 'נוסף לפני $diff ימים ';
  //
  // var addressAndAgo = adminMode ? ('$address' ' - ' '$ago') : address;

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    // mainAxisSize: MainAxisSize.min,
    children: [
      eventItem.originAddress
          .toString()
          .toText(color: Colors.grey, fontSize: subSize, maxLines: 1),

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
      ('להובלה').toText(color: darkMain, fontSize: subSize, bold: true),
      const SizedBox(width: 5),
      Transform.scale(
        scaleX: -1, // 1
        child: Icons.local_shipping.icon(color: darkMain, size: subSize + 5),
      )
      // Assets.svg.whatsappOutline.svg(color: wtspGreen, height: 18)
    ],
  );
}

Widget buildShareButton(
  BuildContext context,
  WidgetsToImageController controller,
  EventItem eventItem,
  double subSize,
) {
  var ageRange = 'לגילאי ' '10-30';

  bool isLoading = false;

  return StatefulBuilder(builder: (context, stfState) {
    return CircleAvatar(
      backgroundColor: bgColor,
      // backgroundColor: Colors.transparent,
      radius: 10,
      // child: Icons.reply.icon(color: Colors.black38, size: subSize + 2), // New share

      // Todo while upload, change the icon to loader.
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.purple,
              strokeWidth: 2,
            ).sizedBox(10, 10)
          : Icons.share.icon(color: Colors.black38, size: subSize + 1), // Classic share
    ).pad(0).onTap(() async {
      isLoading = true;
      stfState(() {});
      await Future.delayed(const Duration(milliseconds: 250));

      // final bytes = await controller.capture();
      // String base64Image = base64Encode(bytes!);
      // // var file = File.fromUri(Uri.file(base64Image));
      // var imageUrl = await UploadServices.imgbbUploadPhoto(base64Image);

      isLoading = false;
      stfState(() {});

      var address = 'eventItem.address?'.replaceAll(', ישראל', '');
      var desc =
          // 'קבוצה חדשה '
          '"${eventItem.title}"'
          ' '
          '$ageRange'
          // '${eventItem.eventCategory?.categoryName}'
          ', מוזמנים אל '
          '$address'
          '\n'
          '\n'
          'כדי להצטרף או למצוא עוד קבוצות מסביבכם'
          ' הכנסו לאתר Around 😀 \n';

      try {
        // Share.share('text');

        // html.window.navigator.share({
        //   'title': desc,
        //   'description': desc,
        //   'text': desc,
        //   // 'image': imageUrl,
        //   'image': 'https://i.ibb.co/rsHsT2v/74db0f2a539b.png',
        //   'url': 'https://around-proj.web.app/'
        // });
      } on Exception catch (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: 'E: $e \n s: $s'.toText(color: Colors.white, maxLines: 10)));
        print(s);
      }
    });
  });
  //   Row(
  //   mainAxisSize: MainAxisSize.min,
  //   children: [
  //     // ('הצטרף ')
  //     // if (distanceMode)
  //     //   '($ageRange)'.toText(color: Colors.grey, fontSize: subSize),
  //     const SizedBox(width: 5),
  //     // Icons.reply.icon(color: Colors.black38, size: subSize + 5),
  //     (
  //         'שיתוף'
  //         ' | '
  //     ).toText(color: Colors.black38, fontSize: subSize, medium: true),
  //     // Assets.svg.whatsappOutline.svg(color: wtspGreen, height: 18)
  //     // const Opacity(
  //     //   opacity: 0.6,
  //     //   child: SizedBox(
  //     //     height: 13,
  //     //     width: 13,
  //     //     child: Image(image: AssetImage('assets/whatsapp-xxl.png'), fit: BoxFit.cover),
  //     //   ),
  //     // )
  //   ],
  // );
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
