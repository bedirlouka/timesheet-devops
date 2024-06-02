pipeline {
    agent any

    tools {
        maven 'M2_HOME' // Assumes Maven is installed and named 'M2_HOME' in Jenkins global tool configuration
    }
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
                   sh '''
                    docker-compose down -v
                    docker-compose up -d
                    '''
                }
            }
        }
        stage('Monitoring Services G/P') {
    steps {
        script {
            def prometheusStatus = sh(script: "docker inspect -f {{.State.Running}} a0e931309b1a", returnStdout: true).trim()
            def grafanaStatus = sh(script: "docker inspect -f {{.State.Running}} c43b44e03e5f", returnStdout: true).trim()

            if (prometheusStatus == 'true') {
                echo "Prometheus is already running."
            } else {
                sh 'docker start a0e931309b1a'
            }

            if (grafanaStatus == 'true') {
                echo "Grafana is already running."
            } else {
                sh 'docker start c43b44e03e5f'
            }
        }
    }
}
        stage('Email Notification') {
            steps {
                mail bcc: '', 
                     body: '''

Stage: Compile
 - Building Spring project...

Stage: Tests - JUnit/Mockito
 - Testing Spring project...

Stage: SonarQube analysis
 - Running Sonarqube analysis...

Stage: Deploy to nexus
 - Deploying to Nexus...

Stage: Build Docker Image
 - Building Docker image for the application...

Stage: Push Docker Image
 - Pushing Docker image to Docker Hub...

Stage: Docker Compose
 - Running Docker Compose...

Stage: Monitoring Services G/P
 - Starting Prometheus and Grafana...

Final Report: The pipeline has completed successfully. No action required''', 
                     cc: '', 
                     from: '', 
                     replyTo: '', 
                     subject: 'Succès de la pipeline DevOps Project timesheet-devops', 
                     to: 'malekbedir70@gmail.com'
            }
        }
    }

}
