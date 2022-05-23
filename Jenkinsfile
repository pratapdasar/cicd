pipeline {
agent any
  options { disableConcurrentBuilds() }
  stages {
    stage('build') {
      when {
        anyOf {
          branch 'main';
        }
      }
      steps {
        sh '''bundle install
RAILS_ENV=test bundle exec rake db:migrate'''
#RAILS_ENV=test bundle exec rspec — format RspecJunitFormatter — out results.xml'''
      }
    }
	
    stage('current-production-deploy') {
      when {
        branch 'main'
      }
      steps {
        sh 'BRANCH=master RAILS_ENV=test bundle exec rspec — format RspecJunitFormatter — out results.xml'
      }
    }
	    stage('Reflect Integration Test Production') {
		      when {
        branch 'main'
      }
      steps {
        script {
          httpRequest(url: 'https://api.reflect.run/v1/suites/test/executions', customHeaders: [[name: 'x-api-key', value: "${API_KEY}"]], requestBody: '{}')
        }
      }
    }
}
  post {
    always {
      deleteDir()
    }
  }
}

