# Calculator

a basic calculator that do the four basic arithmetic operations:

- Addition (Finding the Sum; '+')
- Subtraction (Finding the difference; '-') 
- Multiplication (Finding the product; '×')
- Division (Finding the quotient; '÷')


# Poject folder structure

To build/compile with bob tool the next files are needed:

iproj.json  :   At project root level, it contains project level metadata. This file is necesary to
                use bob as build/compile tool. The file contains some attribuites to build/compile the project. See bob help for more info: https://ibm.github.io/ibmi-bob/#/

Rules.mk    :   At each level of the project (all directories) create a file for defining the targets. 
                This file is requered on each directory that contain compilable source code. 

.ibmi.json  :   At the directories you want to override build variables to target a different 
                object library, or use a different EBCDIC CCSID for the compile.

.gitignore  :   At project root level to tell git a list of files that should not be traked. This file
                it's not requered to use bob.
