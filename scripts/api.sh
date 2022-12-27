#!/bin/bash

url='https://api.binance.com'
outfile="change.txt"
DB_USER='';
DB_PASSWD='';

DB_NAME='binance_api';
TABLE='btcusdt';
TABLE1='anomaly';
  #echo "Welcome to the Binance API, please choose a pair to display its information"
  
#read -p "Pair : " pair

#curl -X GET "${url}/api/v3/ticker/price?symbol=BTCUSDT" > change.txt
curl -X GET "${url}/api/v3/ticker/price?symbol=BTCUSDT" > change.json

price="$(grep -oP '(?<="price":")[^"]*' change.json)"

curl -X GET "${url}/api/v3/ticker/24hr?symbol=BTCUSDT" > change24.json
priceChange="$(grep -oP '(?<="priceChangePercent":")[^"]*' change24.json)"


now=$(date)

echo $now
echo $price
echo $priceChange

#Anomaly Detection
# Store the string and number in variables
number=5.0

# Convert the string to a float using awk
float=$(awk "BEGIN {print ($priceChange + 0)}" 2>/dev/null)

trigger=$(echo $priceChange'>'$number | bc -l)
echo $trigger

# Check if the number is greater than the float
if (($trigger==0)); then
  # If the number is greater, send it to a file named anomaly.txt
  echo "$float" > anomaly.txt

  curl --data chat_id="-" --data-urlencode "text=Bonjour, une anomalie sur la paire BTCUSDT a été détectée. La variation en pourcentage ces dernières 24 heures sur cette paire est de $float et nous sommes actuellement le $time " "https://api.telegram.org/bot<key>/sendMessage?parse_mode"
  mysql -h database-1.cnx76zh3lsox.eu-west-3.rds.amazonaws.com -P 3306 -u$DB_USER -p$DB_PASSWD << EOF
USE $DB_NAME;
INSERT INTO $TABLE1 VALUES ("BTCUSDT","$now","$price","$priceChange");

EOF
fi

#mysql commands
mysql -h database-1.cnx76zh3lsox.eu-west-3.rds.amazonaws.com -P 3306 -u$DB_USER -p$DB_PASSWD << EOF
USE $DB_NAME;
INSERT INTO $TABLE VALUES ("BTCUSDT","$now","$price","$priceChange");

EOF
