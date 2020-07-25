//const Product = require("../models/product");
const mysqlconnection = require('../database.js');

exports.get_all_users = (req, res) => {
    mysqlconnection.query('select * from users', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
};

exports.all_number = (req, res) => {
    //console.log("12345");
    mysqlconnection.query('select id , fullname , phone from users;', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
            //console.log("12345");
        } else {
            console.log(error);
        }
    });
};

exports.login_user = (req, res) => {
    const { email, password } = req.body;
    mysqlconnection.query('select * from users where email = ? && password = ?', [email, password], (error, results, fields) => {
        if (error) {
            res.json({
                status: false,
                message: 'there are some error with query'
            })
        } else {
            if (results.length > 0) {
                res.json(results[0].id);
                //print(results[0].id);
            }
            else {
                res.json({
                    status: false,
                    message: "Email and password does not match"
                });
            }
        }
    });
};

exports.serach_user = (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select * from users where id = ?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
};

exports.create_new_users = (req, res) => {
    const { id, fullname, email, phone, password, token } = req.body;
    //const { } = hash;
    console.log(req.body);
    mysqlconnection.query('insert into users values (?,?,?,?,?)', [ id, fullname, email, phone, password, token], (error, rows, fields) => {
        if (!error) {
            console.log("**************");
            res.send('user saved');
        } else {
            console.log("----------------");
            console.log(error);
        }
    });
};

exports.update_user = (req, res) => {

    const { fullname, email, phone, password } = req.body;
    const { id } = req.params;
    console.log(req.body);
    mysqlconnection.query('UPDATE users SET fullname = ? , email = ? , phone=? , password=? where id=? ', [fullname, email, phone, password, id], (error, rows, fields) => {
        if (!error) {
            res.json({ Status: 'user updated' });
        } else {
            console.log(error);
        }
    });
};
