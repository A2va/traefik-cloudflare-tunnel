FROM golang:1.23 as builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o traefik-cloudflare-tunnel .

# Create image from scratch
FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /app/traefik-cloudflare-tunnel /traefik-cloudflare-tunnel

ENTRYPOINT [ "/traefik-cloudflare-tunnel" ]