ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# PHONY means that it doesn't correspond to a file; it always runs the build commands.

.PHONY: build-all
build-all: build-shared build-static

.PHONY: run-all
run-all: run-shared run-static

.PHONY: build-shared
build-shared:
	cd lib/hello && cargo build --release
	cp lib/hello/target/release/libhello.so lib/
	go build -ldflags="-r $(ROOT_DIR)lib" main_shared.go

.PHONY: build-static
build-static:
	cd lib/hello && cargo build --release
	cp lib/hello/target/release/libhello.a lib/
	go build main_static.go

.PHONY: run-shared
run-shared:
	RUST_LOG=trace ./main_shared

.PHONY: run-static
run-static:
	RUST_LOG=trace ./main_static

# This is just for running the Rust lib tests natively via cargo.
.PHONY: test-rust-lib
test-rust-lib:
	cd lib/hello && RUST_LOG=trace cargo test -- --nocapture

.PHONY: clean
clean:
	rm -rf main_shared main_static lib/libhello.so lib/libhello.a lib/hello/target
