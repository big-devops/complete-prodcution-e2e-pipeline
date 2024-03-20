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
        stage("Maven Build")
        {
            steps
            {
                script
                {
                    sh 'mvn clean package'
                
                }
            }
        }
        stage("Maven Test")
        {
            steps
            {
                script
                {
                    sh 'mvn test'
                
                }
            }
        }
        stage('Sonarqube code quality check')
        {
            steps
            {
                withSonarQubeEnv(credentialsId: 'sonarqube_token') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
    }
}