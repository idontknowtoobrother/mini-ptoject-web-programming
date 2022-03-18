// Loggin Functions
require('./logging')
require('./libs')

// Server Enviroments
const PORT = 3000
const BG_GREEN = '\x1b[42m'
const COLOR_BLACK = '\x1b[30m'
const COLOR_YELLOW = '\x1b[33m'
const COLOR_GREEN = '\x1b[32m'
const COLOR_RED = '\x1b[31m'
const COLOR_RESET = '\x1b[0m'
const TAG_DATABASE = `${BG_GREEN}${COLOR_BLACK} DATABASE ${COLOR_RESET}`
const TAG_SERVER = `${BG_GREEN}${COLOR_BLACK} SERVER ${COLOR_RESET}`
const TAG_LOG = `${BG_GREEN}${COLOR_BLACK} LOG ${COLOR_RESET}`
const ONE_DAY = 1000 * 60 * 60 * 24

// Express Enviroments
const express = require('express')
const bodyParser = require('body-parser')
const morgan = require('morgan')
const cors = require('cors')

// Session Enviroments
const session = require('express-session')
const cookieParser = require("cookie-parser");

// MySQL Enviroments
var mysql = require('mysql')

// Init Server (express)
let server = express()

// Server Use Enviroments
server.use(bodyParser.json())  
server.use(morgan('dev')) 
server.use(cors()) 
server.use(bodyParser.urlencoded({extended: true}))
server.use(express.static('html'))
server.use(express.static('img'))

// Server Use Express-Session
server.use(session({
  secret: "whereismyhexademical",
  saveUninitialized: true,
  cookie: {
    maxAge: ONE_DAY
  },
  resave: true
}))
server.use(express.urlencoded({extended: true}))
server.use(express.json())
server.use(cookieParser())
server.use(express.static(__dirname))

server.set('views', __dirname + '/html')
server.engine('html', require('ejs').renderFile)

// Mock user
var con = mysql.createConnection({
  host: '154.202.3.51',
  user: 'root',
  database: 'licensecheck',
  password: '85*xKioc@p_x'
})

// functions - start

requestLogin = (email, password, req, res) => {
  con.query('SELECT * FROM mst_security WHERE user = ? AND password = ?', [email, password], function(err, userdata){

    if (err) return err
  
    if (!userdata[0]) return res.sendFile(__dirname + '/html/nonmember.html')
      
    con.query('SELECT * FROM mst_employee WHERE id_employee = ?', [userdata[0].id_employee], function(err, userdata){
      const cachedUserData = userdata[0]
      req.session.userdata.id_employee = cachedUserData.id_employee
      req.session.userdata.name = cachedUserData.name
      req.session.userdata.surname = cachedUserData.surname
      req.session.userdata.position = cachedUserData.position
      req.session.userdata.salary = cachedUserData.salary
      req.session.userdata.total_sale = cachedUserData.total_sale
      res.redirect('/main')
    })
  
  })  
}

// end - functions -


con.connect((err, res) => {

  if(err)return console.log(`${TAG_DATABASE} Error connecting`)

  console.log(`${TAG_DATABASE} established.`)

})

server.get('/logout', function (req, res){
  // if user == null || user == undefined
  if(!isHaveSessionUserData(req))return res.status(404).send(`404 not found.`);

  // logout logging
  logoutLogging(con, req.session.userdata.id_employee, (id) => {
    console.log(`${TAG_LOG} user_id ${COLOR_YELLOW}${id} ${COLOR_RED}logged out${COLOR_RESET}`)
    res.render(__dirname + "/html/login.html")
    req.session.destroy()
  })
 
})

// Add
server.get('/add',(req, res) => {
  res.render(__dirname + "/html/add_user.html", {
      name: req.session.userdata.name,
      surname: req.session.userdata.surname,
      position: req.session.userdata.position,
      title : 'เพิ่มผู้ใช้'
  });
});

