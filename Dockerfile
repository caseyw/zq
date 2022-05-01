FROM golang:1.18 as builder
RUN CGO_ENABLED=0 go install github.com/brimdata/zed/cmd/zq@latest

FROM scratch
COPY --from=builder /go/bin/zq .

ENTRYPOINT ["./zq"]