import 'package:dart/src/config/db_config.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoUtils {
  static Db? db;

  static Future<DbCollection> connection(String collection) async {
    try {
      await checkDbConnection();
      return MongoUtils.db!.collection(collection);
    } catch (e) {
      print('Catch in connection');
      print(e);
      await Future.delayed(Duration(seconds: 1));
      await checkDbConnection(reconnect: true);
      return connection(collection);
    }
  }

  static Future<void> checkDbConnection({bool reconnect = false}) async {
    if (db == null || reconnect) {
      if (reconnect) print('reconnecting');
      db = Db(DbConfig.testDB().getURI());
      await db!.open();
    }
  }
}

extension MapExtension on Map<String, dynamic>? {
  void modifyForToProto3JSON() {
    if (this == null) return;
    this!['id'] = idAsHexString;
  }

  String get idAsHexString {
    try {
      return (this!['_id'] as ObjectId).toHexString();
    } catch (e) {
      return '';
    }
  }
}
