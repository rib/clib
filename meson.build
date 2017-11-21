project('clib', 'c',
        default_options : ['c_std=c11', 'cpp_std=c++14'],
        license: ['MIT'])

deps = []

deps += dependency('threads')

compiler = meson.get_compiler('c')
deps += compiler.find_library('m', required : false)

public_includes = include_directories('clib')
inc = include_directories('.', 'clib', 'clib/sfmt') 

c_defines = [
    '-DSFMT_MEXP=19937',
    '-D_C_COMPILATION',
]

warn_opts = [
    '-Wall',
    '-Wextra',
    '-Wno-unused-parameter',
]

sys_libs = []

src = [
    'clib-config.h',
    'clib/ascii_snprintf.c',
    'clib/carray.c',
    'clib/cbytearray.c',
    'clib/cdebugkey.c',
    'clib/cerror.c',
    'clib/ceuler.c',
    'clib/ceuler.h',
    'clib/cfile.c',
    'clib/chashtable.c',
    'clib/ciconv.c',
    'clib/clib-platform.h',
    'clib/clib.h',
    'clib/clist.c',
    'clib/cllist.c',
    'clib/cmatrix.c',
    'clib/cmatrix.h',
    'clib/cmem.c',
    'clib/coutput.c',
    'clib/cpath.c',
    'clib/cptrarray.c',
    'clib/cqsort.c',
    'clib/cquark.c',
    'clib/cquaternion-private.h',
    'clib/cquaternion.c',
    'clib/cquaternion.h',
    'clib/cqueue.c',
    'clib/crand.c',
    'clib/crbtree.c',
    'clib/crbtree.h',
    'clib/cshell.c',
    'clib/cslist.c',
    'clib/cspawn.c',
    'clib/cstr.c',
    'clib/cstring.c',
    'clib/ctimer.c',
    'clib/cunicode.c',
    'clib/cutf8.c',
    'clib/cvector.c',
    'clib/cvector.h',
    'clib/sort.frag.h',
    'clib/unicode-data.h',
    'clib/sfmt/SFMT.h',
    'clib/sfmt/SFMT.c',
    'clib/sfmt/SFMT-common.h',
    'clib/sfmt/SFMT-params607.h',
    'clib/sfmt/SFMT-params1279.h',
    'clib/sfmt/SFMT-params2281.h',
    'clib/sfmt/SFMT-params4253.h',
    'clib/sfmt/SFMT-params11213.h',
    'clib/sfmt/SFMT-params19937.h',
    'clib/sfmt/SFMT-params44497.h',
    'clib/sfmt/SFMT-params86243.h',
    'clib/sfmt/SFMT-params216091.h',
    'clib/sfmt/SFMT-params.h',
]

libuv_dep = dependency('libuv', required: get_option('support_libuv'))
if libuv_dep.found()
src += [
    'clib/cmodule.c',
    'clib/cmodule.h',
]
c_defines += '-DUSE_UV=1'
deps += dependency('libuv')
endif

if compiler.get_define('__unix__') != ''
src += [
    'clib/cdir-unix.c',
    'clib/cdate-unix.c',
    'clib/cxdg-unix.c',
    'clib/ctls.c',
]
endif

if compiler.get_define('ANDROID') != ''
src += [
    'clib/vasprintf.c',
]
endif

if host_machine.system() == 'linux'
src += [
    'clib/cmisc-unix.c',
    'clib/ctls.c',
    'clib/cbacktrace-linux.c',
]
elif host_machine.system() == 'windows'
src += [
    'clib/cdate-win32.c',
    'clib/cdir-win32.c',
    'clib/cmisc-win32.c',
    'clib/ctls-win32.cc',
    'clib/mkstemp.c',
    'clib/vasprintf.c',
    'clib/fmemopen.c',
]
sys_libs += [
    '-ladvapi32',
    '-liphlpapi',
    '-lpsapi',
    '-lshell32',
    '-lws2_32'
]
elif host_machine.system() == 'darwin'
src += [
    'clib/cmisc-unix.c',
    'clib/ctls.c',
    'clib/fmemopen.c',
]
elif compiler.get_define('EMSCRIPTEN') != ''
src += [
    'clib/clib-web.h',
    'clib/cmisc-emscripten.c',
]
endif

if host_machine.system() != 'linux'
src += [
    'clib/cbacktrace.c',
]
endif

clib_lib = library(
        'clib', src,
        version: '1',
        include_directories: inc,
        c_args: c_defines + warn_opts,
        link_args: sys_libs,
        dependencies: deps)
clib_dep = declare_dependency(link_with: clib_lib, include_directories: public_includes)
