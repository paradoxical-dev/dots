#!/bin/sh

# INFO: filter for fzf file content previews

mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}
if [ -d "$1" ]; then
	eza --git -hl --color=always --icons "$1"
elif [ "$category" = image ]; then
	# chafa "$1"
	exiftool "$1"
  # kitten icat "$1"
elif [ "$kind" = vnd.openxmlformats-officedocument.spreadsheetml.sheet ] || \
	[ "$kind" = vnd.ms-excel ]; then
	in2csv "$1" | xsv table | bat -ltsv --color=always
elif [ "$category" = text ]; then
	bat --color=always "$1"
else
	lesspipe.sh "$1" | bat --color=always
fi
