pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                dir("terraform") {
                    git url: "https://github.com/Icode4passion/aws_Terraform_jenkins.git"
                }
            }
        }

        stage('Plan') {
            steps {
                dir("terraform") {
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
            steps {
                script {
                    dir('terraform') {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [
                                text(name: 'Plan', description: 'Please review the plan below', defaultValue: plan)
                            ]
                    }
                }
            }
        }

        stage('Apply') {
            steps {
                dir("terraform") {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }
}
