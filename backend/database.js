var mysql = require('mysql');
 
//console.log('Get connection ...');
 
var con = mysql.createConnection({
  //database: 'user',
  host: "localhost",
  user: "root",
  password: "12345",
  database: "mydb"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});
 
module.exports = con;
// con.connect(function(err) {
//   if (err) throw err;
//   console.log("Connected!");
//   con.query("CREATE DATABASE mydb", function (err, result) {
//     if (err) throw err;
//     console.log("Database created");
//   });
// });
 

// con.connect(function(err) {
//   if (err) throw err;
//   console.log("Connected!");
//   var sql = "CREATE TABLE cus (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), address VARCHAR(255))";
//   con.query(sql, function (err, result) {
//     if (err) throw err;
//     console.log("Table created");
//   });
// });

// con.connect(function(err) {
//   if (err) throw err;
//   console.log("Connected!");
//   var sql = "ALTER TABLE customers ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY";
//   con.query(sql, function (err, result) {
//     if (err) throw err;
//     console.log("Table altered");
//   });
// });
// module.exports = con;

// con.connect(function(err) {
//   if (err) throw err;
//   //console.log("Connected!");
//   //var sql = "INSERT INTO customers (name, address) VALUES ('Company Inc', 'Highway 37')";
//   con.query(con, function (err, result) {
//     if (err) throw err;
//     //console.log("1 record inserted");
//     console.log("Number of records inserted: " + result.affectedRows);
//   });
// });

