pipeline {
    // ใช้ "Built-In Node" (Master) ที่เราแชร์ docker.sock ให้
    agent any 

    stages {
        stage('1. Checkout Code') {
            steps {
                // ดึงโค้ด (ที่มี docker-compose.yml) จาก Git
                checkout scm
            }
        }

        stage('2. Deploy Service') {
            steps {
                echo 'กำลังสั่งติดตั้ง Service...'
                // รันคำสั่ง docker-compose บน Server (ผ่าน docker.sock)
                // --build: สร้าง image ใหม่ถ้าโค้ดเปลี่ยน
                // -d: รันใน background
                sh 'docker-compose up -d --build'
            }
        }

        stage('3. Show Status') {
            steps {
                // (ไม่บังคับ) แสดงผลว่ารันสำเร็จ
                echo 'Service ที่กำลังรันอยู่:'
                sh 'docker-compose ps'
            }
        }
    }
}