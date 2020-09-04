# Copyright (c) 2019-2020 Status Research & Development GmbH
# Licensed under either of
#  * Apache License, version 2.0,
#  * MIT license
# at your option.
# This file may not be copied, modified, or distributed except according to
# those terms.

# In theory, this simple file could be generated by c2nim. In practice, c2nim
# can't handle "__attribute__((...))".

when not declared(cuintptr_t):
  # There is a disparity on macOS where Nim's `uint` is `unsigned long long` and
  # `uintptr_t` is `unsigned long`. Even though both data types are the same
  # size (64 bits), clang++ refuses to do automatic conversion between them.
  type cuintptr_t* {.importc: "uintptr_t", nodecl.} = uint

# The returned cstring needs to be freed by the caller.
proc get_backtrace_max_length_c*(max_length, skip: cint): cstring {.
    importc: "get_backtrace_max_length_c", header: "libbacktrace_wrapper.h".}

# The returned cstring needs to be freed by the caller.
proc get_backtrace_c*(): cstring {.
    importc: "get_backtrace_c", header: "libbacktrace_wrapper.h".}

# The returned array needs to be freed by the caller.
# It holds at least a zero sentinel value at the end.
proc get_program_counters_c*(max_length, skip: cint): ptr cuintptr_t {.
    importc: "get_program_counters_c", header: "libbacktrace_wrapper.h".}

type
  DebuggingInfo* {.importc: "struct debugging_info", header: "libbacktrace_wrapper.h", bycopy.} = object
    filename* {.importc: "filename".}: cstring
    lineno* {.importc: "lineno".}: cint
    function* {.importc: "function".}: cstring

# The returned array needs to be freed by the caller.
# Char pointers in the returned struct need to be freed by the caller.
proc get_debugging_info_c*(program_counters: ptr cuintptr_t, max_length: cint): ptr DebuggingInfo {.
    importc: "get_debugging_info_c", header: "libbacktrace_wrapper.h".}

