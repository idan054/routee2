import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import 'models/address_result.dart';
import 'models/event_category.dart';
import 'models/event_item.dart';

// var
// final
// const

var appVersion = 1.5;
var adminModeV2 = (true && kDebugMode);
// var adminMode = false;
var mixpanel = Mixpanel('PlaceHolder'); // instead nullable

// const bgColor = Color(0xfff7f4ed);
// const bgColor = Color(0xfffdfaed);
const bgColor = Color(0xfffbfaf3);
// const bgColorLight = Color(0xfffbfaf3);
const bgColorDark = Color(0xfffbf4d0);
// const wtspGreen = Color(0xff25d49d);
const darkMain = Color(0xffa95a1e);
const wtspGreenLight = Color(0xffdaf9c4);

class UserData {
  int? age;
  AddressResult? address;

  UserData(
    this.age,
    this.address,
  );
}

var categoryColors = const [
  Color(0xffCC59E9), // 0
  Color(0xffFF4F03), // 1
  Color(0xffFD114A), // 2
  Color(0xff00DA8F), // 3
  Color(0xffFFA800), // 4
  Color(0xff00B4D3), // 5
  // Color(0xff006ad3), // Blue
  Color(0xffA80292), // 6
  Color(0xff7ADA00), // 7
];

// class EventCategory {
//   final CategoryType? categoryType;
//   final String? categoryName;
//   final Color? categoryColor;
//   final String? coverImagePath;
//
//   EventCategory({
//     this.categoryType,
//     this.categoryName,
//     this.categoryColor,
//     this.coverImagePath,
//   });
// }

var categories = [
  EventCategory(
      categoryType: CategoryType.sport,
      // categoryName: 'לאימונים וספורט',
      categoryName: 'לספורט',
      // ' 👟',
      categoryColor: categoryColors[4],
      coverImagePath: 'assets/covers/sport.png'),

  EventCategory(
      categoryType: CategoryType.weekend,
      // categoryName: 'ליציאות בסופש',
      categoryName: 'ליציאות בסופש',
      // ' 🍻',
      categoryColor: categoryColors[0],
      coverImagePath: 'assets/covers/weekend.png'),

  // EventCategory(
  //     categoryType: CategoryType.barPub,
  //     // categoryName: 'לברים ומועדונים',
  //     categoryName: 'לברים ומועדונים',
  //     categoryColor: categoryColors[0], // 1
  //     coverImagePath: 'assets/covers/bar_pub.png'),

  EventCategory(
      categoryType: CategoryType.boardGames,
      // categoryName: 'למשחקי קופסא',
      categoryName: 'למשחקי שולחן',
      // ' 🎲',
      categoryColor: categoryColors[2],
      coverImagePath: 'assets/covers/board_games.png'),
  EventCategory(
      categoryType: CategoryType.otherEvent,
      // categoryName: 'למפגשים ספונטנים',
      categoryName: 'למפגשים ספונטנים',
      // ' 👋',
      categoryColor: categoryColors[3],
      coverImagePath: 'assets/covers/other_event.png'),

  // EventCategory(
  //     categoryType: CategoryType.party,
  //     // categoryName: 'למסיבות ואירועים',
  //     categoryName: 'למסיבות ואירועים',
  //     categoryColor: categoryColors[6],
  //     coverImagePath: 'assets/covers/party.png'),

  EventCategory(
      categoryType: CategoryType.show,
      // categoryName: 'ללכת להופעות',
      categoryName: 'להופעות ומסיבות',
      // ' 🎉',
      categoryColor: categoryColors[1],
      coverImagePath: 'assets/covers/show.png'),
  EventCategory(
      categoryType: CategoryType.trip,
      // categoryName: 'לטיולים וחופשות',
      categoryName: 'לטיולים',
      // ' 🍃',
      categoryColor: categoryColors[7],
      coverImagePath: 'assets/covers/trip.png'),
  EventCategory(
      categoryType: CategoryType.lecture,
      // categoryName: 'לסדנאות והרצאות',
      categoryName: 'לאירועים מיוחדים',
      categoryColor: categoryColors[6],
      coverImagePath: 'assets/covers/lecture.png'),

  EventCategory(
      categoryType: CategoryType.volunteer,
      categoryName: 'להתנדב',
      categoryColor: categoryColors[5],
      coverImagePath: 'assets/covers/lecture.png'),
];

var sampleEvent = EventItem(
  title: 'סמי טריילר להובלת עצים, 45 ק"מ',
  id: '121',
  destinationAddress: 'חבקוק 114, גדרה',
  destinationLat: '433224',
  destinationLong: '334241',
  distanceFromUser: 12,
  truckType: 'משאית',
  price: '300',
  createdAt: DateTime.now(),
  originAddress: 'חבקוק 114, גדרה',
  originLat: '433224',
  originLong: '334241',
);
