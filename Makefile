TARGET_FLAGS := -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"
RELEASE_FLAGS := -c release --static-swift-stdlib

generate_html_swift:
	./gen.sh

build: generate_html_swift
	swift build $(TARGET_FLAGS)

build_release: generate_html_swift
	swift build $(RELEASE_FLAGS) $(TARGET_FLAGS)
	mkdir -p build
	dir=`swift build --show-bin-path $(RELEASE_FLAGS) $(TARGET_FLAGS)` && \
	tar czvf build/xcode-test-reporter_darwin_x86_64.tar.gz $$dir/xcode-test-reporter

test: generate_html_swift
	swift test -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

clean: 
	rm -rf .build
	rm -rf Sources/Lib/Html/*swift

