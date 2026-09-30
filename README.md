# 🍋 Docker + Pipeline CI/CD

## 📌 Sobre a atividade

Esta atividade tem como objetivo aplicar conceitos de **containerização** e **integração contínua (CI)** utilizando Docker e GitHub Actions.

Para a prática, foi utilizado um site estático de **Mousse de Maracujá** como aplicação de exemplo.

O projeto foi configurado para:

* Criar uma imagem Docker da aplicação;
* Executar a aplicação em um container;
* Utilizar o Nginx como servidor web;
* Automatizar o build da imagem através do GitHub Actions;
* Publicar automaticamente a imagem no Docker Hub.

---

## 🐳 Docker

A aplicação foi containerizada utilizando **Docker**.

O `Dockerfile` utiliza uma imagem do **Nginx Alpine** como base:

```dockerfile
FROM nginx:alpine

COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### 📦 Construção da imagem

Para criar a imagem Docker localmente:

```bash
docker build -t mousse-de-maracuja .
```

A imagem pode ser verificada utilizando:

```bash
docker images
```

---

## 🚀 Execução do container

Após a criação da imagem, o container pode ser iniciado com:

```bash
docker run -d -p 8080:80 --name mousse-maracuja-site mousse-de-maracuja
```

A aplicação fica disponível localmente em:

```text
http://localhost:8080
```

Para verificar os containers em execução:

```bash
docker ps
```

Para parar o container:

```bash
docker stop mousse-maracuja-site
```

Para iniciar novamente:

```bash
docker start mousse-maracuja-site
```

---

# ⚙️ Pipeline CI/CD

Para automatizar o processo de construção e publicação da imagem Docker, foi utilizado o **GitHub Actions**.

O pipeline é executado quando ocorre um `push` na branch `main`.

### Fluxo do pipeline

```text
       Push na branch main
                │
                ▼
        GitHub Actions
                │
                ▼
       Checkout do código
                │
                ▼
       Login no Docker Hub
                │
                ▼
       Build da imagem Docker
                │
                ▼
        Push para Docker Hub
                │
                ▼
    nicoleog12/mousse-de-maracuja
```

---

## 🔧 Workflow

O workflow está localizado em:

```text
.github/workflows/pepiline.yml
```

Configuração utilizada:

```yaml
name: Build and Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout código
        uses: actions/checkout@v4

      - name: Login no Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build e push da imagem
        uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/mousse-de-maracuja:latest
```

---

## 🔐 Secrets

As credenciais utilizadas pelo pipeline não são armazenadas diretamente no código.

Foram configurados **Repository Secrets** no GitHub:

```text
DOCKER_USERNAME
DOCKER_PASSWORD
```

### DOCKER_USERNAME

Armazena o usuário utilizado para autenticação no Docker Hub.

```text
nicoleog12
```

### DOCKER_PASSWORD

Armazena um **Access Token do Docker Hub** utilizado pelo GitHub Actions para realizar a autenticação e o envio da imagem.

Dessa forma, informações sensíveis não ficam expostas no arquivo do workflow.

---

# 📦 Docker Hub

Após o processo de build, a imagem é enviada automaticamente para o Docker Hub.

Imagem:

```text
nicoleog12/mousse-de-maracuja:latest
```

Para baixar a imagem:

```bash
docker pull nicoleog12/mousse-de-maracuja:latest
```

Para executar a imagem publicada:

```bash
docker run -d -p 8080:80 --name mousse-maracuja-site nicoleog12/mousse-de-maracuja:latest
```

A aplicação poderá ser acessada em:

```text
http://localhost:8080
```

---

# 🔄 Processo completo

O processo realizado na atividade pode ser representado da seguinte forma:

```text
┌─────────────────────┐
│     Código-fonte    │
│  HTML + CSS + IMG   │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│       Docker        │
│      Dockerfile     │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│    Docker Image     │
│ mousse-de-maracuja  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│    GitHub Actions   │
│       Pipeline      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│     Docker Hub      │
│ nicoleog12/...      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│      Container      │
│        Nginx        │
└──────────┬──────────┘
           │
           ▼
     localhost:8080
```

---

## 🎯 Objetivos alcançados

Com a atividade, foram aplicados os seguintes conceitos:

* [x] Criação de um `Dockerfile`;
* [x] Construção de uma imagem Docker;
* [x] Execução de uma aplicação em container;
* [x] Utilização do Nginx como servidor web;
* [x] Configuração de um pipeline no GitHub Actions;
* [x] Autenticação do pipeline no Docker Hub;
* [x] Utilização de Secrets para proteger credenciais;
* [x] Build automatizado da imagem;
* [x] Push automatizado da imagem para o Docker Hub;
* [x] Execução da imagem publicada.

---

## 🍋 Projeto utilizado

**Aplicação:** Mousse de Maracujá
**Tipo:** Site estático
**Servidor:** Nginx
**Containerização:** Docker
**Pipeline:** GitHub Actions
**Registry:** Docker Hub
**Imagem:** `nicoleog12/mousse-de-maracuja:latest`

---

### 💛 Resultado

A atividade demonstra um fluxo básico de **CI/CD para uma aplicação containerizada**, desde o código-fonte até a criação, publicação e execução da imagem Docker.
