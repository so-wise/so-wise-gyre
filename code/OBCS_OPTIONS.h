C CPP options file for OBCS package
C
C Use this file for selecting options within the OBCS package
C
C OBCS is enabled with ALLOW_OBCS in CPP_OPTIONS.h

#ifndef OBCS_OPTIONS_H
#define OBCS_OPTIONS_H
#include "PACKAGES_CONFIG.h"
#include "CPP_OPTIONS.h"

#ifdef ALLOW_OBCS

C Enable individual open boundaries
#define ALLOW_OBCS_NORTH
#undef ALLOW_OBCS_SOUTH
#define ALLOW_OBCS_EAST
#define ALLOW_OBCS_WEST

C This include hooks to the Orlanski Open Boundary Radiation code
#undef ALLOW_ORLANSKI

C Enable OB values to be prescribed via external fields that are read
C from a file
#define ALLOW_OBCS_PRESCRIBE

C Enable OB conditions following Stevens (1990)
#undef ALLOW_OBCS_STEVENS

C This includes hooks to sponge layer treatment of uvel, vvel
#define ALLOW_OBCS_SPONGE

C Include hooks to sponge layer treatment of pkg/seaice variables
#define ALLOW_OBCS_SEAICE_SPONGE

C balance barotropic velocity
#define ALLOW_OBCS_BALANCE

C -- DJ
C  The five experimental options below are turned off at present. 
C -- DJ

C     The following five CPP options are experimental and aim to deal
C     with artifacts due to the low-frequency specification of sea-ice
C     boundary conditions compared to the model forcing frequency.
C     Ice convergence at edges can cause model to blow up.  The
C     following CPP option fixes this problem at the expense of less
C     accurate boundary conditions.
#undef OBCS_SEAICE_AVOID_CONVERGENCE

C     Smooth the component of sea-ice velocity perpendicular to the edge.
#undef OBCS_SEAICE_SMOOTH_UVICE_PERP

C     Smooth the component of sea ice velocity parallel to the edge.
#undef OBCS_SEAICE_SMOOTH_UVICE_PAR

C     Smooth the tracer sea-ice variables near the edges.
#undef OBCS_SEAICE_SMOOTH_EDGE

C     Compute rather than specify seaice velocities at the edges.
#undef OBCS_SEAICE_COMPUTE_UVICE

#endif /* ALLOW_OBCS */
#endif /* OBCS_OPTIONS_H */
