package main

// NOTE: There should be NO space between the comments and the `import "C"` line.
// The -ldl is necessary to fix the linker errors about `dlsym` that would otherwise appear.

/*
#cgo LDFLAGS: ./lib/libhello.a -ldl
#include "./lib/hello.h"
*/
import "C"

func main() {
    C.init_stuff()
	C.hello(C.CString("John Smith"))
}
