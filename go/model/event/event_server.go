package event_model

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func Initialize(r *gin.Engine) {
	r.GET("/events", getAllEvents)
	r.GET("/events/:id", getByID)
	r.POST("/events", create)
	r.PUT("/events", update)
	r.DELETE("/events/:id", delete)
}

func getAllEvents(c *gin.Context) {
	list := []Entity{}
	var onData OnData = func(e *Entity) {
		list = append(list, *e)
	}

	err := Service.GetAllWithFilter(c, onData, c.Request.URL.Query(), nil)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, list)
}

func getByID(c *gin.Context) {
	id := c.Param("id")

	entity, err := Service.GetByID(c, id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, entity)
}

func create(c *gin.Context) {
	var json Entity
	if err := c.ShouldBindJSON(&json); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	created, err := Service.Create(c, &json)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, created)
}

func update(c *gin.Context) {
	var json Entity
	if err := c.ShouldBindJSON(&json); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	updated, err := Service.Update(c, &json)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, updated)
}

func delete(c *gin.Context) {
	id := c.Param("id")

	_, err := Service.Delete(c, id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": id + " deleted"})
}
