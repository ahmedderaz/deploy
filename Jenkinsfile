pipeline {
    agent any
	
    environment {
       
        DOCKER_IMAGE_NAME = "13121988/nginx-test"
    }
    stages {
         stage('Build') {	
             steps {	
             sh 'echo yes'	
            }	
                    }
    stage('SonarQube Analysis') {
	steps {
        sh "/var/lib/jenkins/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonarqubescanner/bin/sonar-scanner -Dsonar.host.url=http://localhost:9000 -Dsonar.projectName=aly -Dsonar.projectVersion=1.0 -Dsonar.projectKey=aly:app -Dsonar.sources=. -Dsonar.projectBaseDir=/var/lib/jenkins/workspace/$JOB_NAME_$BRANCH_NAME"
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
		/**
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
               
                kubernetesDeploy(
                    configs: 'deploy.yml',
					kubeconfigId: 'kubeconfig',
                    enableConfigSubstitution: true
                )
            }
        }
		**/
		stage('Deploy to K8S'){
		steps {
		sh 'echo $PWD'
		sh 'kubectl apply -f deploy.yml --validate=false'
	
		}
    }
	}
}