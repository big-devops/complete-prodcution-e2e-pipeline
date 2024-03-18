pipeline{
    agent
    {
        label "maven"
    }
    tools
    {
        maven 'maven-3.9.6'
        jdk 'jdk-11'
    }
    stages
    {
        stage("Clean WS")
        {
            steps
            {
                script
                {
                    cleanWs()
                }
            }
        }
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
        stage("Maven Test")
        {
            steps
            {
                script
                {
                    sh 'mvn clean test'
                
                }
            }
        }
    }
}