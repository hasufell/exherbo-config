#!/bin/bash

if [[ "${CATEGORY}/${PN}" == "dev-db/mysql" ]] ; then
	edo sed -i 's/OPENSSL_MAJOR_VERSION STREQUAL "1"/OPENSSL_MAJOR_VERSION STREQUAL "2"/' \
			"${CMAKE_SOURCE}/cmake/ssl.cmake"
fi

