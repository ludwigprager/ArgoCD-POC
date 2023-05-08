# ArgoCD POC

This project is a ArgoCD playground to learn how to setup, use and configure ArgoCD without
investing much time and without risking to damage running installations in your project.  

This project is self-contained and has a zero-footprint. The tear-down script will
remove most traces from your experiments.


## Prerequisites
You need a linux machine to run on, any distribution should work fine.  
docker, docker-compose, yq, wget are required.

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

# Usage
Clone this repo and run the start script:

```
git clone https://github.com/ludwigprager/ArgoCD-POC.git
./ArgoCD-POC/10-deploy.sh
```
It will take a few minutes to to get the installation up and accessible.

This command will print all URLs along with the admin password to log into ArgoCD:
```
./ArgoCD-POC/print-console-links.sh 

```
