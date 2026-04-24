# Helper variable definitions
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

export HOST_HOME="$(/usr/local/lib/host-run bash -c 'printf "%s" "$HOME"')"
export HOST_SHARE="$(/usr/local/lib/host-run bash -c 'printf "%s" "${XDG_DATA_HOME:-$HOME/.local/share}"')"

export SHARE="$HOME/.local/share"
export CACHE="$HOME/.cache"

export QUARTUS_DIR="$SHARE/quartus-prime-lite"
export QUARTUS_INSTALLER_CACHE="$CACHE/quartus-prime-lite"

export QUARTUS_ICON="$SHARE/icons/hicolor/64x64/apps/quartus.png"
