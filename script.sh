sudo apt update
sudo apt-get install -yq openjdk-8-jdk
sudo apt-get -y install python
WILDFLY_VERSION=16.0.0.Final
wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz -P /tmp
sudo tar xf /tmp/wildfly-$WILDFLY_VERSION.tar.gz -C /opt/
sudo mv /tmp/standalone.xml /opt/wildfly-$WILDFLY_VERSION/standalone/configuration
sudo useradd -m -s /bin/bash wildfly
sudo chown -R wildfly:wildfly /opt/wildfly-$WILDFLY_VERSION
sudo cat << EOF > /etc/systemd/system/wildfly.service
[Unit]
Description=Wildfly HTTP Server
[Service]
User=wildfly
WorkingDirectory=/opt/wildfly-16.0.0.Final
ExecStart=/opt/wildfly-16.0.0.Final/bin/standalone.sh
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now wildfly
