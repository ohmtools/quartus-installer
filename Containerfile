FROM quay.io/toolbx/ubuntu-toolbox:24.04

LABEL org.opencontainers.image.source="https://codeberg.org/tobilinz/quartus-prime-lite-installer"
LABEL org.opencontainers.image.description="Quartus prime lite package for a semi-automated install"

RUN apt-get update \
    && apt-get install -y zenity libglib2.0-0t64 libxext6 libfontconfig1 libsm6 libxft2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY install-quartus /usr/local/bin/install-quartus
RUN chmod +x /usr/local/bin/install-quartus

RUN mkdir -p /etc/profile.d/
COPY <<'EOF' /etc/profile.d/quartus-setup.sh
SHARE="$HOME/.local/share"

APPLICATIONS_DIR="$SHARE/applications"
DESKTOP_FILE="$APPLICATIONS_DIR/quartus.desktop"
QUARTUS_DIR="$HOME/.local/share/quartus-prime-lite"
export ICON_FILE="$QUARTUS_DIR/quartus/adm/quartusii.png"
if [ ! -f "$DESKTOP_FILE" ]; then
    mkdir -p "$APPLICATIONS_DIR"
    cp /etc/quartus/quartus.desktop "$DESKTOP_FILE"
    sed -i "s|^Exec=.*|Exec=$QUARTUS_DIR/quartus/bin/quartus --64bit %f|" "$DESKTOP_FILE"
    sed -i "s|^Icon=.*|Icon=$ICON_FILE|" "$DESKTOP_FILE"
fi

MIME_DIR="$SHARE/mime/packages"
export MIME_FILE="$MIME_DIR/quartus-bdf.xml"
if [ ! -f "$MIME_FILE" ]; then
    mkdir -p "$MIME_DIR"
    cp /etc/quartus/quartus-bdf.xml "$MIME_FILE"
fi

INSTALL_BDF_MIME_FILE="$HOME/install-bdf-mime"
if [ ! -f "$INSTALL_BDF_MIME_FILE" ]; then
    cp /etc/quartus/install-bdf-mime "$INSTALL_BDF_MIME_FILE"
fi

install-quartus
EOF

RUN mkdir -p /etc/quartus
COPY install-bdf-mime /etc/quartus/install-bdf-mime
COPY quartus.desktop /etc/quartus/quartus.desktop
COPY quartus-bdf.xml /etc/quartus/quartus-bdf.xml


