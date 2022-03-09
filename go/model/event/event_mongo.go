package event_model

import (
	"context"
	"log"
	"mongo-rest-docker/mongodb"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type service struct{}

var Service = service{}

type OnData = func(*Entity)

func (s *service) getEventCollection() *mongo.Collection {
	return mongodb.GetCollection("Event")
}

//GetAllWithFilter Mongo GetAllWithFilter
func (s *service) GetAllWithFilter(ctx context.Context, onData OnData, filter interface{}, opts ...*options.FindOptions) error {
	cursor, err := s.getEventCollection().Find(ctx, filter, opts...)
	if err != nil {
		return err
	}
	defer cursor.Close(ctx)

	for cursor.Next(ctx) {
		data := &Entity{}
		err := cursor.Decode(data)
		if err != nil {
			return err
		}
		onData(data)
	}

	return nil
}

//GetCount Mongo GetCount
func (s *service) GetCount(ctx context.Context, filter interface{}, opts ...*options.CountOptions) (int64, error) {
	return s.getEventCollection().CountDocuments(ctx, filter, opts...)
}

//GetByID Mongo GetByID
func (s *service) GetByID(ctx context.Context, id string) (*Entity, error) {
	oid, err := primitive.ObjectIDFromHex(id)
	if err != nil {
		return nil, err
	}

	r := s.getEventCollection().FindOne(ctx, bson.M{"_id": oid})
	if r.Err() != nil {
		return nil, r.Err()
	}

	var entity = &Entity{}
	err = r.Decode(entity)
	if err != nil {
		return nil, err
	}

	return entity, nil
}

//Create Mongo Create
func (s *service) Create(ctx context.Context, e *Entity) (*Entity, error) {
	r, err := s.getEventCollection().InsertOne(ctx, e)
	if err != nil {
		return nil, err
	}

	oid, ok := r.InsertedID.(primitive.ObjectID)
	if !ok {
		log.Fatal(err)
	}

	created, err := s.GetByID(ctx, oid.Hex())
	return created, nil
}

//Update Mongo Update
func (s *service) Update(ctx context.Context, e *Entity) (*Entity, error) {
	r := s.getEventCollection().FindOneAndUpdate(ctx, bson.M{"_id": e.ID}, bson.M{"$set": e})
	if r.Err() != nil {
		return nil, r.Err()
	}

	var entity = &Entity{}
	err := r.Decode(entity)
	if err != nil {
		return nil, err
	}

	created, err := s.GetByID(ctx, e.ID.Hex())
	return created, nil
}

//Delete Mongo Delete
func (s *service) Delete(ctx context.Context, id string) (string, error) {
	oid, err := primitive.ObjectIDFromHex(id)
	if err != nil {
		return "", err
	}

	_, err = s.getEventCollection().DeleteOne(ctx, bson.M{"_id": oid})
	if err != nil {
		return "", err
	}

	return id, nil
}
