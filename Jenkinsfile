pipeline{
    agent{
        label "maven"
    }
    stages
    {
        stage("clearing WS")
        {
            step
            {
                cleanWs()
            }
        }
        stage("SCM checkout")
        {
            step
            {
                script
                {
                    sh "git branch: 'CBCOPS-1000', credentialsId: 'bigdevops-github-key', url: 'https://github.com/big-devops/complete-prodcution-e2e-pipeline.git'"
                }
            }
        }
    }
}