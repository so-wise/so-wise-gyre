![image](https://user-images.githubusercontent.com/11757453/112683599-b5ef4800-8e69-11eb-8ac8-8735219096a1.png)

_Development funded by a UKRI Future Leaders Fellowship hosted by the British Antarctic Survey_

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

---------------------------- CURRENTLY IN DEVELOPMENT ---------------------------- 

![image](https://user-images.githubusercontent.com/11757453/112686795-6f501c80-8e6e-11eb-8e42-116983e1f576.png)

**Table of contents**
1. Features
2. Installation
3. Requirements
4. Documentation

### 1. Features

The SO-WISE gyre configuration is a state estimate that covers the Weddell Gyre region, including the Weddell Sea. It features geometrically static ice shelves and ice shelf cavities. Like all state estimates, it is an observationally-constrained numerical simulation that has been brough into consistency with a suite of observations using an adjoint method (i.e. 4DVAR). 

### 2. Installation

SO-WISE is an experimental configuration of [MITgcm](https://mitgcm.org/). To install SO-WISE, first install MITgcm and create a directory for the SO-WISE development and runs:
```
git clone https://github.com/MITgcm/MITgcm.git 
cd MITgcm
mkdir so-wise
```
Edit the `.gitignore` file in the MITgcm directory so that the MITgcm repository ignores the `so-wise` directory and its contents. Now navigate into the `so-wise` directory and clone the `so-wise-gyre` repository. The `so-wise-gyre` repository is independent of the MITgcm repository.
```
git clone https://github.com/so-wise/so-wise-gyre.git
cd so-wise-gyre
```
In order to alter the model grid, initial conditions, surface forcing, or other parameters, you may want the `mitgcm_python` repository as well. 
```
cd setup
git clone https://github.com/knaughten/mitgcm_python.git
```
This python package contains a number of scripts that are useful for creating new MITgcm domains. 

TO BE ADDED ONCE AVAILABLE: how to download the initial conditions, surface forcing files, and other setup files that are too large for this repository.

### 3. Requirements

* [MITgcm](https://github.com/MITgcm/MITgcm)
* [mitgcm_python setup tools](https://github.com/knaughten/mitgcm_python)
* CURRENTLY: some calculations and plotting are done in Matlab
* NOT YET AVAILABLE: initial conditions, surface forcing files, other setup files
* FOR ADJOINT RUNS: access to the TAF source-to-source algorithmic differentiation tool

### 4. Documentation

Once we figure out how to use it, we'll set up one of those "readthedocs" things. 


### 5. Project Organization
We assume that this repository is contained within an MITgcm "experiments" directory, like this one:
```
MITgcm_sowise_dev/MITgcm/experiments/so-wise-gyre/
```
The MITgcm repository is set to ignore the "experiments" directory by changing the `.gitignore` file of the MITgcm repository. That way, we can keep separate repositories for MITgcm and for the specific SO-WISE development. Within `so-wise-gyre`, we assume the following structure:
```
├── code            <- MITgcm code modifications for the so-wise-gyre configuration
├── input           <- Namelists for running MITgcm in the so-wise-gyre configuration
├── run             <- An example run directory. Contains a script to set up a run
├── scripts         <- Various helper scripts for compiling, running, checking
├── setup
│   ├── define_delR        <- Matlab script for generating vertical grid
│   │
│   ├── topo_inputs        <- Links to bathymetry inputs (e.g. GEBCO, bedmap2) (not tracked in repo)
│   │
│   ├── topo_outputs       <- Bathymetry and grid files as produced by mitgcm_python
│   │
│   ├── initial_conditions <- Initial conditions as produced by mitgcm_python (not tracked in repo)
|   |
│   ├── mitgcm_python      <- Needs to be downloaded separately (https://github.com/knaughten/mitgcm_python)
│   │
│   ├── plot_bathy.m       <- Some quick bathymetry plots
│   │
│   └── README.md          <- Markdown file describing the setup procedure
|
├── notebooks           <- Jupyter notebooks. Naming convention is a number (for ordering),
|   |                     the creator's initials, and a short `-` delimited description, e.g.
|   |                     `1.0_jqp_initial-data-exploration`.
│   ├── exploratory    <- Notebooks for initial exploration.
│   └── reports        <- Polished notebooks for presentations or intermediate results.
│
├── report             <- Generated analysis as HTML, PDF, LaTeX, etc.
│   ├── figures        <- Generated graphics and figures to be used in reporting
│   └── sections       <- LaTeX sections. The report folder can be linked to your overleaf
|                         report with github submodules.
│
├── requirements       <- Directory containing the requirement files.
│
├── .gitignore         <- Indicates which files the git repository can ignore
├── LICENSE            <- Describes the terms of use
└── README.md          <- Describes the overall so-wise-gyre configuration

```
