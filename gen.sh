#!/usr/bin/env bash

for file in Sources/Lib/Html/*.html; do
    file_name=$(basename "$file")
    name=$(echo "$file_name" | cut -f 1 -d '.')
    swift_file="$file".swift
    echo "func html_$name(stateData: String) -> String {" > "$swift_file"
    echo '  return """' >> "$swift_file"
    cat "$file" | sed -e 's/__state_data__/\\(stateData)/' >> "$swift_file"
    echo '"""' >> "$swift_file"
    echo "}" >> "$swift_file"
    echo "" >> "$swift_file"
done
