default:
  just --list

build:
  podman build -t quartus-prime-lite-ubuntu .

assemble:
  distrobox assemble create --file distrobox.ini

push-cicd version:
  podman build -f Containerfile.cicd -t codeberg.org/tobilinz/quartus-prime-lite-installer-cicd:{{version}} .
  podman push codeberg.org/tobilinz/quartus-prime-lite-installer-cicd:{{version}}
  podman tag quartus-prime-lite-installer-cicd:{{version}} codeberg.org/tobilinz/quartus-prime-lite-installer-cicd:latest
  podman push codeberg.org/tobilinz/quartus-prime-lite-installer-cicd:latest
