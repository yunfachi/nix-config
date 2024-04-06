# Function Author : Teddy Skarin
function ProgressBar {
	let _progress=(${1}*100/${2}*100)/100
	let _done=(${_progress}*4)/10
	let _left=40-$_done
	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")
	printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"
}

WALLPAPERS_FILE="./data/wallpapers.nix"
wallpapers=$(<"$WALLPAPERS_FILE")
total_lines=$(wc -l < $WALLPAPERS_FILE)
current_line=0

while IFS= read -r line; do
    ((++current_line))
    if [[ $line =~ url.*=.*\"(.*)\" ]]; then
        url="${BASH_REMATCH[1]}"
        new_hash=$(nix-prefetch fetchurl --silent \
            --url "$url" --downloadToTemp --recursiveHash \
            --postFetch \
            "mkdir -p \$out;
            filename=$(basename "$url");
            mv file \$out/\$(printf \`printf \"${url}\" | sha512sum\`).\${filename##*.};
            ")
    fi
    if [[ $line =~ hash.*=.*\"(.*)\" ]]; then
        escaped_new_hash=$(printf '%s\n' "$new_hash" | sed -e 's/[\/&]/\\&/g')
        line=$(echo "$line" | sed "s/\"[^\"]*/\"$escaped_new_hash/")
    fi
    updated_wallpapers="$updated_wallpapers$line"$'\n'
    ProgressBar ${current_line} ${total_lines}
done <<< "$wallpapers"

printf "$updated_wallpapers" > "$WALLPAPERS_FILE"
printf "\nUpdated the hashes in the $WALLPAPERS_FILE."
