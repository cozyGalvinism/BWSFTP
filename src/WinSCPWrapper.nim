import strutils
import os
import parsecfg
import strformat

type
    WinSCP* = object
        path*: string
        logPath*: string
        iniPath*: string

proc newWinSCP*(iniPath: string, path: string, logPath: string): WinSCP =
    result.path = path
    if not result.path.endsWith("\\"):
        result.path = result.path & "\\"
    result.logPath = logPath
    result.iniPath = iniPath

proc newWinSCPFromINI*(iniPath: string): WinSCP =
    var iniConfig: Config = loadConfig(iniPath)
    var path: string = iniConfig.getSectionValue("WinSCP", "Pfad")
    var logPath: string = iniConfig.getSectionValue("WinSCP", "Log")
    return newWinSCP(iniPath, path, logPath)

proc hasLogEnabled(w: WinSCP): bool =
    return w.logPath.isEmptyOrWhitespace() == false

proc spawn*(self: WinSCP): int =
    var iniConfig: Config = loadConfig(self.iniPath)
    var user: string = iniConfig.getSectionValue("SFTP", "User")
    var pass: string = iniConfig.getSectionValue("SFTP", "Passwort")
    var server: string = iniConfig.getSectionValue("SFTP", "Server")
    var local: string = iniConfig.getSectionValue("SFTP", "Lokal")
    var remote: string = iniConfig.getSectionValue("SFTP", "Remote")
    var file: string = iniConfig.getSectionValue("SFTP", "DateiMuster")

    let fp = open("tmpscript.txt", fmWrite)
    fp.writeLine(&"open sftp://{user}:{pass}@{server}{remote} -hostkey=*")
    fp.writeLine(&"lcd \"{local}\"")
    fp.writeLine(&"put \"{file}\"")
    fp.writeLine("exit")

    var cmd: string = &"\"{self.path}WinSCP.exe\" "
    if self.hasLogEnabled():
        cmd = cmd & &"/log=\"{self.logPath}\" "
    
    cmd = cmd & &"/ini=nul /script=tmpscript.txt"
    var exitCode: int = execShellCmd(cmd)
    removeFile("tmpscript.txt")
    return exitCode