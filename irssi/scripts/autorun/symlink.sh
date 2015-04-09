#!/bin/bash

# list of scripts that should autostart
declare -r list=(nickcolor.pl nicklist.pl trackbar.pl usercount.pl)

for entry in ${list}
do
	[[ -f "../${entry}" ]] && ln -v -s "../${entry}" "${entry}"
done
