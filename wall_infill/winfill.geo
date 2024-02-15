SetFactory("OpenCASCADE");

//==========================================================
// Input box
//==========================================================

// Full wall length width, and height
wl = 1000;
ww = 200;
// wh = 1000;
wh = 500;

// Layer width and height
lw = 50;
lh = 25;

// Number of infill pattern
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
iw = wl/inum;

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

a = ibase;
b = iheig;
c = lw/2;
d = iw-a;
e = iw;
f = c+b;
g = iw-a;

Point(1) = {    0,   -c,    0,    lc};
Point(2) = {    d,   -c,    0,    lc};
Point(3) = {    d,    c,    0,    lc};
Point(4) = {    0,    c,    0,    lc};
Point(5) = {    e,   -c,    0,    lc};
Point(6) = {    e,    c,    0,    lc};
Point(7) = {    e,    f,    0,    lc};

a = ibase;
c1 = ww - lw/2;
c2 = ww + lw/2;
f = c1 - b;
g = iw-a;

Point(11) = {    0,   c1,    0,    lc};
Point(12) = {    a,   c1,    0,    lc};
Point(13) = {    a,   c2,    0,    lc};
Point(14) = {    0,   c2,    0,    lc};
Point(15) = {    e,   c1,    0,    lc};
Point(16) = {    e,   c2,    0,    lc};
Point(17) = {    0,    f,    0,    lc};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
Line(5) = {2, 5};
Line(6) = {5, 6};
Line(7) = {6, 3};
Line(8) = {11, 12};
Line(9) = {12, 13};
Line(10) = {13, 14};
Line(11) = {14, 11};
Line(12) = {12, 15};
Line(13) = {15, 16};
Line(14) = {16, 13};
Line(15) = {11, 17};
Line(16) = {17, 3};
Line(17) = {6, 7};
Line(18) = {7, 12};

Curve Loop(1) = {4, 1, 2, 3};
Curve Loop(2) = {2, -7, -6, -5};
Curve Loop(3) = {11, 8, 9, 10};
Curve Loop(4) = {14, -9, 12, 13};
Curve Loop(5) = {8, -18, -17, 7, -16, -15};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};

//==========================================================
// Close wall's end
//==========================================================

h = lw;
f = c1 - b;

Point(21) = {   -h,   -c,    0,    lc};
Point(22) = {   -h,    c,    0,    lc};
Point(23) = {   -h,   c1,    0,    lc};
Point(24) = {   -h,    f,    0,    lc};
Point(25) = {   -h,   c2,    0,    lc};

h = wl;
f = c + b;

Point(26) = {    h,   -c,    0,    lc};
Point(27) = {    h,    c,    0,    lc};
Point(28) = {    h,   c1,    0,    lc};
Point(29) = {    h,    f,    0,    lc};
Point(30) = {    h,   c2,    0,    lc};

h = wl + lw;

Point(31) = {    h,   -c,    0,    lc};
Point(32) = {    h,    c,    0,    lc};
Point(33) = {    h,   c1,    0,    lc};
Point(34) = {    h,    f,    0,    lc};
Point(35) = {    h,   c2,    0,    lc};

Line(195) = {21, 1};
Line(196) = {4, 22};
Line(197) = {22, 21};
Line(198) = {24, 17};
Line(199) = {11, 23};
Line(200) = {23, 24};
Line(201) = {14, 25};
Line(202) = {25, 23};
Line(203) = {4, 17};
Line(204) = {24, 22};

Line(205) = {26, 31};
Line(206) = {31, 32};
Line(207) = {32, 27};
Line(208) = {27, 26};
Line(209) = {29, 27};
Line(210) = {32, 34};
Line(211) = {34, 29};
Line(212) = {34, 33};
Line(213) = {33, 28};
Line(214) = {28, 29};
Line(215) = {33, 35};
Line(216) = {35, 30};
Line(217) = {30, 28};

Curve Loop(6) = {195, -4, 196, 197};
Curve Loop(7) = {196, -204, 198, -203};
Curve Loop(8) = {200, 198, -15, 199};
Curve Loop(9) = {202, -199, -11, 201};
Curve Loop(10) = {205, 206, 207, 208};
Curve Loop(11) = {207, -209, -211, -210};
Curve Loop(12) = {211, -214, -213, -212};
Curve Loop(13) = {213, -217, -216, -215};

Plane Surface(6) = {6};
Plane Surface(7) = {7};
Plane Surface(8) = {8};
Plane Surface(9) = {9};
Plane Surface(10) = {10};
Plane Surface(11) = {11};
Plane Surface(12) = {12};
Plane Surface(13) = {13};



//==========================================================
// Copy the pattern
//==========================================================

// Symmetry: provide the coefficients of the equation defining the symmetry plane Ax + By + Cz + D = 0

// Copy this until the wall is long enought
Symmetry {1, 0, 0, -iw} { Duplicata { Surface{3}; Surface{4}; Surface{5}; Surface{2}; Surface{1}; } }
Symmetry {1, 0, 0, -2*iw} { Duplicata { Surface{3}; Surface{4}; Surface{15}; Surface{14}; Surface{16}; Surface{5}; Surface{1}; Surface{2}; Surface{17}; Surface{18}; } }
Symmetry {1, 0, 0, -4*iw} { Duplicata { Surface{3}; Surface{4}; Surface{5}; Surface{1}; Surface{2}; Surface{17}; Surface{18}; Surface{16}; Surface{15}; Surface{14}; Surface{22}; Surface{23}; Surface{28}; Surface{27}; Surface{26}; Surface{24}; Surface{20}; Surface{21}; Surface{19}; Surface{30}; Surface{29}; Surface{31}; Surface{25}; Surface{32}; Surface{33}; } }

// Last part
Symmetry {1, 0, 0, -8*iw} { Duplicata { Surface{38}; Surface{36}; Surface{35}; Surface{34}; Surface{33}; Surface{32}; Surface{31}; Surface{29}; Surface{30}; Surface{37}; } }

Coherence;
Recombine Surface "*";
Mesh.RecombineAll = 1;

s[] = Surface "*";
Extrude {0, 0, wh} {  Surface{ s[] }  ; Layers{lyr}; Recombine;}
