# Xodo

A dark, layered login theme for SDDM, built with Qt6 QML. It shows a large clock on the left, a centered login card on the right, and restart and shut down controls at the bottom right.

## Install

Copy the theme into the SDDM themes folder and select it:

    sudo cp -r . /usr/share/sddm/themes/xodo
    sudo mkdir -p /etc/sddm.conf.d
    printf '[Theme]\nCurrent=xodo\n' | sudo tee /etc/sddm.conf.d/theme.conf

Put your own background image at the top of the theme folder as wallpaper.png. The image is not included in this repository.

## Preview

    sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/xodo

## Requirements

Qt6 with qt6-declarative, SDDM 0.21 or newer, and the Adwaita Sans font, or change the font in theme.conf.
