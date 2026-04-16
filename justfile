default:
  just --list

build:
  podman build -t quartus-prime-lite-installer:local ./container

assemble:
  distrobox assemble create --file distrobox-local.ini

[no-cd]
rebuild:
  ./container/uninstall
  podman build -t quartus-prime-lite-installer:local ./container
  distrobox assemble create --file distrobox-local.ini

push-cicd version:
  podman manifest rm quartus-prime-lite-installer-cicd:latest || true
  podman manifest create quartus-prime-lite-installer-cicd:latest
  
  podman build --platform linux/amd64 -f Containerfile.cicd -t amd64-tmp .
  podman manifest add quartus-prime-lite-installer-cicd:latest containers-storage:localhost/amd64-tmp
  
  podman build --platform linux/arm64 -f Containerfile.cicd -t arm64-tmp .
  podman manifest add quartus-prime-lite-installer-cicd:latest containers-storage:localhost/arm64-tmp

  podman manifest push quartus-prime-lite-installer-cicd:latest docker://codeberg.org/tobilinz/quartus-prime-lite-installer-cicd:{{version}}
  podman manifest push quartus-prime-lite-installer-cicd:latest docker://codeberg.org/tobilinz/quartus-prime-lite-installer-cicd:latest
  
  podman rmi amd64-tmp arm64-tmp
