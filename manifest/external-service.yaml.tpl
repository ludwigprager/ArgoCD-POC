kind: Service
apiVersion: v1
metadata:
  name: argocd-poc
spec:
  ports:
    - name: ssh
      protocol: TCP
      port: 8022
      targetPort: 8022

---

kind: Endpoints
apiVersion: v1
metadata:
  name: argocd-poc
subsets: 
  - addresses:
        - ip: ${PRIMARY_IP}
    ports:
      - port: 8022
        name: ssh
