## **Testim integration with Nodejs sample app on docker to kubernetes cluster:**</br>

  
  - [**Steps to setup Testim integration for local/grid CLI runs:**<p>](#steps-to-setup-testim-integration-for-localgrid-cli-runsp)
  - [**Steps to build docker & publish to docker registry:**<p>](#steps-to-build-docker--publish-to-docker-registryp)
  - [**Steps to deploy in Kubernetes from CLI:** </br><p>](#steps-to-deploy-in-kubernetes-from-cli-brp)
  - [**Steps to deploy in Kubernetes via Jenkins Pipeline:** </br><p>](#steps-to-deploy-in-kubernetes-via-jenkins-pipeline-brp)
  - [**Extras**](#extras)
</br>

<img alt="alt_text" width="600px" src="docs/k8_arc.png" />

   *Disclaimer:  This Custom Action is provided "AS IS".  It is for instructional purposes only and is not officially supported by Testim*    </br></br>
   
<p>

###  **Steps to setup Testim integration for local/grid CLI runs:**<p>

* Run the following command within your node js application

        npm install --save @testim/testim-cli@latest

* Set testim-cli's dependency version as "latest" within package.json

* Update script -> test within package.json as applicable based on [docs](https://help.testim.io/docs/the-command-line-cli)

</br> 

###  **Steps to build docker & publish to docker registry:**<p>

* Create your Dockerfile and build docker:
    
        docker build -t nodejs .

* Run container:

        docker run -d --name nodejs -p 3000:3000 nodejs

* Login to docker and tag the existing docker image:

        docker tag nodejs genesisthomas/nodejs-starter:1.0

* Upload the image to docker registry:

        docker push genesisthomas/nodejs-starter:1.0
</br> 

###  **Steps to deploy in Kubernetes from CLI:** </br><p> 


* Set Testim's token & project id within k8s/mysecret.yaml.

* cd into k8s folder.

* The following command will deploy k8s, run testim tests & perform cleanup:</br>
  
        chmod +x pipeline.sh && ./pipeline.sh

</br>

###  **Steps to deploy in Kubernetes via Jenkins Pipeline:** </br><p> 


* Set Testim's token & project id as password parameters

* Select pipeline script from SCM -> Git -> Jenkinsfile


</br>

###   **Extras**
 <p>

* Follow [this](https://devopscube.com/jenkins-build-trigger-github-pull-request/) link to achieve automated build trigger on every github pull request.

* Follow [this](https://medium.com/bb-tutorials-and-thoughts/how-to-deploy-nodejs-apis-on-azure-aks-using-helm-8b37ab190d4e) to deploy NodeJS APIs on Azure AKS using HELM.

* Tool to convert docker-compose to k8s
https://kompose.io/ to convert docker-compose to k8s yamls:</br>

        kompose convert -f docker-compose.yaml
