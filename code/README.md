This is a record of the compile-time settings used for SO-WISE (gyre configuration), i.e. those modifications in the `code` folder. It will also serve as a record of the development process.

We are comparing a B-SOSE setup (circa 2018) with [ECCOv4](https://github.com/ECCO-GROUP/ECCO-v4-Configurations/tree/master/ECCOv4%20Release%204) and [WFRIS](https://github.com/knaughten/UaMITgcm/tree/master/example/WSFRIS_999/mitgcm_run). 

# Initial configuration details
Below, 'x' indicates that the SO-WISE model setup differs from either ECCO or WFRIS. 

### File: `AUTODIFF_OPTIONS.h`
Appears to be the same as the ECCO configuration, using tape settings optimised by Gael Forget

### File: `CPP_OPTIONS.h`
|Option                    |Status       |Flag       |ECCO   |WFRIS | Note   |
|--------------------------|-------------|-----------|-------|-------|-------|
| Shortwave heating               | On       | `#define SHORTWAVE_HEATING`                    | | | |
| Geothermal heating              | Off      |  `#undef ALLOW_GEOTHERMAL_FLUX`                | | | Minor, may add later |
| Hydrostatic code                | On       |  `#define INCLUDE_PHIHYD_CALCULATION_CODE`     | | | |
| Convection subroutine           | On       |  `#define INCLUDE_CONVECT_CALL`                | | | |
| Diffusivity subroutine          | On       |  `#define INCLUDE_CALC_DIFFUSIVITY_CALL`       | | | |
| Use 3D vertical diffusivity     | On      |  `#define ALLOW_3D_DIFFKR`                      | |X| Defined in ECCO |
| Implicit vertical advection     | On       |  `#define INCLUDE_IMPLVERTADV_CODE`            | | | |
| Adams-Bashforth 3rd order code  | On       |  `#undef ALLOW_ADAMSBASHFORTH_3`              |X| | Not defined in WFRIS |
| Non-hydrostatic mode            | Off      |  `#undef ALLOW_NONHYDROSTATIC`                 | | | |
| Frictional heating              | Off      |  `#undef ALLOW_FRICTION_HEATING`               | | | |
| Allow source/sink in interior   | Off      |  `#undef ALLOW_ADDFLUID`                       | | | |
| Atmospheric loading             | On       |  `#define ATMOSPHERIC_LOADING`                 | | | ECCO also uses `#define ALLOW_IB_CORR`  | 
| **Vertical coordinate, free surface, and freshwater**  | | | | | Important for sea level rise?|     
| Balance surface forcing fluxes  | Off      |  `#undef ALLOW_BALANCE_FLUXES`                 |X|X| |
| Balance surface forcing relaxation | Off      |  `#undef ALLOW_BALANCE_RELAX`               |X| | |
| Exact conservation of fluid     | On      |  `#define EXACT_CONSERV`                        | | | |
| Non-linear free surface         | On      |  `#define NONLIN_FRSURF`                   |X|X| |
| **Implicit solver routines**
| Kinner solver                   | On      |  `#define SOLVE_DIAGONAL_KINNER`                |X| | Suitable for AD|

Below this line in the file there are other flags mostly for backwards compatibility. We don't need them here.

### File: `CPP_EEOPTIONS.h`
Here we'll stick with the SOSE (2018) file for starters. 

### File: `CTRL_OPTIONS.h`
|Option                                      |Status       |Flag                                         |Note   |
|--------------------------                  |-------------|-----------                                  |-------|
| Non-dimensional control I/O                | Off         | `#undef ALLOW_NONDIMENSIONAL_CONTROL_IO`    | Differs from ECCO approach    |
| Exclude control pack                       | On          | `#define EXCLUDE_CTRL_PACK`                 | Differs from ECCO approach    |
| Use pkg/ctrl correlation operator (3D)     | Off         | `#undef ALLOW_SMOOTH_CORREL3D`              | Differs from ECCO approach    |
| Use pkg/ctrl correlation operator (2D)     | Off         | `#undef ALLOW_SMOOTH_CORREL2D`              | Differs from ECCO approach    |
| Impose bounds on controls                  | Off         | `#undef ALLOW_ADCTRLBOUND`                  | Differs from ECCO approach    |
| Rotate controls                            | Off         | `#undef ALLOW_ROTATE_UV_CONTROLS`           | Differs from ECCO; probably not needed    |

### File: `ECCO_OPTIONS.h`
|Option                                      |Status       |Flag                                         |Note   |
|--------------------------                  |-------------|-----------                                  |-------|
| More flexible gencost                      | On          | `#define ALLOW_GENCOST_FREEFORM`            | Differs from ECCO approach (use w/caution)   |
| Include global mean steric sea level correction in etanFull  | Off          | `#undef ALLOW_PSBAR_STERIC`, `#undef ALLOW_SHALLOW_ALTIMETRY`, `#undef ALLOW_HIGHLAT_ALTIMETRY`            | Differs from ECCO approach  |
| Assume single files are climatologies      | On          | `#define COST_GENERIC_ASSUME_CYCLIC`        | Differs from ECCO approach    |
| To compute global mean cost                | Off         | `#define ALLOW_GENCOST_1D`                  | Differs from ECCO approach    |

### File: `EXF_OPTIONS.h`
|Option                        |Status       |Flag                                       |ECCO   |WFRIS  |Note               |
|--------------------------    |-------------|-----------                                |----   |-----  |----               |
| Large & Yeager bulk formulae | Off         | `#define ALLOW_BULK_LARGEYEAGER04`        |       |X      |Differs from WFRIS |
| Salt flux                    | Off         | `#undef  ALLOW_SALTFLX`                   |X      |       |Differs from ECCO  |

### File: `GGL90_OPTIONS.h`
Since WFRIS999 uses KPP, here we only compare with ECCO
|Option                    |Status       |Flag       |Note   |
|--------------------------|-------------|-----------|-------|
| Horizontal diffusion of TKE            | Off       | `#undef ALLOW_GGL90_HORIZDIFF`                  | Same as default    |
| Horizontal averaging enabled           | On        | `#define ALLOW_GGL90_SMOOTH`                    | Same as ECCO       |
 
### File: `OBCS_OPTIONS.h`
Since ECCO does not use OBCS, here we only compare with WFRIS
|Option                    |Status       |Flag       |Note   |
|--------------------------|-------------|-----------|-------|
| Individual open boundaries                           | On        | North, east, and west all enabled   |                           |
| Sponge layer treatment of sea ice variables          | Off       | `#undef ALLOW_OBCS_SEAICE_SPONGE`   | Defined in WFRIS999       |
| Balance barotropic velocity                          | Off       | `#undef ALLOW_OBCS_BALANCE`         | Defined in WFRIS999       |
| **Old UVICE approach**                              
| Avoid sea ice convergence                            | Off       | `#undef OBCS_SEAICE_AVOID_CONVERGENCE` | Not defined in WFRIS999       |
| Smooth edge-perpendicular component of sea ice vel   | Off       | `#undef OBCS_SEAICE_SMOOTH_UVICE_PERP` | Defined in WFRIS999           |
| Smooth edge-parallel component of sea ice vel        | Off       | `#undef OBCS_SEAICE_SMOOTH_UVICE_PAR`  | Not defined in WFRIS999       |

### File: `SEAICE_OPTIONS.h`
Fluxes are computed by EXF and then modified by the seaice package. 
|Option                    |Status       |Flag                              |ECCO   |WFRIS  |Note               |
|--------------------------|-------------|-----------                       |----   |-----  |----               |
| EVP code                 | Off         | `#undef SEAICE_ALLOW_EVP`        |X      |X      |                   |
| Clipvels                 | On          | `#define SEAICE_ALLOW_CLIPVELS`  |       |X      |Same as ECCO       |
| Free drift code          | On          | `#define SEAICE_ALLOW_FREEDRIFT` |       |X      |Same as ECCO       |

Note that JPL has been implementing the sea ice adjoint. They've made some progress, but it's still not working yet.  

### File: `tamc.h`
Adjoint optimisation (currently using ECCO default values)

# Development journal
Below is a history of the development of SO-WISE (gyre) for tracking purposes

## Initial configuration
The initial configuration is a blend of SOSE (circa 2018, physics only), WFISS999 (K. Naughten), and some parts of ECCOv4. We can start by trying to compile the individual setups and then adding components. 

### MITgcm verification suite
* Ran the 'testresport' script in 'no run' mode; so it only builds/compiles, i.e. `./testreport -norun`
* This was successful; no compilation errors

### SOSE setup compilation tests (11 Feb 2021)
* Matt Mazloff shared the SOSE setup with me. I tried compiling as-is using up-to-date MITgcm code. Although I used the `-mcmodel=medium` flag in the build options file, the build process still returned a 'relocation truncated to fit' error. It's something in eeparams and obcs. 
* Tried compiling with checkpoint67f (released 23 Nov 2018). Exact same issue.
* Trying `mcmodel=large` option. That worked! The setup compiled without error. The executable is about 6GB in size, according to the fourth output of the `size` command. 

### WFRIS999 setup compilation tests
* Checking; setup has a lot of code modifications. Trim back to something more basic?

### SO-WISE setup compilation tests 
11 Feb 2021
* ptracers package throws an error in cost_tile. Package turned off for now. 
```
ftn -fallow-argument-mismatch -mcmodel=medium -O3 -funroll-loops  -c cost_tile.f
cost_tile.f:3485:24:

 3485 |       INTEGER    iptrkey
      |                        1
Error: Symbol 'iptrkey' at (1) already has basic type of INTEGER
```
* The `mcmodel=large` flag option made it possible to compile.
* I revised the code options to match SOSE, with a few additions from ECCO for the adjoint stuff. Let's see if the forward model compiles. 
* Using a PTRACERS_SIZE.h header file from Matt, the ptracers package now compiles.
12 Feb 2021
* Forward compiles, but not the adjoint. Let's start with the forward case. 

23 March 2021:
* Making some progress with the forward run configuration. I think I'll start another one of these compile-time pages in order to better document our choices. 

