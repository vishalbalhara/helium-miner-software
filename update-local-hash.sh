#!/bin/bash
cd ../hm-diag || exit
hm_diag=$(git rev-parse --short HEAD)
cd - || exit
cd ../hm-config  || exit
hm_config=$(git rev-parse --short HEAD)
cd - || exit
cd ../hm-pktfwd || exit
hm_pktfwd=$(git rev-parse --short HEAD)
cd - || exit
cd ../hm-miner || exit
hm_miner=$(git rev-parse --short HEAD)
cd - || exit

sed -i -e "s/DIAGNOSTICS_VERSION=.*$/DIAGNOSTICS_VERSION=${hm_diag}/" settings.ini
sed -i -e "s/CONFIG_VERSION=.*$/CONFIG_VERSION=${hm_config}/" settings.ini
sed -i -e "s/PKTFWD_VERSION=.*$/PKTFWD_VERSION=${hm_pktfwd}/" settings.ini
sed -i -e "s/MINER_VERSION=.*$/MINER_VERSION=${hm_miner}/" settings.ini

FIRMWARE_SHORT_HASH=$(git rev-parse --short HEAD)
export FIRMWARE_SHORT_HASH
python3 gen_docker_compose.py rockpis -o device-compose-files/docker-compose-rockpis.yml