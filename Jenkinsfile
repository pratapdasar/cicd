pipeline {
  agent any
  options { disableConcurrentBuilds() }
        environment {
        API_KEY = 'tRzfvPkFzw1DFTJRBLD2W3bOWk59tziC6O5DnhNM'
    }
  stages {
    stage('build') {
      when {
        anyOf {
          branch 'main'
        }
      }

      steps {

        sh '''export PATH=~/.rvm/rubies/ruby-2.5.1/bin/:$PATH
        bundle install
        bundle update --bundler
        RAILS_ENV=test bundle exec rake db:migrate'''
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
      stage('Regression Production') {
          when {
        branch 'master'
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
