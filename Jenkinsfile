pipeline{
    agent
    {
        node
        {
            label 'maven-agent'
            customWorkspace '/home/jenkins/project'
        }
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
        
    }
    
}