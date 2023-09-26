# CMAKE Basics

## CMAKE

### Generating a project buildsystem
This is the first step required to build our project. Here are a few options in terms of how
the CMake build action can be executed:
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
If you have a few of them installed at the same time, CMake will correctly select it for you. This can be overridden by the `CMAKE_GENERATOR` environment variable or by specifying the generator directly on the
command line, such as in the following:

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
