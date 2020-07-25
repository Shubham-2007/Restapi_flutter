const express = require('express');
const app = express();

// Settings
app.set('port', process.env.PORT || 3000);

// Middlewares
app.use(express.json());

// Routes
app.use("/user",require('./routes/user'));
app.use("/own",require('./routes/ownnotification'));
app.use("/assi",require('./routes/assitask'));

//error
app.use((req, res, next) => {
    const error = new Error("Not found");
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    res.json({
        error: { 
            message: error.message
        }
    });
});

// Starting the server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
}); 