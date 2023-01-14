# BTCUSDT_Price_Variation
 
The purpose of this project is to retrieve the BTCUSDT pair price every 10 minutes and send it to an online hosted MySQL table. Those values are then sorted and when an anomaly is detected a message is sent to the user's phone through Telegram. The SQL table is displayed on a NodeJS app with all the values and the according anomalies.

## Installation

To run this project on your own machine you first need to clone the repo and type `npm start`.
Once this step is done, then open a new tab in your browser and type http://localhost:3000/sample_data. 
You should see a page like this : ![Welcome Page](https://user-images.githubusercontent.com/113424948/209706655-b6ef8b10-b414-40b1-a521-6fd41e5c58ee.PNG)


## How does it work ?

Once on the main page, you can access a table displaying the BTCUSDT pair price. This is done by a query on the SQL table through NodeJs. The MySQL database is hosted on an Amazon RDS server and is filled by a Bash script running on an EC2 Instance. In order to make the script run every 10 minutes we run a cronjob with the following command : `*/10 * * * * /home/ec2-user/DM2/api.sh`.
The anomalies are directly filled with the Bash script whenever he retrieves a new price. If the change in percentage during the last 24 hours is more than 10%, it is considered an anomaly and is inserted in an anomaly SQL Table. Whenever this happens we also send a Telegram message to a channel created for the purpose using a Bot. The Telegram channel is accessible with this [link](https://t.me/BTCUSDT_Anomaly).
To see all the reported anomalies, simply click on the Anomalies button at the bottom of the table. A new page should open.
![AnomaliesPNG](https://user-images.githubusercontent.com/113424948/209707776-02168ee3-566b-49dd-85f4-819dfce531c1.PNG)

