# Rust + Golang
---

This repository shows how, by combining [`cgo`](https://blog.golang.org/c-go-cgo)
and [Rust's FFI capabilities](https://doc.rust-lang.org/book/ffi.html), we can call
Rust code from Golang.

Run `make build-all` and then `make run-all` to see `Rust` + `Golang` in action,
building and running two binaries, one where the Rust lib is compiled to a shared
lib, and one to a static lib. You should see some log output printed to stderr and
then `Hello John Smith!` printed to `stdout`.  This results in the binaries
`main_shared` and `main_static` which you can run.  See [Makefile](Makefile) in
this repository for more useful make targets.

## You can do this for your own project
Begin by creating a `lib` directory, where you will keep your Rust libraries.
[Andrew Oppenlander's article on creating a Rust dynamic library is a great introduction](http://oppenlander.me/articles/rust-ffi).

Then, you need to create a C header file for your library. Just copy the `libc`
types that you used.

All that is left to do is to add some `cgo`-specific comments to your Golang
code. These comments tell `cgo` where to find the library and its headers.

For importing a shared lib into your go code, the following must go along with an
additional option given to `go build` (see Makefile):
```go
/*
#cgo LDFLAGS: -L./lib -lhello
#include "./lib/hello.h"
*/
import "C"
```

For a static lib, the additional `-ldl` is necessary compared to the shared
lib, presumably because in the shared lib linking, `dl` is linked in some other way
by the magic of shared libs.  To import a static lib into your go code:
```
/*
#cgo LDFLAGS: ./lib/libhello.a -ldl
#include "./lib/hello.h"
*/
import "C"
```

> There should not be a newline between `*/` and `import "C"`.
