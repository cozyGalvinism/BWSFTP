import WinSCPWrapper
import argparse

proc main(options: auto) =
    var wrapper: WinSCP = newWinSCPFromINI(options.ini)
    var exitCode: int = wrapper.spawn()
    quit(exitCode)

const PARSER = newParser("BWSFTP"):
    help("Startet eine Dateiübertragung von Dateien über WinSCP")
    arg("ini")
    run:
        main(opts)

when isMainModule:
    try:
       PARSER.run(commandLineParams())
    except UsageError as _:
        stderr.writeLine(getCurrentExceptionMsg())
        quit(1)
