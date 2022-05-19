
window.api.receive("progress", (data) => {

    console.log(data)

    if(data == 10){
        document.getElementById("Status").innerHTML = "Preparing environement ("+data+"%)"
        document.getElementById("statusbar").style.width = "10%"
    }else if(data == 20){
        document.getElementById("Status").innerHTML = "Extracting redist ("+data+"%)"
        document.getElementById("statusbar").style.width = "20%"
    }else if(data == 25){
        document.getElementById("Status").innerHTML = "Downloading Photoshop ("+data+"%)" 
        document.getElementById("statusbar").style.width = "25%"
    }else if(data == 50){
        document.getElementById("Status").innerHTML = "Extracting Photoshop ("+data+"%)"
        document.getElementById("statusbar").style.width = "50%"
    }else if(data == 70){
        document.getElementById("Status").innerHTML = "Extracting redist ("+data+"%)"
        document.getElementById("statusbar").style.width = "70%"
    }else if(data == 80){
        document.getElementById("Status").innerHTML = "Installing redist ("+data+"%)"
        document.getElementById("statusbar").style.width = "80%"
    }else if(data == 90){
        document.getElementById("Status").innerHTML = "Editing some files ("+data+"%)"
        document.getElementById("statusbar").style.width = "90%"
    }else if(data == 95){
        document.getElementById("Status").innerHTML = "CameraRaw (follow setup) ("+data+"%)"
        document.getElementById("statusbar").style.width = "95%"
    }else if(data == 100){
        document.getElementById("Status").innerHTML = "Done, You can close this window("+data+"%)"
        document.getElementById("statusbar").style.width = "100%"
        document.getElementById("installbtn").innerHTML = "Done"
    }else{
        document.getElementById("Status").innerHTML = "Starting (0%)"
    }

})

function OpenFile() {
    /*document.getElementById("cameraraw").disabled = true;
    if(document.getElementById("cameraraw").checked = true){
        window.api.send("toMain", "cameraraw")
    }*/
    window.api.send("toMain", "openfile")
    document.getElementById("installbtn").disabled = true;
    document.getElementById("installbtn").innerHTML = "Installing"
}
