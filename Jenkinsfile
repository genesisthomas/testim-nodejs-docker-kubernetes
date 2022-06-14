pipeline {
  agent any
  tools {
    nodejs "node16"
  }

  environment {
    //   set path of kubectl, docker, etc
    PATH = "/opt/homebrew/opt/node@16/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:${env.PATH}"
  }

  stages {
    stage('Clean up') {
      steps {
        deleteDir()
      }
    }
    stage('Git') {
      steps {
        //   change the credentialsId & git url as required
        git credentialsId: 'githubGT', url: 'https://github.com/genesisthomas/testim-nodejs-docker-kubernetes'
      }
    }
    stage('setup secrets') {
        // Pass TOKEN & PROJECT as password parameter/ environment variable to the job
      steps {
        script {
          def content = """apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
stringData:
  TOKEN: ${TOKEN}
  PROJECT: ${PROJECT}"""
          writeFile(file: 'k8s/mysecret.yaml', text: content)
        }
      }
    }
    stage('Deploy on K8s & Run tests') {
    // deploys the app onto K8s, run testim tests on tunnel 3000
      steps {
        dir('k8s') {
          sh 'chmod +x pipeline.sh && ./pipeline.sh'
        }
      }
    }
    stage('Setup Production environment') {
        // Setup your production environment if needed
        steps {
            sh 'echo "Setup production environment here"'
        }
      }
  }
}