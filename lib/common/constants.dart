import 'package:flutter/material.dart';

import 'models/event_category.dart';

const bgColor = Color(0xff1d1b31);

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



var categories = const [
  EventCategory(
      categoryType: CategoryType.weekend,
      categoryName: 'קבוצות 18-24 ליציאה בסופש',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/weekend.png'),
  EventCategory(
      categoryType: CategoryType.barPub,
      categoryName: 'קבוצות 18-24 לברים ומועדונים',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/bar_pub.png'),
  EventCategory(
      categoryType: CategoryType.boardGames,
      categoryName: 'קבוצות 18-24 למשחקי קופסא',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/board_games.png'),
  EventCategory(
      categoryType: CategoryType.otherEvent,
      categoryName: 'קבוצות 18-24 למפגשים ספונטנים',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/other_event.png'),
  EventCategory(
      categoryType: CategoryType.sport,
      categoryName: 'קבוצות 18-24 לאימונים וספורט',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/sport.png'),
  EventCategory(
      categoryType: CategoryType.lecture,
      categoryName: 'קבוצות 18-24 לסדנאות והרצאות',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/lecture.png'),
  EventCategory(
      categoryType: CategoryType.party,
      categoryName: 'קבוצות 18-24 למסיבות ואירועים',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/party.png'),
  EventCategory(
      categoryType: CategoryType.trip,
      categoryName: 'קבוצות 18-24 לטיולים וחופשות',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/trip.png'),
  EventCategory(
      categoryType: CategoryType.show,
      categoryName: 'קבוצות 18-24 ללכת להופעות',
      categoryColor: Color(0xff1d1b31),
      coverImagePath: 'assets/covers/show.png'),
];
