pipeline {
    agent any 

    stages {
        stage('1. Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('2. Deploy Service') {
            steps {
                echo 'กำลังสั่งติดตั้ง Service...'
                
                // ❗️ เปลี่ยนตรงนี้ (เอาขีดกลางออก)
                sh 'docker compose up -d --build'
            }
        }

        stage('3. Show Status') {
            steps {
                echo 'Service ที่กำลังรันอยู่:'
                
                // ❗️ และเปลี่ยนตรงนี้ด้วย
                sh 'docker compose ps'
            }
        }
    }
}