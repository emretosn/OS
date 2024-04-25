When I ran "cmake .." I got these in the terminal:

-- The C compiler identification is AppleClang 15.0.0.15000309
-- The CXX compiler identification is AppleClang 15.0.0.15000309
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (2.7s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/emre/Documents/GSU/INF333 Operating Systems/lab9/build

And these files and folders got created in the build directory:
dCMakeCache.txt		CMakeFiles		Makefile		cmake.md		cmake\_install.cmake

CMake is a Makefile generator. When we use the "cmake .." command, it generates a Makefile in the current directory following the
instructions in the CMakeLists.txt file in the parent directory. Using an empty "build" directory is called "out-of-source build",
which prevents the object and executable files from mixing with the source files.

After the creation of the Makefile we can use the "make" command to generate the "main" executable and run it with "./main".
This will display our message "Hello from CMake\n".
