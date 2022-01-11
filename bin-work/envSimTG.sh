#!/bin/bash
# This script should be sourced to set the environment used for cores etc.
# This is inspired by the /usr/local/bin/eclipseIASI-NG script

TARGET_DEP="Ubuntu_20.04/64bit"
GEN_TARGET_DEP="Linux/64bit"

# Dependencies Locations
DEPS_CACHE=${HOME}/tmp/DEPS_CACHE
# ACE-TAO
if [ ! -e ${DEPS_CACHE}/${TARGET_DEP}/ACE-TAO/6.5.9 ] ; then
    echo "Caching ACE-TAO 6.5.9..."
    mkdir -p ${DEPS_CACHE}/${TARGET_DEP}/ACE-TAO
    rsync --info=progress2 -az ${SDK_PATH}/tools/dependencies/${TARGET_DEP}/ACE-TAO/6.5.9 ${DEPS_CACHE}/${TARGET_DEP}/ACE-TAO/
fi
export ACE_ROOT=${DEPS_CACHE}/${TARGET_DEP}/ACE-TAO/6.5.9
echo -e "ACE_ROOT ➡ ${ACE_ROOT}"
export TAO_ROOT=${ACE_ROOT}
echo -e "TAO_ROOT ➡ ${TAO_ROOT}"
# XERCES
if [ ! -e ${DEPS_CACHE}/${TARGET_DEP}/xerces-c/3.1.2 ] ; then
    echo "Caching xerces-c 3.1.2..."
    mkdir -p ${DEPS_CACHE}/${TARGET_DEP}/xerces-c
    rsync --info=progress2 -az ${SDK_PATH}/tools/dependencies/${TARGET_DEP}/xerces-c/3.1.2 ${DEPS_CACHE}/${TARGET_DEP}/xerces-c/
fi
export XERCESCROOT=${DEPS_CACHE}/${TARGET_DEP}/xerces-c/3.1.2
echo -e "XERCESCROOT ➡ ${XERCESCROOT}"
export XERCES_ROOT=${XERCESCROOT}
echo -e "XERCES_ROOT ➡ ${XERCES_ROOT}"
# ZMQ
if [ ! -e ${DEPS_CACHE}/${TARGET_DEP}/zeromq/4.0.3 ] ; then
    echo "Caching zeromq 4.0.3..."
    mkdir -p ${DEPS_CACHE}/${TARGET_DEP}/zeromq
    rsync --info=progress2 -az ${SDK_PATH}/tools/dependencies/${TARGET_DEP}/zeromq/4.0.3 ${DEPS_CACHE}/${TARGET_DEP}/zeromq/
fi
export ZMQ_ROOT=${DEPS_CACHE}/${TARGET_DEP}/zeromq/4.0.3
echo -e "ZMQ_ROOT ➡ ${ZMQ_ROOT}"
# XSD
if [ ! -e ${DEPS_CACHE}/${GEN_TARGET_DEP}/xsd/4.0.0 ] ; then
    echo "Caching xsd 4.0.0..."
    mkdir -p ${DEPS_CACHE}/${GEN_TARGET_DEP}/xsd
    rsync --info=progress2 -az ${SDK_PATH}/tools/dependencies/${GEN_TARGET_DEP}/xsd/4.0.0 ${DEPS_CACHE}/${GEN_TARGET_DEP}/xsd
fi
export XSD_ROOT=${DEPS_CACHE}/${GEN_TARGET_DEP}/xsd/4.0.0
echo -e "XSD_ROOT ➡ ${XSD_ROOT}"
# PROTOBUF
if [ ! -e ${DEPS_CACHE}/${TARGET_DEP}/protobuf/3.0.0 ] ; then
    echo "Caching protobuf 3.0.0..."
    mkdir -p ${DEPS_CACHE}/${TARGET_DEP}/protobuf
    rsync --info=progress2 -az ${SDK_PATH}/tools/dependencies/${TARGET_DEP}/protobuf/3.0.0 ${DEPS_CACHE}/${TARGET_DEP}/protobuf
fi
export PROTOBUF_ROOT=${DEPS_CACHE}/${TARGET_DEP}/protobuf/3.0.0
echo -e "PROTOBUF_ROOT ➡ ${PROTOBUF_ROOT}"
# JUNIT
if [ ! -e ${DEPS_CACHE}/All/junit/4.8.2 ] ; then
    echo "Caching junit 4.8.2..."
    mkdir -p ${DEPS_CACHE}/All/junit
    rsync --info=progress2 -az ${SDK_PATH}/tools/dependencies/All/junit/4.8.2 ${DEPS_CACHE}/All/junit
fi
export JUNIT_ROOT=${DEPS_CACHE}/All/junit/4.8.2
echo -e "JUNIT_ROOT ➡ ${JUNIT_ROOT}"

# PYTHON
export PYTHON_ROOT=/usr/bin
echo -e "PYTHON_ROOT ➡ ${PYTHON_ROOT}"

export SIMTG_INSTALL_ROOT=/tools/simtg
echo -e "SIMTG_INSTALL_ROOT ➡ ${SIMTG_INSTALL_ROOT}"
export MODELS_INSTALL_ROOT=/models
echo -e "MODELS_INSTALL_ROOT ➡ ${MODELS_INSTALL_ROOT}"
export PROJECTS_INSTALL_ROOT=/projects
echo -e "PROJECTS_INSTALL_ROOT ➡ ${PROJECTS_INSTALL_ROOT}"
export HYBRID_INSTALL_ROOT=/hybrid
echo -e "HYBRID_INSTALL_ROOT ➡ ${HYBRID_INSTALL_ROOT}"

# Export PATH
export PATH=${TAO_ROOT}/bin:${ACE_ROOT}/bin:${ZMQ_ROOT}/bin:${PATH}

# Export LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${TAO_ROOT}/lib:${ACE_ROOT}/lib:${XERCESCROOT}/lib:${XSD_ROOT}/lib:${PROTOBUF_ROOT}/lib:${ZMQ_ROOT}/lib:${LD_LIBRARY_PATH}

# Set Workspace
if [ ${WORKSPACE} ]
then
    export SIMTG_LOCAL_ROOT=`cd ${WORKSPACE}; pwd`
else
    export SIMTG_LOCAL_ROOT=${HOME}/work
fi
echo -e "SIMTG_LOCAL_ROOT ➡ ${SIMTG_LOCAL_ROOT}"

export SIMANT_CACHE=~/tmp/SIMANT_CACHE
echo -e "SIMANT_CACHE ➡ ${SIMANT_CACHE}"
export SIM_MODULE=~/.sim_modules
echo -e "SIM_MODULE ➡ ${SIM_MODULE}"
export DEPS_CACHE
echo -e "DEPS_CACHE ➡ ${DEPS_CACHE}"
