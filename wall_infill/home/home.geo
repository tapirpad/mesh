SetFactory("OpenCASCADE");

th = 450;
h = 3000;
r = 2500;
lf = 2100;

lc = 300;

r1 = r-th/2;
r2 = r+th/2;
lyr = h/50;

nel1 = 11;
nel2 = 13;
nel3 = 9;

Point(1) = {-lf       ,   0   , 0, lc};
Point(2) = {-lf       ,  r1   , 0, lc};
Point(3) = {-r1-lf    ,   0   , 0, lc};
Point(4) = {-lf       , -r1   , 0, lc};
Point(5) = {-lf       ,  r2   , 0, lc};
Point(6) = {-r2-lf    ,   0   , 0, lc};
Point(7) = {-lf       , -r2   , 0, lc};

Point(12) = {lf       ,  r1   , 0, lc};
Point(13) = {r1+lf    ,   0   , 0, lc};
Point(14) = {lf       , -r1   , 0, lc};
Point(15) = {lf       ,  r2   , 0, lc};
Point(16) = {r2+lf    ,   0   , 0, lc};
Point(17) = {lf       , -r2   , 0, lc};
Point(18) = {lf       ,   0   , 0, lc};

Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {5, 1, 6};
Circle(4) = {6, 1, 7};

Circle(5) = {12, 18, 13};
Circle(6) = {13, 18, 14};
Circle(7) = {15, 18, 16};
Circle(8) = {16, 18, 17};

Line(9)  = {2, 12};
Line(10) = {5, 15};
Line(11) = {4, 14};
Line(12) = {7, 17};

Line(13) = {2, 5};
Line(14) = {3, 6};
Line(15) = {4, 7};
Line(16) = {12, 15};
Line(17) = {13, 16};
Line(18) = {14, 17};

Curve Loop(1) = {13, 3, -14, -1};
Curve Loop(2) = {14, 4, -15, -2};
Curve Loop(3) = {15, 12, -18, -11};
Curve Loop(4) = {18, -8, -17, 6};
Curve Loop(5) = {17, -7, -16, 5};
Curve Loop(6) = {16, -10, -13, 9};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};

Extrude {0, 0, h} {  Surface{1}; Layers{lyr}; Recombine;}
Extrude {0, 0, h} {  Surface{2}; Layers{lyr}; Recombine;}
Extrude {0, 0, h} {  Surface{3}; Layers{lyr}; Recombine;}
Extrude {0, 0, h} {  Surface{4}; Layers{lyr}; Recombine;}
Extrude {0, 0, h} {  Surface{5}; Layers{lyr}; Recombine;}
Extrude {0, 0, h} {  Surface{6}; Layers{lyr}; Recombine;}

Coherence;
Recombine Surface "*";

Transfinite Curve {14,19,15,20,6,11,7,12} = nel1 Using Progression 1;
Transfinite Curve {35,30,31,36,43,44,38,39} = nel1 Using Progression 1;
Transfinite Curve {22,23,27,28,45,46,47,48} = nel2 Using Progression 1;
Transfinite Curve {9,10,17,18,3,4,25,26,41,42,33,34} = nel3 Using Progression 1;

Transfinite Surface "*";

