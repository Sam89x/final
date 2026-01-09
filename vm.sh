#!/bin/bash

# ============================================
# COLORS
# ============================================
R="\e[1;31m"
G="\e[1;32m"
Y="\e[1;33m"
B="\e[1;34m"
C="\e[1;36m"
W="\e[1;37m"
N="\e[0m"

# ============================================
# ASCII UI FUNCTIONS (SAM-DEV)
# ============================================

print_line() {
    echo -e "${R}----------------------------------------------------${N}"
}

print_box() {
    local title="$1"
    local color="$2"
    echo -e "${color}+--------------------------------------------------+${N}"
    printf "${color}| ${Y}SAM-DEV${color} | ${W}%-36s ${color}|\n" "$title"
    echo -e "${color}+--------------------------------------------------+${N}"
}

print_status() {
    echo -e "${G}[ SAM-DEV ] >>> ${W}$1${N}"
}

print_option() {
    local num="$1"
    local text="$2"
    echo -e "${R}+--------------------------------------------------+${N}"
    printf "${R}| ${Y}SAM-DEV${R} | ${W}[%s] %-36s ${R}|\n" "$num" "$text"
    echo -e "${R}+--------------------------------------------------+${N}"
}

print_header() {
    clear
    print_box "DEVELOPMENT MANAGEMENT CONSOLE" "$R"
}

print_footer() {
    print_line
    echo -e "${W}[ SAM-DEV ] Jishnu Network (C) 2024 - All Rights Reserved${N}"
    print_line
}

# ============================================
# MAIN MENU LOOP
# ============================================

while true; do
    print_header

    print_box "MAIN OPTIONS" "$R"

    print_option "1" "GitHub VPS Maker"
    print_option "2" "IDX Tool Setup"
    print_option "3" "IDX VPS Maker"
    print_option "4" "Exit"

    print_line
    echo -ne "${W}[ SAM-DEV ] Select Option [1-4]: ${Y}"
    read op
    echo -ne "${N}"

    case $op in

    # ========================================
    # 1) GITHUB VPS MAKER
    # ========================================
    1)
        clear
        print_box "GITHUB VPS MAKER" "$R"

        RAM=15000
        CPU=4
        DISK_SIZE=100G
        CONTAINER_NAME=hopingboyz
        IMAGE_NAME=hopingboyz/debain12
        VMDATA_DIR="$PWD/vmdata"

        print_status "Preparing VM environment"
        mkdir -p "$VMDATA_DIR"

        print_line
        echo -e "${W}SAM-DEV CONFIGURATION SUMMARY${N}"
        print_line
        echo -e " RAM        : $RAM MB"
        echo -e " CPU        : $CPU Cores"
        echo -e " DISK       : $DISK_SIZE"
        echo -e " NAME       : $CONTAINER_NAME"
        echo -e " IMAGE      : $IMAGE_NAME"
        echo -e " TYPE       : Docker VPS"
        print_line

        print_status "Launching GitHub VPS container"

        docker run -it --rm \
          --name "$CONTAINER_NAME" \
          --device /dev/kvm \
          -v "$VMDATA_DIR":/vmdata \
          -e RAM="$RAM" \
          -e CPU="$CPU" \
          -e DISK_SIZE="$DISK_SIZE" \
          "$IMAGE_NAME"

        print_status "GitHub VPS session ended"
        echo -ne "${W}[ SAM-DEV ] Press Enter to return..."
        read
        ;;

    # ========================================
    # 2) IDX TOOL SETUP
    # ========================================
    2)
        clear
        print_box "IDX TOOL SETUP" "$R"

        print_status "Cleaning old files"
        cd ~ || exit
        rm -rf myapp flutter

        mkdir -p ~/vps123
        cd ~/vps123 || exit

        if [ ! -d ".idx" ]; then
            mkdir .idx
            cd .idx || exit

            print_status "Creating dev.nix configuration"

cat <<EOF > dev.nix
{ pkgs, ... }: {
  channel = "stable-24.05";

  packages = with pkgs; [
    unzip
    openssh
    git
    qemu
    sudo
    cloud-utils
  ];

  env = {
    EDITOR = "nano";
  };

  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];
  };
}
EOF

            print_status "IDX Tool setup completed"
        else
            print_status "IDX Tool already exists - skipping"
        fi

        print_line
        echo -e "${W}SAM-DEV IDX STATUS${N}"
        print_line
        echo -e " LOCATION : ~/vps123/.idx"
        echo -e " CHANNEL  : stable-24.05"
        echo -e " STATUS   : Ready"
        print_line

        echo -ne "${W}[ SAM-DEV ] Press Enter to return..."
        read
        ;;

    # ========================================
    # 3) IDX VPS MAKER
    # ========================================
    3)
        clear
        print_box "IDX VPS MAKER" "$R"

        print_status "Connecting to remote script"
        print_status "Executing IDX VPS Maker"

        bash <(curl -s https://rough-hall-1486.jishnumondal32.workers.dev)

        print_status "IDX VPS Maker completed"
        echo -ne "${W}[ SAM-DEV ] Press Enter to return..."
        read
        ;;

    # ========================================
    # 4) EXIT
    # ========================================
    4)
        clear
        print_box "SESSION TERMINATED" "$R"
        echo -e "${W}[ SAM-DEV ] Thank you for using Jishnu Network${N}"
        echo -e "${W}[ SAM-DEV ] Made with love by Jishnu${N}"
        print_footer
        sleep 2
        exit 0
        ;;

    # ========================================
    # INVALID OPTION
    # ========================================
    *)
        print_box "INVALID OPTION" "$R"
        echo -e "${W}[ SAM-DEV ] Please choose between 1-4 only${N}"
        sleep 2
        ;;
    esac
done
