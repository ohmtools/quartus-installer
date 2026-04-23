# Shorthand commands definitions for common actions
#
# Copyright (C) 2026  Tobias Linz <contact@tobilinz.de>
#
# This file is part of Quartus Installer.
#
# Quartus Installer is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#
# Quartus Installer is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along with Quartus Installer. If not, see <https://www.gnu.org/licenses/>.

default:
  just --list

[no-cd]
build:
  podman build -t quartus-installer:local ./container

[no-cd]
assemble:
  distrobox assemble create --file distrobox-local.ini

rebuild:
  -quartus-uninstall | xargs -d '\n' "${XDG_DATA_HOME:-$HOME/.local/share}/quartus-prime-lite/uninstall"
  just build
  just assemble

[no-cd]
push-cicd version:
  #!/usr/bin/env bash
  set -euo pipefail

  cleanup() {
    podman rmi amd64-tmp arm64-tmp || true
    podman manifest rm quartus-installer-cicd:latest || true
  }
  trap cleanup EXIT

  podman manifest create quartus-installer-cicd:latest

  podman build --platform linux/amd64 -f Containerfile.cicd -t amd64-tmp .
  podman manifest add quartus-installer-cicd:latest containers-storage:localhost/amd64-tmp

  podman build --platform linux/arm64 -f Containerfile.cicd -t arm64-tmp .
  podman manifest add quartus-installer-cicd:latest containers-storage:localhost/arm64-tmp

  podman manifest push quartus-installer-cicd:latest docker://codeberg.org/tobilinz/quartus-installer-cicd:{{version}}
  podman manifest push quartus-installer-cicd:latest docker://codeberg.org/tobilinz/quartus-installer-cicd:latest

