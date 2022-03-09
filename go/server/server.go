package server

import (
	event_model "mongo-rest-docker/model/event"

	"github.com/gin-gonic/gin"
)

func StartServer() {
	gin.ForceConsoleColor()

	r := gin.Default()

	event_model.Initialize(r)

	r.Run()
}
