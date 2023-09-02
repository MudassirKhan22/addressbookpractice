pipeline {
    

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'Env to deploy')
        booleanParam(name:'executeTest',defaultValue:true,description:'Decide to tun TC')
        choice(name:'Appversion',choices:['1.1','1.2','1.3'],description:'List of app versions')
    
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                
                git 'https://github.com/MudassirKhan22/addressbookpractice.git'
                sh "mvn compile"
                echo "Env to deploy:${params.Env}"
            }

           
        }
        
         stage('Test') {
            agent any
            when{
                expression{
                    params.executeTest==true
                }
            }

            //When the "when" condition becomes true then only it will run the test cases.
            steps { 
                sh "mvn test"
            }

           
        }
        
         stage('Package') {
            //agent {label 'linux-slave1'}
            agent any
           
                steps {
                    script{
                        sshagent(['build-server-key']){
                            sh "mvn package"
                            echo "Deploying app version:${params.Appversion}"
                        }
                    }
                } 

             
        }

        stage('Deploy'){
            agent {label 'linux-slave2'}

                input{ 
                        message "Please approve to deploy"
                        ok "Yes, we should."
                        parameters{
                            choice(name:'Newversion',choices:['1.1','1.2','1.3'],description:'Version to deploy')
                        }
                }


            steps{
                echo "Deploying to test"
            }
        }
    }
}
