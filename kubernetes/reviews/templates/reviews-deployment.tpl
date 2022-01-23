apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews
  labels:
    app: reviews
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
  template:
    metadata:
      labels:
        app: reviews
    spec:
      containers:
      - name: equipo9-k8s-reviews
        image: arcones/equipo9-k8s-reviews
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9080
        env:
        - name: RATINGS_HOSTNAME
          value: {{RATINGS_HOSTNAME}}