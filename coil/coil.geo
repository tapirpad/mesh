// SetFactory("OpenCASCADE");

SetFactory("Built-in");

Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 1;

rc = 5;
hc = 5;
rf = 1;

ml = 0.75;
nel1 = 41;

r1 = rc-rf;
r2 = rc+rf;

Point(0) = {-rc,   0,      rf,      ml};
Point(1) = {-rc,   0,       0,      ml};
Point(2) = {-r1,   0,      rf,      ml};
Point(3) = {-rc,   0,    2*rf,      ml};
Point(4) = {-r2,   0,      rf,      ml};

Circle(1) = {1, 0, 4};
Circle(2) = {4, 0, 3};
Circle(3) = {3, 0, 2};
Circle(4) = {2, 0, 1};

Curve Loop(1) = {3, 4, 1, 2};
Plane Surface(1) = {1};

Extrude {{0, 0, 1}, {0, 0, 1}, Pi} { Surface{1}; Layers{nel1/2}; Recombine; }

Extrude {{0, 0, hc}, {0, 0, 1}, {0, 0, 1}, 2*Pi} { Surface{26}; Layers{nel1}; Recombine; }
Extrude {{0, 0, hc}, {0, 0, 1}, {0, 0, 1}, 2*Pi} { Surface{48}; Layers{nel1}; Recombine; }
Extrude {{0, 0, hc}, {0, 0, 1}, {0, 0, 1}, 2*Pi} { Surface{70}; Layers{nel1}; Recombine; }
Extrude {{0, 0, hc}, {0, 0, 1}, {0, 0, 1}, 2*Pi} { Surface{92}; Layers{nel1}; Recombine; }
Extrude {{0, 0, hc}, {0, 0, 1}, {0, 0, 1}, 2*Pi} { Surface{114}; Layers{nel1}; Recombine; }


Recombine Surface "*";

