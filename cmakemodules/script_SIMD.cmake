# SSE{2,3,4} extensions?
# ===================================================
include(CheckCXXCompilerFlag)
set(MRPT_AUTODETECT_SSE ON CACHE BOOL "Check /proc/cpuinfo to determine if SSE{2,3,4} optimizations are available")
mark_as_advanced(MRPT_AUTODETECT_SSE)

# Read info about CPUs:
set(DO_SSE_AUTODETECT 0)
if(MRPT_AUTODETECT_SSE AND EXISTS "/proc/cpuinfo" AND
	("${CMAKE_MRPT_ARCH}" STREQUAL "x86_64" OR
	"${CMAKE_MRPT_ARCH}" STREQUAL "i686") )
	set(DO_SSE_AUTODETECT 1)
endif()

# Macro for each SSE* var: Invoke with name in uppercase:
macro(DEFINE_SSE_VAR _flag  _setname)
	string(TOLOWER ${_setname} _set)

	if (DO_SSE_AUTODETECT)
		# Automatic detection:
        CHECK_CXX_COMPILER_FLAG(${_flag} CMAKE_MRPT_HAS_${_setname})
        IF(NOT CMAKE_MRPT_HAS_${_setname})
		    set(CMAKE_MRPT_HAS_${_setname} 0)
        ENDIF()
	ELSE (DO_SSE_AUTODETECT)
		# Manual:
		set("DISABLE_${_setname}" OFF CACHE BOOL "Forces compilation WITHOUT ${_setname} extensions")
		mark_as_advanced("DISABLE_${_setname}")
		set(CMAKE_MRPT_HAS_${_setname} 0)
		if (NOT DISABLE_${_setname})
			set(CMAKE_MRPT_HAS_${_setname} 1)
		endif (NOT DISABLE_${_setname})
	endif (DO_SSE_AUTODETECT)
endmacro(DEFINE_SSE_VAR)

# SSE optimizations:
DEFINE_SSE_VAR("-msse2" SSE2)
DEFINE_SSE_VAR("-msse3" SSE3)
DEFINE_SSE_VAR("-msse4.1" SSE4_1)
DEFINE_SSE_VAR("-msse4.2" SSE4_2)
DEFINE_SSE_VAR("-msse4a" SSE4_A)
