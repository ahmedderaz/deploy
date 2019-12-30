pipeline {
    agent any
	
    environment {
       
        DOCKER_IMAGE_NAME = "13121988/nodejs-test"
    }
    stages {
         stage('Build') {	
             steps {	
             sh 'echo yes'	
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
                   docker.withRegistry('docker.io', 'docker_hub_login') {
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
}