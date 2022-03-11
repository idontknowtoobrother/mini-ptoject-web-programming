// LOGOUT history
logoutLogging = (con, id, cb) => {
    con.query('INSERT INTO trn_logout (id_employee, datetime_logout) VALUES(?, NOW())', id, function(err){
        if (err)return cb(false)
        cb(id)
    })
}

// LOGIN history
loginLogging = (con, id, cb) => {
    con.query('INSERT INTO trn_login (id_employee, datetime_login) VALUES(?, NOW())', id, function(err){
        if (err)return cb(false)
        cb(id)
    })
}