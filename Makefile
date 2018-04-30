generate_html_swift:
	./gen.sh

build: generate_html_swift
	swift build

test: generate_html_swift
	swift test
