// .set() / .update() = WRITE.
import 'package:around/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/event_item.dart';

class Database {
  static var db = FirebaseFirestore.instance;
  static final advanced = FsAdvanced();

  get dbSetting {
    db.settings = const Settings(
        persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  static void deleteDoc({required String collection, String? docName}) {
    db.collection(collection).doc(docName).delete();
  }

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

  static Future updateFirestore({
    required String collection,
    String? docName,
    required Map<String, dynamic> toJson,
    bool merge = true,
  }) async {
    db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: merge)) // Almost always true
        .onError((error, stackTrace) => print('updateFirestore ERR - $error'));
  }
}

class FsAdvanced {
  // Get 3 event start soon + Category filter
  // Get 3 lasted + Category filter
  // Get 3 location close + Category filter

  static final db = FirebaseFirestore.instance;

  //~ The 3 start soon events of each category:
  static Future<List<EventItem>> getHomeEvents() async {
    List eventDocs = [];
    List<EventItem> events = [];
    for (var category in categories) {
      var snap = await db
          .collection('events')
          .orderBy('eventAt', descending: true)
          .where('eventCategory.categoryType', isEqualTo: category.categoryType?.name)
          .limit(1) // 3
          .get();
      eventDocs.addAll(snap.docs);
    }
    events = eventDocs.map((doc) => EventItem.fromJson(doc.data())).toList();
    print('events ${events.length}');
    return events;
  }
}
