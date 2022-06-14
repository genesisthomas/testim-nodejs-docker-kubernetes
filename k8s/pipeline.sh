#!/bin/bash
CODE=0
NAMESPACE = $1
# checks if namespace is supplied, defaults to node-dev
if [ -z "$1" ]
  then
    echo "No namespace is supplied as argument! Default: node-dev"
    NAMESPACE="node-dev"
fi
# delete entire namespace
kubectl delete all --all -n $NAMESPACE &
# create namespace
kubectl create ns $NAMESPACE || true &
# set's the namespace as current namespace
kubectl config set-context --current --namespace=$NAMESPACE || true & 
# deploys the namespace
kubectl apply -f . &&
    # waits for testim pod to be ready
    kubectl wait --for=condition=Ready -f testim-pod.yaml &&
    # shows the current status of pods and service
    kubectl get po,svc &&
    # confirms the status of testim pod
    echo  $(kubectl get pods testim --no-headers -o custom-columns=":status.phase") &&
    # Checks if testim pod is still running
    while [ $(kubectl get pods testim --no-headers -o custom-columns=":status.phase") == "Running" ]; do
        sleep 1
        kubectl logs --follow testim
    done &&
    echo  $(kubectl get pods testim --no-headers -o custom-columns=":status.phase") &&
    #  Checks the status of POD
    if [ $(kubectl get pods testim --no-headers -o custom-columns=":status.phase") == "Succeeded" ]; then
        echo 'Tests Passed!'
        CODE=0
    else
        echo 'Tests Failed!'
        CODE=1
    fi &&
    # delete entire namespace
    kubectl delete all --all -n $NAMESPACE &&
    docker container prune -f &&
    exit $CODE
