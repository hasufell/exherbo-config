#!/bin/bash

if [[ ${CATEGORY}/${PN} == "sys-libs/glibc" ]] ; then
	einfo "Updating locales"
	for _mylang in $(locale -a) ; do
		if [[ ${_mylang} =~ "utf8" ]] ; then
			edo localedef -i ${_mylang%.*} -f UTF-8 ${_mylang%.*}.UTF-8
		fi
	done
fi

