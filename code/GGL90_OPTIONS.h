C     *=============================================================*
C     | GGL90_OPTIONS.h
C     | o CPP options file for GGL90 package.
C     *=============================================================*
C     | Use this file for selecting options within the GGL90
C     | package.
C     *=============================================================*

C -- DJ
C These options should work for dz=5-10m in the surface layers. 
C But for finer surface layers, we may need to revisit this. 
C -- DJ

#ifndef GGL90_OPTIONS_H
#define GGL90_OPTIONS_H
#include "PACKAGES_CONFIG.h"
#include "CPP_OPTIONS.h"

#ifdef ALLOW_GGL90
C     Package-specific Options & Macros go here

C     Enable horizontal diffusion of TKE.
#undef ALLOW_GGL90_HORIZDIFF

C     Use horizontal averaging for viscosity and diffusivity as
C     originally implemented in OPA.
#define ALLOW_GGL90_SMOOTH

#endif /* ALLOW_GGL90 */
#endif /* GGL90_OPTIONS_H */
