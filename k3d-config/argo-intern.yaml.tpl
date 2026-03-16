apiVersion: k3d.io/v1alpha4
kind: Simple
metadata:
  name: argo-intern
servers: 1
agents: 0
ports:
  - port: ${INGRESS_PORT}:80
