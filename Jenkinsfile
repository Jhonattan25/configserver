pipeline {
    agent any
    tools {
        maven 'maven_3_9_2'
    }
    environment {
        def imageName = "jhonattan25/app-microservicios-config-server"
        def date = new Date().format('yyyyMMdd')
        def release = "${env.BUILD_NUMBER}"
        def releaseId = "${env.BUILD_ID}"
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Jhonattan25/configserver.git']])
                sh 'mvn clean install'
            }
        }
        stage ('Build docker image') {
            environment {
                def imageTag = "${imageName}:${releaseId}-${date}-r${release}"
            }
            steps {
                script {
                    sh "docker build -t ${imageTag} ."
                }
            }
        }
        stage('Push image to DockerHub') {
            environment {
                def imageTag = "${imageName}:${releaseId}-${date}-r${release}"
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u jhonattan25 -p ${dockerhubpwd}'
                        sh "docker push ${imageTag}"
                    }
                }
            }
        }
    }
    post {
        always {
            deleteDir() // Eliminar el directorio de trabajo después de finalizar el pipeline
        }
        success {
            echo 'El pipeline se ha ejecutado exitosamente' // Notificar que el pipeline fue exitoso
        }
        failure {
            echo 'El pipeline ha fallado' // Notificar que el pipeline ha fallado
        }
    }
}
