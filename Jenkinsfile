pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'Env to deploy')
        booleanParam(name:'executeTest',defaultValue:true,description:'Decide to tun TC')
        choice(name:'Appversion',choices:['1.1','1.2','1.3'],description:'List of app versions')
    
    }

    environment{
        BUILD_SERVER_IP='ec2-user@172.31.13.140'
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
                            echo "Packaging the code on the slave"
                            
                            //Copy the server-config.sh file on slave2 so that slave2 have the 
                            //server-config.sh file before hand to install the tools which we conigured in server-config.sh
                            sh "scp -o StrictHostKeyChecking=no sever-config.sh ${BUILD_SERVER_IP}:/home/ec2-user"


                            //Before packaging the code on the slave2 first of all we need to 
                            //have the required tools on the slave2. To get the required tools on
                            //slave2 we will install the tools and to install the tools we write
                            //the commands in a separate file called server-config.sh
                            sh "ssh o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash /home/ec2-user/server-config.sh'"
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
