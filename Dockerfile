FROM golang:1.16-alpine AS builder

ENV GO111MODULE=on \
    CGO_ENABLED=0 \ 
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build

ADD go.mod go.sum main.go ./

ADD app /build/app

ADD model /build/model

ADD public /build/public

RUN go mod download

RUN go build -o main .

WORKDIR /dist

RUN cp /build/main .

FROM scratch

COPY --from=builder /dist/main .

ENTRYPOINT ["/main"]
