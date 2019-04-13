# =========================================================================
#  The Mobile Robot Programming Toolkit (MRPT) CMake configuration file
#
#             ** File generated automatically, do not modify **
#
#  Please, read:
#  https://docs.mrpt.org/reference/devel/mrpt_from_cmake.html

#   In your CMakeLists.txt, add these lines:
#
#    find_package(MRPT REQUIRED
#       COMPONENTS slam nav
#       OPTIONAL_COMPONENTS  vision)
#    target_link_libraries(MY_TARGET_NAME ${MRPT_LIBRARIES})
#
#   or do it individually:
#    find_package(mrpt-slam)
#    find_package(mrpt-nav)
#    target_link_libraries(MY_TARGET_NAME mrpt::slam mrpt::nav)
# =========================================================================
include(CMakeFindDependencyMacro)

# FIXME: These find_package calls are only required with hunter
find_package(Assimp CONFIG REQUIRED)
find_package(Eigen3 CONFIG REQUIRED)
find_package(JPEG CONFIG REQUIRED)
find_package(jsoncpp CONFIG REQUIRED)
find_package(octomap CONFIG REQUIRED)
find_package(OpenCV CONFIG REQUIRED)
find_package(ZLIB CONFIG REQUIRED)
find_package(CVD CONFIG REQUIRED)

set(MRPT_LIBRARIES "")
foreach(_comp ${MRPT_FIND_COMPONENTS})
  if (MRPT_FIND_REQUIRED_${_comp})
    find_dependency(mrpt-${_comp})
  else()
    find_package(mrpt-${_comp} CONFIG QUIET)
  endif()
  if (mrpt-${_comp}_FOUND)
    list(APPEND MRPT_LIBRARIES mrpt::${_comp})
  endif()
endforeach()

# backwards-compatibility var name:
set(MRPT_LIBS ${MRPT_LIBRARIES})
