ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# PHONY means that it doesn't correspond to a file; it always runs the build commands.

.PHONY: build-all
build-all: build-dynamic build-static

.PHONY: run-all
run-all: run-dynamic run-static

.PHONY: build-dynamic
build-dynamic:
	@cd lib/hello && cargo build --release
	@cp lib/hello/target/release/libhello.so lib/
	go build -ldflags="-r $(ROOT_DIR)lib" main_dynamic.go

.PHONY: build-static
build-static:
	@cd lib/hello && cargo build --release
	@cp lib/hello/target/release/libhello.a lib/
	go build main_static.go

.PHONY: run-dynamic
run-dynamic: build-dynamic
	@./main_dynamic

.PHONY: run-static
run-static: build-static
	@./main_static

# This is just for running the Rust lib tests natively via cargo
.PHONY: test-rust-lib
test-rust-lib:
	@cd lib/hello && cargo test -- --nocapture

.PHONY: clean
clean:
	rm -rf main_dynamic main_static lib/libhello.so lib/libhello.a lib/hello/target
