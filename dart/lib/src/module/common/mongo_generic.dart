import 'package:mongo_dart/mongo_dart.dart';
import '../../model/_model_exporter.dart';
import '../../mongo/_mongo_exporter.dart';
import '_common_exporter.dart';

class MongoGeneric<T extends ModelBase> {
  String collection;

  MongoGeneric({required this.collection});

  T createMessage(Map<String, dynamic>? map) {
    return (MongoFactory.fromMap(T, map)!) as T;
  }

  Future<List<T>> getAll({dynamic selector}) async {
    var connection = await MongoUtils.connection(collection);
    var list = <T>[];
    await connection.find(selector).forEach((map) {
      list.add(createMessage(map));
    });
    return list;
  }

  Future<int> getCount({dynamic selector}) async {
    var connection = await MongoUtils.connection(collection);
    return await connection.find(selector).length;
  }

  Future<T> getById({required String id}) async {
    try {
      var connection = await MongoUtils.connection(collection);
      var map = await connection.findOne(where.id(ObjectId.fromHexString(id)));
      return createMessage(map);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MongoCreateResponse<T>> create({required T message}) async {
    var connection = await MongoUtils.connection(collection);
    var doc = message.toMap();
    doc.remove('id');
    var res = await connection.insertOne(doc);
    T item = await getById(id: res.document.idAsHexString);
    return MongoCreateResponse<T>(model: item);
  }

  Future<MongoUpdateResponse<T>> update({required T message, required String id}) async {
    try {
      var connection = await MongoUtils.connection(collection);
      await connection.modernUpdate(where.id(ObjectId.fromHexString(id)), message.toMap());
      return MongoUpdateResponse<T>(updated: await getById(id: id));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MongoDeleteResponse> delete({required String id}) async {
    try {
      var connection = await MongoUtils.connection(collection);
      await connection.deleteOne(where.id(ObjectId.fromHexString(id)));
      return MongoDeleteResponse(id: id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
