import 'package:dart/src/model/event.dart';

class MongoFactory {
  static Object? fromMap(Type t, Map<String, dynamic>? map) {
    switch (t) {
      case Event:
        return Event.fromMongoMap(map);
      default:
        return null;
    }
  }
}
