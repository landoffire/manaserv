# Find Sqlite 3 libraries
# SQLITE3_INCLUDE_DIR - Where to find Sqlite 3 header files (directory)
# SQLITE3_LIBRARIES - Sqlite 3 libraries
# SQLITE3_LIBRARY_RELEASE - Where the release library is
# SQLITE3_LIBRARY_DEBUG - Where the debug library is
# SQLITE3_FOUND - Set to TRUE if we found everything (library, includes and executable)

IF( SQLITE3_INCLUDE_DIR AND SQLITE3_LIBRARY_RELEASE AND SQLITE3_LIBRARY_DEBUG )
    SET(Sqlite3_FIND_QUIETLY TRUE)
ENDIF()

FIND_PATH( SQLITE3_INCLUDE_DIR sqlite3.h  )

FIND_LIBRARY(SQLITE3_LIBRARY_RELEASE NAMES sqlite3 )

FIND_LIBRARY(SQLITE3_LIBRARY_DEBUG NAMES sqlite3 sqlite3d  HINTS /usr/lib/debug/usr/lib/ )

IF( SQLITE3_LIBRARY_RELEASE OR SQLITE3_LIBRARY_DEBUG AND SQLITE3_INCLUDE_DIR )
    SET( SQLITE3_FOUND TRUE )
ENDIF( SQLITE3_LIBRARY_RELEASE OR SQLITE3_LIBRARY_DEBUG AND SQLITE3_INCLUDE_DIR )

IF( SQLITE3_LIBRARY_DEBUG AND SQLITE3_LIBRARY_RELEASE )
    # if the generator supports configuration types then set
    # optimized and debug libraries, or if the CMAKE_BUILD_TYPE has a value
    IF( CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE )
        SET( SQLITE3_LIBRARIES optimized ${SQLITE3_LIBRARY_RELEASE} debug ${SQLITE3_LIBRARY_DEBUG} )
    ELSE()
        # if there are no configuration types and CMAKE_BUILD_TYPE has no value
        # then just use the release libraries
        SET( SQLITE3_LIBRARIES ${SQLITE3_LIBRARY_RELEASE} )
    ENDIF()
ELSEIF()
    SET( SQLITE3_LIBRARIES ${SQLITE3_LIBRARY_RELEASE} )
ELSE()
    SET( SQLITE3_LIBRARIES ${SQLITE3_LIBRARY_DEBUG} )
ENDIF()

IF( SQLITE3_FOUND )
    IF( NOT Sqlite3_FIND_QUIETLY )
        MESSAGE( STATUS "Found Sqlite3 header file in ${SQLITE3_INCLUDE_DIR}")
        MESSAGE( STATUS "Found Sqlite3 libraries: ${SQLITE3_LIBRARIES}")
    ENDIF()
ELSE()
    IF( Sqlite3_FIND_REQUIRED)
        MESSAGE( FATAL_ERROR "Could not find Sqlite3" )
    ELSE()
        MESSAGE( STATUS "Optional package Sqlite3 was not found" )
    ENDIF()
ENDIF(SQLITE3_FOUND)
