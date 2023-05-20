# Rust + Go(lang)

> TL;DR: Call Rust code from Go using FFI

---

This repository shows how, by combining [`cgo`](https://blog.golang.org/c-go-cgo)
and [Rust's FFI capabilities](https://doc.rust-lang.org/book/ffi.html), we can call
Rust code from Go.

Two ways of achieving this are presented in this repository: with a dynamic
library, and with a static library.

## Running the example code

Run `make run-all` to see `Rust + Go` in action, building and running two
binaries, one where the Rust code is compiled as a dynamic (sometimes also
referred to as a 'shared') library, and one where it is compiled as a static
library.

You should see the following output:

```console
$ make run-all
   Compiling libc v0.2.132
   Compiling hello v0.1.0 (/home/user/rust-plus-golang/lib/hello)
    Finished release [optimized] target(s) in 0.1s
Hello world!
(this is code from the dynamic library)
    Finished release [optimized] target(s) in 0.00s
Hello world!
(this is code from the static library)
```

You will also find the binaries `./main_dynamic` and `./main_static` in your
current working directory.

## How it works

The Rust code is packaged up into a dynamic library and a static library, and
the two Go binaries then call these using [`cgo`](https://blog.golang.org/c-go-cgo).

## You can do this for your own project

> [Andrew Oppenlander's article on creating a Rust dynamic
> library](https://github.com/oppenlander/oppenlanderme/blob/master/public/articles/rust-ffi.md)
> is a great introduction to this topic.

1. Begin by creating a `lib` directory, where you will keep your Rust libraries.
2. Then, create a C header file for your library. [See the example `hello.h`](lib/hello.h).
3. All that is left to do is to add some `cgo`-specific comments to your Go
   code. These comments tell `cgo` where to find the library and its headers.

### Dynamic library setup

The following `cgo` comments are required to use a dynamic library:

```go
/*
#cgo LDFLAGS: -L./lib -lhello
#include "./lib/hello.h"
*/
import "C"
```

You must also pass the `-ldflags` option to `go build` (see [the `build-dynamic` target in
the `Makefile`](https://github.com/mediremi/rust-plus-golang/blob/97e8444573698bdf2c82316074b112f7d6209e13/Makefile#L12-L15)).

See [`main_dynamic.go`](main_dynamic.go)

### Static library setup

For a static library, an additional `-ldl` `LDFLAGS` flag is sometimes
necessary. This flag will link the `dl` library.

```go
/*
#cgo LDFLAGS: ./lib/libhello.a -ldl
#include "./lib/hello.h"
*/
import "C"
```

> There should not be a newline between `*/` and `import "C"`.

See [the `build-static` target in the `Makefile`](https://github.com/mediremi/rust-plus-golang/blob/97e8444573698bdf2c82316074b112f7d6209e13/Makefile#L18-L21) and [`main_dynamic.go`](main_dynamic.go).

## See also

* [rustgo: Calling Rust from Go with near-zero overhead](https://words.filippo.io/rustgo/)
* [Hooking Go from Rust](https://metalbear.co/blog/hooking-go-from-rust-hitchhikers-guide-to-the-go-laxy/)
