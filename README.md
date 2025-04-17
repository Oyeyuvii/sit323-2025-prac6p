Node.js Kubernetes Deployment
=============================

This project demonstrates how to containerize a Node.js application and deploy it to a Kubernetes cluster using Minikube on macOS.

Tech Stack
----------
- Node.js
- Express.js
- Docker
- Kubernetes (via Minikube)
- kubectl (Kubernetes CLI)

Project Structure
-----------------
.
├── app.js
├── package.json
├── Dockerfile
├── deployment.yaml
└── service.yaml

Setup Instructions (macOS)
---------------------------

1. Install Prerequisites

Make sure you have these installed:
- Homebrew: https://brew.sh/
- Node.js: brew install node
- Docker Desktop: https://www.docker.com/products/docker-desktop/
- Minikube: brew install minikube
- kubectl: brew install kubectl

2. Clone or Create the Project

Create a folder and add:
- app.js
- package.json
- Dockerfile

3. Start Minikube

    minikube start

(Use eval $(minikube docker-env) to use Minikube's Docker daemon.)

4. Build Docker Image

    docker build -t nodejs-app:v1 .

5. Create Kubernetes Resources

Create Deployment (deployment.yaml):

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nodejs-deployment
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: nodejs-app
      template:
        metadata:
          labels:
            app: nodejs-app
        spec:
          containers:
          - name: nodejs
            image: nodejs-app:v1
            ports:
            - containerPort: 3000

Apply Deployment:

    kubectl apply -f deployment.yaml

Create Service (service.yaml):

    apiVersion: v1
    kind: Service
    metadata:
      name: nodejs-service
    spec:
      type: ClusterIP
      selector:
        app: nodejs-app
      ports:
        - protocol: TCP
          port: 3000
          targetPort: 3000

Apply Service:

    kubectl apply -f service.yaml

Verify and Access the App
--------------------------

Check pods and services:

    kubectl get pods
    kubectl get services

Port Forward to Access Locally:

    kubectl port-forward service/nodejs-service 8080:3000

Visit in your browser:

    http://localhost:8080

You should see:

    Hello from Kubernetes + Node.js!

Cleanup
--------

    kubectl delete -f deployment.yaml
    kubectl delete -f service.yaml
    minikube stop
