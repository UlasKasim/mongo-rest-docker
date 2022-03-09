# create image from the official Go image
FROM golang:alpine
RUN apk add --update tzdata \
    bash wget curl git;
# Create binary directory, install glide and fresh

ENV CGO_ENABLED 0    

RUN mkdir -p $$GOPATH/bin

# define work directory
ADD . /go/src/mongo-rest-docker
WORKDIR /go/src/mongo-rest-docker
# serve the app
CMD go install && go run main.go