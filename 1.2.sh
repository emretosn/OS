#!/bin/bash -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
b="$SCRIPT_DIR/burakarslan.com"
mkdir -p "$b/outbox" "$b/lecture"

url="https://burakarslan.com/inf333/"
html_file="$SCRIPT_DIR/page.html"

course_mail="ext-inf333.lab3@burakarslan.com"
mail="emre7osun@gmail.com"

curl -sL "$url" > "$html_file"

generate_hash() {
    echo -n "$1" | sha256sum | awk '{print $1}'
}

check_hash_existence() {
    local hash="$1"
    local directory="$2"
    local file
    for file in "$directory"/*; do
        [ -f "$file" ] || continue
        if [ "$(sha256sum "$file" | awk '{print $1}')" = "$hash" ]; then
            return 0
        fi
    done
    return 1
}

send_email() {
    local file_path="$1"
    local subject="$2"
    local -a email_addresses=("${@:3}")
    local body=$(cat "$file_path")

    local email_list=$(IFS=, ; echo "${email_addresses[*]}")

    echo "$body" | mutt -s "$subject" -- "$email_list"
}

process_outbox() {
    local i=1
    xmllint --html --xpath "//ul[@class='outbox']//li" "$html_file" | \
    while IFS= read -r line; do
        if [[ $line == "<li>"* ]]; then
            local content="$line"
            while IFS= read -r inner_line && [[ $inner_line != *"</li>"* ]]; do
                content+=$'\n'"$inner_line"
            done
            content+=$'\n'"$inner_line"
            local hash=$(generate_hash "$content")

            if ! check_hash_existence "$hash" "$b/outbox"; then
                local out_file="$b/outbox/$i"
                echo "$content" > "$out_file"
                date=$(echo "$content" | grep -oP '\(\d{4}-\d{2}-\d{2}\)' | sed 's/[()]//g')
                echo "[New Outbox Entry]: $date"
		        send_email "$out_file" "New Outbox Entry" $course_mail $mail
            fi
            ((i++))
        fi
    done            
}

process_lectures() {
    local i=1
    xmllint --html --xpath "//ul[@class='lectures']//a" "$html_file" 2>/dev/null | \
    sed 's/href=//g' | sed 's/"//g' | \
    while IFS= read -r href; do
        local hash=$(generate_hash "$href")

        if ! check_hash_existence "$hash" "$b/lecture"; then
            local lect_file="$b/lecture/$i"
            echo "$href" > "$lect_file"
            echo "[New Lecture]     : $href"
	        send_email "$lect_file" "New Lecture" $course_mail $mail
        fi
        ((i++))
    done
}

process_outbox
process_lectures

rm "$html_file"

