# Introduction

Ansible `2.9.6`  (python 3)

Image docker permettant de lancer ansible de manière uniforme quelque soit l'environnement hôte,
avec une version "officielle" et "supportée" par et pour les playbook d'infrastructure.

# TLDR;

```bash
$ docker build -t trv/ansible .
$ 
```

```
$ cd projects/bixxi-platform
$ docker run --rm -v $(pwd):/root/bixxi-platform -v /c/Users/$USERNAME/.ssh:/root/.ssh -ti trv/ansible /bin/bash
```

```
# cd 
# cd bixxi-platform
# ansible-playbook -i inventory/bixxi/ovh-alo playbooks/bixxi-platform.yml -u arnauld -v 2>&1 | tee ansible-output-2.log
```

# Notes

## ansible all infra

```bash
-v $(pwd):/root/bixxi-platform
```

On monte le repertoire courant (`cd projects/bixxi-platform`) contenant le projet `bixxi-platform` dans un dossier `bixxi-platform` du container.

## SSH

```
-v /c/Users/$USERNAME/.ssh:/root/.ssh
```

Le container docker utilise le user `root`, on monte ses propres clés ssh (`/c/Users/$USERNAME/.ssh`) pour qu'elles puissent être utilisées via ansible.