import 'package:dart/src/module/event/event_server.dart';
import 'package:alfred/alfred.dart';

Future<void> main(List<String> arguments) async {
  var app = Alfred();

  EventServer.initialize(app);

  await app.listen(8080);
}
