//go:build !static

package main

// NOTE: There should be NO space between the comments and the `import "C"` line.

/*
#cgo LDFLAGS: -L./lib -lhello
#include "./lib/hello.h"
#include <stdlib.h>
*/
import "C"
import "unsafe"

func main() {
	str1 := C.CString("world")
	str2 := C.CString("this is code from the dynamic library")
	defer C.free(unsafe.Pointer(str1))
	defer C.free(unsafe.Pointer(str2))

	C.hello(str1)
	C.whisper(str2)
}
