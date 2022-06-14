#!/bin/bash
CODE=0
# delete entire namespace
kubectl delete all --all -n nodejs-integration &
# deploys the nodejs-integration namespace
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
    kubectl delete all --all -n nodejs-integration &&
    docker container prune -f &&
    exit $CODE
