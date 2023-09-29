# CMAKE Basics

## CMAKE

### Generating a project buildsystem
This is the first step required to build our project. Here are a few options in terms of how the CMake build action can be executed:

The syntax of the generation mode
```
cmake [<options>] -S <path-to-source> -B <path-to-build>
cmake [<options>] <path-to-source>
cmake [<options>] <path-to-existing-build>
```

Examples:
```
# generate a buildsystem in the ./build directory (or create it if it's missing) from the source in the ./project directory
cmake -S ./project -B ./build

# Build in the current directory, but take the source from one directory up (note that -S is
optional)
cmake -S ..

# Build in the ./build directory, and use a source from the current directory:
cmake -B build
```

#### Options for generator
If you have a few of them installed at the same time, CMake will correctly select it for you. This can be overridden by the `CMAKE_GENERATOR` environment variable or by specifying the generator directly on the command line, such as in the following:

```
cmake -G <generator-name> <path-to-source>
```

Some generators (such as Visual Studio) support a more in-depth specification of a toolset (compiler) and platform (compiler or SDK). Additionally, these have respective environment variables that override the default values: `CMAKE_GENERATOR_TOOLSET` and `CMAKE_GENERATOR_PLATFORM`. We can specify them directly, as follows:

```
cmake -G <generator-name>
-T <toolset-spec> -A <platform-name>
<path-to-source>
```

#### Options for caching
Prepopulate cached information:

```
cmake -C <initial-cache-script> <path-to-source>
```

We can provide a path to the CMake script, which (only) contains a list of set() commands to specify variables that will be used to initialize an empty build tree.

The initialization and modification of existing cache variables can be done in another way (for instance, when creating a file is a bit much to only set a few variables). You can simply set them in a command line, as follows:

```
cmake -D <var>[:<type>]=<value> <path-to-source>
```

The `:<type>` section is optional (it is used by GUIs); you can use `BOOL`, `FILEPATH`, `PATH`, `STRING`, or `INTERNAL`. If you omit the type, it will be set to the type of an already existing variable; otherwise, it will be set to `UNINITIALIZED`.

Example:
```
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
```

List cache variables with the -L option:
```
cmake -L[A][H] <path-to-source>
```

The removal of one or more variables can be done with the following option:
```
cmake -U <globbing_expr> <path-to-source>
```

Both of the -U and -D options can be repeated multiple times.

#### Options for debugging and tracing

To get general information about variables, commands, macros, and other settings, run the following:
```
# The optional file argument allows you to store the output in a file.
cmake --system-information [file]
```

Combine with fzf to grep cmake variables:
```
cmake --system-information | fzf
```

CMake filters the log output of these based on the current log level (by default, this is STATUS). The following line specifies the log level that we're interested in:
```
cmake --log-level=<level>
```

level can be any of the following: `ERROR`, `WARNING`, `NOTICE`, `STATUS`, `VERBOSE`, `DEBUG`, or `TRACE`. You can specify this setting permanently in the `CMAKE_MESSAGE_LOG_LEVEL` cache variable.

Trace mode:
This will print every command with the filename and exact line number it is called from alongside its arguments. You can enable it as follows:
```
cmake --trace
```

#### Options for preset
```
cmake --list-presets
cmake --preset=<preset>
```

### Building a project

The syntax of the build mode:
```
cmake --build <dir> [<options>] [-- <build-tool-options>]
```

Simplify:
```
cmake --build <dir>
```

If you need to provide special arguments to your chosen, native builder, pass them at the end of the command after the -- token:
```
cmake --build <dir> -- <build-tool-options>
```

#### Options for parallel builds

```
cmake --build <dir> --parallel [<number-of-jobs>]
cmake --build <dir> -j [<number-of-jobs>]
```

#### Options for target

Building a target that was deliberately excluded from normal builds
```
cmake --build <dir> --target <target1> -t <target2> ...
```

Remove all artifacts from the build directory
```
cmake --build <dir> -t clean
```

Clean first and then implement a normal build
```
cmake --build <dir> --clean-first
```

#### Options for multi-configuration generators

Select Debug, Release, MinSizeRel, or RelWithDebInfo and specify it as follows:
```
cmake --build <dir> --config <cfg>
```

#### Options for Debugging

```
cmake --build <dir> --verbose
cmake --build <dir> -v
```

### Installing a project
When artifacts are built, users can install them on the system. Usually, this means copying files into the correct directories, installing libraries, or running some custom installation logic from a CMake script.

