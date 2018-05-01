TARGET_FLAGS := -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"
RELEASE_FLAGS := -c release --static-swift-stdlib

generate_html_swift:
	./gen.sh

build: generate_html_swift
	swift build $(TARGET_FLAGS)

build_release: generate_html_swift
	swift build $(RELEASE_FLAGS) $(TARGET_FLAGS)
	dir=`swift build --show-bin-path $(RELEASE_FLAGS) $(TARGET_FLAGS)` && \
	mdkir -p output
	echo cp $$dir/xcode-test-reporter output/xcode-test-reporter_darwin_x86_64

test: generate_html_swift
	swift test -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

clean: 
	rm -rf .build
	rm -rf Sources/Lib/Html/*swift

