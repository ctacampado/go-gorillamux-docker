FROM golang:1.12.7-alpine AS build-env
LABEL stage=build
WORKDIR /go/src/test
COPY . /go/src/test
RUN CGO_ENABLED=0 GOOS=linux go build -o test-app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=build-env /go/src/test/test-app .
ENTRYPOINT ["./test-app"]