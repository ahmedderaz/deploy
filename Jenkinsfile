pipeline {
    agent any
	 tools {nodejs "node"}
    environment {
       
        DOCKER_IMAGE_NAME = "ahmedderaz/nodejs-test"
    }
    stages {
         stage('Build') {	
             steps {	
             sh 'npm config ls'	
            }	
                    }
		}
		       
		
       
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'deploy.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
