apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage
  labels:
    app: productpage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: productpage
  template:
    metadata:
      labels:
        app: productpage
    spec:
      containers:
      - name: equipo9-k8s-productpage
        image: arcones/equipo9-k8s-productpage
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9080
        env:
        - name: DETAILS_HOSTNAME
          value: {{DETAILS_HOSTNAME}}
        - name: REVIEWS_HOSTNAME
          value: {{REVIEWS_HOSTNAME}}
