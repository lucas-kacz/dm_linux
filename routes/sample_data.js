var express = require('express');

var router = express.Router();
var database = require('../database');

router.get("/", function(request, response, next){

	var query = "SELECT * FROM btcusdt;";

	database.query(query, function(error, data){

		if(error)
		{
			throw error; 
		}
		else
		{
			response.render('sample_data', {title:'Price of the BTCUSDT Pair', action:'list', sampleData:data});
		}
	});
});

router.get("/anomaly", function(request, response, next){

	var query = "SELECT * FROM anomaly;";

	database.query(query, function(error, data){

		if(error)
		{
			throw error; 
		}
		else
		{
			response.render('sample_data', {title:'Anomalies in the BTCUSDT Pair', action:'ask', sampleData:data});
		}
	});
});

router.get("/query", function(request, response, next){

  response.render("sample_data", {title:'Select data from MySQL', action:'add'});

});
  
router.get("/result", function(request, response, next){

  var selection = request.body.userinput;
  var pair = document.getElementById('userinput').value;
	var query = `SELECT * FROM anomaly;`;

	database.query(query, function(error, data){

		if(error)
		{
			throw error; 
		}
		else
		{
			response.render('sample_data', {title:'Anomalies in the BTCUSDT Pair', action:'ask', sampleData:data});
		}
	});
});

// router.post("/add_sample_data", function(request, response, next){

//   var selection = request.body.value;

//   var query = `SELECT * FROM btcusdt;`;

//   database.query(query, function(error, data){

//     if(error)
//     {
//       throw error;
//     }	
//     else
//     {
//       response.render('sample_data', {title:'Anomalies in the BTCUSDT Pair', action:'query', sampleData:data});
//     }

//   });

// });

module.exports = router;