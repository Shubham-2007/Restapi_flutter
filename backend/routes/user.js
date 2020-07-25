const { Router } = require('express');
const router = Router();



const usersController = require('../controllers/user');



router.get("/number", usersController.all_number);

router.get("/", usersController.get_all_users);

router.post("/signup", usersController.create_new_users);

router.get("/login" , usersController.login_user)

router.get("/:id", usersController.serach_user);

router.put("/:id", usersController.update_user);




router.get('/a', (req, res) => {
    res.status(200).json('Server on port 4000 and Database is connected.');
});

//show all user
// router.get('/:user', (req, res) => {
//     mysqlconnection.query('select * from users', (error, rows, fields) => {
//         if (!error) {
//             res.json(rows);
//         } else {
//             console.log(error);
//         }
//     });
// });

//show select user
// router.get('/:users/:id', (req, res) => {
//     const { id } = req.params;
//     mysqlconnection.query('select * from users where id = ?;', [id], (error, rows, fields) => {
//         if (!error) {
//             res.json(rows);
//         } else {
//             console.log(error);
//         }
//     });
// });

//user sign up
// router.post('/:users/signup', (req, res) => {
//     const { id,fullname, email, phone, password } = req.body;
//     console.log(req.body);
//     mysqlconnection.query('insert into users values (?,?,?,?,?)', [id,fullname, email, phone, password], (error, rows, fields) => {
//         if (!error) {
//             res.send('user saved');
//         } else {
//             console.log(error);
//         }
//     });
// });

//user change data
// router.put('/:users/update/:id', (req, res) => {
    
//     const { fullname, email, phone, password } = req.body;
//     const { id } = req.params;
//     console.log(req.body);
//     mysqlconnection.query('UPDATE users SET fullname = ? , email = ? , phone=? , password=? where id=? ', [ fullname, email, phone, password, id], (error, rows, fields) => {
//         if (!error) {
//             res.json({ Status: 'user updated' });
//         } else {
//             console.log(error);
//         }
//     });
// });

// //This function allows us concatenate 'id' to url => localhost:4000/id
// router.get('/:customers/:id', (req, res) => {
//     const { id } = req.params;
//     mysqlConnection.query('select * from customers where id = ?', [id], (error, rows, fields) => {
//         if (!error) {
//             res.json(rows);
//         } else {
//             console.log(error);
//         }
//     })
// });

// router.post('/:customers', (req, res, result) => {
//     const { name, address,id//email, phone, hash 
//     } = req.body;
//     console.log(req.body);
//     mysqlConnection.query('insert into customers ( name, address,id ) values ( ?, ? ,?)', [ name, address,id], (error, rows, fields) => {
//         if (!error) {
//             res.json({ Status: "User saved" })
//             console.log(rows);
//         } else {
//             console.log(error);
//         }
//     });
// })

// router.post('/:input', (req, res) => {
//     const { name, address,id } = req.body;
//     console.log(req.body);
//     mysqlConnection.query('insert into customers values (?,?,?)', [name, address,id], (error, rows, fields) => {
//         if (!error) {
//             res.json({message: 'user saved'});
//         } else {
//             console.log(error);
//         }
//     });
// });

// router.put('/:customers/:id', (req, res) => {
//     const { id, name, email, phone, hash } = req.body;
//     console.log(req.body);
//     mysqlConnection.query('update customers set name = ?, email = ?, phone = ?, hash = ? where id = ?;',
//         [ name, email, phone, hash, id ], (error, rows, fields) => {
//             if (!error) {
//                 res.json({
//                     Status: 'User updated'
//                 });
//             } else {
//                 console.log(error);
//             }
//         });
// });

// router.delete('/:customers/:id', (req, res) => {
//     const { id } = req.params;
//     mysqlConnection.query('delete from customers where id = ?', [id], (error, rows, fields) => {
//         if (!error) {
//             res.json({
//                 Status: "User deleted"
//             });
//         } else {
//             res.json({
//                 Status: error
//             });
//         }
//     })
// });

 module.exports = router;

// [{
// 	"id":1,
//     "username": "Veterano23",
//     "name": "Jesus",
//     "lastname": "Hedo",
//     "mail": "hedo.jesus@gmail.com",
//     "randomstr": "dsDsfj=·",
//     "hash": "sdfjioi93448rfj7"
// },
// {
// 	"id":2,
//     "username": "Xavito95",
//     "name": "Xavi",
//     "lastname": "Castro",
//     "mail": "xc@gmail.com",
//     "randomstr": "gHf08vf^",
//     "hash": "1sr6p5ly´c,wzh6/"
// }]
