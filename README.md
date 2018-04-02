Statement
==
- Host machine of this program is a  CentOS 7.3 VM with kernel version 3.10.0-693.21.1.el7.x86_64.

- The program is a solitaire card game developed with JavaScript and node.js.

- Use a in service email server in an organiztion instead or if slack's available, integrate it into the notification system would be a good idea.

Installations and Configurations
==
1. Install and configure must-have packages including Jenkins, docker, npm
 with script install_packages.sh in the folder.

2. Restart the VM so the configurations can come into effect.

3. Open a Jenkin window with a browser and proceed with initializations

4. Create a new project in Jenkins, select poll SCM and configure Jenkins to
check source code in master branch every minute so once new commits pushed to master, build triggers.  
Pileline code has already been checked into code repository: https://github.com/vcaocaov/cicd.git  
configure in Pipeline, fill in master branch and Jenkinsfile for script path

5. For notifications, install mailhog with docker:  
docker run --restart unless-stopped --name mailhog -p 1025:1025 -p 8025:8025 -d mailhog/mailhog  
Fill in localhost for SMTP server in Extended E-mail Notification. Set SMPT port to 1025, open http://*ipadress*:8025 with a brower will help get notifications when new build's been deployed and issue raised in CI/CD processes.

6. Code in master will be built, tested and archived once new code checked in. After the CI process, code will be deployed in docker and person in contact list will get the notifications. Visit http://*ipaddress*:3000 can check the latest deployment.

Staging and Production Considerations
==
Staging
--
- After building and testing the code by developers and testers, code can be deployed to staging. Insert into pipeline to ask for human input to proceed with the deployment. In this process, docker images can be pushed to a private registry hub. In staging, we can use kubernetes to create docker clusters to mimic the high availability in production.

Production
--
- After system testings in staging, consider to deploy in production. Production pulls images from private docker hub and deployed with more stable and powerful hardware.

- Considering using logging systems like SumoLogic or Splunk in the production deployment, collect important information from services to help troubleshooting and set up alerts as well, logs could be very helpful.

- Heapster can be used to minitor services running with k8s.

- Public cloud provivers can also be considered to deploy with ease.
AWS already provides AKS service to use fully managed k8s clusters, CloudWatch and CloudTrail can help monitor services. Furthermore, AWS and Azure provides PaaS services like AWS Elastic Beanstalk and Azure App Service to deploy services if choosing virtual environments other than containers. Terraform, Ansible and other provision and orchestration tools can help create and configure relative resources. Besides, Python and other script languages can be used to do more fine-grained work.
