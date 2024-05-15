#! /bin/bash
#Install the prerequisite packages:
sudo apt-get install -y apt-transport-https software-properties-common wget
#Import the GPG key:
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
#To add a repository for stable releases, run the following command:
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
# Updates the list of available packages
sudo apt-get update
# Installs the latest OSS release:
sudo apt-get install grafana
sudo systemctl status grafana-server
#sudo apt-get remove grafana
#Optional: To remove the Grafana repository:
#sudo rm -i /etc/apt/sources.list.d/grafana.list

#sudo ufw status
#sudo ufw enable
#sudo ufw allow 3000
#sudo systemctl restart ufw
