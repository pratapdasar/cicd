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

        sh '''pwd
        /var/lib/jenkins/.rvm/gems/ruby-2.5.1/bin/bundle
        which bundle
        /var/lib/jenkins/.rvm/bin/rvm install "ruby-2.5.1"
        /var/lib/jenkins/.rvm/bin/rvm list
        bundle update --bundler 
        bundle install
        RAILS_ENV=test bundle exec rake db:migrate'''
    }
    }
          stage('Regression Productioni1') {
          when {
        branch 'main'
      }
      steps {
        script {
          httpRequest(url: 'https://api.reflect.run/v1/suites/test/executions', customHeaders: [[name: 'x-api-key', value: "${API_KEY}"]], requestBody: '{}')
        }
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

