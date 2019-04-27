cd ~
git clone https://github.com/matt712/IndividualProjectFront.git
cd IndividualProjectFront
cd src
sudo sed -i 's/replaceme/NEW_URL/g' Constants.js 
sudo sed -i 's/8080/8081/g' Constants.js
cd ..
sudo apt-get install -y nodejs
sudo apt-get install -y npm@latest -g
npm install 

