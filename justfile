default:
  just --list

build:
  podman build -t quartus-prime-lite-ubuntu .

assemble:
  distrobox assemble create --file distrobox.ini
