#! /bin/bash
sudo yum install java-1.8.0-openjdk-devel
sudo yum install git -y
sudo yum install maven -y

if[ -d "addressbookpractice" ]
then
    echo "Repository is already cloned and exist"
    git pull origin Practice
else
git clone https://github.com/MudassirKhan22/addressbookpractice.git
fi

cd /home/ec2-user/addressbookpractice
mvn package