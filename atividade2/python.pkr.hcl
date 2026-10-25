packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:jammy"
  commit = true
  changes = [
    "WORKDIR /app"
  ]
}

build {
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get install -y python3 python3-pip",
      "mkdir -p /app",
      "pip3 install Flask"
    ]
  }

  post-processor "docker-tag" {
    repository = "ambiente-dev-python"
    tags       = ["v1"]
  }
}