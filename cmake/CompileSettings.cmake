cmake_minimum_required(VERSION 3.20)

# -----------------------------------------------------------------------------
# compiler settings interfaces (Misc)
# -----------------------------------------------------------------------------
# default option settings
add_library(_cmp_option_settings INTERFACE)
add_library(Compile::OptionSettings ALIAS _cmp_option_settings)

target_compile_options(_cmp_option_settings
                       INTERFACE $<$<CXX_COMPILER_ID:MSVC>:/bigobj>)

# default feature settings
add_library(_cmp_feature_settings INTERFACE)
add_library(Compile::FeatureSettings ALIAS _cmp_feature_settings)

target_compile_features(_cmp_feature_settings INTERFACE cxx_std_17)

# default definition settings
add_library(_cmp_definition_settings INTERFACE)
add_library(Compile::DefinitionSettings ALIAS _cmp_definition_settings)

target_compile_definitions(_cmp_definition_settings 
  INTERFACE 
    $<$<CXX_COMPILER_ID:MSVC>:_SCL_SECURE_NO_WARNINGS>
)

# -----------------------------------------------------------------------------
# compiler settings interfaces (Group)
# -----------------------------------------------------------------------------
# advanced error settings
add_library(_cmp_error_settings INTERFACE)
add_library(Compile::ErrorSettings ALIAS _cmp_error_settings)

# cmake-format off
target_compile_options(
  _cmp_error_settings
  INTERFACE 
    $<$<CXX_COMPILER_ID:AppleClang>:-Wall -Wextra -Wfatal-errors>
    $<$<AND:$<COMPILE_LANGUAGE:CXX>,$<CXX_COMPILER_ID:Clang>>:-Wall -Wextra -Wfatal-errors>
    $<$<AND:$<COMPILE_LANGUAGE:CXX>,$<CXX_COMPILER_ID:GNU>>:-Wall -Wextra -Wfatal-errors>
    $<$<AND:$<COMPILE_LANGUAGE:CXX>,$<CXX_COMPILER_ID:MSVC>>:/W3 /permissive->)
# cmake-format on

# advanced optimization settins
#
# ! Msvc flags info
#
# /Zi - Produces a program database (PDB) that contains type information and
# symbolic debugging information for use with the debugger.
# /FS - Allows multiple cl.exe processes to write to the same .pdb file
#
# /DEBUG - Enable debug during linking
#
# /Od - Disables optimization
#
# /Ox - Full optimization
#
# /Oy- do not suppress frame pointers (recommended for debugging)
#

add_library(_cmp_optimize_settings INTERFACE)
add_library(Compile::OptimizeSettings ALIAS _cmp_optimize_settings)

# cmake-format off
target_compile_options(
  _cmp_optimize_settings
  INTERFACE 
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:Clang>>:-O2 -march=native>
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:AppleClang>>:-O2 -march=native>
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU>>:-O2 -march=native>
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:/O2 -DNDEBUG /MP>
    $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:GNU>>:-O0 -g>
    $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:Clang>>:-O0 -g>
    $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:AppleClang>>:-O0 -g>
    $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:MSVC>>:/Zi /FS /DEBUG /Od /MP /MDd /Oy->)

target_compile_definitions(_cmp_optimize_settings
  INTERFACE
    $<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:NDEBUG>
    $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:MSVC>>:DEBUG>)
# cmake-format on

# cmake-format off
# common settings
add_library(_cmp_common_settings INTERFACE)
add_library(Compile::CommonSettings ALIAS _cmp_common_settings)
target_link_libraries(
  _cmp_common_settings
  INTERFACE 
    Compile::OptionSettings
    Compile::FeatureSettings
    Compile::DefinitionSettings
    Compile::ErrorSettings
    Compile::OptimizeSettings)
# cmake-format on
