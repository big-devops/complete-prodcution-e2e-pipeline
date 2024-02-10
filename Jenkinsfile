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
                def qg = waitForQualityGate()
                if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
            }
        }
    }
    
}