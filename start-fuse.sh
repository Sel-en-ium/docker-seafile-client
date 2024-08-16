#!/bin/bash

# WIP - start.sh might not work as it uses a lower permission user (seafile)
# Might need to run as root to work with fuse
# To test interactively, set docker-compose.yml command: "sleep infinity"

STATE_DIR="/seafile-state"
# Used with every seaf-cli command to ensure it is using the correct configuration file
C="-c ${STATE_DIR}/conf"
# Must own the settings/state/conf directory
chown seafile:seafile -R /seafile-state

# initialise seafile client with this folder
seaf-cli init ${C} -d ${STATE_DIR}  
seaf-cli start ${C}
# seaf-cli config ${C} -k disable_verify_certificate -v true
seaf-cli sync ${C} -l "$LIBRARY_ID" -s "${SERVER_URL}:${SERVER_PORT}" -d "$LIBRARY_DIR" -u "$USERNAME" -p "$PASSWORD"
