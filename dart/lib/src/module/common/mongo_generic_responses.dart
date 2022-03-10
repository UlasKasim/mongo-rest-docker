import 'package:dart/src/model/model_base.dart';

class MongoCreateResponse<T extends ModelBase> {
  T model;
  MongoCreateResponse({required this.model});
}

class MongoUpdateResponse<T extends ModelBase> {
  T updated;
  MongoUpdateResponse({required this.updated});
}

class MongoDeleteResponse {
  String id;
  MongoDeleteResponse({required this.id});
}
