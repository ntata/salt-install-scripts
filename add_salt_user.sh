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
# Script to check if "salt" user exists; if not, will be created
############################################################

# Ensures the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ "" = "${SALT_USER}" ]; then
   export SALT_USER="salt"
fi

if [ "" = "${SALT_GROUP}" ]; then
   export SALT_GROUP="salt"
fi
#verify that salt group exists
if grep -q ${SALT_GROUP} /etc/group; then
    echo "salt user group exists"
else
   groupadd ${SALT_GROUP}
   echo "salt user group has been created"
fi

#verify salt user exists
if grep -q ${SALT_USER} /etc/passwd; then
   echo "salt user exists"
else
  useradd -g ${SALT_GROUP} -m -s /bin/bash ${SALT_USER}
  echo "salt user has been created"
   
  #add user to sudo group
  adduser ${SALT_USER} sudo
  echo "salt user has been added to the  group"
  echo "try 'sudo su salt' to switch to salt user and it will not prompt for password"
fi
   
#set no password for salt. 
if grep -q ${SALT_GROUP} /etc/sudoers; then
  continue
else
  echo "%${SALT_GROUP} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi  
