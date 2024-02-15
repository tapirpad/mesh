SetFactory("OpenCASCADE");

r4 = 5;
r1 = 4.0;
r3 = 2.5;
r2 = 75;
h  = 50;

lc1  = 0.2;
lc2  = 0.4;
lc4  = 0.4;
lc3  = 11;
nel0 = 9;
nel1 = 12;
nel2 = 13;

Point(1) = {r1     , 0     , 0,    lc2};
Point(2) = {0      , r1    , 0,    lc2};
Point(3) = {r2     , 0     , 0,    lc3};
Point(4) = {0      , r2    , 0,    lc3};
Point(5) = {0      , 0     , 0,    lc1};

Point(6) = {r3     , 0     , 0,    lc2};
Point(7) = {0      , r3    , 0,    lc2};
Point(8) = {r4     , 0     , 0,    lc4};
Point(9) = {0      , r4    , 0,    lc4};

Circle(1) = {2, 5, 1};
Circle(2) = {4, 5, 3};
Circle(3) = {6, 5, 7};
Circle(4) = {8, 5, 9};

Line(5) = {5, 6};
Line(6) = {6, 1};
Line(7) = {1, 8};
Line(8) = {8, 3};
Line(9) = {5, 7};
Line(10) = {7, 2};
Line(11) = {2, 9};
Line(12) = {9, 4};

Curve Loop(1) = {9, -3, -5};
Curve Loop(2) = {3, 10, 1, -6};
Curve Loop(3) = {1, 7, 4, -11};
Curve Loop(4) = {8, -2, -12, -4};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};

Coherence;
Recombine Surface "*";

Transfinite Curve {6,10} = nel1 Using Progression 1;
Transfinite Curve {7,11} = nel0 Using Progression 1;

Transfinite Curve {1,3,4} = nel2 Using Progression 1;
Transfinite Surface {2,3};

Extrude {0, 0, h} {
  Surface{1,2,3,4};
  Layers{
    {
      2,
      4,
      6,
      10,
      20
    },
    {
      0.2,
      0.4,
      0.6,
      0.8,
      1.0
    }
  };
  Recombine;
}

// Extrude {0, 0, h} {
//   Surface{1,2,3,4};
//   Layers{
//     {
//       1,
//       2,
//       4,
//       8,
//       8,
//       7,
//       10
//     },
//     {
//       0.2,
//       0.4,
//       0.6,
//       0.85,
//       0.95,
//       0.99,
//       1.0
//     }
//   };
//   Recombine;
// }



