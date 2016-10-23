#!/bin/bash

#Author: Nandini Tata <nandini.tata@intel.com>
# Copyright (c) 2016 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.


###########################################################
# Script to install salt master and minions on a single node
############################################################

SALT_USER="salt"
SALT_GROUP="salt"
SALT_MINION="minion"

SALT_CONFIG_DIR="/etc/salt"
SALT_RUN_DIR="/var/run/salt"
SALT_CACHE_DIR="/var/cache/salt"
SALT_LOG_DIR="/var/log/salt"

#own all directories by salt user to read from and write to
chown -R ${SALT_USER}:${SALT_GROUP} ${SALT_CONFIG_DIR}
chown -R ${SALT_USER}:${SALT_GROUP} ${SALT_RUN_DIR}
chown -R ${SALT_USER}:${SALT_GROUP} ${SALR_CACHE_DIR}
chown -R ${SALT_USER}:${SALT_GROUP} ${SALT_LOG_DIR}

MY_IP=$(ip a | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo "My ip is ${MY_IP}"

#configure master
sed -i 's/#\(interface: \)\(.*\)/echo "\1(("'${MY_IP}'"))"/ge' ${SALT_CONFIG_DIR}/master
sed -i 's/#\(user: \)\(.*\)/echo "\1(("'${SALT_USER}'"))"/ge' ${SALT_CONFIG_DIR}/master


#connfigure minion
sed -i 's/#\(master: \)\(.*\)/echo "\1(("'${MY_IP}'"))"/ge' ${SALT_CONFIG_DIR}/minion
sed -i 's/#\(user: \)\(.*\)/echo "\1(("'${SALT_USER}'"))"/ge' ${SALT_CONFIG_DIR}/minion
sed -i 's/#\(id: \)\(.*\)/echo "\1(("'${SALT_MINION}'"))"/ge' ${SALT_CONFIG_DIR}/minion
