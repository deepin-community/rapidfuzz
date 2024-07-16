macro(_CHECK_CPU_ARCH ARCH ARCH_DEFINES VARIABLE)
  if(NOT DEFINED HAVE_${VARIABLE})
    message(STATUS "Check CPU architecture is ${ARCH}")
    set(CHECK_CPU_ARCH_DEFINES ${ARCH_DEFINES})
    configure_file(
      ${PROJECT_SOURCE_DIR}/cmake/CheckCPUArch.c.in
      ${PROJECT_BINARY_DIR}/CMakeFiles/CMakeTmp/CheckCPUArch.c @ONLY)
    try_compile(HAVE_${VARIABLE} "${PROJECT_BINARY_DIR}"
                "${PROJECT_BINARY_DIR}/CMakeFiles/CMakeTmp/CheckCPUArch.c")
    if(HAVE_${VARIABLE})
      message(STATUS "Check CPU architecture is ${ARCH} - yes")
      set(${VARIABLE}
          1
          CACHE INTERNAL "Result of CHECK_CPU_ARCH" FORCE)
    else()
      message(STATUS "Check CPU architecture is ${ARCH} - no")
    endif()
  endif()
endmacro(_CHECK_CPU_ARCH)

macro(CHECK_CPU_ARCH_X64 VARIABLE)
  _check_cpu_arch(
    x64
    "defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || defined(_M_X64) || defined(_M_AMD64)"
    ${VARIABLE})
endmacro(CHECK_CPU_ARCH_X64)

macro(CHECK_CPU_ARCH_X86 VARIABLE)
  _check_cpu_arch(
    x86
    "defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__) ||defined( __i386) || defined(_M_IX86)"
    ${VARIABLE})
endmacro(CHECK_CPU_ARCH_X86)

macro(CHECK_CPU_ARCH_PPC64 VARIABLE)
  _check_cpu_arch(
    ppc64
    "defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__) ||defined(_ARCH_PPC64)"
    ${VARIABLE})
endmacro(CHECK_CPU_ARCH_PPC64)

macro(CHECK_CPU_ARCH_ARM64 VARIABLE)
  _check_cpu_arch(arm64 "defined(__aarch64__) || defined(__arm64__)"
                  ${VARIABLE})
endmacro(CHECK_CPU_ARCH_ARM64)
