#!/bin/bash

source "${PALUDIS_EBUILD_DIR}/echo_functions.bash"

_my_pbin_repo="hasufell-binhost"

if [[ ${CAVE_PERFORM_CMDLINE_destination} == ${_my_pbin_repo} ]] ; then
	_mypn=${TARGET%%:*}
	_mypn=${_mypn%-*}
	einfo "Updating ${_mypn} digest in ${_my_pbin_repo}"

	cave digest ${_mypn} ${_my_pbin_repo}
fi

