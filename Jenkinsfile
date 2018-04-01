stage 'CI'
node {
    try{
	    checkout scm

	    // pull dependencies from npm
	    sh 'npm install'

	    // stash code & dependencies to expedite subsequent testing
	    // and ensure same code & dependencies are used throughout the pipeline
	    // stash is a temporary archive
	    stash name: 'everything', 
		  excludes: 'test-results/**', 
		  includes: '**'
	    
	    // test with PhantomJS for "fast" "generic" results
	    sh 'npm run test-single-run -- --browsers PhantomJS'
	    
	    // archive karma test results (karma is configured to export junit xml files)
	    step([$class: 'JUnitResultArchiver', 
		  testResults: 'test-results/**/test-results.xml'])

	    // archive the app folder
	    archiveArtifacts 'app/'
    } catch (err) {
     notify("Failed building or testing.  ${err}")
    } 
}


// limit concurrency so we don't perform simultaneous deploys
// and if multiple pipelines are executing, 
// newest is only that will be allowed through, rest will be canceled
stage name: 'Deploy to testing', concurrency: 1
node {
    try{
	    // write build number to index page so we can see this update
	    sh "echo '<h1>${env.BUILD_DISPLAY_NAME}</h1>' >> app/index.html"
	    
	    // deploy to a docker container mapped to port 3000
	    sh 'docker-compose up -d --build'
	    
	    notify 'New Version Deployed!'
    } catch (err) {
      notify("Failed deploying. ${err}")
    }
}






def notify(status){
    emailext (
      to: "caoshuai354826@gmail.com",
      subject: "${status}  Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>${status}  Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
    )
}
