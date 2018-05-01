generate_html_swift:
	./gen.sh

build: generate_html_swift
	swift build -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

test: generate_html_swift
	swift test
