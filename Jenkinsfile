pipeline {
    agent any

    environment {
        S3_BUCKET = "your-s3-bucket-name"
        PYTHON_FILE = "main.py"
        EC2_HOST = "ec2-user@your-ec2-public-ip"
        PEM_FILE = "/path/to/your-key.pem"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://your-git-repo-url.git'
            }
        }

        stage('Upload Python File to S3') {
            steps {
                sh 'aws s3 cp ${PYTHON_FILE} s3://${S3_BUCKET}/main.py'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh '''
                    terraform init
                    terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Copy & Execute Python File (Live Change)') {
            steps {
                sh '''
                echo "Copying updated file to EC2..."
                scp -i ${PEM_FILE} ${PYTHON_FILE} ${EC2_HOST}:/home/ec2-user/main.py

                echo "Executing Python file on EC2..."
                ssh -i ${PEM_FILE} ${EC2_HOST} 'python3 /home/ec2-user/main.py'
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline ran successfully with live update."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