```
cmake --install <dir> [<options>]
```

#### Options for multi-configuration generators

Select Debug, Release, MinSizeRel, or RelWithDebInfo and specify it as follows:
```
cmake --install <dir> --config <cfg>
```

#### Options for components

To install a single component, use the following option, which might be something like application, docs, and extra-tools.
```
cmake --install <dir> --component <comp>
```

#### Options for the installation directory

```
cmake --install <dir> --prefix <prefix>
```

#### Options for Debugging

```
cmake --install <dir> --verbose
cmake --install <dir> -v
```

### Running a script

Run CMake's custom language scripts:

```
cmake [{-D <var>=<value>}...] -P <cmake-script-file> [-- <unparsed-options>...]
```

Pass values to script:
- Through variables defined with the -D option.
- Through arguments that can be passed after a `--` token. CMake will create `CMAKE_ARGV<n>` variables for all arguments passed to the script (including the `--` token).

### Running a command-line tool

```
cmake -E <command> [<options>]
```

## CTest && CPack

The ctest executable is the CMake test driver program. CMake-generated build trees created for projects that use the enable_testing() and add_test() commands have testing support. This program will run the tests and report results.

CPack is built for the exact purpose of creating packages for different platforms: compressed archives, executable installers, wizards, NuGet packages, macOS bundles, DMG packages, RPMs, and more.

## Navigating the CMake project

### The source tree(project root)

Contains all of the C++ sources and CMake project files.
- It is requires a CMakeLists.txt configuration file in its top directory.
- It should be managed with a VCS such as git.
- The path to this directory is given by the user with a -S argument of the cmake command.
- Avoid hardcoding any absolute paths to the source tree in your CMake code.

### The build tree(build root/binary tree)

Directory to store everything that gets generated during the build.
- Binary files are created here: executables, libraries, object files, and archives used for final linking.
- Don't add this directory to your VCS
- CMake recommends out-of-source builds or builds that produce artifacts in a directory that is separate from all source files. This way, we can avoid polluting our project's source tree with temporary, system-specific files (or in-source builds).
- It is specified with -B or as a last argument to the cmake command if you have provided a path to the source, for example, `cmake -S ../project ./`.
- It's recommended that your projects include an installation stage that allows you to put the final artifacts in the corr

### Listfiles

Files that contain the CMake language are called listfiles and can be included one in another, by calling `include()` and `find_package()`, or indirectly with `add_subdirectory()`.
- CMake doesn't enforce consistent naming for these files, but usually, they have a .cmake extension.
- A very important naming exception is a file called CMakeLists.txt, which is the first file to be executed in the configuration stage. It is required at the top of the source tree.
- As CMake walks the source tree and includes different listfiles, the following variables are set: `CMAKE_CURRENT_LIST_DIR`, `CMAKE_CURRENT_LIST_FILE`, `CMAKE_PARENT_LIST_FILE`, and `CMAKE_CURRENT_LIST_LINE`.

### CMakeLists.txt
CMake projects are configured with CMakeLists.txt listfiles. It should contain at least two commands:
- cmake_minimum_required(VERSION <x.xx>): Sets an expected version of CMake.
- project(<name> <OPTIONS>): This is used to name the project (the provided name will be stored in the `PROJECT_NAME` variable) and specify the options to configure it.

### CMakeCache.txt
Cache variables will be generated from listfiles and stored in CMakeCache.txt when the configure stage is run for the first time.

### The Config-files for packages
- Config-files contain information regarding how to use the library binaries, headers, and helper tools. Sometimes, they expose CMake macros to use in your project.
- Use the `find_package()` command to include packages.
- CMake files describing packages are named `<PackageName>-config.cmake` and `<PackageName>Config.cmake`.
- When using packages, you can specify which version of the package you need. CMake will check this in the associated `<Config>Version.cmake` file.
- Config-files are provided by package vendors supporting the CMake ecosystem.
- CMake provides a package registry to store packages system-wide and for each user.

### Generated files
These files are generated in the build tree by the cmake executable in the generation stage:
cmake_install.cmake, CTestTestfile.cmake, CPackConfig.cmake

### Presets

Presets are stored in the same JSON format in two files:
• CMakePresets.json: This is meant for project authors to provide official presets.
• CMakeUserPresets.json: This is dedicated to users who want to customize the project configuration to their liking.
