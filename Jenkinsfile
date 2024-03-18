pipeline{
    agent
    {
        label "maven"
    }
    stages
    {
        stage("SCM checkout")
        {
            steps
            {
                script
                {
                    git branch: 'CBCOPS-1000', credentialsId: 'bigdevops-github-key', url: 'https://github.com/big-devops/complete-prodcution-e2e-pipeline.git'
                }
            }
        }
    }
}