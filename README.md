## What is AWS?
- Amazon Web Services
_ Infrastructure as a service
- Secure, cloud services platform
- Offers compute power, database strage, content delivert etc
- Includes many different services offered

Allows you to:

1. Running web and application servers in the cloud to host dynamic websites.
2. Securely store all your files on the cloud so you can access them from anywhere.
3. Using managed databases like MySQL, PostgreSQL, Oracle or SQL Server to store information.
4. Deliver static and dynamic files quickly around the world using a Content Delivery Network (CDN).
5. Send bulk email to your customers.

** PROVIDES GLOBAL INFRASTRUCTURE
![image](https://s3-us-west-1.amazonaws.com/corpinfowebsiteuploads/content/uploads/2016/04/25051531/AWS-Global-Infrastructure.jpg)

## EC2
- Part of Amazons cloud compouting platform
- Allows users to rent virtual computers on which they run their own application
- Encourages scalable deployment of applications by providing a web service through which a user can boot an Amazon Machine Image AMI to configure a virtual machine (which Amazon calls an instance), containing desired software
- User can create, launch and terminate server instances 
- Provides users with control over gerographical locations of instances that allow latency optimization

## Provisioning
- Process of setting up IT infrastructure
- Steps required to manage access to data and resources and make them available to users and systems
 
1. Provisioning folders
2. Installing packages, software
3. Making configurations
4. Environment variables

## What is IAM
- Identity and access management
- Where you can create & destroy users

# Creating EC2 instance
- On location choose Ireland
- EC2 --> Launch instance

## Step 1: Choose an Amazon Machine Image (AMI)
- Select Ubntu 16.04

## Step 2: Choose an Instance Type
- Here you choose the size of the machine
- Keep the default for now

## Step 3: Configure Instance Details
- Network: DevOpsStudents
- Subnet: Default 1a
- Enable public IP

## Step 4: Step 4: Add Storage
- Keep default 

## Step 5: Add Tags
- Key: Name
- Value: Eng67.Ugne.Webapp

## Step 6: Configure Security Group
- Add name & Description
- Change IP address to personal to avoid security breaches

## Step 7: Review Instance Launch
- Use DevOp Students key (sent via chat)
- Move this to .ssh
- ssh -i(identify your key) user@target


# Connecting to application via AWS

![image](https://github.com/ugneokmanaite/NodeJS_AWS_Deploy_code/blob/master/printscreens/connect%20AWS.JPG)
1. Add provision file in os app/ with the required installations
2. Create a setup file to automate syncing & running the VM process(these will need to be changed everytime IP changes)

## To sync OS files to VM
`scp -i ~/.ssh/DevOpsStudents.pem -r ~/Documents/sparta_global_vagrant/NodeJS_AWS_Deploy_code/environment/db/ubuntu@ec2-54-246-20-235.eu-west-1.compute.amazonaws.com:/home/ubuntu/`

## To run the VM

`ssh -i ~/.ssh/DevOpsStudents.pem ubuntu@ec2-54-246-20-235.eu-west-1.compute.amazonaws.com `

1. cd app/
2. npm install
2. node app.js


## Acceptance Criteria
- [x] New repo with readme
- [x] document your aws and new comamnd
- [x] Proof of app on port 3000
- [x] Extra port 80
- [x] Stop instance 


![image](https://github.com/ugneokmanaite/NodeJS_AWS_Deploy_code/blob/master/printscreens/listening%20on%20port%203000.JPG)
![image](https://github.com/ugneokmanaite/NodeJS_AWS_Deploy_code/blob/master/printscreens/up%20and%20running.JPG)

## Reverse Proxy
1. Setting up a provision file with port 80 details:
```
#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# configuring nginx proxy
sudo rm /etc/nginx/sites-enabled/default
cd /etc/nginx/sites-available
sudo touch reverse-proxy.conf
sudo chmod 666 reverse-proxy.conf
echo "server{
  listen 80;
  server_name development.local;
  location / {
      proxy_pass http://127.0.0.1:3000;
  }
}" > reverse-proxy.conf
sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/s$

#restart nginx
sudo service nginx restart

# installing node and npm
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt-get install npm -y

cd /home/ubuntu/app
sudo npm install

# Install pm2 for easier application start & stop
sudo npm install pm2 -g

# stop anything that is running before running the app
pm2 stop all
pm2 start app.js -f

```


2. Create a set up file which links os to VM and automates entering the VM
```
#!/bin/bash

# Linking app folder from Ubuntu to VM
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Documents/sparta_global_vagrant>

# Linking provision file
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Documents/sparta_global_vagrant>

# ssh into VM
ssh -i ~/.ssh/DevOpsStudents.pem ubuntu@54.217.0.130
```


3. Once in VM - enter 

`./provision` (this will be eliminated in next iteration to automate the process further)

This will have the reverse proxy set up! Just copy & paste your public IP into web browser 


## DOD
- [x] Create new Jenkins job called 'firsname-lastname-deploy' & ensure it runs the above steps 
- [x] Set this job to run when CI testing job has finished successfully
- [x] Make change to the homepage of the app and push your code to the develop branch to test pipeline

### To be aware of
- This job should pull from the master branch only 
- There are many tools and methods for uploading files to a remote server. We want to keep it simple and use rsync and ssh as we've learned previously. Do not use the Publish over SSH plugins
- You can create this configuration entirely in your job using:

ssh, 
rsync, 
ssh-agent, 
credentials system, 

- When `Jenkins` attempts to connect via SSH it will ask for confirmation as we saw in the lesson. We can ask it to skip this confirmation with the following flags:

```
ssh -o "StrictHostKeyChecking=no" ubuntu@ ...
rsync -avz -e "ssh -o StrictHostKeyChecking=no" ...
```

- You can send multiple commands over ssh with the following syntax

```
ssh -o "StrictHostKeyChecking=no" ubuntu@52.50.22.47 <<EOF

	commands here...

EOF
```

### Problem encountered
- not linking correctly with etc/ folder
- code appearing multiple times within reverse-proxy.conf
- worked around the problem by manually deleting files within etc/ngnx/sites-available and manually entering it 


1. Created a new instance for DB machine
2. Configured secutiy groups by telling DB instance to allow inbound communication from the app- specified web IP address & linked the 2 together  

![image](https://github.com/ugneokmanaite/NodeJS_AWS_Deploy_code/blob/master/printscreens/inbound-rules.JPG)

3. Added the following environment variable in DB VM

export DB_HOST=mongodb://54.246.20.235:27017/post

4. Whilst DB is still running- SSH into the app and run 
`npm install 
node app.js`





