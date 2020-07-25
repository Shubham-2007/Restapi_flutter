const mysqlconnection = require('../database.js');

exports.get_all_assitask = (req, res) => {
    const { id } = req.params;    
            mysqlconnection.query('select * from assitask where id = ?;', [id], (error, rows, fields) => {
                if ( !error ) {
                    res.json(rows);
                } 
                
                else {
                    console.log(error);
                }
  
            }); 
            //return true;
}; 

exports.add_assitask = (req, res) => {
    const { id } = req.params;
    const {  transferhead , transferdesc , transferdate , transfernumber , transferid} = req.body;
    console.log(req.body);
    mysqlconnection.query('insert into assitask values (?,?,?,?,?,?);', [id, transferhead , transferdesc , transferdate , transfernumber , transferid ], (error, rows, fields) => {
        if (!error) {
            res.json({ Status: 'selftask added' });
        } else {
            console.log(error);
        } 
    });
};
