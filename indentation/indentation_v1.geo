SetFactory("OpenCASCADE");

r1 = 5;
r2 = 75;
r3 = r1 - 0.10*r1;
r4 = r1 + 0.10*r1;
h  = 50;

lc1  = 0.5;
lc2  = 0.1;
lc3  = 10;

nel1 = 11;
nel2 = 101;

Point(1) = {r1     , 0     , 0,    lc2};
Point(2) = {0      , r1    , 0,    lc2};
Point(3) = {r2     , 0     , 0,    lc3};
Point(4) = {0      , r2    , 0,    lc3};
Point(5) = {0      , 0     , 0,    lc1};

Circle(1) = {2, 5, 1};
Circle(2) = {4, 5, 3};

Line(3) = {5, 2};
Line(4) = {5, 1};
Line(5) = {2, 4};
Line(6) = {3, 1};

Curve Loop(1) = {6, -1, 5, 2};
Curve Loop(2) = {4, -1, -3};

Plane Surface(1) = {1};
Plane Surface(2) = {2};

Extrude {0, 0, h} {
  Surface{1};
  Layers{
    {
      2,
      4,
      8,
      12,
      15,
      10
    },
    {
      0.2,
      0.4,
      0.6,
      0.8,
      0.99,
      1.0
    }
  };
  Recombine;
}
Extrude {0, 0, h} {
  Surface{2};
  Layers{
    {
      2,
      4,
      8,
      12,
      15,
      10
    },
    {
      0.2,
      0.4,
      0.6,
      0.8,
      0.99,
      1.0
    }
  };
  Recombine;
}

// Extrude {0, 0, h} {
//   Surface{1};
//   Layers{
//     {
//       3,
//       6,
//       9,
//       12,
//       15
//     },
//     {
//       0.2,
//       0.4,
//       0.6,
//       0.8,
//       1.0
//     }
//   };
//   Recombine;
// }
// Extrude {0, 0, h} {
//   Surface{2};
//   Layers{
//     {
//       3,
//       6,
//       9,
//       12,
//       15
//     },
//     {
//       0.2,
//       0.4,
//       0.6,
//       0.8,
//       1.0
//     }
//   };
//   Recombine;
// }

Coherence;
Recombine Surface "*";

// Transfinite Curve {6,7}   = nel1 Using Progression 1;
// Transfinite Curve {11,12} = nel2 Using Progression 1;
// Transfinite Surface "*";

