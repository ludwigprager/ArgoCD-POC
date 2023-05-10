# ArgoCD POC

## TL;DR
Clone this repo and run the start script:

```
git clone https://github.com/ludwigprager/ArgoCD-POC.git
./ArgoCD-POC/10-deploy.sh
```

Display URL endpoints created by this poc:
```
./ArgoCD-POC/print-console-links.sh 
```

## Description

This project is an ArgoCD playground to install, configure and run ArgoCD
in a matter of minutes without risking to damage running installations.  
This project is self-contained and has a small footprint. The [tear-down script](./90-teardown.sh) will
remove most traces from your experiments.

## Prerequisites
- a linux machine. Any distribution should work fine.  
- docker, docker-compose, jq, yq, wget installed

## How this POC works

ArgoCD surveys a git repository outside of the cluster.
In regular intervals, it tests for a drift in configuration
and attempt a reconciliation if found.

The [launcher script](./10-deploy.sh) will
- start a local git-server (gitea) in docker-compose
- start a local kubernetes cluster (k3d)
- install ArgoCD
ArgoCD in turn installs the example applications that are referenced in [the manifest](./manifest/application.yaml.tpl)

Open the ArgoCD ui and the example applications in your browser.
Call the [provided script](./print-console-links.sh) to see the URLs and the argocd admin password.

The applications were copied from the [argocd example repo](https://github.com/argoproj/argocd-example-apps) and the
[FluxCD example app](https://github.com/stefanprodan/podinfo).

# Possible Applications
- manage multiple clusters with a single argocd server
- resiliency tests: ArgoCD autorepairs a number of properties, but details of effects are hard to discover without tests.
- promotion from pre-prod to prod: you can start a prod and pre-prod cluster with k3d.
- Behaviour of ArgoCD in various circumstances, e.g. network failures, already present objects in kubernetes, RBAC properties et.al.

# Script Properties

The bash scripts adhere to the following principles:
- idempotent
- exit on first error
- independent of the caller's working directory
- possibility of quick tear down and rebuild.
