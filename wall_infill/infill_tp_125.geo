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
inum  = 8;

// Infill gap between strut
ig = lw/2;

// Mesh size
lc   = 15;
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
iw = wl/inum;

// Infill base and height
e = ww-lw;
d = (lw*iw - 2*ig*lw)/e;
c = (d^2) + (lw^2);
b = -2*d*lw/e;
a = (lw^2)/(e^2) - 1;

ibase = (-b - Sqrt((b^2)-4*a*c)) / (2*a);

Printf("lyr   =  %g", wh);
Printf("lyr   =  %g", lyr);
Printf("iw    =  %g", iw);
Printf("ig    =  %g", ig);
Printf("ibase =  %g", ibase);

//==========================================================
// Create one patern
//==========================================================

a = ibase;
c = lw/2;
d = iw-ig-a;
e = iw-ig;
f = iw;

Point(1) = {    0,   -c,    0,    lc};
Point(2) = {    d,   -c,    0,    lc};
Point(3) = {    e,   -c,    0,    lc};
Point(4) = {    f,   -c,    0,    lc};
Point(5) = {    0,    c,    0,    lc};
Point(6) = {    d,    c,    0,    lc};
Point(7) = {    e,    c,    0,    lc};
Point(8) = {    f,    c,    0,    lc};

c1 = ww - lw/2;
c2 = ww + lw/2;
d = ig;
e = ig+a;
f = iw;

Point(11) = {    0,    c1,    0,    lc};
Point(12) = {    d,    c1,    0,    lc};
Point(13) = {    e,    c1,    0,    lc};
Point(14) = {    f,    c1,    0,    lc};
Point(15) = {    0,    c2,    0,    lc};
Point(16) = {    d,    c2,    0,    lc};
Point(17) = {    e,    c2,    0,    lc};
Point(18) = {    f,    c2,    0,    lc};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {5, 6};
Line(5) = {6, 7};
Line(6) = {7, 8};
Line(7) = {1, 5};
Line(8) = {2, 6};
Line(9) = {3, 7};
Line(10) = {4, 8};
Line(11) = {11, 12};
Line(12) = {12, 13};
Line(13) = {13, 14};
Line(14) = {14, 18};
Line(15) = {15, 16};
Line(16) = {16, 17};
Line(17) = {17, 18};
Line(18) = {11, 15};
Line(19) = {12, 16};
Line(20) = {13, 17};
Line(21) = {6, 12};
Line(22) = {7, 13};

Curve Loop(1) = {7, 4, -8, -1};
Curve Loop(2) = {8, 5, -9, -2};
Curve Loop(3) = {9, 6, -10, -3};
Curve Loop(4) = {5, 22, -12, -21};
Curve Loop(5) = {11, 19, -15, -18};
Curve Loop(6) = {12, 20, -16, -19};
Curve Loop(7) = {13, 14, -17, -20};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};

//==========================================================
// Close wall's end
//==========================================================

a = ibase;
h = lw;
f = c1 - b;

Point(21) = {   -h,   -c,    0,    lc};
Point(22) = {   -h,    c,    0,    lc};
Point(23) = {   -h,   c1,    0,    lc};
Point(25) = {   -h,   c2,    0,    lc};

h = wl;

Point(26) = {    h,   -c,    0,    lc};
Point(27) = {    h,    c,    0,    lc};
Point(28) = {    h,   c1,    0,    lc};
Point(29) = {    h,   c2,    0,    lc};

h = wl+lw;

Point(31) = {    h,   -c,    0,    lc};
Point(32) = {    h,    c,    0,    lc};
Point(33) = {    h,   c1,    0,    lc};
Point(35) = {    h,   c2,    0,    lc};

Line(23) = {1, 21};
Line(24) = {21, 22};
Line(25) = {22, 5};
Line(26) = {5, 11};
Line(27) = {11, 23};
Line(28) = {23, 22};
Line(29) = {23, 25};
Line(30) = {25, 15};
Line(31) = {26, 31};
Line(32) = {31, 32};
Line(33) = {32, 27};
Line(34) = {27, 26};
Line(35) = {27, 28};
Line(36) = {28, 29};
Line(37) = {29, 35};
Line(38) = {35, 33};
Line(39) = {33, 32};
Line(40) = {28, 33};

Curve Loop(8) = {23, 24, 25, -7};
Curve Loop(9) = {25, 26, 27, 28};
Curve Loop(10) = {27, 29, 30, -18};
Curve Loop(11) = {31, 32, 33, 34};
Curve Loop(12) = {34, 31, 32, 33};
Curve Loop(13) = {33, 35, 40, 39};
Curve Loop(14) = {40, -38, -37, -36};

Plane Surface(8) = {8};
Plane Surface(9) = {9};
Plane Surface(10) = {10};
Plane Surface(11) = {12};
Plane Surface(12) = {13};
Plane Surface(13) = {14};

//==========================================================
// Copy the pattern
//==========================================================


// Symmetry: provide the coefficients of the equation defining the symmetry plane Ax + By + Cz + D = 0

// Copy this until the wall is long enought
Symmetry {1, 0, 0, -iw} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Surface{6}; Surface{7}; } }

// Translate the first part
Translate {2*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Surface{6}; Surface{7}; } }
Translate {4*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Surface{6}; Surface{7}; } }
Translate {6*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Surface{6}; Surface{7}; } }
// Translate {8*iw, 0, 0} { Duplicata { Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Surface{6}; Surface{7}; } }

// Translate the second part
Translate {2*iw, 0, 0} { Duplicata { Surface{14}; Surface{15}; Surface{16}; Surface{17}; Surface{18}; Surface{19}; Surface{20}; } }
Translate {4*iw, 0, 0} { Duplicata { Surface{14}; Surface{15}; Surface{16}; Surface{17}; Surface{18}; Surface{19}; Surface{20}; } }
Translate {6*iw, 0, 0} { Duplicata { Surface{14}; Surface{15}; Surface{16}; Surface{17}; Surface{18}; Surface{19}; Surface{20}; } }

Coherence;
Recombine Surface "*";
Mesh.RecombineAll = 1;
s[] = Surface "*";
Extrude {0, 0, wh} {  Surface{ s[] }  ; Layers{lyr}; Recombine;}
