cd ~
git clone https://github.com/matt712/IndividualProjectFront.git
cd IndividualProjectFront
cd src
sudo sed -i 's/replaceme/NEW_URL/g' Constants.js 
sudo sed -i 's/8080/8081/g' Constants.js
cd ..
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
docker build . -t frontendapp
docker run -d -p 80:80 --rm frontendapp

