// LOGOUT history
logoutLogging = (con, id) => {
    con.query('INSERT INTO trn_logout (id_employee, datetime_logout) VALUES(?, NOW())', id, function(err){
        if (err) return err;
        console.log(`\n\n[ Logging ] -> userId: ${id} has logout ...\n\n`);
    })
}

// LOGIN history
loginLogging = (con, id) => {
    con.query('INSERT INTO trn_login (id_employee, datetime_login) VALUES(?, NOW())', id, function(err){
        if (err) return err;
        console.log(`\n\n[ Logging ] -> userId: ${id} has login ...\n\n`);
    })
}