# BWSFTP

Implementiert SFTP für die BüroWARE.

**Wichtig!** Bisher wird nur ein Upload unterstützt!

## Verwendung

```usage
Startet eine Dateiübertragung von Dateien über WinSCP

Usage:
  BWSFTP ini

Arguments:
  ini

Options:
  -h, --help
```

## INI-Datei

BWSFTP verwendet eine INI-Datei um Parameter zu vermeiden. Eine INI sieht folgendermaßen aus:

```ini
[SFTP]
User=myuser
Passwort=mypass
Server=example.com
Lokal=C:\BueroWARE\Upload
Remote=/input
DateiMuster=*.pdf

[WinSCP]
Pfad=C:\Program Files (x86)\WinSCP
Log=C:\BueroWARE\sftp.log
```
