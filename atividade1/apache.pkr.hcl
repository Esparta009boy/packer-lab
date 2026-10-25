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
    "EXPOSE 80",
    "CMD [\"apache2ctl\", \"-D\", \"FOREGROUND\"]"
  ]
}

build {
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get install -y apache2"
    ]
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/var/www/html/index.html"
  }

  post-processor "docker-tag" {
    repository = "meu-apache-packer"
    tags       = ["latest"]
  }
}