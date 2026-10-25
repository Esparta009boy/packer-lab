# 🚀 Laboratório Prático: Infraestrutura Imutável com HashiCorp Packer & Docker

<p align="center">
  <img src="https://img.shields.io/badge/Packer-1.11.2-1676D9?style=for-the-badge&logo=HashiCorp%20Packer&logoColor=white" alt="Packer">
  <img src="https://img.shields.io/badge/Docker-Engine-2496ED?style=for-the-badge&logo=Docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/DevOps-Immutable%20Infrastructure-2ea44f?style=for-the-badge" alt="DevOps">
</p>

---

## 📋 Sumário
1. [Sobre o Projeto](#-sobre-o-projeto)
2. [Propósito e Proposta em Ambientes Corporativos](#-propósito-e-proposta-em-ambientes-corporativos)
3. [Tecnologias e Conceitos Implementados](#-tecnologias-e-conceitos-implementados)
4. [Estrutura do Repositório e Implementação](#-estruturas-do-repositório-e-implementação)
5. [Guia de Execução e Validação](#-guia-de-execução-e-validação)
6. [Conclusão e Benefícios Corporativos](#-conclusão-e-benefícios-corporativos)

---

## 🎯 Sobre o Projeto

Este repositório documenta a execução de um laboratório prático de DevOps focado no conceito de **Infraestrutura Imutável** e no processo de **"Baking" (preparação de imagens)** utilizando o **HashiCorp Packer** integrado ao **Docker**[cite: 1, 4]. O objetivo central foi automatizar a criação de imagens padronizadas, eliminando configurações manuais propensas a falhas[cite: 1].

---

## 🏢 Propósito e Proposta em Ambientes Corporativos

Em ambientes corporativos modernos, a gestão tradicional de servidores baseada em configuração manual (*Configuration Drift*) gera inconsistências entre ambientes de desenvolvimento, homologação e produção. 

A proposta deste laboratório reflete as melhores práticas de mercado (*Infrastructure as Code - IaC*):
* **Padronização e Repetibilidade:** Garantir que todos os ambientes sejam rigorosamente idênticos.
* **Segurança e Conformidade:** Injetar dependências, patches e artefatos de forma controlada antes que o container ou servidor seja instanciado em produção.
* **Agilidade no *Deployment*:** Reduzir o tempo de provisionamento, uma vez que as imagens já chegam prontas para execução imediata (*Plug-and-Play*).

---

## 🛠️ Tecnologias e Conceitos Implementados

* **HashiCorp Packer:** Ferramenta de código aberto para criar imagens de máquina imutáveis a partir de uma única fonte de configuração escrita em HCL (*HashiCorp Configuration Language*). Ele automatiza o ciclo de vida: inicializa uma instância, aplica as personalizações (*provisioners*) e congela o resultado em uma imagem final[cite: 1, 4, 5].
* **Docker & Containers:** Tecnologia de virtualização baseada em sistema operacional que empacota aplicações e suas dependências em containers leves, garantindo isolamento e portabilidade.
* **Infraestrutura Imutável:** Paradigma onde os servidores ou imagens nunca são modificados após o *deploy*. Caso seja necessária uma atualização, uma nova imagem é gerada e substituída por completo.
* **Provisioners (Shell & File):** Mecanismos do Packer utilizados para executar comandos de script dentro da imagem durante o build (`shell`) e transferir arquivos locais para dentro do sistema de arquivos do container (`file`)[cite: 1].

---

## 📂 Estrutura do Repositório e Implementação

O laboratório foi dividido em três cenários práticos progressivos:

### 1. Atividade 1: Servidor Web Apache (`/atividade1`)
* **Objetivo:** Criar uma imagem baseada em `ubuntu:jammy` que instala o servidor web Apache (`apache2`) e injeta um arquivo HTML personalizado (`index.html`) diretamente no diretório raiz do servidor (`/var/www/html/`)[cite: 1].
* **D destaque técnico:** Respeito estrito à ordem dos *provisioners* (instalação do pacote primeiro para criação prévia da árvore de diretórios, seguida pela cópia do arquivo) e configuração de pós-processador para rotulagem (*tagging*) como `meu-apache-packer:latest`[cite: 1].

### 2. Atividade 2: Ambiente Base para Python (`/atividade2`)
* **Objetivo:** Desenvolver uma imagem padronizada para equipes de desenvolvimento Python, embutindo o interpretador, o gerenciador de pacotes `pip`, a biblioteca `Flask` e estruturando o diretório de trabalho padrão (`WORKDIR /app`)[cite: 2].
* **Destaque técnico:** Automação completa do fluxo de dependências de desenvolvimento sem intervenção manual e versionamento da imagem como `ambiente-dev-python:v1`[cite: 2].

### 3. Atividade 3: Ambiente Node.js em Múltiplos Passos (`/atividade3`)
* **Objetivo:** Combinar múltiplos blocos de provisionamento sequencial para configurar um ambiente Node.js e npm, gerando e injetando um arquivo `package.json` local e executando a instalação de pacotes (`npm install`) dentro do diretório `/app`[cite: 3].
* **Destaque técnico:** Orquestração avançada de comandos encadeados (`cd /app && npm install`) e garantia de imutabilidade do ambiente JavaScript para produção[cite: 3].

---

## 🚀 Guia de Execução e Validação

Para reproduzir os builds das imagens utilizando o **GitHub Codespaces** ou um ambiente local com Docker e Packer configurados, utilize os seguintes comandos em cada diretório de atividade[cite: 4]:

```bash
# 1. Inicializar os plugins do Packer no diretório da atividade
packer init .

# 2. Validar a sintaxe do arquivo de configuração HCL
packer validate .

# 3. Executar o build para gerar a imagem imutável
packer build .
