#!/bin/bash

sudo yum update -y
sudo yum install wget -y
sudo wget https://corretto.aws/downloads/latest/amazon-corretto-21-x64-linux-jdk.rpm
sudo yum install git -y 

cd /opt 
git clone https://github.com/techeazy-consulting/techeazy-devops.git
sudo chown -R ec2-user:ec2-user /opt/*
cd techeazy-devops

sudo chmod +x mvnw
./mvnw clean install

sudo yum install httpd -y
sudo systemctl restart httpd

cat << 'EOF' > /home/$USER/file.txt
if lsof -i :80 >/dev/null 2>&1; then
    echo "Port 80 is in use. Stopping the process..."
    PID=$(lsof -ti :80)
    sudo kill -9 $PID
    echo "Port 80 is now free."
else
    echo "Port 80 is free."
fi
EOF
sudo chmod +x /home/$USER/file.txt
./home/$USER/file.txt

nohup sudo java -jar target/*.jar --server.port=80 > /home/$USER/file 2>&1 &
