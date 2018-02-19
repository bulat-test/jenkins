node("x86_64") {
    deleteDir()
    withCredentials([string(credentialsId: '7c62eff2-ed2e-4ee0-be37-2bbd5b127984', variable: 'TOKEN')]){

    sh "echo ${TOKEN}  | grep '123'"
    
    echo "Сборщик: ${env.NODE_NAME}"
    echo "Директория: ${env.WORKSPACE}"
    echo "Версия Docker"
    sh "docker -v"

    checkout scm

    sh "docker build -t 'global_doc:latest' ./docker "
    sh "docker images"
    sh "echo 'docker push global_doc:latest'"
}
}
