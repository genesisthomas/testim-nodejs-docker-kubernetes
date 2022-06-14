
- [**Testim integration with Nodejs sample app on docker to kubernetes cluster:**</br>](#testim-integration-with-nodejs-sample-app-on-docker-to-kubernetes-clusterbr)
  - [**Steps to setup Testim integration for local/grid CLI runs:**](#steps-to-setup-testim-integration-for-localgrid-cli-runs)
  - [**Steps to build docker & publish to docker registry:**](#steps-to-build-docker--publish-to-docker-registry)
  - [**Steps to deploy in Kubernetes:** </br>](#steps-to-deploy-in-kubernetes-br)
    - [**Extras**](#extras)

</br>

   *Disclaimer:  This Custom Action is provided "AS IS".  It is for instructional purposes only and is not officially supported by Testim*    </br>

## **Testim integration with Nodejs sample app on docker to kubernetes cluster:**</br>

###  **Steps to setup Testim integration for local/grid CLI runs:**

* Run the following command within your node js application

        npm install --save @testim/testim-cli@latest

* Set testim-cli's dependency version as "latest" within package.json

* Update script -> test within package.json as applicable based on [docs](https://help.testim.io/docs/the-command-line-cli)

</br> 

###  **Steps to build docker & publish to docker registry:**

* Create your Dockerfile and build docker:
    
        docker build -t nodejs .

* Run container:

        docker run -d --name nodejs -p 3000:3000 nodejs

* Login to docker and tag the existing docker image:

        docker tag nodejs genesisthomas/nodejs-starter:1.0

* Upload the image to docker registry:

        docker push genesisthomas/nodejs-starter:1.0
</br> 

###  **Steps to deploy in Kubernetes:** </br> 


* Set Testim's token & project id within k8s/mysecret.yaml.

* cd into k8s folder.

* Set current namespace: </br>
  
        kubectl create ns nodejs-integration && kubectl config set-context --current --namespace=nodejs-integration

* The following shell will deploy k8s, run testim tests & perform cleanup:</br>
  
        chmod +x pipeline.sh && ./pipeline.sh



</br>

####   **Extras**

* Tool to convert docker-compose to k8s
https://kompose.io/ to convert docker-compose to k8s yamls:</br>

        kompose convert -f docker-compose.yaml
