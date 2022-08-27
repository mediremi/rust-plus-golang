package main

// NOTE: There should be NO space between the comments and the `import "C"` line.
// The -ldl is sometimes necessary to fix linker errors about `dlsym`.

/*
#cgo LDFLAGS: ./lib/libhello.a -ldl
#include "./lib/hello.h"
*/
import "C"

func main() {
	C.hello(C.CString("world"))
	C.whisper(C.CString("this is code from the static library"))
}
