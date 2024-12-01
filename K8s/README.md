
---

# **Kubernetes Setup for NTI Project**

This repository contains the **Kubernetes configuration** for deploying a **3-tier architecture** with **Frontend (ReactJS)**, **Backend (Node.js/Express)**, and **MongoDB** using **StatefulSet** for MongoDB, **Deployments** for frontend and backend, and **Services** to expose the applications.



## **How to Use**

### **1. Clone the Repository**

Clone this repository to your local machine:
```bash
git clone <repository-url>
cd <project-directory>
```

### **2. Set Up Kubernetes Cluster (EKS)**

Ensure that you have an EKS cluster running and configured to interact with `kubectl`:
```bash
aws eks --region <your-region> update-kubeconfig --name <cluster-name>
```

### **3. Apply Kubernetes Resources**

Once the cluster is set up, apply the Kubernetes manifests to deploy the resources:

1. **Create Persistent Volume Claim (PVC)** for MongoDB:
   ```bash
   kubectl apply -f kubernetes/pvc/mongo-pvc.yaml
   ```

2. **Deploy MongoDB StatefulSet**:
   ```bash
   kubectl apply -f kubernetes/deployments/mongodb-deployment.yaml
   ```

3. **Deploy Backend (API)**:
   ```bash
   kubectl apply -f kubernetes/deployments/backend-deployment.yaml
   ```

4. **Deploy Frontend (ReactJS)**:
   ```bash
   kubectl apply -f kubernetes/deployments/frontend-deployment.yaml
   ```

5. **Apply Services** to expose the applications:
   ```bash
   kubectl apply -f kubernetes/services/
   ```

---

## **Verify the Deployment**

After applying the resources, check that everything is running as expected:

- **Check Pods** to verify the deployments:
  ```bash
  kubectl get pods
  ```

- **Check Services** to verify the exposed ports:
  ```bash
  kubectl get svc
  ```

- **View Logs** of a specific pod for troubleshooting:
  ```bash
  kubectl logs <pod-name>
  ```

---

## **Access the Services**

Once the services are up and running, you can access the **Frontend** and **Backend** as follows:

- **Frontend** will be exposed on port `31000` (NodePort).
- **Backend API** will be exposed on port `31001` (NodePort).

You can access the services using the following URLs:

- **Frontend**: `http://<node-ip>:31000`
- **Backend**: `http://<node-ip>:31001`

---

## **Scaling the Application**

You can scale the number of replicas for each deployment as needed. For example:

```bash
kubectl scale deployment frontend --replicas=4
kubectl scale deployment backend --replicas=4
kubectl scale statefulset mongodb --replicas=3
```

---

## **Cleanup**

To clean up the Kubernetes resources after testing or production use, run:

```bash
kubectl delete -f kubernetes/
```

---

## **Technologies Used**

- **Kubernetes**: For orchestrating the containerized application.
- **ReactJS**: Frontend framework for building the user interface.
- **Node.js**: Backend API built using Node.js and Express.
- **MongoDB**: NoSQL database for data storage, running in a StatefulSet.
- **AWS EKS**: Managed Kubernetes service to run the application.
- **ConfigMaps**: For managing environment variables and configuration data.

