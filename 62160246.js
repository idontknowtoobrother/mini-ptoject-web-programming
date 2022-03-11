const express = require('express')
const bodyParser = require('body-parser')
const morgan = require('morgan')
const cors = require('cors')
var mysql = require('mysql')

// Loggin Functions
require('./logging')

// Server Enviroments
const PORT = 3000
const BG_GREEN = '\x1b[42m'
const COLOR_BLACK = '\x1b[30m'
const COLOR_YELLOW = '\x1b[33m'
const COLOR_RESET = '\x1b[0m'
const TAG_DATABASE = `${BG_GREEN}${COLOR_BLACK} DATABASE ${COLOR_RESET}`
const TAG_SERVER = `${BG_GREEN}${COLOR_BLACK} SERVER ${COLOR_RESET}`

let server = express()
server.use(bodyParser.json())  
server.use(morgan('dev')) 
server.use(cors()) 
server.use(bodyParser.urlencoded({extended: true}))
server.use(express.static('html'))
server.use(express.static('img'))

server.set('views', __dirname + '/html')
server.engine('html', require('ejs').renderFile)

// Mock user
let user

var con = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  database: 'dcoffee',
  password: 'whereismypassword'
})

con.connect((err) => {

  if(err)return console.log(`${TAG_DATABASE} Error connecting`)

  console.log(`${TAG_DATABASE} established.`)

})

server.get('/logout', function (req, res){
  // if user == null || user == undefined
  if(!user)return res.status(404).send(`404 not found.`) 

  // logout logging
  logoutLogging(con, user.id_employee)

  res.render(__dirname + "/html/login.html")

  user = null

})

server.post('/login', function (req, res){

  let email = req.body.email
  let password = req.body.password
  
  con.query('SELECT * FROM mst_security WHERE user = ? AND password = ?', [email, password], function(err, userdata){

    if (err) return err
 
    if (!userdata[0]) return res.sendFile(__dirname + '/html/nonmember.html')
      
    con.query('SELECT * FROM mst_employee WHERE id_employee = ?', [userdata[0].id_employee], function(err, userdata){
      user = userdata[0]
      res.redirect('/main')
    })

  })

})

server.get('/main', function (req, res){
  // if user == null || user == undefined
  if(!user)return res.status(404).send(`404 not found.`) 

  // logout logging
  loginLogging(con, user.id_employee)

  res.render(__dirname + "/html/main_menu.html", {
    name: user.name,
    surname: user.surname,
    position: user.position
  })

})

server.get('/', function (req, res){
  
  res.sendFile(__dirname+ "/html" + "/login.html")

})

server.listen(PORT, function() {

  console.log(`${TAG_SERVER} Listen at http://localhost:${COLOR_YELLOW}${PORT}${COLOR_RESET}`)

})