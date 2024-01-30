#build stage
FROM golang:1.21 AS build

WORKDIR /app

COPY full.go .

RUN go build full.go

#final image stage
FROM scratch

WORKDIR /app

COPY --from=build /app/full .

CMD ["./full"]