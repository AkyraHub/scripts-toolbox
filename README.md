# Public Scripts Toolbox

This repository contains few scripts that can be used to execute some actions automatically.

# How to use

## install-k8s.sh

> Install Kubernetes on a Bare Metal server.

Execute this command from the server:

```bash
curl -o- https://raw.githubusercontent.com/AkyraHub/scripts-toolbox/trunk/install-k8s.sh | bash -s SERVER_IP SERVER_DNS
```

## setup-monorepo.sh

> Create a new monorepo project

Execute this command from the parent folder of the project:

```bash
curl -o- https://raw.githubusercontent.com/AkyraHub/scripts-toolbox/trunk/setup-monorepo.sh | bash -s CLIENT_NAME PROJECT_NAME (ORG_NAME)
```
