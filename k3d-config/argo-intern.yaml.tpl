apiVersion: k3d.io/v1alpha3
kind: Simple

ports:
  - port: ${INGRESS_PORT}:80
#   nodeFilters:
#     - loadbalancer
