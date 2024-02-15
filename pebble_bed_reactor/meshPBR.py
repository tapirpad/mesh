#!/usr/bin/env python3
# Script to generate geometry and mesh of pebble bed reactor using gmsh
# Author: Ignasius P.A. Wijaya
# Email : iwijaya2@illinois.edu
# ref: https://gmsh.info/doc/texinfo/gmsh.html

import sys
import time

import gmsh
import numpy as np

# Current time
tic = time.time()

# ======================================================================================
# Input box
# ======================================================================================
# fmt:off

# General
modelname   = "PBR"
numThreads  = 8
printInfo   = 1

# Geometry
cylinderRadIn   = 1200
cylinderRadOut  = 3600
cylinderHeight  = 250
pebbleRadius    = 30
gap             = 50

# Mesh
meshSizeMin = 0.0
meshSizeMax = 10

# fmt:on
# ======================================================================================
# Compute the location of pebbles
# ======================================================================================

gmsh.initialize(sys.argv)
gmsh.model.add("temp")
gmsh.option.setNumber("General.Terminal", printInfo)
gmsh.option.setNumber("General.NumThreads", numThreads)
gmsh.option.setNumber("Mesh.Algorithm", 5)  # -Delaunay
# gmsh.option.setNumber("Mesh.Algorithm", 6)  # Frontal-Delaunay
gmsh.option.setNumber("Mesh.Algorithm3D", 10)  # HXT
gmsh.option.setNumber("Mesh.MeshSizeMin", 2 * pebbleRadius + gap)
gmsh.option.setNumber("Mesh.MeshSizeMax", 2 * pebbleRadius + 1.2 * gap)
gapH = gap + pebbleRadius
dz = cylinderHeight - 2 * gapH
c1 = gmsh.model.occ.addCylinder(0, 0, gapH, 0, 0, dz, cylinderRadIn + gap, -1)
c2 = gmsh.model.occ.addCylinder(0, 0, gapH, 0, 0, dz, cylinderRadOut - gap, -1)
c3, c4 = gmsh.model.occ.cut([(3, c2)], [(3, c1)], -1, True, True)
gmsh.model.occ.synchronize()
gmsh.model.addPhysicalGroup(3, [c3[-1][1]], 1)
gmsh.model.mesh.generate(3)
nodeCoord = gmsh.model.mesh.getNodesForPhysicalGroup(3, 1)[1]
nPebbles = int(len(nodeCoord) / 3)
cPebbles = np.zeros([nPebbles, 3])
for i in range(nPebbles):
    cPebbles[i, 0] = nodeCoord[3 * i]
    cPebbles[i, 1] = nodeCoord[3 * i + 1]
    cPebbles[i, 2] = nodeCoord[3 * i + 2]
gmsh.write("temp.vtk")
gmsh.finalize()

# ======================================================================================
# Create mesh
# ======================================================================================

gmsh.initialize(sys.argv)
gmsh.model.add(modelname)

gmsh.option.setNumber("General.Terminal", printInfo)
gmsh.option.setNumber("General.NumThreads", numThreads)
gmsh.option.setNumber("Mesh.Algorithm", 5)  # -Delaunay
# gmsh.option.setNumber("Mesh.Algorithm", 6)  # Frontal-Delaunay
gmsh.option.setNumber("Mesh.Algorithm3D", 10)  # HXT
gmsh.option.setNumber("Mesh.MeshSizeMin", meshSizeMin)
gmsh.option.setNumber("Mesh.MeshSizeMax", meshSizeMax)

c1 = gmsh.model.occ.addCylinder(0, 0, 0, 0, 0, cylinderHeight, cylinderRadIn, -1)
c2 = gmsh.model.occ.addCylinder(0, 0, 0, 0, 0, cylinderHeight, cylinderRadOut, -1)
c3, c4 = gmsh.model.occ.cut([(3, c2)], [(3, c1)], -1, True, True)
cylinderId = [c3[-1][1]]

# nPebbles = 10
holes = []
pebblesId = np.zeros(nPebbles)
for i in range(nPebbles):
    x = cPebbles[i, 0]
    y = cPebbles[i, 1]
    z = cPebbles[i, 2]
    pebblesId[i] = gmsh.model.occ.addSphere(x, y, z, pebbleRadius, -1)
    holes.append((3, pebblesId[i]))

print("Subtracting")
ov, ovv = gmsh.model.occ.fragment([(3, cylinderId[0])], holes)
toc = time.time()
print("Elapsed time = {0:<12.3f}".format(toc - tic))

print("Synchronize")
gmsh.model.occ.synchronize()
toc = time.time()
print("Elapsed time = {0:<12.3f}".format(toc - tic))

cylinderId = [ov[-1][1]]
gmsh.model.addPhysicalGroup(3, cylinderId, 1)
gmsh.model.addPhysicalGroup(3, pebblesId, 2)

if len(ov) - nPebbles != 1:
    sys.exit("ERROR: Overlapping pebbles?")

# print(ov)
print(len(ov))
print(nPebbles)
print(pebblesId)
print(cylinderId)

sys.stdout.flush()

gmsh.model.mesh.generate(3)
# gmsh.write(modelname + ".msh")
gmsh.write(modelname + ".vtk")

# if '-nopopup' not in sys.argv:
#     gmsh.fltk.run()

gmsh.finalize()

# ======================================================================================
# Print elapsed time
# ======================================================================================

toc = time.time()
print("Finished")
print("Elapsed time = {0:<12.3f}".format(toc - tic))
print("nPebbles = {}".format(nPebbles))
