ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

build:
	rustc $(wildcard lib/*.rs) --out-dir lib
	go build -ldflags="-r $(ROOT_DIR)lib" main.go
