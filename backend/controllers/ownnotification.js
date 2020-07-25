const mysqlconnection = require('../database.js');

exports.get_all_owntask = (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select * from owntask where id = ?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        }

        else {
            console.log(error);
        }

    });
    //return true;
};

exports.add_owntask = (req, res) => {
    const { id } = req.params;
    const { taskhead, taskdesc, date, competed } = req.body;
    console.log(req.body);
    mysqlconnection.query('insert into owntask values (?,?,?,?,?);', [id, taskhead, taskdesc, date, competed], (error, rows, fields) => {
        if (!error) {
            res.json({ Status: 'selftask added' });
        } else {
            console.log(error);
        }
    });
};

exports.user_notifi = (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select taskhead , date  from owntask where id = ?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        }

        else {
            console.log(error);
        }

    });
    //return true;
};
