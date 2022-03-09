package mongodb

import (
	"context"
	"log"
	"mongo-rest-docker/config/dbconfig"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type handler struct {
	Client *mongo.Client
	D      *dbconfig.DbConfig
}

//H Current handler struct for mongo client
var H *handler

//StartDatabase Starts mongo connection operations
func StartDatabase(ctx context.Context, d *dbconfig.DbConfig) {
	H = &handler{D: d}

	client, err := mongo.NewClient(options.Client().ApplyURI(H.D.MongoURI))
	if err != nil {
		log.Fatalf("Error creating mongo client : %v", err)
	}
	err = client.Connect(ctx)
	if err != nil {
		log.Fatalf("Error connecting mongo %v", err)
	}

	H.Client = client
}

//GetCollection Retrieve mongo collection with collection name
func GetCollection(collection string) *mongo.Collection {
	return H.Client.Database(H.D.DbName).Collection(collection)
}
