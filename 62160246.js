const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const cors = require('cors');
var mysql = require('mysql');
const res = require('express/lib/response');

let server = express();

server.use(bodyParser.json());
server.use(morgan('dev'));
server.use(cors());
server.use(bodyParser.urlencoded({ extended: true }))
server.use(express.static('html'));
server.use('/img', express.static('img'));


server.set('views', __dirname + '/html');
server.engine('html', require('ejs').renderFile);

let user = {}

var con = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'dcoffee',
  password: 'whereismypassword'
});

con.connect((err) => {
  if (err) {
    console.log('Error connecting to Db');
    return;
  }
  console.log('Connection established');
});

server.get('/logout', function (req, res) {
  if(user.data == undefined || user.data.id_employee == undefined)res.render(__dirname + "/html/user_login.html");

  const id = user.data.id_employee
  con.query('INSERT INTO trn_logout (id_employee, datetime_logout) VALUES(?, NOW())', id, function (err) {
    if (err) return err;
  })
  res.render(__dirname + "/html/user_login.html")
})

server.post('/login', function (req, res) {
  user = {}
  let email = req.body.email;
  let password = req.body.password;

  con.query('SELECT * FROM mst_security WHERE user = ? AND password = ?', [email, password], function (err, data) {
    if (err) {
      return err;
    }
    if (data.length == 0) {
      return res.sendFile(__dirname + '/html/user_nonmember.html')
    }
    if (data[0] == null) {
      return res.redirect('/')
    }
    con.query('SELECT * FROM mst_employee WHERE id_employee = ?', [data[0].id_employee], function (err, data2) {
      user = {
        data: data2[0]
      }
      res.redirect('/user_mainmenu')
    })
  })
});


server.get('/user_mainmenu', function (req, res) {
  const id = user.data.id_employee
  con.query('INSERT INTO trn_login (id_employee, datetime_login) VALUES(?, NOW())', id, function (err) {
    if (err) return err;
  })
  res.render(__dirname + "/html/user_mainmenu.html", {
    name: user.data.name,
    surname: user.data.surname,
    position: user.data.position
  })
})

server.get('/memcon', function (req, res, next) {
  con.query('SELECT id_employee, name, surname, position, FORMAT(salary,2) AS salary , FORMAT(total_sale,2) as total_sale FROM `mst_employee`',
    (err, data) => {
      if (err) throw err
      res.render(__dirname + "/html/user_management.html", { data: data })
    }
  )
})

server.post('/update', function(req, res, next){
  const employee = req.body
  con.query("UPDATE mst_employee SET name = ? , surname = ? , position = ? , salary = ? , total_sale = ? WHERE id_employee = ?", [employee.name, employee.surname, employee.position, employee.salary, employee.total_sale, employee.id_employee], function(err, result) {
    if(err) return;
    con.query("UPDATE mst_security SET user = ? , password = ? WHERE id_employee = ?", [employee.email, employee.password, employee.id_employee], function(err, result){
      res.redirect('/user_mainmenu')
    })
  });
}) 

server.get('/search/:word', function (req, res, next) {
  let { word } = req.params
  search = "'%"
  search += word
  search += "%'"
  let query =
    'SELECT id_employee, name, surname, position, salary , total_sale FROM mst_employee WHERE name LIKE ' + search + ' OR surname LIKE ' + search + ' OR position LIKE ' + search
  con.query(query, (err, data) => {
    if (err) throw err
    res.render(__dirname + '/html/user_management.html', { data: data })
  })
})

server.get('/user_add', function (req, res) {
  res.sendFile(__dirname + "/html" + "/user_add.html");
})


server.post('/addMember', function (req, res, next) {
  var employee = {
    name: req.body.name,
    surname: req.body.surname,
    position: req.body.position,
    salary: req.body.salary,
    total_sale: req.body.total_sale
  }
  con.query('INSERT INTO mst_employee SET ?', employee, (err, res2) => {
    if (err) throw err
    console.log('Last inset ID: ', res2.insertId)
    insert = res2.insertId
    var security = {
      user: req.body.email,
      password: req.body.password,
      id_employee: res2.insertId
    }
    con.query('INSERT INTO mst_security SET ?', security, (err, res3) => {
      if (err) throw err
      console.log('Last insert ID: ', res3.insertId)
      return res.status(201)
    })
  })
  res.redirect('/user_mainmenu')
})

server.get('/edit/:id', function (req, res) {
  if(!req.params.id)return;

  con.query('SELECT * FROM mst_employee WHERE id_employee = ?', [req.params.id], function (err, data2) {
    let user = data2[0]
    con.query('SELECT * FROM mst_security WHERE id_employee = ?', [req.params.id], function (err, secureData) {
      user.user = secureData[0].user
      user.password = secureData[0].password
      res.render(__dirname + "/html/user_edit.html", { 
        user: user
      })
    })
  })
})



server.get('/req-delete/:id', function (req, res) {
  if(!req.params.id)return;
  con.query('SELECT * FROM mst_employee WHERE id_employee = ?', [req.params.id], function (err, data2) {
    res.render(__dirname + "/html/user_remove.html", { 
      user: data2[0]
    })
  })
})

server.post('/delete', function (req, res) {

  const id_employee = req.body.id_employee
  if(id_employee == undefined || id_employee == null)return;
    con.query('DELETE FROM trn_logout WHERE id_employee = ?', [id_employee], function(){
      con.query('DELETE FROM trn_login WHERE id_employee = ?', [id_employee], function(){
        con.query('DELETE FROM mst_security WHERE id_employee = ?', [id_employee], function(){
          con.query('DELETE FROM mst_employee WHERE id_employee = ?', [id_employee], function(){
            res.redirect('/user_mainmenu')
          })
        })
      })
    })
})



server.get('/', function (req, res) {
  res.sendFile(__dirname + "/html" + "/user_login.html");
})


server.listen(3000, function () {
  console.log('Server Listen at http://localhost:3000');
});