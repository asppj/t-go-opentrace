

protoDir=./api/proto/
task=task
plan=plan
rpc:
	protoc --go_out=plugins=grpc:. ${protoDir}${task}/*.proto
	protoc --go_out=plugins=grpc:. ${protoDir}${plan}/*.proto

build:
	go get -v
	go test ./test
	go build -v


publish:
	docker build . -t "lolita:latest"
	docker push asppj/lolita:latest

compose:
	docker-compose -f docker-compose.yml down
	docker-compose -f docker-compose.yml up -d --force-recreate

start:
	go run main.go
run:
	chmod +x run.sh &&./run.sh

lint:
	gocyclo -top 15 .