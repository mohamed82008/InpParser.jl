# InpParser

[![Build Status](https://travis-ci.org/mohamed82008/InpParser.jl.svg?branch=master)](https://travis-ci.org/mohamed82008/InpParser.jl)

[![Coverage Status](https://coveralls.io/repos/mohamed82008/InpParser.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/mohamed82008/InpParser.jl?branch=master)

[![codecov.io](http://codecov.io/github/mohamed82008/InpParser.jl/coverage.svg?branch=master)](http://codecov.io/github/mohamed82008/InpParser.jl?branch=master)


This package reads the content of an ABAQUS inp file into native Julia data structures. Not all features are supported yet.

## Supported features

1. Homogeneous volume elements
2. Single elastic material objects
3. Pressure on faces
4. Concentrated loads on nodes
5. Loads on faces
6. Zero and non-zero Dirichlet boundary conditions on nodes and/or faces
7. Cell sets
8. Node sets

## Installation

```julia
Pkg.clone("https://github.com/mohamed82008/InpParser.jl")
```

## Example

```julia
using InpParser

inp_content = import_inp("inpfilename.inp")

node_coords = inp_content.node_coords
celltype = inp_content.celltype
cells = inp_content.cells
nodesets = inp_content.nodesets
cellsets = inp_content.cellsets
E = inp_content.E
mu = inp_content.mu
nodedbcs = inp_content.nodedbcs
cloads = inp_content.cloads
facesets = inp_content.facesets
dloads = inp_content.dloads
```