const mysql = require ('mysql');

var connection = mysql.createConnection({
    host: database-1.cnx76zh3lsox.eu-west-3.rds.amazonaws.com,
    user: "root",
    password: EU(f5*qNthORPHMhoy9Qf[+<mT$5,
    database: binance_api,
});

connection.connect(function(error){
	if(error)
	{
		throw error;
	}
	else
	{
		console.log('MySQL Database is connected Successfully');
	}
});

module.exports = connection;
