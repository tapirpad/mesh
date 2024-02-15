#!/usr/bin/env python3

# This script converts .msh file into feap input files and a .vtk file
# Author: Ignasius P.A. Wijaya
# Email : iwijaya2@illinois.edu

# import os
import time
import numpy as np
import pandas as ps

# Current time
tic = time.time()

########################################################################
# Input
########################################################################

# Path of the .msh file
# meshfile = './sphere200a.msh'
# meshfile = './rve200a-2.msh'
# meshfile = './rve200a-4.msh'
# meshfile = './rve200a-8.msh'
meshfile = './rve400a.msh'

# Flag for periodic BC
periodicFlag = 0

# Material assignment
def assignMat(elemid):
        return 1

# Define boundary conditions
def bcs(nodeCoord):
    tol  = 1.e-6
    boun = np.zeros(4, dtype=int)
    disp = np.zeros(4, dtype=np.float32)
    forc = np.zeros(4, dtype=np.float32)
    bflag = 0
    x1 = nodeCoord[0]
    x2 = nodeCoord[1]
    x3 = nodeCoord[2]
    checkX1 = (abs(x1)<tol) or (abs(x1-1.0)<tol)
    checkX2 = (abs(x2)<tol) or (abs(x2-1.0)<tol)
    checkX3 = (abs(x3)<tol) or (abs(x3-1.0)<tol)
    dispMag = 1.0
    if checkX1 or checkX2 or checkX3:
        bflag = 1
        boun[0] = 1
        boun[1] = 1
        boun[2] = 1
        boun[3] = 0
        disp[0] = x2*dispMag
    return [bflag, boun, disp, forc]

# Search for nodes on the opposite surfaces that needs to be linked
def periodicNodeMap(nodeTable):
    tol  = 1.e-6
    nnode = nodeTable.shape[0]
    xnode = np.zeros((nnode,2), dtype=int)
    ynode = np.zeros((nnode,2), dtype=int)
    znode = np.zeros((nnode,2), dtype=int)
    coord = np.zeros(3, dtype=np.float32)
    nx1node = 0
    ny1node = 0
    nz1node = 0
    nx2node = 0
    ny2node = 0
    nz2node = 0
    # Identify node on surfaces
    for i in range (nnode):
        x1 = nodeTable[i,0]
        x2 = nodeTable[i,1]
        x3 = nodeTable[i,2]
        if abs(x1) < tol:
            nx1node = nx1node+1
            xnode[nx1node-1,0] = i+1
        if abs(x2) < tol:
            ny1node = ny1node + 1
            ynode[ny1node-1,0] = i+1
        if abs(x3) < tol:
            nz1node = nz1node + 1
            znode[nz1node-1,0] = i+1
        if abs(x1-1.0) < tol:
            nx2node = nx2node+1
            xnode[nx2node-1,1] = i+1
        if abs(x2-1.0) < tol:
            ny2node = ny2node+1
            ynode[ny2node-1,1] = i+1
        if abs(x3-1.0) < tol:
            nz2node = nz2node+1
            znode[nz2node-1,1] = i+1
    # Node map array
    xmap = np.zeros((nx1node,2), dtype=int)
    ymap = np.zeros((ny1node,2), dtype=int)
    zmap = np.zeros((nz1node,2), dtype=int)
    # Node map for x-surfaces
    for i in range (nx1node):
        nid1 = xnode[i,0]
        coord[0] = 1.0
        coord[1] = nodeTable[nid1-1,1]
        coord[2] = nodeTable[nid1-1,2]
        xmap[i,0] = nid1
        for j in range (nx2node):
            nid2 = xnode[j,1]
            if np.sum(np.abs(coord-nodeTable[nid2-1,:])) < tol:
                xmap[i,1] = nid2
                break
    # Node map for y-surfaces
    for i in range (ny1node):
        nid1 = ynode[i,0]
        coord[0] = nodeTable[nid1-1,0]
        coord[1] = 1.0
        coord[2] = nodeTable[nid1-1,2]
        ymap[i,0] = nid1
        for j in range (ny2node):
            nid2 = ynode[j,1]
            if np.sum(np.abs(coord-nodeTable[nid2-1,:])) < tol:
                ymap[i,1] = nid2
                break
    # Node map for z-surfaces
    for i in range (nz1node):
        nid1 = znode[i,0]
        coord[0] = nodeTable[nid1-1,0]
        coord[1] = nodeTable[nid1-1,1]
        coord[2] = 1.0
        zmap[i,0] = nid1
        for j in range (nz2node):
            nid2 = znode[j,1]
            if np.sum(np.abs(coord-nodeTable[nid2-1,:])) < tol:
                zmap[i,1] = nid2
                break
    return[xmap, ymap, zmap]

