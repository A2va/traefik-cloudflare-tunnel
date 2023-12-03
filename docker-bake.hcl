target "docker-metadata-action" {}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  context = "./traefik-cloudflare-tunnel"
}

target "all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7"
  ]
}