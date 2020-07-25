const { Router } = require('express');
const router = Router();

const usersController = require('../controllers/ownnotification');

router.get("/:id", usersController.get_all_owntask);

router.post("/:id", usersController.add_owntask);

router.get("/:id/noti", usersController.user_notifi);



// router.post("/:id/add", usersController.create_new_notification);

// router.get("/:id/:head", usersController.serach_notification);

// router.put("/:id/head", usersController.update_notification);

// router.delete("/:id/head", usersController.delete_notification);

router.get('/', (req, res) => {
    res.status(200).json('Server on port 3000 and Database is connected.');
});
 
module.exports = router;