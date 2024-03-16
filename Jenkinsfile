pipeline{
    agent{
        label "maven"
    }
    stages
    {
        stage("clearing WS")
        {
            steps
            {
                cleanWs()
            }
        }
        stage("SCM checkout")
        {
            steps
            {
                
                sh "git branch: 'CBCOPS-1000', credentialsId: 'bigdevops-github-key', url: 'https://github.com/big-devops/complete-prodcution-e2e-pipeline.git'"
            }
        }
    }
}