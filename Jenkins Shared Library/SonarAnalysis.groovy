#!/usr/bin/env groovy

def call(){ 
	withSonarQubeEnv() { 
        	echo "Starting SonarQube Analysis..."
		sh 'chmod +x gradlew'
        	sh "./gradlew sonar" 
	}
}