// Save
server.post('/save',(req, res) => { 

  con.query('INSERT INTO mst_employee SET ?',
  {
    name: req.body.name,
    surname: req.body.surname,
    position: req.body.position,
    salary: req.body.salary, 
    total_sale: req.body.total_sale
  }, function(err, result){
    if(err) throw err;

    con.query('SELECT id_employee FROM mst_employee WHERE name = ? AND surname = ?', [req.body.name, req.body.surname], function(err, ids_employee){
      if(err) return err;
      console.log(JSON.stringify(ids_employee));
      if (!ids_employee[0] || !ids_employee[0].length < 1) return
      con.query('INSERT INTO mst_security SET ?',
        {
          user: req.body.email,
          password: req.body.password,
          id_employee: ids_employee[0].id_employee
        }, function(err, result){
          if(err) throw err;
          res.redirect('/managment');
        }
      )
    })
   
  })

});

// Edit
server.get('/edit/:userId',(req, res) => {
  const sql = "SELECT * FROM mst_employee WHERE id_employee = " + req.params.userId + ";";
  let query = con.query(sql, function(err, users){
    if(err) return err;
    res.render(__dirname + "/html/user_edit.html", {
      name: req.session.userdata.name,
      surname: req.session.userdata.surname,
      position: req.session.userdata.position,
      title : 'แก้ไขผู้ใช้',
      user : users[0]
    })
  })
})

// Delete
// server.get('/delete/:userId',(req, res) => {
//   const userId = req.params.userId; 
//   let sql = `DELETE from users where id = ${userId}`;
//   let query = connection.query(sql,(err, result) => {
//       if(err) throw err;
//       res.redirect('/');
//   });
// });

// Update
// server.post('/update',(req, res) => {
//   const userId = req.body.id;
//   let sql = "update users SET name='"+req.body.name+"',  email='"+req.body.email+"',  phone_no='"+req.body.phone_no+"' where id ="+userId;
//   let query = connection.query(sql,(err, results) => {
//     if(err) throw err;
//     res.redirect('/');
//   });
// });


// Management
server.get('/managment', (req, res) => {
  if(!isHaveSessionUserData(req))return res.redirect('/')
  if(!isHavePositionByName(req.session.userdata.position, 'เจ้าของร้าน')) return res.redirect('/')

  con.query('SELECT * FROM mst_employee', function(err, rows){
    if(err) return err
    res.render(__dirname + "/html/managment.html", {
      name: req.session.userdata.name,
      surname: req.session.userdata.surname,
      position: req.session.userdata.position,
      title: 'การจัดการข้อมูลผู้ใช่',
      users: rows
    })

  })

  
})




server.post('/login', function (req, res){
  if(!req.body.email || !req.body.password)return res.redirect('/')
  req.session.userdata = {}
  req.session.userdata.email = req.body.email
  req.session.userdata.password = req.body.password
  requestLogin(req.session.userdata.email, req.session.userdata.password, req, res)
})

server.get('/main', function (req, res){
  // if user == null || user == undefined
  if(!isHaveSessionUserData(req))return res.status(404).send(`404 not found.`);

  console.log(req.session.userdata)

  // login logging
  loginLogging(con, req.session.userdata.id_employee, (id) => {

    console.log(`${TAG_LOG} user_id ${COLOR_YELLOW}${id} ${COLOR_GREEN}logged in${COLOR_RESET}`)
    res.render(__dirname + "/html/main_menu.html", {
      name: req.session.userdata.name,
      surname: req.session.userdata.surname,
      position: req.session.userdata.position
    })

  })

})

server.get('/', function (req, res){
  if(!isHaveSessionUserData(req)){
    res.sendFile(__dirname+ "/html" + "/login.html")
    return
  }

  requestLogin(req.session.userdata.email, req.session.userdata.password, req, res)
})

server.listen(PORT, function() {

  console.log(`${TAG_SERVER} Listen at http://localhost:${COLOR_YELLOW}${PORT}${COLOR_RESET}`)

})