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
        stage('Build Docker Image (Spring Part)') {
            steps {
                script {
                    sh 'sudo chmod 666 /var/run/docker.sock'
                    def dockerImage=docker.build("mbedir/Timesheet-devops:latest")
                }
            }
        }
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerpwd')]) {
                        sh '''
                        docker login -u mbedir -p "$dockerpwd"
                        docker push mbedir/Timesheet-devops:latest
                        '''
                    }
                }
            }
        }

    }

}
