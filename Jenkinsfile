pipeline{
    agent
    {
        node
        {
            label 'maven-agent'
            customWorkspace '/home/jenkins/project'
        }
    }
    tools
    {
        maven 'mvn-3.9.6'
    }
    environment
    {
        APP_NAME = "cbcapp"
        REL = "1.0.0"
        DOCKER_USER = "uriyapraba"
        DOCKER_CRED = "docker-token"
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${REL}-${BUILD_NUMBER}"
    }
    stages
    {
        stage('Clear-Workspace')
        {
            steps
            {
                cleanWs()
            }
        }
        stage('SCM-Checkout')
        {
                steps{
                    script
                    {
                        git branch: 'CBCOPS-4000', credentialsId: 'git-private-token', url: 'https://github.com/big-devops/complete-prodcution-e2e-pipeline.git'
                    }
            }
        }
        stage("Building Application")
        {
            steps
            {
                script
                {
                   sh 'mvn clean package'
                }
            }
        }
        stage("Testing Application")
        {
            steps
            {
                script
                {
                    sh 'mvn test'
                }
            }
        }
        stage('Code Quality Analysis')
        {
            steps
            {
                withSonarQubeEnv('sonar')
                {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Quality Gate')
        {
            options
            {
                timeout(time: 60, unit: 'SECONDS')
            }
            steps
            {
                script
                {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
                }
              
            }
        }
        stage('Build and Push docker image')
        {
            steps
            {
                script
                {
                        docker_image = docker.build("${IMAGE_NAME}") // This is repo
                        
                    withDockerRegistry(credentialsId: "${DOCKER_CRED}") 
                    {
                        docker_image.push("${IMAGE_TAG}") // This is repo
                    }
                }
            }
            post
            {
                success
                {
                    sh "docker image rm ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker image rm ${IMAGE_NAME}:latest"
                }
            }
        }
        stage("Build Downstream Job")
        {
            steps
            {
                script
                {
                    // Define environment variables to pass to the downstream job
                    def envVar = [
                        key: 'IMAGE_NAME',
                        value: IMAGE_NAME
                    ]

                    // Trigger another job named 'AnotherPipelineJob' with environment variables
                    build job: 'complete-e2e-deployment', parameters: [], env: envVar, wait: true
                }

            }
        }
    }
    
}