#!/bin/bash

if [[ ${_HOOK_AUTORECONF_CONFIGURE_PRE} == 1 ]] ; then
	if declare -f eautoreconf >/dev/null ; then
		eautoreconf
	else
		einfo "Running autoreconf -fi"
		autoreconf -fi
	fi
fi
