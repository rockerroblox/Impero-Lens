import os


var run = getAppDir()

# Pre-flight checks

var player = run & "\\ScreenRecordingPlayer.exe"
if fileExists(player):
    # Works, continue
    discard
else:
    echo "ScreenRecordingPlayer.exe not found."
    quit(1)



echo "Welcome to Impero Viewer. This lets you view your screen recordings."
echo "Please locate your Impero installer directory if an error is shown."

var imppath = "C:\\Program Files (x86)\\Impero Solutions Ltd\\Impero Client\\Recordings\\PUBLIC"
var impnoerr = "C:\\Program Files (x86)\\Impero Solutions Ltd\\Impero Client"

proc checkImp1(): bool =
    if dirExists(imppath):
        return true
    elif not dirExists(imppath):
        return false

proc checkImpMain(): bool =
    if dirExists(impnoerr):
        return true
    elif not dirExists(impnoerr):
        return false

var Imprec = checkImp1()
var Impain = checkImpMain()

if not Imprec and not Impain:
    echo "Checking current directory..."
    for file in walkFiles(getCurrentDir()):
        let (_, name, ext) = splitFile(file)
        if ext == ".irf":
            echo "Found recording " & name
            echo "Viewing recording..."
            var cmd = player.quoteShell() & " filepath=" & file.quoteShell()
            discard os.execShellCmd(cmd)
            echo "Here is your recording."


if Impain and not Imprec:
    if fileExists(impnoerr & "\\Recordings"):
        echo "Found Recording directory."
        echo "Checking for recordings"
        for file in walkFiles(impnoerr & "\\Recordings\\PUBLIC"):
            echo "Found file " & file
            let (_, name, ext) = splitFile(file)
            if ext == ".irf":
                echo "Found recording " & name
                echo "Viewing recording..."
                var cmd = player.quoteShell() & " filepath=" & file.quoteShell()
                discard os.execShellCmd(cmd)
                echo "Here is your recording."
    elif not fileExists(impnoerr & "\\Recordings"):
        echo "No recordings found."
        quit(1)

if Imprec and Impain:
    echo "Found recording dir"
    echo "Checking dir."
    for file in walkFiles(imppath):
        let (_, name, ext) = splitFile(file)
        if ext == ".irf":
            echo "Found recording " & name
            echo "Viewing recording..."
            var cmd = player.quoteShell() & " filepath=" & file.quoteShell()
            discard os.execShellCmd(cmd)
            echo "Here is your recording."



