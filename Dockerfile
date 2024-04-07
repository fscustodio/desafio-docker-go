FROM golang:alpine AS builder

WORKDIR /usr/src/app

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-s -w' -o fullcycle main.go

FROM scratch

COPY --from=builder /usr/src/app /

CMD ["/fullcycle"]