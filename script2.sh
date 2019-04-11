sudo apt update
sudo apt install maven -y
cd ~
git clone https://github.com/matt712/IndividualProject.git
cd IndividualProject
mvn clean install
cd target
sudo cp IndividualProject.war /opt/wildfly-16.0.0.Final/standalone/deployments



