#!/bin/sh

#Author: Paul Dardeau <paul.dardeau@intel.com>
#        Nandini Tata <nandini.tata@intel.com>
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



###################################################
#Script to install all required dependencies for Salt
###################################################


# Ensures the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get update
add-apt-repository ppa:saltstack/salt -y
add-apt-repository ppa:saltstack/salt2015-5 -y
apt-get install python-software-properties -y
apt-get install software-properties-common -y
apt-get install salt-api -y
apt-get install salt-cloud -y
apt-get install salt-master -y
apt-get install salt-minion -y
apt-get install salt-ssh -y
apt-get install salt-syndic -y
