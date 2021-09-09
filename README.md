# C Data Structures

A collection of data structure implementations written in C.

# Building and Installing

To build all of the libraries, simply type `make` in the root directory of this repo.

To build specific libraries, navigate to the directory of the library you wish to build and run `make lib`. For easy installation, you can copy the .so and .h files to the lib and inc directories respectively.

By default, a combined library called `libstructures.so` containing the contents of every other library is generated. To only include specific data structures in `libstructures.so`, run `make obj` in the direcories for the data structures you wish to include. This will generate .o files, which can be copied into the obj directory, and don't forget to copy the header file for each data structure into the inc directory. Running `make libstructures.so` at the root of the repository will build a library containing only your selected data structures.

To install, use `make install` (you will probably need root)

`make install` copies all libraries from the lib directory to /usr/lib, and all header files from the inc directory to /usr/include/structures.

# Navigation

structures
  +-inc                     header files
  |   `-*.h
  +-lib                     output for the libraries built
  |   `-*.so
  +-obj                     stores .o files during build
  |   `-*.o
  +-scripts                 shell scripts
  |   `-*.sh
  +-structs                 directory of data structures
  |   +-LinkedList          Linked list implementation
  |   |   +-LinkedList.c
  |   |   +-LinkedList.h
  |   |   `-Makefile
  |   `-...                 Etc...
  |       `...
  +-.gitignore    
  +-Makefile                makefile
  +-Makefile-for-ds         makefile template 
  `-README.md

# Adding your own data structures

Run the command `scripts/new_ds.sh [STRUCTURE_NAME]`, which will create a Makefile, `\[STRUCTURE_NAME].c and \[STRUCTURE_NAME].h. In order to be compatible with the Makefile in the root of the directory, user created Makefiles should have these three rules:
    
    1. obj: builds a singular object ready to be compiled into a shared object library (ie must be compiled with -fpic)

    2. lib: builds a shared object library (linked with -shared) with all the functionality of your data structure.

    3. clean: cleans the directory (remove unnecessary objects/libraries)

Next time you run `make` in the top level of the repository, your library will be built as dictated by your Makefile. As a result, `make install` will install your own libraries too.