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
                    mvn clean package
                }
            }
        }
        stage("Testing Application")
        {
            steps
            {
                script
                {
                    mvn test
                }
            }
        }
    }
    
}