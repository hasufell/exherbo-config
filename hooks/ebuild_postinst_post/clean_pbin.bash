#!/usr/bin/env bash

# set this only
reponame="hasufell-binhost"


if [[ ${CAVE_PERFORM_CMDLINE_destination} == ${reponame} ]] ; then
	shopt -s nullglob

	repo="$(${CAVE} print-repository-metadata --format '%v' --raw-name location ${reponame})"
	bins="$(${CAVE} print-repository-metadata --format '%v' --raw-name distdir ${reponame})"

	good_files=(
	    $(for pkg in "${repo}/packages/${CATEGORY}/${PN}/"*".pbin-1+exheres-0" ; do . "${pkg}" ; basename "${BINARY_URI}" ; done)
	)

	for file in "${bins}"/${reponame}--${CATEGORY}--${PN}-*.tar.bz2 ; do
	    file=${file##*/}
	    if ! echo "${good_files[@]}" | grep -q "${file}" ; then
		rm -vf "${bins}/${file}"
	    fi
	done
fi

