pipeline {
    agent {
        docker {
            image 'lawest98/april:latest'
            args '-u root:root'  // run as root user for permissions
        }
    }

    environment {
        SSH_CREDENTIALS_ID = 'april-id'        // Jenkins SSH credentials ID
        EC2_USER = 'ec2-user'                        // EC2 SSH username (e.g., ec2-user or ubuntu)
        EC2_HOST = 'your-ec2-public-ip-or-dns'      // EC2 public IP or hostname
        REMOTE_DIR = '/var/www/html'                  // Deployment directory on EC2
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/LA-WEST98/April.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'  // your build command, adjust if you don’t have one
            }
        }

        stage('Test') {
            steps {
                sh 'npm run test'  // optional, remove if no tests
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent([env.SSH_CREDENTIALS_ID]) {
                    sh """
                    scp -o StrictHostKeyChecking=no -r ./dist/* ${env.EC2_USER}@${env.EC2_HOST}:${env.REMOTE_DIR}
                    ssh -o StrictHostKeyChecking=no ${env.EC2_USER}@${env.EC2_HOST} 'sudo systemctl restart nginx'
                    """
                }
            }
        }
    }
}
