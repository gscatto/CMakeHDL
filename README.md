# CMakeHDL

CMakeHDL streamlines FPGA and HDL development by integrating industry tools (e.g., GHDL, Vivado) into CMake with a consistent, unified API. This eliminates tool-specific build configurations and lets you focus on your hardware designs.

[Requirements](#requirements) | [Installation](#installation) | [Quick Start](#requirements) | [API Reference](#api-reference) | [Contributing](#contributing)

## Requirements

- CMake 3.31.6 (might work with older versions)
- GHDL 5.0.1, LLVM 19.1.7 (might work with older versions)

## Installation

Add CMakeHDL to your CMake project using `FetchContent`:

```cmake
include(FetchContent)
FetchContent_Declare(CMakeHDL
    GIT_REPOSITORY "https://github.com/gscatto/CMakeHDL"
    GIT_TAG "5a5705c977aca1ab800f4ec7476ff8a2bce96ab8"
)
FetchContent_MakeAvailable(CMakeHDL)
get_property(CMakeHDL_CMAKE_MODULE_PATH
    TARGET CMakeHDL
    PROPERTY CMAKE_MODULE_PATH
)
list(APPEND CMAKE_MODULE_PATH "${CMakeHDL_CMAKE_MODULE_PATH}")
include(CMakeHDL)
```

## Quick Start

Create a VHDL library containing entity and supporting testbench, then add a simulation that runs the testbench.

```cmake
# Add a library containing entity and testbench
CMakeHDL_add_library(
    NAME and_gate_tb
    SOURCES
        and_gate.vhd
        and_gate_tb.vhd
)

# Add a testbench simulation
CMakeHDL_add_simulation(
    NAME and_gate_tb_sim
    WORK_LIBRARY and_gate_tb
    VHDL_TOP_ENTITY and_gate_tb
)
```

This creates two CMake targets:

- `and_gate_tb` compiles the VHDL sources into a library
- `and_gate_tb_sim` runs the testbench in a simulation

## API Reference

[Properties](#properties) | [Functions](#functions)

### Properties

| Name                   | Default | Values      | Description            |
|------------------------|---------|-------------|------------------------|
| CMakeHDL_PROGRAM_NAME  | -       | `ghdl-llvm` | HDL program            |
| CMakeHDL_VHDL_STANDARD | 1993    | 1993, 2008  | VHDL language standard |

### Functions

[CMakeHDL_add_library()](#CMakeHDL_add_library) | [CMakeHDL_add_simulation()](#CMakeHDL_add_simulation)

#### CMakeHDL_add_library()

Creates a new HDL library.

```cmake
CMakeHDL_add_library(
    NAME <name>
    [SOURCES <source1> <source2>]
)
```

##### Parameters

- `NAME` (required) - Name of the library
- `SOURCES` (optional) - Sources of the library

##### Examples

```cmake
# Create a library named "and_gate_tb"
CMakeHDL_add_library(
    NAME and_gate_tb
    SOURCES
        and_gate.vhd
        and_gate_tb.vhd
)
```

#### CMakeHDL_add_simulation()

Creates a new HDL simulation.

```cmake
CMakeHDL_add_simulation(
    NAME <name>
    [WORK_LIBRARY <work-library>]
    [VHDL_TOP_CONFIGURATION <vhdl-top-config>]
    [VHDL_TOP_ENTITY <vhdl-top-entity>]
    [VHDL_TOP_ARCHITECTURE <vhdl-top-arch>]
)
```

##### Parameters

- `NAME` (required) - Name of the simulation
- `WORK_LIBRARY` (optional) - Name of the work library
- `VHDL_TOP_CONFIGURATION` (optional) - Name of the VHDL configuration
- `VHDL_TOP_ENTITY` (optional) - Name of the VHDL entity
- `VHDL_TOP_ARCHITECTURE` (optional) - Name of the VHDL architecture

##### Examples

```cmake
# Specify work library and VHDL top entity
CMakeHDL_add_simulation(
    NAME and_gate_tb_sim
    WORK_LIBRARY and_gate_tb
    VHDL_TOP_ENTITY and_gate_tb
)
```

## Contributing

Contributions are welcome! Please submit issues and pull requests on [GitHub](https://github.com/gscatto/CMakeHDL).

## License

MIT License — See `LICENSE` file for details.

Copyright © 2026 Giulio Scattolin