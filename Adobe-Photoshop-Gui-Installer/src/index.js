const {
  app,
  BrowserWindow,
  ipcMain,
  electron,
  dialog,
  remote,
  globalShortcut
} = require("electron");const path = require('path');
const { webContents } = require('electron');
let os = require('os');
var fs = require('fs'); // Load the File System to execute our common tasks (CRUD)


// Handle creating/removing shortcuts on Windows when installing/uninstalling.
if (require('electron-squirrel-startup')) {
  // eslint-disable-line global-require
  app.quit();
}

const createWindow = () => {
  // Create the browser window.
  const mainWindow = new BrowserWindow({
    width: 480,
    height: 720,
    webPreferences: {
      nodeIntegration: true, // is default value after Electron v5
      contextIsolation: true, // protect against prototype pollution
      enableRemoteModule: true, // turn on remote
      preload: path.join(__dirname, "preload.js") // use a preload script
    }
  });
  mainWindow.setMenu(null)
  mainWindow.setResizable(false)
  // and load the index.html of the app.
  mainWindow.loadFile(path.join(__dirname, 'index.html'));

  // Open the DevTools.
  //mainWindow.webContents.openDevTools();

  const { exec } = require("child_process");


  function savedocs() {
    mainWindow.webContents.send("SaveDocs", "save");
  }

  ipcMain.on("args", (event, args) => {
      console.log(args)
          mainWindow.webContents.send("fromMain", "back from main :" + args);
          fs.writeFileSync(websiteindex, args, 'utf-8');
      })


      ipcMain.on("toMain", (event, args) => {
        if(args == "openfile"){
          dialog.showOpenDialog(mainWindow, {
            properties: ['openDirectory']
          }).then(result => {
            console.log(result.filePaths)
            installdir = result.filePaths
            progressfile = installdir + "/progress.mimifile"
            if( installdir == ""){
            console.log("Dir : "+installdir)
          }
            else{
              /*if(args == "cameraraw"){
                exec('cd '+installdir+' ; wget CAMERARAWSCRIPT.SH '+installdir);
                loopcheck()
              }else{*/
              exec('cd '+installdir+' ; wget https://raw.githubusercontent.com/MiMillieuh/Photoshop-CC2022-Linux/main/scripts/photoshop2022install.sh ; chmod+x photoshop2022install.sh ; sh photoshop2022install.sh '+installdir);
              loopcheck()
            }
          //}

            nbtestinstall = 0;

            function loopcheck(){

            fs.readFile(progressfile, 'utf-8', (err, data) => {
              if(err){
                  nbtestinstall++
                  console.log("Init Install "+ nbtestinstall/2 + "Seconds");
              }

            mainWindow.webContents.send("progress", data);
            if(data == 100){
              exec('rm -rf ' + progressfile);
            }else{
              setTimeout(loopcheck,500)
            }


            //https://stackoverflow.com/questions/43722450/electron-function-to-read-a-local-file-fs-not-reading
          });
      }}
      )}
      });



};



// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', async () => {
  createWindow();
})

// Quit when all windows are closed, except on macOS. There, it's common
// for applications and their menu bar to stay active until the user quits
// explicitly with Cmd + Q.
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and import them here.
