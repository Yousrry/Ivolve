@Library('Shared-Library')_
pipeline {
    agent any
    environment {
        dockerHubCredentialsID	    = 'DockerHub'  		    			// DockerHub credentials ID.
        imageName   		    = 'engyousry/spring-app'     			// DockerHub repo/image name.
	openshiftCredentialsID	    = 'Openshift'		    		        // service account token credentials ID
	openshiftClusterURL	    = 'https://api.ocp-training.ivolve-test.com:6443'   // OpenShift Cluser URL.
        openshiftProject 	    = 'mohamedyousry'			     		// OpenShift project name.
        }
    stages {
        
        stage('Repo Checkout') {
            steps {
			checkout scm
            }
        }

        stage('Run Unit Test') {
            steps {
                script {
                	dir('App') {
                		runUnitTests
            		}
        	}
    	    }
	}
	
	
        stage('Run SonarQube Analysis') {
            steps {
                script {
                    	dir('App') {
                    		SonarAnalysis
                    	}
                }
            }
        }
       

    

        stage('Build Docker Image') {
            steps {
                script {
                 	dir('App') {
                 		buildDockerImage("${imageName}")
                    	}
                }
            }
        }
        stage('push Docker Image') {
            steps {
                script {
                 	dir('App') {
                 		pushDockerImage("${dockerHubCredentialsID}", "${imageName}")
                    	}
                }
            }
        }


        stage('Deploy on OpenShift Cluster') {
            steps {
                script { 
                	dir('OpenShift') {
				deployOnOpenShift("${openshiftCredentialsID}", "${openshiftClusterURL}", "${openshiftProject}", "${imageName}")
                    	}
                }
            }
        }
    }

    post {
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }
}

