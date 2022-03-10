import 'package:dart/src/module/event/event_mongo.dart';
import 'package:alfred/alfred.dart';
import '../../model/_model_exporter.dart';

class EventServer {
  static void initialize(Alfred r) {
    r.get('/events', getAll);
    r.get('/events/:id', getByID);
    r.post('/events', create);
    r.put('/events', update);
    r.delete('/events/:id', delete);
  }

  static getAll(HttpRequest req, HttpResponse res) async {
    try {
      var list = await EventMongo().getAll();
      return (res..statusCode = 200).json(list.map((e) => e.toMap()).toList());
    } catch (e) {
      res.statusCode = 404;
      return e;
    }
  }

  static getByID(HttpRequest req, HttpResponse res) async {
    try {
      String id = req.params['id'];
      var event = await EventMongo().getById(id: id);
      return (res..statusCode = 200).json(event.toMap());
    } catch (e) {
      res.statusCode = 404;
      return e;
    }
  }

  static create(HttpRequest req, HttpResponse res) async {
    try {
      final body = await req.body;
      var response =
          await EventMongo().create(message: Event.fromMap(body as Map<String, dynamic>));
      return (res..statusCode = 201).json(response.model.toMap());
    } catch (e) {
      res.statusCode = 404;
      return e;
    }
  }

  static update(HttpRequest req, HttpResponse res) async {
    try {
      final body = await req.body;
      Event event = Event.fromMap(body as Map<String, dynamic>);
      var response = await EventMongo().update(id: event.id!, message: event);
      return (res..statusCode = 200).json(response.updated.toMap());
    } catch (e) {
      res.statusCode = 404;
      return e;
    }
  }

  static delete(HttpRequest req, HttpResponse res) async {
    try {
      String id = req.params['id'];
      var response = await EventMongo().delete(id: id);
      return (res..statusCode = 200).json(response.id);
    } catch (e) {
      res.statusCode = 404;
      return e;
    }
  }
}