def applyNodeMap(nid, map):
    for i in range (map.shape[0]):
        if nid==map[i,1]:
            return map[i,0]
    return nid

########################################################################
# Parse and write mesh data
########################################################################

# Open file
meshdata = open(meshfile, 'r')
meshchck = open('./Vmesh.vtk','w')
inode = open('./inode', 'w')
ielem = open('./ielem', 'w')
iboun = open('./iboun', 'w')
idisp = open('./idisp', 'w')
iforc = open('./iforc', 'w')
# ielem_ori = open('./ielem_ori', 'w')

# Initialization
nodeCoord = np.zeros(3, dtype=np.float32)
ix        = np.zeros(4, dtype=int)
ixv       = np.zeros(4, dtype=int)

# vtk Header
print('# vtk DataFile Version 1.0', file=meshchck);
print('10-node tetrahedral element mesh', file=meshchck);
print('ASCII\n', file=meshchck);

# Total node number
while True:
    line = meshdata.readline()
    if '$Nodes' in line:
        line = meshdata.readline()
        split = line.split()
        nnode = int(split[1])
        break
print('Total number of nodes = {0:<8d}'.format(nnode))
print('DATASET UNSTRUCTURED_GRID', file=meshchck);
print('POINTS {0:8d} float'.format(nnode), file=meshchck);

# Nodal coordinates and boundary conditions
nodeid = 0
line = meshdata.readline()
xno = len(str(nnode))
fno = '{0:<' + str(xno) + 'd} {1:2d}'
vboun = ''
vdisp = ''
vdispl = ''
vforc = ''
nodeTable = np.zeros((nnode,3), dtype=np.float32)
while True:
    split = line.split()
    nblock = int(split[3])
    for i in range(nblock):
        line = meshdata.readline()
    for i in range(nblock):
        nodeid = nodeid+1
        line = meshdata.readline()
        split = line.split()
        nodeCoord[0] = np.float32(split[0])
        nodeCoord[1] = np.float32(split[1])
        nodeCoord[2] = np.float32(split[2])
        nodeTable[nodeid-1,:] = nodeCoord[:]
        bflag, boun, disp, forc = bcs(nodeCoord)
        vboun = vboun + '{} {} {} {}\n'.format(boun[0], boun[1], boun[2], boun[3])
        vdisp = vdisp + '{} {} {} {}\n'.format(disp[0], disp[1], disp[2], disp[3])
        vforc = vforc + '{} {} {} {}\n'.format(forc[0], forc[1], forc[2], forc[3])
        vdispl = vdispl + '{} {} {}\n'.format(disp[0], disp[1], disp[2])
        print(''.join('{0:12.3f}'.format(coord) for coord in nodeCoord), file=meshchck)
        if bflag==1:
            print(fno.format(nodeid, 0) \
                      + ''.join('{0:2d}'.format(ibc) for ibc in boun), file=iboun)
            print(fno.format(nodeid, 0) \
                      + ''.join('{0:12.3f}'.format(bc) for bc in disp), file=idisp)
            print(fno.format(nodeid, 0) \
                      + ''.join('{0:12.3f}'.format(bc) for bc in forc), file=iforc)
        print(fno.format(nodeid, 0) \
                  + ''.join('{0:12.3f}'.format(coord) for coord in nodeCoord), file=inode)
    line = meshdata.readline()
    if '$EndNodes' in line: break

# Total element number
while True:
    line = meshdata.readline()
    if '$Elements' in line:
        line = meshdata.readline()
        split = line.split()
        nelem = int(split[1])
        break

