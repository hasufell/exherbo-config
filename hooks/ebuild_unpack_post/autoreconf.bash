#!/bin/bash

if [[ ${_HOOK_AUTORECONF_UNPACK_POST} == 1 ]] ; then
	cd "${S}" || die
	if declare -f eautoreconf >/dev/null ; then
		eautoreconf
	else
		einfo "Running autoreconf -fi"
		autoreconf -fi
	fi
fi
