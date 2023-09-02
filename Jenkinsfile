pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/MudassirKhan22/addressbookpractice.git'

                // Run Maven on a Unix agent.
                sh "mvn compile"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

           
        }
        
         stage('Test') {
            steps {
                // Get some code from a GitHub repository
               

                // Run Maven on a Unix agent.
                sh "mvn test"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

           
        }
        
         stage('Package') {
            steps {
                // Get some code from a GitHub repository
               

                // Run Maven on a Unix agent.
                sh "mvn package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

           
        }
    }
}
