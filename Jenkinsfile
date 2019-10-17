#!groovy

properties([
  parameters([
    string(name: 'message', defaultValue: 'Hello, world', description: 'Message to display')
   ])
])
node {
  stage("Checkout") {
     checkout scm
  }
 stage("Stage1") {
    echo "${message}"  //access to your parameter
    sh "whoami"
    sh "cat /etc/fstab"
  }

  stage("Approve") {
    input "Do you accept changes?"
  }

  stage("Stage2") {
    sh "true"
  }

}

