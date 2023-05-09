# ArgoCD POC

## TL;DR
Clone this repo and run the start script:

```
git clone https://github.com/ludwigprager/ArgoCD-POC.git
./ArgoCD-POC/10-deploy.sh
```

The next command prints the argocd admin password and the URLs to reach the demo apps:
```
./ArgoCD-POC/print-console-links.sh 

```

## Description

This project is an ArgoCD playground to install, configure and use ArgoCD
in a matter of minutes and without risking to damage running installations.

This project is self-contained and has a small footprint. The [tear-down script](./90-teardown.sh) will
remove most traces from your experiments.

## Prerequisites
- a linux machine. Any distribution should work fine.  
- docker, docker-compose, yq, wget installed

## How this POC works

ArgoCD surveys a git repository outside of the cluster.
In regular intervals, it tests for a drift in configuration
and attempt a reconciliation if found.

The [launcher script](./10-deploy.sh) will
- start a local git-server (gitea) in docker-compose
- start a local kubernetes cluster (k3d)
- install ArgoCD
ArgoCD then installs the example applications that are referenced in [the manifest](./manifest/application.yaml.tpl)

You can then access the ArgoCD ui and the example applications via ingresses using your browser.

# Script Properties

The script adhere to the following principles:

- idempotent
- exit on first error
- does not depend on the working directory of the caller
