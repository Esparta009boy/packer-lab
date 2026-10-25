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
}

build {
  sources = ["source.docker.ubuntu"]

  # 1. Instalar o Node.js e o npm via shell
  provisioner "shell" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get install -y nodejs npm"
    ]
  }

  # 2. Criar a pasta /app dentro da imagem
  provisioner "shell" {
    inline = [
      "mkdir -p /app"
    ]
  }

  # 3. Copiar o package.json local para dentro de /app na imagem
  provisioner "file" {
    source      = "package.json"
    destination = "/app/package.json"
  }

  # 4. Executar o comando npm install dentro da pasta /app
  provisioner "shell" {
    inline = [
      "cd /app && npm install"
    ]
  }

  # Pós-processor para atribuir o nome exigido no requisito
  post-processor "docker-tag" {
    repository = "ambiente-node"
    tags       = ["v1"]
  }
}