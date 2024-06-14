#!/usr/bin/env groovy

def call(){ 
	withSonarQubeEnv(credentialsId: 'Sonarqube',installationName: 'Sonarqube' ) { 
	
		sh"./gradlew sonarqube  -Dsonar.projectKey=SpringApp  -Dsonar.host.url=http://35.174.205.184:9000 "
	 
	}
}
