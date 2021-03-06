#!/bin/bash

# Copyright (c) 2013 Yubico AB
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#   * Redistributions in binary form must reproduce the above
#     copyright notice, this list of conditions and the following
#     disclaimer in the documentation and/or other materials provided
#     with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

HYPERVISOR="vmw6"
DIST="ubuntu"
SUITE="trusty"
DEST="output"

#Allow overriding dest
if [ "x$1" == "x-d" ] || [ "x$1" == "x--dest" ]; then
	shift
	DEST=$1
	shift
fi

VMBUILDER_ARGS="--suite $SUITE --arch i386 --flavour virtual --mem 512 \
	--tmpfs 2048 --hostname yubix --user yubikey --pass yubico --copy \
	$DIR/copy --exec $DIR/exec.sh --firstboot $DIR/firstboot.sh --dest \
	$DEST --templates $DIR/templates --verbose --ppa yubico/yubix --ppa \
	yubico/stable --addpkg linux-image-extra-virtual --addpkg \
	unattended-upgrades --addpkg acpid --addpkg yubix --addpkg pwgen \
	--addpkg ssh --addpkg bash-completion"

vmbuilder $HYPERVISOR $DIST $VMBUILDER_ARGS "$@"

echo "Completed successfully, result is in: $DEST"
