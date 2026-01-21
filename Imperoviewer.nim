import os

let run = getAppDir()
let player = run / "ScreenRecordingPlayer.exe"

if not fileExists(player):
    echo "ScreenRecordingPlayer.exe not found."
    quit(1)

echo "Welcome to Impero Viewer. This lets you view your screen recordings."
echo "Please locate your Impero installer directory if an error is shown."

let imppath = r"C:\Program Files (x86)\Impero Solutions Ltd\Impero Client\Recordings\PUBLIC"
let impnoerr = r"C:\Program Files (x86)\Impero Solutions Ltd\Impero Client"

proc findAndPlay(directory: string) =
    for file in walkFiles(directory / "*.irf"):
        let (_, name, _) = splitFile(file)
        echo "Found recording " & name
        echo "Viewing recording..."
        let cmd = player.quoteShell() & " filepath=" & file.quoteShell()
        discard execShellCmd(cmd)
        echo "Here is your recording."

if dirExists(imppath):
    echo "Found recording dir"
    findAndPlay(imppath)
elif dirExists(impnoerr):
    let subDir = impnoerr / "Recordings" / "PUBLIC"
    if dirExists(subDir):
        echo "Found Recording directory."
        findAndPlay(subDir)
    else:
        echo "No recordings found."
        quit(1)
else:
    echo "Checking current directory..."
    findAndPlay(getCurrentDir())
