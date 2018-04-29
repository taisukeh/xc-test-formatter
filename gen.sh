#!/usr/bin/env bash

for file in Sources/Lib/Html/*.{html,svg}; do
    file_name=$(basename "$file")
    extension="${file_name##*.}"
    name=$(echo "$file_name" | cut -f 1 -d '.')
    swift_file="$file".swift

    if [ $extension = "html" ]; then
        echo "func ${extension}_${name}(stateData: String) -> String {" > "$swift_file"
        echo '  return """' >> "$swift_file"
        cat "$file" | sed -e 's/__state_data__/\\(stateData)/' >> "$swift_file"
        echo '"""' >> "$swift_file"
        echo "}" >> "$swift_file"
        echo "" >> "$swift_file"
    else
        echo "let ${extension}_${name} = " > "$swift_file"
        echo '"""' >> "$swift_file"
        cat "$file" >> "$swift_file"
        echo '"""' >> "$swift_file"
        echo "" >> "$swift_file"
    fi
done
