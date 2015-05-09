package main

/*
#cgo LDFLAGS: -L./lib -lhello
#include "./lib/hello.h"
*/
import "C"

func main() {
	C.hello(C.CString("John Smith"))
}
