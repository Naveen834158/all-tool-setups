#STEP-1: INSTALLING GIT 
yum install git  -y

#STEP-2: GETTING THE REPO (jenkins.io --> download -- > redhat)
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

#STEP-3: DOWNLOAD JAVA11 AND JENKINS
yum install java-17-amazon-corretto -y
yum install jenkins -y

#STEP-4: RESTARTING JENKINS (when we download service it will on stopped state)
systemctl start jenkins.service
systemctl status jenkins.service



-----------------------------------------------------------------------------------------------------------------------
# STEP-1: INSTALL GIT
yum install git -y

# STEP-2: ADD JENKINS REPO
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# STEP-3: INSTALL JAVA 21 (REQUIRED FOR LATEST JENKINS)
yum install java-21-amazon-corretto -y

# SET JAVA 21 AS DEFAULT (IMPORTANT)
alternatives --config java

# STEP-4: INSTALL JENKINS
yum install jenkins -y

# STEP-5: START + ENABLE JENKINS
systemctl enable jenkins
systemctl start jenkins

# STEP-6: VERIFY STATUS
systemctl status jenkins

# STEP-7: CLEAN FIX (SAFE RESET IF NEEDED)
systemctl stop jenkins
systemctl reset-failed jenkins

chown -R jenkins:jenkins /var/lib/jenkins
chmod -R 755 /var/lib/jenkins

rm -rf /var/lib/jenkins/caches
rm -rf /var/lib/jenkins/tmp

systemctl daemon-reload
systemctl start jenkins
systemctl status jenkins
