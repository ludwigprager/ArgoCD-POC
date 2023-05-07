apiVersion: argoproj.io/v1alpha1

kind: Application

metadata:

  name: argo-application

  namespace: default

spec:

  project: default

  source:
    
    repoURL: ssh://git@${GITEA}:8022/lp/${REPO}.git
    
    targetRevision: HEAD

    path: dev

  destination: 

    server: https://kubernetes.default.svc

    namespace: myapp

  syncPolicy:

    syncOptions:

    - CreateNamespace=true

    automated:

      selfHeal: true

      prune: true
