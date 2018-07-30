#!/bin/sh

set -e

# Shanmin Zhang (zhangshanmin@mail.tsinghua.edu.cn)
# 20180713

UBUNTU_LOWER_PATH=/data/ubuntu-lower
UBUNTU_UPPER_PATH=/data/ubuntu-upper
UBUNTU_WORK_PATH=/data/ubuntu-work
UBUNTU_PATH=/data/ubuntu

alias mount='busybox mount'
alias umount='busybox umount'

DISPLAY=:0

test -e $UBUNTU_LOWER_PATH || mkdir -p $UBUNTU_LOWER_PATH
test -e $UBUNTU_UPPER_PATH || mkdir -p $UBUNTU_UPPER_PATH
test -e $UBUNTU_WORK_PATH || mkdir -p $UBUNTU_WORK_PATH
test -e $UBUNTU_PATH || mkdir -p $UBUNTU_PATH

test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_LOWER_PATH`"   || mount -t squashfs ubuntu.img   $UBUNTU_LOWER_PATH
test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH`"         || \
mount -t overlay overlay -o lowerdir=$UBUNTU_LOWER_PATH,upperdir=$UBUNTU_UPPER_PATH,workdir=$UBUNTU_WORK_PATH $UBUNTU_PATH
test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/proc`"    || mount --bind /proc             $UBUNTU_PATH/proc
test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/sys`"     || mount --bind /sys              $UBUNTU_PATH/sys
test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/dev`"     || mount --bind /dev              $UBUNTU_PATH/dev
test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/dev/pts`" || mount --bind /dev/pts          $UBUNTU_PATH/dev/pts
test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/tmp`"     || mount -t tmpfs none            $UBUNTU_PATH/tmp

chroot $UBUNTU_PATH /usr/bin/env -i \
LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/jli \
DISPLAY=$DISPLAY \
PATH=/root/Android/Sdk/platform-tools:/usr/sbin:/usr/bin:/sbin:/bin /bin/bash \

#test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/tmp`"     || umount -lf $UBUNTU_PATH/tmp
#test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/dev/pts`" || umount -lf $UBUNTU_PATH/dev/pts
#test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/dev`"     || umount -lf $UBUNTU_PATH/dev
#test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/sys`"     || umount -lf $UBUNTU_PATH/sys
#test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/proc`"    || umount -lf $UBUNTU_PATH/proc
#test -n "`mount | awk '{print \$3}' | grep -x $UBUNTU_PATH/root`"    || umount -lf $UBUNTU_PATH/root

