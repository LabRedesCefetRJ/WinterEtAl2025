#! /bin/bash
FRAMEWORK="/usr/bin/jasonEmbedded"
SIMULIDE="/opt/group.chon/simulide/simulide"
SERIALPORT="/dev/ttyEmulatedPort1"
XTERM="/usr/bin/xterm"

clear
if [[ ! -f "$FRAMEWORK"  ]] || [[ ! -f "$SIMULIDE" ]] || [[ ! -e "$SERIALPORT" ]] || [[ ! -e "$XTERM" ]]
then
    echo "Installing dependencies..."
    sudo clear
    echo "deb [trusted=yes] http://packages.chon.group/ chonos main" | sudo tee /etc/apt/sources.list.d/chonos.list
    sudo apt update
    sudo apt install linux-headers-`uname -r` -y
    sudo apt install jason-embedded chonos-serial-port-emulator chonos-simulide xterm -y
    clear
else
    echo "The computer has JasonEmbedded and SimulIDE"
fi

cd alimentador
chonos-simulide alimentador.sim1 &

echo "Starting Simulation..."
sleep 3

cd ../mas1/
xterm -T "Multiagent System 1" -e jasonEmbedded mas1.mas2j &

cd ../mas2/
xterm -T "Multiagent System 2" -e jasonEmbedded mas2.mas2j