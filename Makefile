TARGET_FLAGS := -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"
RELEASE_FLAGS := -c release --static-swift-stdlib

generate_html_swift:
	./gen.sh

build: generate_html_swift
	swift build $(TARGET_FLAGS)

build_release: generate_html_swift
	swift build $(RELEASE_FLAGS) $(TARGET_FLAGS)
	build_dir=$(PWD)/build && \
	mkdir -p $$build_dir && \
	dir=`swift build --show-bin-path $(RELEASE_FLAGS) $(TARGET_FLAGS)` && \
	cd $$dir && tar czvf xcode-test-reporter_darwin_x86_64.tar.gz xcode-test-reporter && \
	mv $$dir/xcode-test-reporter_darwin_x86_64.tar.gz $$build_dir && \
	cat $$dir/xcode-test-reporter | openssl dgst -sha256 > $$build_dir/xcode-test-reporter_darwin_x86_64.sha256 && \
	cat $$build_dir/xcode-test-reporter_darwin_x86_64.tar.gz | openssl dgst -sha256 > $$build_dir/xcode-test-reporter_darwin_x86_64.tar.gz.sha256

test: generate_html_swift
	swift test -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

brew_release:
	git clone https://github.com/taisukeh/homebrew-xcode-test-reporter.git
	cd homebrew-xcode-test-reporter 


clean: 
	rm -rf .build
	rm -rf Sources/Lib/Html/*swift

