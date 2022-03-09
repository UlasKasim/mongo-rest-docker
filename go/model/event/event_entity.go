package event_model

import "go.mongodb.org/mongo-driver/bson/primitive"

type Entity struct {
	ID          primitive.ObjectID `json:"id" bson:"_id,omitempty"`
	Title       string             `json:"title"`
	Description string             `json:"description"`
}
