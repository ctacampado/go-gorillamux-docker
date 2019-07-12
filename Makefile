# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=test-app

all: test build
build: 
	$(GOBUILD) -o $(BINARY_NAME) -v
test: 
	$(GOTEST) -v ./...
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	docker image rm -f $(BINARY_NAME)
# Cross compilation
deploy-docker:
	docker build -t $(BINARY_NAME):latest .
	docker image prune --filter label=stage=build
	docker images