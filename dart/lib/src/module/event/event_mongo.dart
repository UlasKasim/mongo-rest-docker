import 'package:dart/src/module/common/mongo_generic.dart';

import '../../model/_model_exporter.dart';

class EventMongo extends MongoGeneric<Event> {
  EventMongo() : super(collection: Event().runtimeType.toString());
}
