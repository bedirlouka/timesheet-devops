pipeline {
    agent any
    stages {
        stage('clean install') {
            steps {
                // Compile the Maven project
                sh 'mvn clean install'
            }
        }
        stage('SonarQube analysis') {
            steps {
                // Exécution de l'analyse de code avec SonarQube
                  sh ' mvn sonar:sonar \
                        -Dsonar.projectKey=timsheet-devops \
                        -Dsonar.host.url=http://192.168.56.2:9000 \
                        -Dsonar.login=654ace06b219a3a7c1f7c0e8dfa66bf7a8380867'
            }
        }
      /*  stage('Deploy to nexus'){
            steps
                {
                    echo 'Deploying to nexus server'
                    sh 'mvn deploy'
                }
        }*/
    }
}
