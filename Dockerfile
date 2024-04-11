FROM golang:alpine3.19@sha256:cdc86d9f363e8786845bea2040312b4efa321b828acdeb26f393faa864d887b0 AS build

WORKDIR /app

# Pre-compile std lib, can be cached!
RUN CGO_ENABLED=0 GOOS=linux go install -v -installsuffix cgo -a std

COPY go.mod ./
RUN go mod download && go mod verify

COPY ./cmd ./cmd
COPY ./internal ./internal
RUN go build -v -o /app/bin/main ./cmd/api/main.go
RUN CGO_ENABLED=0 GOOS=linux go build -v -installsuffix cgo -o /app/bin/main -ldflags "-s -w" ./cmd/api/main.go

FROM scratch

COPY --from=build /app/bin/main /app/bin/main

EXPOSE 8888

CMD ["/app/bin/main"]
