#!/bin/sh

# PROVIDE: dingo
# REQUIRE: LOGIN
# BEFORE:  securelevel
# KEYWORD: shutdown

# Add the following lines to /etc/rc.conf to enable `dingo':
#
# dingo_enable="YES"
# dingo_flags="<set as needed>"
#
# See rsync(1) for rsyncd_flags
#

. /etc/rc.subr

name="dingo"
rcvar=dingo_enable
load_rc_config "$name"
command="/usr/local/bin/dingo"
pidfile="/var/run/$name.pid"
dingo_user="dingo"
start_cmd=dingo_start
stop_postcmd=dingo_stop

: ${dingo_enable="NO"}
: ${dingo_flags=""}

dingo_start() {
  echo "Starting dingo..."
  touch ${pidfile} && chown ${dingo_user} ${pidfile}
  /usr/sbin/daemon -cS -T dingo -p ${pidfile} -u ${dingo_user} ${command} ${dingo_flags}
}

dingo_stop() {
  [ -f ${pidfile} ] && rm ${pidfile}
}

run_rc_command "$1"
