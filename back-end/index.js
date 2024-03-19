const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const session = require('express-session');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
var passport = require('passport');
const cors = require('cors');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: '*',
  }
});

io.on('connection', (socket) => {
  console.log('Client connected');

  // Ngắn ngủ kết nối khi client ngắt kết nối
  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

global.io = io;
global.appAll = app
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, PUT, POST");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});
const corsOptions = {
  origin: 'http://localhost:3000',
  credentials: true,            //access-control-allow-credentials:true
  optionSuccessStatus: 200
}
// app.use(cors(corsOptions));
app.use(cors());
// app
// Thêm middleware xử lý yêu cầu được chuyển hướng

const path = require('path');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(session({
  secret: '123456tk',
  resave: false,
  saveUninitialized: true
}));
app.use(require('./routes/router').router)

app.set('view engine', 'ejs')
app.set('views', 'views')


// Set up a route to serve the login.html file
// app.use(express.static(path.join(__dirname, 'public')))

app.get('/', function (req, res) {
  res.json({ message: "hi" })
});

app.use(express.json());
app.use(passport.authenticate('session'));

// Start the browser and run the scraper

app.use(express.static('public'));
const port = process.env.PORT || 8000
// Start the server
server.listen(port, function () {
  console.log(`Server is listening on port ${port}`);
});

module.exports = io;