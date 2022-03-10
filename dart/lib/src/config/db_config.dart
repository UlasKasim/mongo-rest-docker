class DbConfig {
  static DbConfig? instance;
  String mongoURI;
  String dbName;
  String replicaSet;

  DbConfig({
    required this.mongoURI,
    required this.dbName,
    required this.replicaSet,
  });

  // factory DbConfig.local() {
  //   return DbConfig(
  //     mongoURI: 'mongodb://localhost:27017',
  //     dbName: 'mongo-rest-docker-dart',
  //     replicaSet: '',
  //   );
  // }

  factory DbConfig.testDB() {
    return DbConfig(
      mongoURI: 'mongodb://mongo-rs0-1:27017,mongo-rs0-2',
      dbName: 'mongo-rest-docker-dart',
      replicaSet: 'replicaSet=rs0',
    );
  }

  String getURI() {
    return '$mongoURI/$dbName?$replicaSet';
  }

  static void init({String? mode}) {
    instance = DbConfig.testDB();
  }
}
