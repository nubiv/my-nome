project(
  'xxx', 
  'cpp',
  version: '0.0.1',
  default_options: ['cpp_std=c++17']
)

incdir = include_directories('./include')
srcdir = meson.current_source_dir() / 'src'
src = [
]

gsl_incdir = include_directories('./lib/gsl')
dotenv_incdir = include_directories('./lib/dotenv')
spdlog_dep = dependency('spdlog', required: true)

exe = executable(
  'xxx', 
  sources: src, 
  include_directories: [incdir, gsl_incdir, dotenv_incdir], 
  dependencies: [spdlog_dep],
#   build_rpath: libdir + ':' + libdir,
)

test('xxx', exe)