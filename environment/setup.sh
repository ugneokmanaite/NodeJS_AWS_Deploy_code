#!/bin/bash

# Linking app folder from Ubuntu to VM
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Documents/sparta_global_vagrant/NodeJS_AWS_Deploy_code/app/ ubuntu@54.247.32.79:/home/ubuntu/

# Linking db provision file
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Documents/sparta_global_vagrant/NodeJS_AWS_Deploy_code/environment/db/ ubuntu@54.247.32.79:/home/ubuntu/ 

<<<<<<< HEAD
# ssh into VM
ssh -i ~/.ssh/DevOpsStudents.pem ubuntu@54.217.0.130 -i ./environment/app/provision.sh
=======
# Linking app provision file
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Documents/sparta_global_vagrant/NodeJS_AWS_Deploy_code/environment/app/provision.sh ubuntu@54.247.32.79:~/app/

# ssh app into VM
ssh -i ~/.ssh/DevOpsStudents.pem ubuntu@54.247.32.79 -i ./db/provision.sh
>>>>>>> develop



