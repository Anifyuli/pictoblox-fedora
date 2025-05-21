#!/usr/bin/env bash

Red="\033[0;31m"
Bold="\033[1m"
Color_Off="\033[0m"
Cyan="\033[0;36m"
Green="\033[0;32m"

user_name=$(who | cut -d ' ' -f 1 | head -1)
installer_search_path="/home/$user_name"

USAGE_MESSAGE="Usage: $0 [OPTIONS]... [DIRECTORY]...
Install PictoBlox on Fedora Linux using a .deb installer.

 -d, --directory         Directory where the installer is located
 -h, --help              Show this help message and exit
 --uninstall             Uninstall PictoBlox
"

install () {
    localized_installers=()
    selected_installer=''

    echo -e "${Green}${Bold}Searching for PictoBlox installers in user home...${Color_Off}\n"
    c=1
    for installer in $(find $installer_search_path -type f -name "PictoBlox*.deb"); do
        localized_installers[$c]=$installer
        ((c++))
    done

    clear

    if [[ -z "${localized_installers[@]}" ]]; then
        echo -e "\n${Red}${Bold}PictoBlox installer not found in /home. It must be named like: PictoBlox*.deb${Color_Off}\n"
        echo -e "You can download the installer from ${Cyan}https://thestempedia.com/product/pictoblox/#downloads${Color_Off}"
        exit 1
    elif [ "${#localized_installers[@]}" -eq 1 ]; then
        selected_installer="${localized_installers[1]}"
    else
        echo -e "${Red}${Bold}Press CTRL + C to cancel installation.${Color_Off}\n"
        echo -e "${Cyan}${Bold}$((c-1)) installers of PictoBlox found:${Color_Off}\n"

        PS3="Select an installer to use: "
        select installer in ${localized_installers[@]}
        do
            selected_installer=$installer
            break
        done
    fi

    echo -e "\n${Bold}Selected installer: ${Red}${Bold}$selected_installer ${Color_Off}\n"
    sleep 2

    echo "Removing old version of PictoBlox"
    uninstall

    echo "Extracting files"
    mkdir pictoblox
    ar -x "$selected_installer" --output=pictoblox
    tar -xf pictoblox/control.tar.* -C pictoblox
    tar -xf pictoblox/data.tar.* -C pictoblox

    sudo cp -r pictoblox/usr /
    sudo cp -r pictoblox/opt /

    echo "Running post-install scripts (if any)"
    if [ -f pictoblox/postinst ]; then
        sudo bash pictoblox/postinst
    fi

    sudo rm -rf pictoblox
    echo -e "${Green}PictoBlox installed successfully.${Color_Off}"
}

uninstall () {
    if [ -d /opt/PictoBlox ]; then
        echo "Uninstalling PictoBlox."
        sudo rm -rf /opt/PictoBlox
        sudo rm -f /usr/share/applications/pictoblox.desktop
        sudo rm -f /usr/local/bin/pictoblox
        sudo update-mime-database /usr/share/mime || true
        sudo gtk-update-icon-cache -t --force /usr/share/icons/hicolor || true
        echo "PictoBlox was uninstalled."
    else
        echo "PictoBlox is not installed."
    fi
    sleep 2
}

case "$1" in
    -h | --help)
        echo "$USAGE_MESSAGE"
        exit 0
    ;;

    -d | --directory)
        installer_search_path="$2"
        echo -e "A directory was specified to search the installer: ${Bold}$installer_search_path${Color_Off}"
        sleep 2
        install
    ;;

    --uninstall)
        uninstall
    ;;

    *)
        install
    ;;
esac

