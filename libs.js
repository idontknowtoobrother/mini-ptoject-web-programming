isHavePositionByName = (userPosition, requestPermission) => {
    console.log(userPosition, requestPermission)
    return userPosition == requestPermission
}

isHaveSessionUserData = (sessionUserData) => {
    if(!sessionUserData || 
        !sessionUserData.session || 
        !sessionUserData.session.userdata
    ){
        return false
    }
    return true
}