pipeline {
    agent any
    stages {
        stage('Compile') {

            steps {
                // Compile the Maven project
                sh 'mvn compile'
            }
        }
        stage('Tests - JUnit/Mockito') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube analysis') {
            steps {
                // Exécution de l'analyse de code avec SonarQube

                  sh ''' mvn sonar:sonar \
                        -Dsonar.projectKey=timsheet-devops\
                        -Dsonar.host.url=http://192.168.56.2:9000\
                        -Dsonar.login=654ace06b219a3a7c1f7c0e8dfa66bf7a8380867'''
            }
        }
        stage('Deploy to nexus'){
            steps
                {
                    echo 'Deploying to nexus server'
                    sh 'mvn deploy'
                }
        }
        stage('Build Docker Image') {
            steps
                {
                   def imageTag = "mbedir/timesheet-devops:${BUILD_NUMBER}"
                   sh "docker build -t ${imageTag} ."
                }
             }
        stage('Push Docker Image to DockerHub') {
            steps {
                  def imageTag = "mbedir/timesheet-devops:${BUILD_NUMBER}"
                  sh """
                     docker login -u mbedir -p 223AFT1221
                     docker push ${imageTag}
                     """
                }
        }
        stage('Docker compose (FrontEnd BackEnd MySql)') {
           environment {
                        BUILD_NUMBER = "${env.BUILD_NUMBER}"
                     }
            steps {
            sh """
            docker-compose down -v
            docker-compose up -d
            """
        }
    }
        
    }

}
