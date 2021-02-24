# Package

version       = "1.0.0"
author        = "cozyGalvinism"
description   = "Ein Wrapper für WinSCP um SFTP in der BüroWARE zu ermöglichen"
license       = "GPL-3.0"
srcDir        = "src"
bin           = @["BWSFTP"]


# Dependencies

requires "nim >= 1.4.2", "argparse == 2.0.0"
