package main

import (
	"context"
	"mongo-rest-docker/config/dbconfig"
	"mongo-rest-docker/mongodb"
	"mongo-rest-docker/server"
)

func main() {
	ctx := context.Background()

	//Mongodb start database
	mongodb.StartDatabase(ctx, dbconfig.Test)

	//Server start database
	server.StartServer()
}
