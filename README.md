⚠️  MINDESTENS 35GB SPEICHERPLATZ BENÖTIGT

Systemanforderungen:
- distrobox (https://distrobox.it/#installation  Am besten über Paketmanager der jeweiligen Distribution installieren)
- just

Umgebung vorbereiten:
1. Dieses Projekt herunterladen
2. In `quartus-prime-lite-ubuntu` folgendes ausführen:
   `just build && just assemble`
3. `distrobox enter quartus-prime-lite-ubuntu`

In VHDL Skripten immer `-suppress 12110` anhängen

finish workflow
finish tutorial for workflow
add more about tutorial from github (https://gist.github.com/snaens/124cbe35fe23bb865f2403d5e1de9d4e)

## Deinstallation

`distrobox rm quartus-prime-lite-ubuntu`
`rm -rf ~/.local/share/mime/packages/quartus-bdf.xml ~/.local/share/icons/hicolor/64x64/mimetypes/application-x-quartus-bdf.png ~/.local/share/quartus-prime-lite-ubuntu`
