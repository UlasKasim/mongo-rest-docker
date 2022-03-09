package dbconfig

//DbConfig Struct for database config
type DbConfig struct {
	MongoURI string
	DbName   string
}

//Test Test config for db
var Test = &DbConfig{MongoURI: "mongodb://mongo-rs0-1:27017,mongo-rs0-2/?replicaSet=rs0", DbName: "Mongo-Rest-Docker"}
