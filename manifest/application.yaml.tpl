apiVersion: argoproj.io/v1alpha1
kind: Application

metadata:
  name: ${REPO}
  namespace:  argocd

spec:

  project: default

  source:
    repoURL: http://${PRIMARY_IP}:3000/lp/${REPO}.git
    targetRevision: HEAD
    path: .

  destination: 
    server: https://kubernetes.default.svc
    namespace: default

  syncPolicy:

    syncOptions:
    - CreateNamespace=true

    automated:
      selfHeal: true
      prune: true
