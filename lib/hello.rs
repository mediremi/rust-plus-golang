// http://oppenlander.me/articles/rust-ffi explains how to create a Rust dynamic
//  library

#![crate_type = "dylib"]

#![feature(libc)]
extern crate libc;
use std::ffi::CStr;

#[no_mangle]
pub extern "C" fn hello(name: *const libc::c_char) {
    let buf_name = unsafe { CStr::from_ptr(name).to_bytes() };
    let str_name = String::from_utf8(buf_name.to_vec()).unwrap();
    println!("Hello {}!", str_name);
}
