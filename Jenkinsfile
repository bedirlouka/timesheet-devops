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
            steps {
                script {
                    sh 'docker build -t mbedir/timesheet-devops:1.0.0 .'
                }
            }
        }
          stage('Push Docker Image to DockerHub') {
             steps {
                 script {
                     sh '''
                     docker login -u mbedir -p 223AFT1221
                     docker push mbedir/timesheet-devops:1.0.0
                     '''
                }
            }
         }
        stage('Docker compose (FrontEnd BackEnd MySql)') {
            steps {
                script {
                    sh 'sudo systemctl stop mysql'
                    sh 'docker-compose up -d'
                }
            }
        }
    }

}
