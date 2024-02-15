SetFactory("OpenCASCADE");

//==========================================================
// Input box
//==========================================================

// Full wall length width, and height
wl = 1000;
ww = 200;
// wh = 1000;
wh = 500;
// wh = 25;

// Layer width and height
lw = 50;
lh = 25;

// Number of infill pattern
// inum  =  5;
// inum  = 8;
inum  = 10;

// Mesh size
lc   = 20;
nel1 = 5;
nel2 = 4;
nel3 = 4;
nel4 = 5;

//==========================================================
// Compute geometry
//==========================================================

// Total number of layers
lyr = wh/lh;

// Infill spacing
// iw = wl/inum;
iw = (wl+lw)/inum;

// Infill base and height
ibase = lw/2*Sqrt(3);
iheig = lw/2;

Printf("lyr   =  %g", wh);
Printf("lyr   =  %g", lyr);
Printf("iw    =  %g", iw);
Printf("ibase =  %g", ibase);
Printf("iheig =  %g", iheig);

//==========================================================
// Create one patern
//==========================================================

c = lw/2;
d = iw-lw;
e = iw;

Point(1) = {    0,   -c,    0,    lc};
Point(2) = {    d,   -c,    0,    lc};
Point(3) = {    d,    c,    0,    lc};
Point(4) = {    0,    c,    0,    lc};
Point(5) = {    e,   -c,    0,    lc};
Point(6) = {    e,    c,    0,    lc};

c1 = ww - lw/2;
c2 = ww + lw/2;

Point(11) = {    0,   c1,    0,    lc};
Point(12) = {    d,   c1,    0,    lc};
Point(13) = {    d,   c2,    0,    lc};
Point(14) = {    0,   c2,    0,    lc};
Point(15) = {    e,   c1,    0,    lc};
Point(16) = {    e,   c2,    0,    lc};

Line(1) = {1, 2};
Line(2) = {2, 5};
Line(3) = {1, 4};
Line(4) = {4, 3};
Line(5) = {3, 6};
Line(6) = {2, 3};
Line(7) = {5, 6};
Line(8) = {6, 15};
Line(9) = {3, 12};
Line(10) = {12, 13};
Line(11) = {15, 16};
Line(12) = {11, 12};
Line(13) = {12, 15};
Line(14) = {11, 14};
Line(15) = {14, 13};
Line(16) = {13, 16};

Curve Loop(1) = {1, 6, -4, -3};
Curve Loop(2) = {2, 7, -5, -6};
Curve Loop(3) = {5, 8, -13, -9};
Curve Loop(4) = {13, 11, -16, -10};
Curve Loop(5) = {10, -15, -14, 12};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};

//==========================================================
// Close wall's end
//==========================================================

a = ibase;
b = iheig;

h = lw;
f = c1 - b;

Point(21) = {   -h,   -c,    0,    lc};
Point(22) = {   -h,    c,    0,    lc};
Point(23) = {   -h,   c1,    0,    lc};
Point(25) = {   -h,   c2,    0,    lc};

h = wl;
f = c + b;

// Point(26) = {    h,   -c,    0,    lc};
// Point(27) = {    h,    c,    0,    lc};
// Point(28) = {    h,   c1,    0,    lc};
// Point(30) = {    h,   c2,    0,    lc};

h = wl + lw;

// Point(31) = {    h,   -c,    0,    lc};
// Point(32) = {    h,    c,    0,    lc};
// Point(33) = {    h,   c1,    0,    lc};
// Point(35) = {    h,   c2,    0,    lc};

Line(17) = {21, 1};
Line(18) = {4, 22};
Line(19) = {22, 21};
Line(20) = {22, 23};
Line(21) = {23, 11};
Line(22) = {11, 4};
Line(23) = {23, 25};
Line(24) = {25, 14};

// Line(25) = {26, 31};
// Line(26) = {31, 32};
// Line(27) = {32, 27};
// Line(28) = {27, 26};
// Line(29) = {27, 28};
// Line(30) = {28, 33};
// Line(31) = {33, 32};
// Line(32) = {33, 35};
// Line(33) = {35, 30};
// Line(34) = {30, 28};

Curve Loop(6) = {17, 3, 18, 19};
Curve Loop(7) = {18, 20, 21, 22};
Curve Loop(8) = {21, 14, -24, -23};

// Curve Loop(9) = {25, 26, 27, 28};
// Curve Loop(10) = {27, 29, 30, 31};
// Curve Loop(11) = {30, 32, 33, 34};

Plane Surface(6) = {6};
Plane Surface(7) = {7};
Plane Surface(8) = {8};

// Plane Surface(9) = {9};
// Plane Surface(10) = {10};
// Plane Surface(11) = {11};

//==========================================================
// Copy the pattern
//==========================================================

// Symmetry: provide the coefficients of the equation defining the symmetry plane Ax + By + Cz + D = 0

// Copy this until the wall is long enought
Translate {  iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {2*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {3*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {4*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {5*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {6*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {7*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {8*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }
Translate {9*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; } }

Coherence;
Recombine Surface "*";
Mesh.RecombineAll = 1;
s[] = Surface "*";
Extrude {0, 0, wh} {  Surface{ s[] }  ; Layers{lyr}; Recombine;}
