# ArgoCD POC

This project is a ArgoCD playground to learn how to setup, use and configure ArgoCD without
investing much time and without risking to damage running installations in your project.

You need a linux machine to run on.

## How this POC works

ArgoCD, which runs in a k8s-cluster , surveys a git repository outside of the cluster.
In regularl intevals, e.g. every 5 minutes, it will test for a drift in configuration
and attempt a reconciliation if found.

With only few preconditions this POC will be set up in an isolated environment,
increment a version number in a git repository, demonstrate a reconciliation adn torn down again.

A launcher script will
- start a local git git-server (gitea) in docker-compose
- start a local kubernetes cluster (k3d)
- install ArgoCD
- make ArgoCD install a number of example applications

You can then access the ArgoCD ui and the example applications via ingresses using your browser.

# Usage
In [the configuration file of this POC](./set-env.sh) select either `multi-cluster` or `multi-tenancy`.
## Starten
```
git clone https://github.com/ludwigprager/ArgoCD-POC.git
./ArgoCD-POC/10-deploy.sh
```

This command will print all URLs along with the admin password to log into ArgoCD:
```
./ArgoCD-POC./print-console-links.sh 

```
