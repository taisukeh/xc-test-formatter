generate_html_swift:
	./gen.sh

test: generate_html_swift
	swift test
