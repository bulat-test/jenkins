node("x86_64") {
    deleteDir()
    withCredentials([string(credentialsId: '7c62eff2-ed2e-4ee0-be37-2bbd5b127984', variable: 'TOKEN')]){

    sh "TTT=000${TOKEN}000; echo $TTT"
    
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