# Node map for periodic BC in XYZ direction
if periodicFlag==1:
    xmap, ymap, zmap = periodicNodeMap(nodeTable)
    pnode = np.unique(np.append(xmap[:,1], [ymap[:,1], zmap[:,1]]))
    pmap = np.zeros((pnode.shape[0],2), dtype=int)
    pmap[:,1] = pnode
    for i in range(pmap.shape[0]):
        pmap[i,0] = pmap[i,1]
        pmap[i,0] = applyNodeMap(pmap[i,0], xmap)
        pmap[i,0] = applyNodeMap(pmap[i,0], ymap)
        pmap[i,0] = applyNodeMap(pmap[i,0], zmap)

# print(xmap)
# print(ymap)
# print(zmap)
# print(pmap)

# Element connectivity
elemid = 0
nelem12 = 0
xel = len(str(nelem))
fel = '{0:<' + str(xel) + 'd} {1:2d} {2:2d}'
fno = '{0:' + str(xno+2) + 'd}'
vlmat = ''
while True:
    line = meshdata.readline()
    split = line.split()
    eltype = int(split[2])
    nblock = int(split[3])
    if eltype!=4:
        for i in range(nblock):
            line = meshdata.readline()
        nelem12 = nelem12 + nblock
    else:
        nelem = nelem - nelem12
        print('\nCELLS {0:8d} {1:9d}'.format(nelem, nelem*5), file=meshchck);
        print('Total number of elements = {0:<8d}'.format(nelem))
        while True:
            split = line.split()
            nblock = int(split[3])
            for i in range(nblock):
                elemid = elemid+1
                line = meshdata.readline()
                split = line.split()
                ixv[0] = int(split[1])
                ixv[1] = int(split[2])
                ixv[2] = int(split[3])
                ixv[3] = int(split[4])
                ix[:] = ixv[:]
                # Periodic node
                if periodicFlag==1:
                    for i in range(4):
                        ix[i] = applyNodeMap(ixv[i], pmap)
                elmat  = assignMat(elemid)
                vlmat = vlmat + '{}\n'.format(elmat)
                print('4' + ''.join('{0:8d}'.format(node) for node in (ixv-1)), file=meshchck)
                # print('4' + ''.join('{0:8d}'.format(node) for node in (ixv-1)), file=ielem_ori)
                print(fel.format(elemid, 0, 1) \
                          + ''.join(fno.format(node) for node in (ix)), file=ielem)
            line = meshdata.readline()
            if '$EndElements' in line: break
        break

# Cell type
print('\nCELL_TYPES {0:8d}'.format(nelem), file=meshchck);
for i in range(nelem):
    print('10', file=meshchck)

meshdata.close()
meshchck.close()
inode.close()
ielem.close()
iboun.close()
idisp.close()
iforc.close()

########################################################################
# Additional information on .vtk files
########################################################################

# Open file
meshchck = open('./Vmesh.vtk','a')

# Point data
print('\nPOINT_DATA {0:8d}'.format(nnode), file=meshchck);

# Dirichlet BC
print('\nSCALARS B float 4', file=meshchck);
print('LOOKUP_TABLE default', file=meshchck);
meshchck.write(vboun)

# Dirichlet BC
print('\nSCALARS D float 4', file=meshchck);
print('LOOKUP_TABLE default', file=meshchck);
meshchck.write(vdisp)

# Applied displacement
print('\nVECTORS Disp float', file=meshchck);
meshchck.write(vdispl)

# Neumann BC
print('\nSCALARS F float 4', file=meshchck);
print('LOOKUP_TABLE default', file=meshchck);
meshchck.write(vforc)

# Node number
print('\nSCALARS NodeNum float 1', file=meshchck);
print('LOOKUP_TABLE default', file=meshchck);
for i in range (nnode):
    meshchck.write(f"{i+1}\n")

# Cell data
print('\nCELL_DATA {0:8d}'.format(nelem), file=meshchck);

# Material id
print('\nSCALARS Mat float', file=meshchck);
print('LOOKUP_TABLE default', file=meshchck);
meshchck.write(vlmat)

# Element number
print('\nSCALARS ElNum float', file=meshchck);
print('LOOKUP_TABLE default', file=meshchck);
for i in range (nelem):
    meshchck.write(f"{i+1}\n")

meshchck.close()

########################################################################
# Print elapsed time
########################################################################

toc = time.time()
print('Elapsed time = {0:<12.3f}'.format(toc-tic))
