#!/bin/bash

source "${PALUDIS_EBUILD_DIR}/echo_functions.bash"

ebegin "Update search index at ${CAVE_SEARCH_INDEX}"
cave manage-search-index --create "${CAVE_SEARCH_INDEX}"
eend $?
