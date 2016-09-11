#!/bin/bash
#
# Paludis hook script to apply patch (w/o modifying corresponding ebuild file).
#
# Copyright (c), 2010-2012 by Alex Turbov <i.zaufi@gmail.com>
#
# Version: @PH_VERSION@
#

source ${PALUDIS_EBUILD_DIR}/echo_functions.bash

declare -r CONFIG_FILE="/etc/paludis/hooks/configs/auto_patch.conf"
PATCH_DIR="/etc/paludis/autopatches"
# Configuration override
[[ -f ${CONFIG_FILE} ]] && source ${CONFIG_FILE}

_ap_rememberfile="${TEMP}/.autopatch_was_here_${PALUDIS_PID}"

issue_a_warning()
{
    local -r tobe="$1"
    ewarn "WARNING: ${CATEGORY}/${PNVR} package $tobe installed with additional patches applied by auto-patch hook."
    ewarn "WARNING: Before filing a bug, remove all patches, reinstall, and try again..."
}

try_to_apply_patches()
{
	local check

	for check in "${PATCH_DIR}/${HOOK}"/${CATEGORY}/{${PNVR},${PNV},${PN}}{,:${SLOT}}; do

		if [[ -d ${check} ]] ; then
			# activate nullglob if it isn't already
			local saved_opt=$(shopt nullglob &> /dev/null && echo "yes" || echo "no")
			[[ ${saved_opt} == no ]] && shopt -s nullglob

			if [[ -n ${CMAKE_SOURCE} ]] ; then
				cd "${CMAKE_SOURCE}" || die "Failed to cd into ${CMAKE_SOURCE}!"
			else
				cd "${WORK}" || die "Failed to cd into ${WORK}!"
			fi
			for i in "${check}"/*.patch ; do
				einfo "Applying ${i} ..."
				patch -p1 -f -i "${i}" || die "Failed to apply ${i}!"
				touch "${_ap_rememberfile}" || die "Failed to touch ${_ap_rememberfile}!"
			done

			# make sure nullglob is set to what it was before this function was called
			[[ ${saved_opt} == no ]] && shopt -u nullglob

			if [[ -e ${_ap_rememberfile} ]]; then
				issue_a_warning "will be"
			else
				einfo "No patches in for this package."
			fi
		fi

	done
}

case "${HOOK}" in
    # ATTENTION This script must be symlinked to the following hook dirs:
    ebuild_compile_post         | \
    ebuild_compile_pre          | \
    ebuild_configure_post       | \
    ebuild_configure_pre        | \
    ebuild_install_pre          | \
    ebuild_unpack_post          )
        try_to_apply_patches
        ;;
    install_all_post)
        if [[ -e ${_ap_rememberfile} ]] ; then
            issue_a_warning "was"
        fi
        ;;
esac

# kate: hl bash;
