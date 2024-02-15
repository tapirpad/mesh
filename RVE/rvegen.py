#!/usr/bin/env python3

# Script to generate RVE of composite with spherical incusion
# Author: Ignasius P.A. Wijaya
# Email : iwijaya2@illinois.edu

import random as rd

# import os
import time

import numpy as np
import pandas as ps

# Current time
tic = time.time()

########################################################################
# Input
########################################################################

# Side length of cube
lcube = 1.0

# Number of spheres
nsphe = 200

# Volume fraction
vfrac = 0.15

# Minimum distance between spheres and side of cube
odist = 0.02

# name of gmsh file
matrixFile = "rve.geo"
sphereFile = "sphere.geo"

########################################################################
# Function
########################################################################


# Check if there is overlaping spheres
def isOverlap(sid1, sid2, csphe, dsphe, odist):
    cdist = np.sqrt(np.sum((csphe[sid1, :] - csphe[sid2, :]) ** 2))
    if cdist < dsphe + odist:
        return True
    else:
        return False


def isAnyOverlap(sid, csphe, dsphe, odist):
    for i in range(nsphe):
        if sid == i:
            continue
        if isOverlap(sid, i, csphe, dsphe, odist):
            return True
    return False


########################################################################
# Generate non-overlaping sphere
########################################################################

# Radius and diameter of the spheres
rsphe = np.cbrt((lcube**3) * vfrac / nsphe * 3.0 / (4.0 * np.pi))
dsphe = 2.0 * rsphe

# Generate random center points
csphe = np.zeros([nsphe, 3], dtype=np.float32)
cofft = rsphe + odist
for i in range(nsphe):
    # csphe[i,0] = (1.0-2.0*cofft)*np.random.beta(0.5, 0.5) + cofft
    # csphe[i,1] = (1.0-2.0*cofft)*np.random.beta(0.5, 0.5) + cofft
    # csphe[i,2] = (1.0-2.0*cofft)*np.random.beta(0.5, 0.5) + cofft
    csphe[i, 0] = rd.uniform(0 + cofft, lcube - cofft)
    csphe[i, 1] = rd.uniform(0 + cofft, lcube - cofft)
    csphe[i, 2] = rd.uniform(0 + cofft, lcube - cofft)

# print(isOverlap(0, 1, csphe, dsphe, odist))
tol = 1.0e-4
for i in range(nsphe):
    print("Generating sphere #{}".format(i + 1))
    for j in range(nsphe):
        if i <= j:
            continue
        if isOverlap(i, j, csphe, dsphe, odist):
            cdist = np.sqrt(np.sum((csphe[j, :] - csphe[i, :]) ** 2))
            cdir = (csphe[j, :] - csphe[i, :]) / cdist
            csphe[i, :] = csphe[j, :] + 2.0 * cofft * cdir
            check1 = (np.abs(csphe[i, 0]) < tol) and (np.abs(csphe[i, 0] - lcube) < tol)
            check2 = (np.abs(csphe[i, 1]) < tol) and (np.abs(csphe[i, 1] - lcube) < tol)
            check3 = (np.abs(csphe[i, 2]) < tol) and (np.abs(csphe[i, 2] - lcube) < tol)
            check = check1 and check2 and check3
            while isAnyOverlap(i, csphe, dsphe, odist) or (not check):
                check = True
                csphe[i, 0] = rd.uniform(0 + cofft, 1 - cofft)
                csphe[i, 1] = rd.uniform(0 + cofft, 1 - cofft)
                csphe[i, 2] = rd.uniform(0 + cofft, 1 - cofft)

########################################################################
# Write .geo file for gmsh
########################################################################

matrixGmsh = open(matrixFile, "w")
sphereGmsh = open(sphereFile, "w")

print('SetFactory("OpenCASCADE");\n', file=matrixGmsh)
print('SetFactory("OpenCASCADE");\n', file=sphereGmsh)
print(
    "Box(1) = {{0.0, 0.0, 0.0, {}, {}, {}}};\n".format(lcube, lcube, lcube),
    file=matrixGmsh,
)

for i in range(nsphe):
    print(
        "Sphere({}) = {{{}, {}, {}, {}, -Pi/2, Pi/2, 2*Pi}};".format(
            i + 2, csphe[i, 0], csphe[i, 1], csphe[i, 2], rsphe
        ),
        file=sphereGmsh,
    )
    print(
        "Sphere({}) = {{{}, {}, {}, {}, -Pi/2, Pi/2, 2*Pi}};".format(
            i + 2, csphe[i, 0], csphe[i, 1], csphe[i, 2], rsphe
        ),
        file=matrixGmsh,
    )
    print(
        "BooleanDifference{{ Volume{{1}}; Delete; }}{{ Volume{{{}}}; Delete; }}".format(
            i + 2
        ),
        file=matrixGmsh,
    )

print("\nMesh.MeshSizeMax = {};".format(odist), file=matrixGmsh)
print("\nMesh.MeshSizeMax = {};".format(odist), file=sphereGmsh)

matrixGmsh.close()
sphereGmsh.close()

########################################################################
# Print elapsed time
########################################################################

toc = time.time()
print("Elapsed time = {0:<12.3f}".format(toc - tic))
