node {
    def commit_id
    def previous_id
    stage('Preparacion') {
        checkout scm
        // Save actual id commit on file
        sh "git rev-parse --short HEAD > .git/commit-id"
        // Read actual id commit
        commit_id = readFile('.git/commit-id').trim()
        // Check if previous id commit exists
        sh "if (test ! -f .git/previous-id); then echo '' > .git/previous-id; fi"
        // Read previous id commit
        previous_id = readFile('.git/previous-id').trim()
    }
    stage('Build y Push a DockerHub') {
        // Build and push the image
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
            def app = docker.build("luisdocker361/graphql-image:${commit_id}", '.').push()
        }
        // Save previous id commit on file
        sh "echo ${commit_id} > .git/previous-id"
        // Delete image
        sh "docker rmi luisdocker361/graphql-image:${commit_id}"
    }
    stage('Correr contenedor') {
        withCredentials([string(credentialsId: 'mongodb', variable: 'mongodb'),string(credentialsId: 'graphql-puerto', variable: 'puerto') ]) {
            // save image to constraint
            def cont = docker.image("luisdocker361/graphql-image:${commit_id}")
            // Download image
            cont.pull()
            // Delete container if exists with same name
            sh "docker stop graphql || true && docker rm graphql || true"
            // Check if environments folder exists
            sh "if (test ! -d ./environments); then mkdir ./environments; fi"
            // save env 
            sh "echo $puerto    >  ./environments/.env"
            sh "echo $mongodb   >> ./environments/.env"
            // Run container
            sh "docker run -d --restart always -p 3028:3028 -u root:root --name graphql -v \$(pwd)/environments/:/tmp/environments/ luisdocker361/graphql-image:${commit_id}"
        }
    } 
}