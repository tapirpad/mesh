SetFactory("OpenCASCADE");

//==========================================================
// Input box
//==========================================================

// Layer dimension
lw = 50; // layer width
lh = 25; // layer height

// Wall
wt = 200; // wall thickness
bl = 200; // brace length

// Overall dimension (centerline of wall)
h  = 1000; // total height
r  = 2500; // radius of curved ends
lf = 2000; // length of side wall

// Mesh size
lc   = 25; // pointwise size
nel1 = 5;
nel2 = 4;
nel3 = 4;
nel4 = 5;

lyr = h/lh;

Printf("sqrt(2) =  %g", Sqrt(2));
Printf("Circumference =  %g", 2625*Pi);
Printf("segment =  %g", 2625*Pi/400);
Printf("angle segment =  %g", 180/20);


//==========================================================
// Inner wall
//==========================================================

r1  = r-lw/2-wt/2;
r2  = r+lw/2-wt/2;

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

//==========================================================
// Outer wall
//==========================================================

r1  = r-lw/2+wt/2;
r2  = r+lw/2+wt/2;

Point(21) = {-lf       ,   0   , 0, lc};
Point(22) = {-lf       ,  r1   , 0, lc};
Point(23) = {-r1-lf    ,   0   , 0, lc};
Point(24) = {-lf       , -r1   , 0, lc};
Point(25) = {-lf       ,  r2   , 0, lc};
Point(26) = {-r2-lf    ,   0   , 0, lc};
Point(27) = {-lf       , -r2   , 0, lc};

Point(32) = {lf       ,  r1   , 0, lc};
Point(33) = {r1+lf    ,   0   , 0, lc};
Point(34) = {lf       , -r1   , 0, lc};
Point(35) = {lf       ,  r2   , 0, lc};
Point(36) = {r2+lf    ,   0   , 0, lc};
Point(37) = {lf       , -r2   , 0, lc};
Point(38) = {lf       ,   0   , 0, lc};

Circle(21) = {22, 21, 23};
Circle(22) = {23, 21, 24};
Circle(23) = {25, 21, 26};
Circle(24) = {26, 21, 27};

Circle(25) = {32, 38, 33};
Circle(26) = {33, 38, 34};
Circle(27) = {35, 38, 36};
Circle(28) = {36, 38, 37};

Line(29) = {22, 32};
Line(30) = {25, 35};
Line(31) = {24, 34};
Line(32) = {27, 37};

Line(33) = {22, 25};
Line(34) = {23, 26};
Line(35) = {24, 27};
Line(36) = {32, 35};
Line(37) = {33, 36};
Line(38) = {34, 37};

Curve Loop(11) = {33,  23, -34, -21};
Curve Loop(12) = {34,  24, -35, -22};
Curve Loop(13) = {35,  32, -38, -31};
Curve Loop(14) = {38, -28, -37,  26};
Curve Loop(15) = {37, -27, -36,  25};
Curve Loop(16) = {36, -30, -33,  29};

Plane Surface(11) = {11};
Plane Surface(12) = {12};
Plane Surface(13) = {13};
Plane Surface(14) = {14};
Plane Surface(15) = {15};
Plane Surface(16) = {16};

//==========================================================
// Infill: top side
//==========================================================

r1  = r-wt/2;

Point(100) = {-lf+0*bl      ,  r1   , 0, lc};
Point(101) = {-lf+2*bl      ,  r1   , 0, lc};
Point(102) = {-lf+4*bl      ,  r1   , 0, lc};
Point(103) = {-lf+6*bl      ,  r1   , 0, lc};
Point(104) = {-lf+8*bl      ,  r1   , 0, lc};
Point(105) = {-lf+10*bl      ,  r1   , 0, lc};
Point(106) = {-lf+12*bl      ,  r1   , 0, lc};
Point(107) = {-lf+14*bl      ,  r1   , 0, lc};
Point(108) = {-lf+16*bl      ,  r1   , 0, lc};
Point(109) = {-lf+18*bl      ,  r1   , 0, lc};
Point(110) = {-lf+20*bl      ,  r1   , 0, lc};

Translate {0, lw*Sqrt(2), 0} { Point{100}; }
Translate {0, lw*Sqrt(2), 0} { Point{101}; }
Translate {0, lw*Sqrt(2), 0} { Point{102}; }
Translate {0, lw*Sqrt(2), 0} { Point{103}; }
Translate {0, lw*Sqrt(2), 0} { Point{104}; }
Translate {0, lw*Sqrt(2), 0} { Point{105}; }
Translate {0, lw*Sqrt(2), 0} { Point{106}; }
Translate {0, lw*Sqrt(2), 0} { Point{107}; }
Translate {0, lw*Sqrt(2), 0} { Point{108}; }
Translate {0, lw*Sqrt(2), 0} { Point{109}; }
Translate {0, lw*Sqrt(2), 0} { Point{110}; }

Point(120) = {-lf+0*bl      ,  r1   , 0, lc};
Point(121) = {-lf+2*bl      ,  r1   , 0, lc};
Point(122) = {-lf+4*bl      ,  r1   , 0, lc};
Point(123) = {-lf+6*bl      ,  r1   , 0, lc};
Point(124) = {-lf+8*bl      ,  r1   , 0, lc};
Point(125) = {-lf+10*bl      ,  r1   , 0, lc};
Point(126) = {-lf+12*bl      ,  r1   , 0, lc};
Point(127) = {-lf+14*bl      ,  r1   , 0, lc};
Point(128) = {-lf+16*bl      ,  r1   , 0, lc};
Point(129) = {-lf+18*bl      ,  r1   , 0, lc};
Point(130) = {-lf+20*bl      ,  r1   , 0, lc};

r1  = r+wt/2;

Point(200) = {-lf+1*bl      ,  r1   , 0, lc};
Point(201) = {-lf+3*bl      ,  r1   , 0, lc};
Point(202) = {-lf+5*bl      ,  r1   , 0, lc};
Point(203) = {-lf+7*bl      ,  r1   , 0, lc};
Point(204) = {-lf+9*bl      ,  r1   , 0, lc};
Point(205) = {-lf+11*bl      ,  r1   , 0, lc};
Point(206) = {-lf+13*bl      ,  r1   , 0, lc};
Point(207) = {-lf+15*bl      ,  r1   , 0, lc};
Point(208) = {-lf+17*bl      ,  r1   , 0, lc};
Point(209) = {-lf+19*bl      ,  r1   , 0, lc};

Point(220) = {-lf+1*bl      ,  r1   , 0, lc};
Point(221) = {-lf+3*bl      ,  r1   , 0, lc};
Point(222) = {-lf+5*bl      ,  r1   , 0, lc};
Point(223) = {-lf+7*bl      ,  r1   , 0, lc};
Point(224) = {-lf+9*bl      ,  r1   , 0, lc};
Point(225) = {-lf+11*bl      ,  r1   , 0, lc};
Point(226) = {-lf+13*bl      ,  r1   , 0, lc};
Point(227) = {-lf+15*bl      ,  r1   , 0, lc};
Point(228) = {-lf+17*bl      ,  r1   , 0, lc};
Point(229) = {-lf+19*bl      ,  r1   , 0, lc};

Translate {0, -lw*Sqrt(2), 0} { Point{220}; }
Translate {0, -lw*Sqrt(2), 0} { Point{221}; }
Translate {0, -lw*Sqrt(2), 0} { Point{222}; }
Translate {0, -lw*Sqrt(2), 0} { Point{223}; }
Translate {0, -lw*Sqrt(2), 0} { Point{224}; }
Translate {0, -lw*Sqrt(2), 0} { Point{225}; }
Translate {0, -lw*Sqrt(2), 0} { Point{226}; }
Translate {0, -lw*Sqrt(2), 0} { Point{227}; }
Translate {0, -lw*Sqrt(2), 0} { Point{228}; }
Translate {0, -lw*Sqrt(2), 0} { Point{229}; }

Line(100) = {100, 200};
Line(101) = {200, 101};
Line(102) = {101, 201};
Line(103) = {201, 102};
Line(104) = {102, 202};
Line(105) = {202, 103};
Line(106) = {103, 203};
Line(107) = {203, 104};
Line(108) = {104, 204};
Line(109) = {204, 105};
Line(110) = {105, 205};
Line(111) = {205, 106};
Line(112) = {106, 206};
Line(113) = {206, 107};
Line(114) = {107, 207};
Line(115) = {207, 108};
Line(116) = {108, 208};
Line(117) = {208, 109};
Line(118) = {109, 209};
Line(119) = {209, 110};
Line(120) = {120, 220};
Line(121) = {220, 121};
Line(122) = {121, 221};
Line(123) = {221, 122};
Line(124) = {122, 222};
Line(125) = {222, 123};
Line(126) = {123, 223};
Line(127) = {223, 124};
Line(128) = {124, 224};
Line(129) = {224, 125};
Line(130) = {125, 225};
Line(131) = {225, 126};
Line(132) = {126, 226};
Line(133) = {226, 127};
Line(134) = {127, 227};
Line(135) = {227, 128};
Line(136) = {128, 228};
Line(137) = {228, 129};
Line(138) = {129, 229};
Line(139) = {229, 130};
Line(140) = {100, 120};
Line(141) = {101, 121};
Line(142) = {102, 122};
Line(143) = {103, 123};
Line(144) = {104, 124};
Line(145) = {105, 125};
Line(146) = {106, 126};
Line(147) = {107, 127};
Line(148) = {108, 128};
Line(149) = {109, 129};
Line(150) = {110, 130};
Line(151) = {200, 220};
Line(152) = {201, 221};
Line(153) = {202, 222};
Line(154) = {203, 223};
Line(155) = {204, 224};
Line(156) = {205, 225};
Line(157) = {206, 226};
Line(158) = {207, 227};
Line(159) = {208, 228};
Line(160) = {209, 229};

Curve Loop(101) = {100, 151, -120, -140};
Curve Loop(102) = {101, 141, -121, -151};
Curve Loop(103) = {102, 152, -122, -141};
Curve Loop(104) = {103, 142, -123, -152};
Curve Loop(105) = {104, 153, -124, -142};
Curve Loop(106) = {105, 143, -125, -153};
Curve Loop(107) = {106, 154, -126, -143};
Curve Loop(108) = {107, 144, -127, -154};
Curve Loop(109) = {108, 155, -128, -144};
Curve Loop(100) = {109, 145, -129, -155};
Curve Loop(111) = {110, 156, -130, -145};
Curve Loop(112) = {111, 146, -131, -156};
Curve Loop(113) = {112, 157, -132, -146};
Curve Loop(114) = {113, 147, -133, -157};
Curve Loop(115) = {114, 158, -134, -147};
Curve Loop(116) = {115, 148, -135, -158};
Curve Loop(117) = {116, 159, -136, -148};
Curve Loop(118) = {117, 149, -137, -159};
Curve Loop(119) = {118, 160, -138, -149};
Curve Loop(120) = {119, 150, -139, -160};

Plane Surface(101) = {101};
Plane Surface(102) = {102};
Plane Surface(103) = {103};
Plane Surface(104) = {104};
Plane Surface(105) = {105};
Plane Surface(106) = {106};
Plane Surface(107) = {107};
Plane Surface(108) = {108};
Plane Surface(109) = {109};
Plane Surface(110) = {100};
Plane Surface(111) = {111};
Plane Surface(112) = {112};
Plane Surface(113) = {113};
Plane Surface(114) = {114};
Plane Surface(115) = {115};
Plane Surface(116) = {116};
Plane Surface(117) = {117};
Plane Surface(118) = {118};
Plane Surface(119) = {119};
Plane Surface(120) = {120};

BooleanDifference{ Surface{101}; Delete; }{ Surface{1}; Surface{6}; Surface{16}; Surface{102}; }
BooleanDifference{ Surface{102}; Delete; }{ Surface{6}; Surface{16}; Surface{103}; }
BooleanDifference{ Surface{103}; Delete; }{ Surface{6}; Surface{16}; Surface{104}; }
BooleanDifference{ Surface{104}; Delete; }{ Surface{6}; Surface{16}; Surface{105}; }
BooleanDifference{ Surface{105}; Delete; }{ Surface{6}; Surface{16}; Surface{106}; }
BooleanDifference{ Surface{106}; Delete; }{ Surface{6}; Surface{16}; Surface{107}; }
BooleanDifference{ Surface{107}; Delete; }{ Surface{6}; Surface{16}; Surface{108}; }
BooleanDifference{ Surface{108}; Delete; }{ Surface{6}; Surface{16}; Surface{109}; }
BooleanDifference{ Surface{109}; Delete; }{ Surface{6}; Surface{16}; Surface{110}; }
BooleanDifference{ Surface{110}; Delete; }{ Surface{6}; Surface{16}; Surface{111}; }
BooleanDifference{ Surface{111}; Delete; }{ Surface{6}; Surface{16}; Surface{112}; }
BooleanDifference{ Surface{112}; Delete; }{ Surface{6}; Surface{16}; Surface{113}; }
BooleanDifference{ Surface{113}; Delete; }{ Surface{6}; Surface{16}; Surface{114}; }
BooleanDifference{ Surface{114}; Delete; }{ Surface{6}; Surface{16}; Surface{115}; }
BooleanDifference{ Surface{115}; Delete; }{ Surface{6}; Surface{16}; Surface{116}; }
BooleanDifference{ Surface{116}; Delete; }{ Surface{6}; Surface{16}; Surface{117}; }
BooleanDifference{ Surface{117}; Delete; }{ Surface{6}; Surface{16}; Surface{118}; }
BooleanDifference{ Surface{118}; Delete; }{ Surface{6}; Surface{16}; Surface{119}; }
BooleanDifference{ Surface{119}; Delete; }{ Surface{6}; Surface{16}; Surface{120}; }
BooleanDifference{ Surface{120}; Delete; }{ Surface{6}; Surface{16}; Surface{5}; }

Recursive Delete { Surface{6}; Surface{16}; }
Recursive Delete { Surface{3}; Surface{13}; }

Extrude {0,  lw, 0} { Curve{165}; }
Extrude {0,  lw, 0} { Curve{167}; }
Extrude {0,  lw, 0} { Curve{177}; }
Extrude {0,  lw, 0} { Curve{179}; }
Extrude {0,  lw, 0} { Curve{189}; }
Extrude {0,  lw, 0} { Curve{191}; }
Extrude {0,  lw, 0} { Curve{201}; }
Extrude {0,  lw, 0} { Curve{203}; }
Extrude {0,  lw, 0} { Curve{213}; }
Extrude {0,  lw, 0} { Curve{215}; }
Extrude {0,  lw, 0} { Curve{225}; }
Extrude {0,  lw, 0} { Curve{227}; }
Extrude {0,  lw, 0} { Curve{237}; }
Extrude {0,  lw, 0} { Curve{239}; }
Extrude {0,  lw, 0} { Curve{249}; }
Extrude {0,  lw, 0} { Curve{251}; }
Extrude {0,  lw, 0} { Curve{261}; }
Extrude {0,  lw, 0} { Curve{263}; }
Extrude {0,  lw, 0} { Curve{273}; }
Extrude {0,  lw, 0} { Curve{275}; }
Extrude {0, -lw, 0} { Curve{162}; }
Extrude {0, -lw, 0} { Curve{170}; }
Extrude {0, -lw, 0} { Curve{174}; }
Extrude {0, -lw, 0} { Curve{182}; }
Extrude {0, -lw, 0} { Curve{186}; }
Extrude {0, -lw, 0} { Curve{194}; }
Extrude {0, -lw, 0} { Curve{198}; }
Extrude {0, -lw, 0} { Curve{206}; }
Extrude {0, -lw, 0} { Curve{210}; }
Extrude {0, -lw, 0} { Curve{218}; }
Extrude {0, -lw, 0} { Curve{222}; }
Extrude {0, -lw, 0} { Curve{230}; }
Extrude {0, -lw, 0} { Curve{234}; }
Extrude {0, -lw, 0} { Curve{242}; }
Extrude {0, -lw, 0} { Curve{246}; }
Extrude {0, -lw, 0} { Curve{254}; }
Extrude {0, -lw, 0} { Curve{258}; }
Extrude {0, -lw, 0} { Curve{266}; }
Extrude {0, -lw, 0} { Curve{270}; }
Extrude {0, -lw, 0} { Curve{278}; }

Line(401) = {231, 236};
Line(402) = {351, 352};
Line(403) = {239, 244};
Line(404) = {355, 356};
Line(405) = {247, 252};
Line(406) = {359, 360};
Line(407) = {255, 260};
Line(408) = {363, 364};
Line(409) = {263, 268};
Line(410) = {367, 368};
Line(411) = {271, 276};
Line(412) = {371, 372};
Line(413) = {279, 284};
Line(414) = {375, 376};
Line(415) = {287, 292};
Line(416) = {379, 380};
Line(417) = {295, 300};
Line(418) = {383, 384};
Line(419) = {303, 308};
Line(420) = {387, 388};
Line(421) = {32, 307};
Line(422) = {35, 349};
Line(423) = {305, 299};
Line(424) = {346, 345};
Line(425) = {297, 291};
Line(426) = {342, 341};
Line(427) = {289, 283};
Line(428) = {338, 337};
Line(429) = {281, 275};
Line(430) = {334, 333};
Line(431) = {273, 267};
Line(432) = {330, 329};
Line(433) = {265, 259};
Line(434) = {326, 325};
Line(435) = {257, 251};
Line(436) = {322, 321};
Line(437) = {249, 243};
Line(438) = {318, 317};
Line(439) = {241, 235};
Line(440) = {314, 313};
Line(441) = {233, 22};
Line(442) = {310, 25};

Curve Loop(556) = {342, 402, -344, -401};
Curve Loop(558) = {348, 404, -350, -403};
Curve Loop(560) = {354, 406, -356, -405};
Curve Loop(562) = {360, 408, -362, -407};
Curve Loop(564) = {366, 410, -368, -409};
Curve Loop(566) = {372, 412, -374, -411};
Curve Loop(568) = {378, 414, -380, -413};
Curve Loop(570) = {384, 416, -386, -415};
Curve Loop(572) = {390, 418, -392, -417};
Curve Loop(574) = {396, 420, -398, -419};
Curve Loop(576) = {36, 422, -339, -421};
Curve Loop(577) = {335, 424, -333, -423};
Curve Loop(578) = {329, 426, -327, -425};
Curve Loop(579) = {323, 428, -321, -427};
Curve Loop(580) = {317, 430, -315, -429};
Curve Loop(581) = {311, 432, -309, -431};
Curve Loop(582) = {305, 434, -303, -433};
Curve Loop(583) = {299, 436, -297, -435};
Curve Loop(584) = {293, 438, -291, -437};
Curve Loop(585) = {287, 440, -285, -439};
Curve Loop(586) = {281, 442, -33, -441};

Plane Surface(556) = {556};
Plane Surface(558) = {558};
Plane Surface(560) = {560};
Plane Surface(562) = {562};
Plane Surface(564) = {564};
Plane Surface(566) = {566};
Plane Surface(568) = {568};
Plane Surface(570) = {570};
Plane Surface(572) = {572};
Plane Surface(574) = {574};
Plane Surface(576) = {576};
Plane Surface(577) = {577};
Plane Surface(578) = {578};
Plane Surface(579) = {579};
Plane Surface(580) = {580};
Plane Surface(581) = {581};
Plane Surface(582) = {582};
Plane Surface(583) = {583};
Plane Surface(584) = {584};
Plane Surface(585) = {585};
Plane Surface(586) = {586};

// Inner and outer wall
Symmetry {0, 1, 0, 0} { Duplicata { Surface{556}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{558}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{560}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{562}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{564}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{566}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{568}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{570}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{572}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{574}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{576}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{577}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{578}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{579}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{580}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{581}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{582}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{583}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{584}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{585}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{586}; } }

// Triangle
Symmetry {0, 1, 0, 0} { Duplicata { Surface{101}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{102}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{103}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{104}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{105}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{106}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{107}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{108}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{109}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{110}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{111}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{112}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{113}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{114}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{115}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{116}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{117}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{118}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{119}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{120}; } }

// Filling between piece of wall
Symmetry {0, 1, 0, 0} { Duplicata { Surface{141}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{121}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{122}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{142}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{143}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{123}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{124}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{144}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{145}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{125}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{126}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{146}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{147}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{127}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{128}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{148}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{149}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{129}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{130}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{150}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{151}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{131}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{132}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{152}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{153}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{133}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{134}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{154}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{155}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{135}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{136}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{156}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{157}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{137}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{138}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{158}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{159}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{139}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{140}; } }
Symmetry {0, 1, 0, 0} { Duplicata { Surface{160}; } }

//==========================================================
// Infill: left circle
//==========================================================

r1 = r - wt/2;
angs = 9/180*Pi;
angi = Pi/2;

Point(1000) = {Cos(angi+ 0*angs)*r1-lf,   Sin(angi+ 0*angs)*r1,  0,  lc};
Point(1001) = {Cos(angi+ 1*angs)*r1-lf,   Sin(angi+ 1*angs)*r1,  0,  lc};
Point(1002) = {Cos(angi+ 2*angs)*r1-lf,   Sin(angi+ 2*angs)*r1,  0,  lc};
Point(1003) = {Cos(angi+ 3*angs)*r1-lf,   Sin(angi+ 3*angs)*r1,  0,  lc};
Point(1004) = {Cos(angi+ 4*angs)*r1-lf,   Sin(angi+ 4*angs)*r1,  0,  lc};
Point(1005) = {Cos(angi+ 5*angs)*r1-lf,   Sin(angi+ 5*angs)*r1,  0,  lc};
Point(1006) = {Cos(angi+ 6*angs)*r1-lf,   Sin(angi+ 6*angs)*r1,  0,  lc};
Point(1007) = {Cos(angi+ 7*angs)*r1-lf,   Sin(angi+ 7*angs)*r1,  0,  lc};
Point(1008) = {Cos(angi+ 8*angs)*r1-lf,   Sin(angi+ 8*angs)*r1,  0,  lc};
Point(1009) = {Cos(angi+ 9*angs)*r1-lf,   Sin(angi+ 9*angs)*r1,  0,  lc};
Point(1010) = {Cos(angi+10*angs)*r1-lf,   Sin(angi+10*angs)*r1,  0,  lc};
Point(1011) = {Cos(angi+11*angs)*r1-lf,   Sin(angi+11*angs)*r1,  0,  lc};
Point(1012) = {Cos(angi+12*angs)*r1-lf,   Sin(angi+12*angs)*r1,  0,  lc};
Point(1013) = {Cos(angi+13*angs)*r1-lf,   Sin(angi+13*angs)*r1,  0,  lc};
Point(1014) = {Cos(angi+14*angs)*r1-lf,   Sin(angi+14*angs)*r1,  0,  lc};
Point(1015) = {Cos(angi+15*angs)*r1-lf,   Sin(angi+15*angs)*r1,  0,  lc};
Point(1016) = {Cos(angi+16*angs)*r1-lf,   Sin(angi+16*angs)*r1,  0,  lc};
Point(1017) = {Cos(angi+17*angs)*r1-lf,   Sin(angi+17*angs)*r1,  0,  lc};
Point(1018) = {Cos(angi+18*angs)*r1-lf,   Sin(angi+18*angs)*r1,  0,  lc};
Point(1019) = {Cos(angi+19*angs)*r1-lf,   Sin(angi+19*angs)*r1,  0,  lc};
Point(1020) = {Cos(angi+20*angs)*r1-lf,   Sin(angi+20*angs)*r1,  0,  lc};

r1 = r - wt/2 + lw*Sqrt(2);

Point(1030) = {Cos(angi+ 0*angs)*r1-lf,   Sin(angi+ 0*angs)*r1,  0,  lc};
Point(1031) = {Cos(angi+ 1*angs)*r1-lf,   Sin(angi+ 1*angs)*r1,  0,  lc};
Point(1032) = {Cos(angi+ 2*angs)*r1-lf,   Sin(angi+ 2*angs)*r1,  0,  lc};
Point(1033) = {Cos(angi+ 3*angs)*r1-lf,   Sin(angi+ 3*angs)*r1,  0,  lc};
Point(1034) = {Cos(angi+ 4*angs)*r1-lf,   Sin(angi+ 4*angs)*r1,  0,  lc};
Point(1035) = {Cos(angi+ 5*angs)*r1-lf,   Sin(angi+ 5*angs)*r1,  0,  lc};
Point(1036) = {Cos(angi+ 6*angs)*r1-lf,   Sin(angi+ 6*angs)*r1,  0,  lc};
Point(1037) = {Cos(angi+ 7*angs)*r1-lf,   Sin(angi+ 7*angs)*r1,  0,  lc};
Point(1038) = {Cos(angi+ 8*angs)*r1-lf,   Sin(angi+ 8*angs)*r1,  0,  lc};
Point(1039) = {Cos(angi+ 9*angs)*r1-lf,   Sin(angi+ 9*angs)*r1,  0,  lc};
Point(1040) = {Cos(angi+10*angs)*r1-lf,   Sin(angi+10*angs)*r1,  0,  lc};
Point(1041) = {Cos(angi+11*angs)*r1-lf,   Sin(angi+11*angs)*r1,  0,  lc};
Point(1042) = {Cos(angi+12*angs)*r1-lf,   Sin(angi+12*angs)*r1,  0,  lc};
Point(1043) = {Cos(angi+13*angs)*r1-lf,   Sin(angi+13*angs)*r1,  0,  lc};
Point(1044) = {Cos(angi+14*angs)*r1-lf,   Sin(angi+14*angs)*r1,  0,  lc};
Point(1045) = {Cos(angi+15*angs)*r1-lf,   Sin(angi+15*angs)*r1,  0,  lc};
Point(1046) = {Cos(angi+16*angs)*r1-lf,   Sin(angi+16*angs)*r1,  0,  lc};
Point(1047) = {Cos(angi+17*angs)*r1-lf,   Sin(angi+17*angs)*r1,  0,  lc};
Point(1048) = {Cos(angi+18*angs)*r1-lf,   Sin(angi+18*angs)*r1,  0,  lc};
Point(1049) = {Cos(angi+19*angs)*r1-lf,   Sin(angi+19*angs)*r1,  0,  lc};
Point(1050) = {Cos(angi+20*angs)*r1-lf,   Sin(angi+20*angs)*r1,  0,  lc};

r1 = r + wt/2;
angs = 9/180*Pi;
angi = Pi/2 + angs/2;

Point(1100) = {Cos(angi+ 0*angs)*r1-lf,   Sin(angi+ 0*angs)*r1,  0,  lc};
Point(1101) = {Cos(angi+ 1*angs)*r1-lf,   Sin(angi+ 1*angs)*r1,  0,  lc};
Point(1102) = {Cos(angi+ 2*angs)*r1-lf,   Sin(angi+ 2*angs)*r1,  0,  lc};
Point(1103) = {Cos(angi+ 3*angs)*r1-lf,   Sin(angi+ 3*angs)*r1,  0,  lc};
Point(1104) = {Cos(angi+ 4*angs)*r1-lf,   Sin(angi+ 4*angs)*r1,  0,  lc};
Point(1105) = {Cos(angi+ 5*angs)*r1-lf,   Sin(angi+ 5*angs)*r1,  0,  lc};
Point(1106) = {Cos(angi+ 6*angs)*r1-lf,   Sin(angi+ 6*angs)*r1,  0,  lc};
Point(1107) = {Cos(angi+ 7*angs)*r1-lf,   Sin(angi+ 7*angs)*r1,  0,  lc};
Point(1108) = {Cos(angi+ 8*angs)*r1-lf,   Sin(angi+ 8*angs)*r1,  0,  lc};
Point(1109) = {Cos(angi+ 9*angs)*r1-lf,   Sin(angi+ 9*angs)*r1,  0,  lc};
Point(1110) = {Cos(angi+10*angs)*r1-lf,   Sin(angi+10*angs)*r1,  0,  lc};
Point(1111) = {Cos(angi+11*angs)*r1-lf,   Sin(angi+11*angs)*r1,  0,  lc};
Point(1112) = {Cos(angi+12*angs)*r1-lf,   Sin(angi+12*angs)*r1,  0,  lc};
Point(1113) = {Cos(angi+13*angs)*r1-lf,   Sin(angi+13*angs)*r1,  0,  lc};
Point(1114) = {Cos(angi+14*angs)*r1-lf,   Sin(angi+14*angs)*r1,  0,  lc};
Point(1115) = {Cos(angi+15*angs)*r1-lf,   Sin(angi+15*angs)*r1,  0,  lc};
Point(1116) = {Cos(angi+16*angs)*r1-lf,   Sin(angi+16*angs)*r1,  0,  lc};
Point(1117) = {Cos(angi+17*angs)*r1-lf,   Sin(angi+17*angs)*r1,  0,  lc};
Point(1118) = {Cos(angi+18*angs)*r1-lf,   Sin(angi+18*angs)*r1,  0,  lc};
Point(1119) = {Cos(angi+19*angs)*r1-lf,   Sin(angi+19*angs)*r1,  0,  lc};

r1 = r + wt/2 - lw*Sqrt(2);

Point(1130) = {Cos(angi+ 0*angs)*r1-lf,   Sin(angi+ 0*angs)*r1,  0,  lc};
Point(1131) = {Cos(angi+ 1*angs)*r1-lf,   Sin(angi+ 1*angs)*r1,  0,  lc};
Point(1132) = {Cos(angi+ 2*angs)*r1-lf,   Sin(angi+ 2*angs)*r1,  0,  lc};
Point(1133) = {Cos(angi+ 3*angs)*r1-lf,   Sin(angi+ 3*angs)*r1,  0,  lc};
Point(1134) = {Cos(angi+ 4*angs)*r1-lf,   Sin(angi+ 4*angs)*r1,  0,  lc};
Point(1135) = {Cos(angi+ 5*angs)*r1-lf,   Sin(angi+ 5*angs)*r1,  0,  lc};
Point(1136) = {Cos(angi+ 6*angs)*r1-lf,   Sin(angi+ 6*angs)*r1,  0,  lc};
Point(1137) = {Cos(angi+ 7*angs)*r1-lf,   Sin(angi+ 7*angs)*r1,  0,  lc};
Point(1138) = {Cos(angi+ 8*angs)*r1-lf,   Sin(angi+ 8*angs)*r1,  0,  lc};
Point(1139) = {Cos(angi+ 9*angs)*r1-lf,   Sin(angi+ 9*angs)*r1,  0,  lc};
Point(1140) = {Cos(angi+10*angs)*r1-lf,   Sin(angi+10*angs)*r1,  0,  lc};
Point(1141) = {Cos(angi+11*angs)*r1-lf,   Sin(angi+11*angs)*r1,  0,  lc};
Point(1142) = {Cos(angi+12*angs)*r1-lf,   Sin(angi+12*angs)*r1,  0,  lc};
Point(1143) = {Cos(angi+13*angs)*r1-lf,   Sin(angi+13*angs)*r1,  0,  lc};
Point(1144) = {Cos(angi+14*angs)*r1-lf,   Sin(angi+14*angs)*r1,  0,  lc};
Point(1145) = {Cos(angi+15*angs)*r1-lf,   Sin(angi+15*angs)*r1,  0,  lc};
Point(1146) = {Cos(angi+16*angs)*r1-lf,   Sin(angi+16*angs)*r1,  0,  lc};
Point(1147) = {Cos(angi+17*angs)*r1-lf,   Sin(angi+17*angs)*r1,  0,  lc};
Point(1148) = {Cos(angi+18*angs)*r1-lf,   Sin(angi+18*angs)*r1,  0,  lc};
Point(1149) = {Cos(angi+19*angs)*r1-lf,   Sin(angi+19*angs)*r1,  0,  lc};

Line(1000) = {230, 1100};
Line(1001) = {1100, 1031};
Line(1002) = {1031, 1101};
Line(1003) = {1101, 1032};
Line(1004) = {1032, 1102};
Line(1005) = {1102, 1033};
Line(1006) = {1033, 1103};
Line(1007) = {1103, 1034};
Line(1008) = {1034, 1104};
Line(1009) = {1104, 1035};

Line(1010) = {1035, 1105};
Line(1011) = {1105, 1036};
Line(1012) = {1036, 1106};
Line(1013) = {1106, 1037};
Line(1014) = {1037, 1107};
Line(1015) = {1107, 1038};
Line(1016) = {1038, 1108};
Line(1017) = {1108, 1039};
Line(1018) = {1039, 1109};
Line(1019) = {1109, 1040};

Line(1020) = {1040, 1110};
Line(1021) = {1110, 1041};
Line(1022) = {1041, 1111};
Line(1023) = {1111, 1042};
Line(1024) = {1042, 1112};
Line(1025) = {1112, 1043};
Line(1026) = {1043, 1113};
Line(1027) = {1113, 1044};
Line(1028) = {1044, 1114};
Line(1029) = {1114, 1045};

Line(1030) = {1045, 1115};
Line(1031) = {1115, 1046};
Line(1032) = {1046, 1116};
Line(1033) = {1116, 1047};
Line(1034) = {1047, 1117};
Line(1035) = {1117, 1048};
Line(1036) = {1048, 1118};
Line(1037) = {1118, 1049};
Line(1038) = {1049, 1119};
Line(1039) = {1119, 474};

Line(1040) = {1000, 1130};
Line(1041) = {1130, 1001};
Line(1042) = {1001, 1131};
Line(1043) = {1131, 1002};
Line(1044) = {1002, 1132};
Line(1045) = {1132, 1003};
Line(1046) = {1003, 1133};
Line(1047) = {1133, 1004};
Line(1048) = {1004, 1134};
Line(1049) = {1134, 1005};

Line(1050) = {1005, 1135};
Line(1051) = {1135, 1006};
Line(1052) = {1006, 1136};
Line(1053) = {1136, 1007};
Line(1054) = {1007, 1137};
Line(1055) = {1137, 1008};
Line(1056) = {1008, 1138};
Line(1057) = {1138, 1009};
Line(1058) = {1009, 1139};
Line(1059) = {1139, 1010};

Line(1060) = {1010, 1140};
Line(1061) = {1140, 1011};
Line(1062) = {1011, 1141};
Line(1063) = {1141, 1012};
Line(1064) = {1012, 1142};
Line(1065) = {1142, 1013};
Line(1066) = {1013, 1143};
Line(1067) = {1143, 1014};
Line(1068) = {1014, 1144};
Line(1069) = {1144, 1015};

Line(1070) = {1015, 1145};
Line(1071) = {1145, 1016};
Line(1072) = {1016, 1146};
Line(1073) = {1146, 1017};
Line(1074) = {1017, 1147};
Line(1075) = {1147, 1018};
Line(1076) = {1018, 1148};
Line(1077) = {1148, 1019};
Line(1078) = {1019, 1149};
Line(1079) = {1149, 1020};

Line(1080) = {1100, 1130};
Line(1081) = {1031, 1001};
Line(1082) = {1101, 1131};
Line(1083) = {1032, 1002};
Line(1084) = {1102, 1132};
Line(1085) = {1033, 1003};
Line(1086) = {1103, 1133};
Line(1087) = {1034, 1004};
Line(1088) = {1104, 1134};
Line(1089) = {1035, 1005};

Line(1090) = {1105, 1135};
Line(1091) = {1036, 1006};
Line(1092) = {1106, 1136};
Line(1093) = {1037, 1007};
Line(1094) = {1107, 1137};
Line(1095) = {1038, 1008};
Line(1096) = {1108, 1138};
Line(1097) = {1039, 1009};
Line(1098) = {1109, 1139};
Line(1099) = {1040, 1010};

Line(1100) = {1110, 1140};
Line(1101) = {1041, 1011};
Line(1102) = {1111, 1141};
Line(1103) = {1042, 1012};
Line(1104) = {1112, 1142};
Line(1105) = {1043, 1013};
Line(1106) = {1113, 1143};
Line(1107) = {1044, 1014};
Line(1108) = {1114, 1144};
Line(1109) = {1045, 1015};

Line(1110) = {1115, 1145};
Line(1111) = {1046, 1016};
Line(1112) = {1116, 1146};
Line(1113) = {1047, 1017};
Line(1114) = {1117, 1147};
Line(1115) = {1048, 1018};
Line(1116) = {1118, 1148};
Line(1117) = {1049, 1019};
Line(1118) = {1119, 1149};
Line(1119) = {1000, 5};

Line(1120) = {474, 7};
Line(1121) = {7, 1020};

Curve Loop(1000) = {1040, -1080, -1000, 161, -1119};
Curve Loop(1001) = {1001, 1081, -1041, -1080};
Curve Loop(1002) = {1042, -1082, -1002, 1081};
Curve Loop(1003) = {1003, 1083, -1043, -1082};
Curve Loop(1004) = {1044, -1084, -1004, 1083};
Curve Loop(1005) = {1005, 1085, -1045, -1084};
Curve Loop(1006) = {1046, -1086, -1006, 1085};
Curve Loop(1007) = {1007, 1087, -1047, -1086};
Curve Loop(1008) = {1048, -1088, -1008, 1087};
Curve Loop(1009) = {1009, 1089, -1049, -1088};
Curve Loop(1010) = {1050, -1090, -1010, 1089};
Curve Loop(1011) = {1011, 1091, -1051, -1090};
Curve Loop(1012) = {1052, -1092, -1012, 1091};
Curve Loop(1013) = {1013, 1093, -1053, -1092};
Curve Loop(1014) = {1054, -1094, -1014, 1093};
Curve Loop(1015) = {1015, 1095, -1055, -1094};
Curve Loop(1016) = {1056, -1096, -1016, 1095};
Curve Loop(1017) = {1017, 1097, -1057, -1096};
Curve Loop(1018) = {1058, -1098, -1018, 1097};
Curve Loop(1019) = {1019, 1099, -1059, -1098};
Curve Loop(1020) = {1060, -1100, -1020, 1099};
Curve Loop(1021) = {1021, 1101, -1061, -1100};
Curve Loop(1022) = {1062, -1102, -1022, 1101};
Curve Loop(1023) = {1023, 1103, -1063, -1102};
Curve Loop(1024) = {1064, -1104, -1024, 1103};
Curve Loop(1025) = {1025, 1105, -1065, -1104};
Curve Loop(1026) = {1066, -1106, -1026, 1105};
Curve Loop(1027) = {1027, 1107, -1067, -1106};
Curve Loop(1028) = {1068, -1108, -1028, 1107};
Curve Loop(1029) = {1029, 1109, -1069, -1108};
Curve Loop(1030) = {1070, -1110, -1030, 1109};
Curve Loop(1031) = {1031, 1111, -1071, -1110};
Curve Loop(1032) = {1032, 1112, -1072, -1111};
Curve Loop(1033) = {1033, 1113, -1073, -1112};
Curve Loop(1034) = {1034, 1114, -1074, -1113};
Curve Loop(1035) = {1035, 1115, -1075, -1114};
Curve Loop(1036) = {1036, 1116, -1076, -1115};
Curve Loop(1037) = {1037, 1117, -1077, -1116};
Curve Loop(1038) = {1038, 1118, -1078, -1117};
Curve Loop(1039) = {1039, 1120, 1121, -1079, -1118};

Plane Surface(1000) = {1000};
Plane Surface(1001) = {1001};
Plane Surface(1002) = {1002};
Plane Surface(1003) = {1003};
Plane Surface(1004) = {1004};
Plane Surface(1005) = {1005};
Plane Surface(1006) = {1006};
Plane Surface(1007) = {1007};
Plane Surface(1008) = {1008};
Plane Surface(1009) = {1009};
Plane Surface(1010) = {1010};
Plane Surface(1011) = {1011};
Plane Surface(1012) = {1012};
Plane Surface(1013) = {1013};
Plane Surface(1014) = {1014};
Plane Surface(1015) = {1015};
Plane Surface(1016) = {1016};
Plane Surface(1017) = {1017};
Plane Surface(1018) = {1018};
Plane Surface(1019) = {1019};
Plane Surface(1020) = {1020};
Plane Surface(1021) = {1021};
Plane Surface(1022) = {1022};
Plane Surface(1023) = {1023};
Plane Surface(1024) = {1024};
Plane Surface(1025) = {1025};
Plane Surface(1026) = {1026};
Plane Surface(1027) = {1027};
Plane Surface(1028) = {1028};
Plane Surface(1029) = {1029};
Plane Surface(1030) = {1030};
Plane Surface(1031) = {1031};
Plane Surface(1032) = {1032};
Plane Surface(1033) = {1033};
Plane Surface(1034) = {1034};
Plane Surface(1035) = {1035};
Plane Surface(1036) = {1036};
Plane Surface(1037) = {1037};
Plane Surface(1038) = {1038};
Plane Surface(1039) = {1039};

BooleanDifference{ Surface{1000}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1001}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1002}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1003}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1004}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1005}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1006}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1007}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1008}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1009}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1010}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1011}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1012}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1013}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1014}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1015}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1016}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1017}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1018}; Delete; }{ Surface{1}; Surface{11}; }
BooleanDifference{ Surface{1019}; Delete; }{ Surface{1}; Surface{11}; }

BooleanDifference{ Surface{1020}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1021}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1022}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1023}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1024}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1025}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1026}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1027}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1028}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1029}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1030}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1031}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1032}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1033}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1034}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1035}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1036}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1037}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1038}; Delete; }{ Surface{2}; Surface{12}; }
BooleanDifference{ Surface{1039}; Delete; }{ Surface{2}; Surface{12}; }

Recursive Delete { Surface{11}; Surface{1}; Surface{2}; Surface{12}; }

r1 = r + wt/2;
angs = 9/180*Pi;
angi = Pi/2 + angs/2;

Extrude {Cos(angi+ 0*angs)*lw, Sin(angi+ 0*angs)*lw, 0} { Curve{1124}; }
Extrude {Cos(angi+ 0*angs)*lw, Sin(angi+ 0*angs)*lw, 0} { Curve{1127}; }
Extrude {Cos(angi+ 1*angs)*lw, Sin(angi+ 1*angs)*lw, 0} { Curve{1136}; }
Extrude {Cos(angi+ 1*angs)*lw, Sin(angi+ 1*angs)*lw, 0} { Curve{1139}; }
Extrude {Cos(angi+ 2*angs)*lw, Sin(angi+ 2*angs)*lw, 0} { Curve{1148}; }
Extrude {Cos(angi+ 2*angs)*lw, Sin(angi+ 2*angs)*lw, 0} { Curve{1151}; }
Extrude {Cos(angi+ 3*angs)*lw, Sin(angi+ 3*angs)*lw, 0} { Curve{1160}; }
Extrude {Cos(angi+ 3*angs)*lw, Sin(angi+ 3*angs)*lw, 0} { Curve{1163}; }
Extrude {Cos(angi+ 4*angs)*lw, Sin(angi+ 4*angs)*lw, 0} { Curve{1172}; }
Extrude {Cos(angi+ 4*angs)*lw, Sin(angi+ 4*angs)*lw, 0} { Curve{1175}; }
Extrude {Cos(angi+ 5*angs)*lw, Sin(angi+ 5*angs)*lw, 0} { Curve{1184}; }
Extrude {Cos(angi+ 5*angs)*lw, Sin(angi+ 5*angs)*lw, 0} { Curve{1187}; }
Extrude {Cos(angi+ 6*angs)*lw, Sin(angi+ 6*angs)*lw, 0} { Curve{1196}; }
Extrude {Cos(angi+ 6*angs)*lw, Sin(angi+ 6*angs)*lw, 0} { Curve{1199}; }
Extrude {Cos(angi+ 7*angs)*lw, Sin(angi+ 7*angs)*lw, 0} { Curve{1208}; }
Extrude {Cos(angi+ 7*angs)*lw, Sin(angi+ 7*angs)*lw, 0} { Curve{1211}; }
Extrude {Cos(angi+ 8*angs)*lw, Sin(angi+ 8*angs)*lw, 0} { Curve{1220}; }
Extrude {Cos(angi+ 8*angs)*lw, Sin(angi+ 8*angs)*lw, 0} { Curve{1223}; }
Extrude {Cos(angi+ 9*angs)*lw, Sin(angi+ 9*angs)*lw, 0} { Curve{1232}; }
Extrude {Cos(angi+ 9*angs)*lw, Sin(angi+ 9*angs)*lw, 0} { Curve{1235}; }
Extrude {Cos(angi+10*angs)*lw, Sin(angi+10*angs)*lw, 0} { Curve{1244}; }
Extrude {Cos(angi+10*angs)*lw, Sin(angi+10*angs)*lw, 0} { Curve{1247}; }
Extrude {Cos(angi+11*angs)*lw, Sin(angi+11*angs)*lw, 0} { Curve{1256}; }
Extrude {Cos(angi+11*angs)*lw, Sin(angi+11*angs)*lw, 0} { Curve{1259}; }
Extrude {Cos(angi+12*angs)*lw, Sin(angi+12*angs)*lw, 0} { Curve{1268}; }
Extrude {Cos(angi+12*angs)*lw, Sin(angi+12*angs)*lw, 0} { Curve{1271}; }
Extrude {Cos(angi+13*angs)*lw, Sin(angi+13*angs)*lw, 0} { Curve{1280}; }
Extrude {Cos(angi+13*angs)*lw, Sin(angi+13*angs)*lw, 0} { Curve{1283}; }
Extrude {Cos(angi+14*angs)*lw, Sin(angi+14*angs)*lw, 0} { Curve{1292}; }
Extrude {Cos(angi+14*angs)*lw, Sin(angi+14*angs)*lw, 0} { Curve{1295}; }
Extrude {Cos(angi+15*angs)*lw, Sin(angi+15*angs)*lw, 0} { Curve{1304}; }
Extrude {Cos(angi+15*angs)*lw, Sin(angi+15*angs)*lw, 0} { Curve{1307}; }
Extrude {Cos(angi+16*angs)*lw, Sin(angi+16*angs)*lw, 0} { Curve{1317}; }
Extrude {Cos(angi+16*angs)*lw, Sin(angi+16*angs)*lw, 0} { Curve{1319}; }
Extrude {Cos(angi+17*angs)*lw, Sin(angi+17*angs)*lw, 0} { Curve{1329}; }
Extrude {Cos(angi+17*angs)*lw, Sin(angi+17*angs)*lw, 0} { Curve{1331}; }
Extrude {Cos(angi+18*angs)*lw, Sin(angi+18*angs)*lw, 0} { Curve{1341}; }
Extrude {Cos(angi+18*angs)*lw, Sin(angi+18*angs)*lw, 0} { Curve{1343}; }
Extrude {Cos(angi+19*angs)*lw, Sin(angi+19*angs)*lw, 0} { Curve{1353}; }
Extrude {Cos(angi+19*angs)*lw, Sin(angi+19*angs)*lw, 0} { Curve{1355}; }

r1 = r - wt/2;
angs = 9/180*Pi;
angi = Pi/2;

Extrude {-Cos(angi+ 0*angs)*lw, -Sin(angi+ 0*angs)*lw, 0} { Curve{1122}; }
Extrude {-Cos(angi+ 1*angs)*lw, -Sin(angi+ 1*angs)*lw, 0} { Curve{1130}; }
Extrude {-Cos(angi+ 1*angs)*lw, -Sin(angi+ 1*angs)*lw, 0} { Curve{1133}; }
Extrude {-Cos(angi+ 2*angs)*lw, -Sin(angi+ 2*angs)*lw, 0} { Curve{1142}; }
Extrude {-Cos(angi+ 2*angs)*lw, -Sin(angi+ 2*angs)*lw, 0} { Curve{1145}; }
Extrude {-Cos(angi+ 3*angs)*lw, -Sin(angi+ 3*angs)*lw, 0} { Curve{1154}; }
Extrude {-Cos(angi+ 3*angs)*lw, -Sin(angi+ 3*angs)*lw, 0} { Curve{1157}; }
Extrude {-Cos(angi+ 4*angs)*lw, -Sin(angi+ 4*angs)*lw, 0} { Curve{1166}; }
Extrude {-Cos(angi+ 4*angs)*lw, -Sin(angi+ 4*angs)*lw, 0} { Curve{1169}; }
Extrude {-Cos(angi+ 5*angs)*lw, -Sin(angi+ 5*angs)*lw, 0} { Curve{1178}; }
Extrude {-Cos(angi+ 5*angs)*lw, -Sin(angi+ 5*angs)*lw, 0} { Curve{1181}; }
Extrude {-Cos(angi+ 6*angs)*lw, -Sin(angi+ 6*angs)*lw, 0} { Curve{1190}; }
Extrude {-Cos(angi+ 6*angs)*lw, -Sin(angi+ 6*angs)*lw, 0} { Curve{1193}; }
Extrude {-Cos(angi+ 7*angs)*lw, -Sin(angi+ 7*angs)*lw, 0} { Curve{1202}; }
Extrude {-Cos(angi+ 7*angs)*lw, -Sin(angi+ 7*angs)*lw, 0} { Curve{1205}; }
Extrude {-Cos(angi+ 8*angs)*lw, -Sin(angi+ 8*angs)*lw, 0} { Curve{1214}; }
Extrude {-Cos(angi+ 8*angs)*lw, -Sin(angi+ 8*angs)*lw, 0} { Curve{1217}; }
Extrude {-Cos(angi+ 9*angs)*lw, -Sin(angi+ 9*angs)*lw, 0} { Curve{1226}; }
Extrude {-Cos(angi+ 9*angs)*lw, -Sin(angi+ 9*angs)*lw, 0} { Curve{1229}; }
Extrude {-Cos(angi+10*angs)*lw, -Sin(angi+10*angs)*lw, 0} { Curve{1238}; }
Extrude {-Cos(angi+10*angs)*lw, -Sin(angi+10*angs)*lw, 0} { Curve{1241}; }
Extrude {-Cos(angi+11*angs)*lw, -Sin(angi+11*angs)*lw, 0} { Curve{1250}; }
Extrude {-Cos(angi+11*angs)*lw, -Sin(angi+11*angs)*lw, 0} { Curve{1253}; }
Extrude {-Cos(angi+12*angs)*lw, -Sin(angi+12*angs)*lw, 0} { Curve{1262}; }
Extrude {-Cos(angi+12*angs)*lw, -Sin(angi+12*angs)*lw, 0} { Curve{1265}; }
Extrude {-Cos(angi+13*angs)*lw, -Sin(angi+13*angs)*lw, 0} { Curve{1274}; }
Extrude {-Cos(angi+13*angs)*lw, -Sin(angi+13*angs)*lw, 0} { Curve{1277}; }
Extrude {-Cos(angi+14*angs)*lw, -Sin(angi+14*angs)*lw, 0} { Curve{1286}; }
Extrude {-Cos(angi+14*angs)*lw, -Sin(angi+14*angs)*lw, 0} { Curve{1289}; }
Extrude {-Cos(angi+15*angs)*lw, -Sin(angi+15*angs)*lw, 0} { Curve{1298}; }
Extrude {-Cos(angi+15*angs)*lw, -Sin(angi+15*angs)*lw, 0} { Curve{1301}; }
Extrude {-Cos(angi+16*angs)*lw, -Sin(angi+16*angs)*lw, 0} { Curve{1310}; }
Extrude {-Cos(angi+16*angs)*lw, -Sin(angi+16*angs)*lw, 0} { Curve{1314}; }
Extrude {-Cos(angi+17*angs)*lw, -Sin(angi+17*angs)*lw, 0} { Curve{1322}; }
Extrude {-Cos(angi+17*angs)*lw, -Sin(angi+17*angs)*lw, 0} { Curve{1326}; }
Extrude {-Cos(angi+18*angs)*lw, -Sin(angi+18*angs)*lw, 0} { Curve{1334}; }
Extrude {-Cos(angi+18*angs)*lw, -Sin(angi+18*angs)*lw, 0} { Curve{1338}; }
Extrude {-Cos(angi+19*angs)*lw, -Sin(angi+19*angs)*lw, 0} { Curve{1346}; }
Extrude {-Cos(angi+19*angs)*lw, -Sin(angi+19*angs)*lw, 0} { Curve{1350}; }
Extrude {-Cos(angi+20*angs)*lw, -Sin(angi+20*angs)*lw, 0} { Curve{1358}; }

Circle(1601) = {1387, 1, 1388};
Circle(1602) = {1391, 1, 1392};
Circle(1603) = {1395, 1, 1396};
Circle(1604) = {1399, 1, 1400};
Circle(1605) = {1403, 1, 1404};
Circle(1606) = {1407, 1, 1408};
Circle(1607) = {1411, 1, 1412};
Circle(1608) = {1415, 1, 1416};
Circle(1609) = {1419, 1, 1420};
Circle(1610) = {1423, 1, 1424};
Circle(1611) = {1427, 1, 1428};
Circle(1612) = {1431, 1, 1432};
Circle(1613) = {1435, 1, 1436};
Circle(1614) = {1439, 1, 1440};
Circle(1615) = {1443, 1, 1444};
Circle(1616) = {1447, 1, 1448};
Circle(1617) = {1451, 1, 1452};
Circle(1618) = {1455, 1, 1456};
Circle(1619) = {1459, 1, 1460};
Circle(1620) = {1463, 1, 1464};
Circle(1621) = {1150, 1, 1155};
Circle(1622) = {1158, 1, 1163};
Circle(1623) = {1166, 1, 1171};
Circle(1624) = {1174, 1, 1179};
Circle(1625) = {1182, 1, 1187};
Circle(1626) = {1190, 1, 1195};
Circle(1627) = {1198, 1, 1203};
Circle(1628) = {1206, 1, 1211};
Circle(1629) = {1214, 1, 1219};
Circle(1630) = {1222, 1, 1227};
Circle(1631) = {1228, 1, 1233};
Circle(1632) = {1236, 1, 1241};
Circle(1633) = {1244, 1, 1249};
Circle(1634) = {1252, 1, 1257};
Circle(1635) = {1260, 1, 1265};
Circle(1636) = {1268, 1, 1273};
Circle(1637) = {1276, 1, 1281};
Circle(1638) = {1284, 1, 1289};
Circle(1639) = {1292, 1, 1297};
Circle(1640) = {1300, 1, 1305};
Circle(1641) = {22, 1, 1151};
Circle(1642) = {1154, 1, 1159};
Circle(1643) = {1162, 1, 1167};
Circle(1644) = {1170, 1, 1175};
Circle(1645) = {1178, 1, 1183};
Circle(1646) = {1186, 1, 1191};
Circle(1647) = {1194, 1, 1199};
Circle(1648) = {1202, 1, 1207};
Circle(1649) = {1210, 1, 1215};
Circle(1650) = {1218, 1, 1223};
Circle(1651) = {1226, 1, 1229};
Circle(1652) = {1232, 1, 1237};
Circle(1653) = {1240, 1, 1245};
Circle(1654) = {1248, 1, 1253};
Circle(1655) = {1256, 1, 1261};
Circle(1656) = {1264, 1, 1269};
Circle(1657) = {1272, 1, 1278};
Circle(1658) = {1280, 1, 1286};
Circle(1659) = {1288, 1, 1294};
Circle(1660) = {1296, 1, 1302};
Circle(1661) = {1304, 1, 473};

Circle(1662) = {1309, 1, 1310};
Circle(1663) = {1313, 1, 1314};
Circle(1664) = {1317, 1, 1318};
Circle(1665) = {1321, 1, 1322};
Circle(1666) = {1325, 1, 1326};
Circle(1667) = {1329, 1, 1330};
Circle(1668) = {1333, 1, 1334};
Circle(1669) = {1337, 1, 1338};
Circle(1670) = {1341, 1, 1342};
Circle(1671) = {1345, 1, 1346};
Circle(1672) = {1349, 1, 1350};
Circle(1673) = {1353, 1, 1354};
Circle(1674) = {1357, 1, 1358};
Circle(1675) = {1361, 1, 1362};
Circle(1676) = {1365, 1, 1366};
Circle(1677) = {1369, 1, 1370};
Circle(1678) = {1373, 1, 1374};
Circle(1679) = {1377, 1, 1378};
Circle(1680) = {1381, 1, 1382};

Line(1681) = {1306, 25};
Line(1682) = {1385, 472};

Curve Loop(759) = {1602, -1490, -1622, 1488};
Curve Loop(760) = {1603, -1496, -1623, 1494};
Curve Loop(761) = {1604, -1502, -1624, 1500};
Curve Loop(762) = {1605, -1508, -1625, 1506};
Curve Loop(763) = {1606, -1514, -1626, 1512};
Curve Loop(764) = {1607, -1520, -1627, 1518};
Curve Loop(765) = {1608, -1526, -1628, 1524};
Curve Loop(766) = {1609, -1532, -1629, 1530};
Curve Loop(767) = {1610, -1538, -1630, 1536};
Curve Loop(768) = {1611, -1544, -1631, 1542};
Curve Loop(769) = {1612, -1550, -1632, 1548};
Curve Loop(770) = {1613, -1556, -1633, 1554};
Curve Loop(771) = {1614, -1562, -1634, 1560};
Curve Loop(772) = {1615, -1568, -1635, 1566};
Curve Loop(773) = {1616, -1574, -1636, 1572};
Curve Loop(774) = {1617, -1580, -1637, 1578};
Curve Loop(775) = {1618, -1586, -1638, 1584};
Curve Loop(776) = {1619, -1592, -1639, 1590};
Curve Loop(777) = {1620, -1598, -1640, 1596};
Curve Loop(778) = {1641, 1361, 1681, -33};
Curve Loop(779) = {1642, 1367, -1662, -1365};
Curve Loop(780) = {1643, 1373, -1663, -1371};
Curve Loop(781) = {1644, 1379, -1664, -1377};
Curve Loop(782) = {1645, 1385, -1665, -1383};
Curve Loop(783) = {1646, 1391, -1666, -1389};
Curve Loop(784) = {1647, 1397, -1667, -1395};
Curve Loop(785) = {1648, 1403, -1668, -1401};
Curve Loop(786) = {1649, 1409, -1669, -1407};
Curve Loop(787) = {1650, 1415, -1670, -1413};
Curve Loop(788) = {1651, 1421, -1671, -1419};
Curve Loop(789) = {1652, 1427, -1672, -1425};
Curve Loop(790) = {1653, 1433, -1673, -1431};
Curve Loop(791) = {1654, 1439, -1674, -1437};
Curve Loop(792) = {1655, 1445, -1675, -1443};
Curve Loop(793) = {1656, 1451, -1676, -1449};
Curve Loop(794) = {1657, 1457, -1677, -1455};
Curve Loop(795) = {1658, 1463, -1678, -1461};
Curve Loop(796) = {1659, 1469, -1679, -1467};
Curve Loop(797) = {1660, 1475, -1680, -1473};
Curve Loop(798) = {1661, 525, -1682, -1479};
Curve Loop(758) = {1601, -1484, -1621, 1482};

Plane Surface(1120) = {758};
Plane Surface(1121) = {759};
Plane Surface(1122) = {760};
Plane Surface(1123) = {761};
Plane Surface(1124) = {762};
Plane Surface(1125) = {763};
Plane Surface(1126) = {764};
Plane Surface(1127) = {765};
Plane Surface(1128) = {766};
Plane Surface(1129) = {767};
Plane Surface(1130) = {768};
Plane Surface(1131) = {769};
Plane Surface(1132) = {770};
Plane Surface(1133) = {771};
Plane Surface(1134) = {772};
Plane Surface(1135) = {773};
Plane Surface(1136) = {774};
Plane Surface(1137) = {775};
Plane Surface(1138) = {776};
Plane Surface(1139) = {777};
Plane Surface(1140) = {778};
Plane Surface(1141) = {779};
Plane Surface(1142) = {780};
Plane Surface(1143) = {781};
Plane Surface(1144) = {782};
Plane Surface(1145) = {783};
Plane Surface(1146) = {784};
Plane Surface(1147) = {785};
Plane Surface(1148) = {786};
Plane Surface(1149) = {787};
Plane Surface(1150) = {788};
Plane Surface(1151) = {789};
Plane Surface(1152) = {790};
Plane Surface(1153) = {791};
Plane Surface(1154) = {792};
Plane Surface(1155) = {793};
Plane Surface(1156) = {794};
Plane Surface(1157) = {795};
Plane Surface(1158) = {796};
Plane Surface(1159) = {797};
Plane Surface(1160) = {798};


Recursive Delete { Surface{5}; Surface{15}; Surface{4}; Surface{14}; }



Symmetry {1, 0, 0, 0} { Duplicata { Surface{1120}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1121}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1122}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1123}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1124}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1125}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1126}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1127}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1128}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1129}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1130}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1131}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1132}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1133}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1134}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1135}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1136}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1137}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1138}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1139}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1140}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1141}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1142}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1143}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1144}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1145}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1146}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1147}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1148}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1149}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1150}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1151}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1152}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1153}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1154}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1155}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1156}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1157}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1158}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1159}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1160}; } }

Symmetry {1, 0, 0, 0} { Duplicata { Surface{1000}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1001}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1002}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1003}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1004}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1005}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1006}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1007}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1008}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1009}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1010}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1011}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1012}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1013}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1014}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1015}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1016}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1017}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1018}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1019}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1020}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1021}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1022}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1023}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1024}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1025}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1026}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1027}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1028}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1029}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1030}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1031}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1032}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1033}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1034}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1035}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1036}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1037}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1038}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1039}; } }

Symmetry {1, 0, 0, 0} { Duplicata { Surface{1080}; Surface{1040}; Surface{1041}; Surface{1081}; Surface{1082}; Surface{1042}; Surface{1043}; Surface{1083}; Surface{1084}; Surface{1044}; Surface{1045}; Surface{1085}; Surface{1086}; Surface{1046}; Surface{1047}; Surface{1087}; Surface{1088}; Surface{1048}; Surface{1049}; Surface{1089}; Surface{1090}; Surface{1050}; Surface{1051}; Surface{1091}; Surface{1092}; Surface{1052}; Surface{1053}; Surface{1093}; Surface{1094}; Surface{1054}; Surface{1055}; Surface{1095}; Surface{1096}; Surface{1056}; Surface{1057}; Surface{1097}; Surface{1098}; Surface{1058}; } }
Symmetry {1, 0, 0, 0} { Duplicata { Surface{1059}; Surface{1099}; Surface{1100}; Surface{1060}; Surface{1061}; Surface{1101}; Surface{1102}; Surface{1062}; Surface{1063}; Surface{1103}; Surface{1104}; Surface{1064}; Surface{1065}; Surface{1105}; Surface{1106}; Surface{1066}; Surface{1067}; Surface{1107}; Surface{1108}; Surface{1068}; Surface{1069}; Surface{1109}; Surface{1110}; Surface{1070}; Surface{1071}; Surface{1111}; Surface{1112}; Surface{1072}; Surface{1073}; Surface{1113}; Surface{1114}; Surface{1074}; Surface{1075}; Surface{1115}; Surface{1116}; Surface{1076}; Surface{1077}; Surface{1117}; Surface{1118}; Surface{1078}; Surface{1079}; Surface{1119}; } }

//==========================================================
// Mesh
//==========================================================

Coherence;

Recombine Surface "*";

Mesh.RecombineAll = 1;

// Transfinite Surface "*";
//+
Transfinite Curve {33, 1906, 342, 281, 2074, 285, 344, 2105, 348, 287, 2077, 291, 350, 2108, 354, 293, 2080, 297, 356, 2111, 360, 299, 2083, 303, 362, 2114, 366, 305, 2086, 309, 368, 2117, 372, 311, 2089, 315, 374, 2124, 378, 317, 2092, 321, 380, 2135, 384, 323, 2095, 327, 386, 2146, 390, 329, 2098, 333, 392, 2157, 396, 335, 2101, 339, 398, 2168, 2217} = nel1 Using Progression 1;
//+
Transfinite Curve {2017, 525, 2620, 2699, 2802, 2697, 2622, 2805, 2624, 2695, 2808, 2693, 2626, 2811, 2628, 2691, 2814, 2689, 2630, 2817, 2632, 2687, 2820, 2685, 2634, 2823, 2636, 2683, 2826, 2681, 2638, 2829, 2640, 2679, 2832, 2677, 2642, 2835, 2644, 2675, 2838, 2673, 2646, 2841, 2648, 2671, 2844, 2669, 2650, 2847, 2652, 2667, 2850, 2665, 2654, 2853, 2656, 2663, 2856, 2661, 2658, 2616, 2295} = nel1 Using Progression 1;
//+
Transfinite Curve {281, 342, 1906, 1482, 1361, 1837, 1365, 1484, 1908, 1488, 1367, 1842, 1371, 1490, 1913, 1494, 1373, 1847, 1377, 1496, 1918, 1500, 1379, 1852, 1383, 1502, 1923, 1506, 1385, 1857, 1389, 1508, 1928, 1512, 1391, 1861, 1395, 1514, 1931, 1518, 1397, 1864, 1401, 1520, 1934, 1524, 1403, 1867, 1407, 1526, 1937, 1530, 1409, 1870, 1413, 1532, 1940, 1536, 1415, 1873, 1419, 1538, 1943, 1542, 1421, 1876, 1425, 1544, 1946, 1548, 1427, 1879, 1431, 1550, 1949, 1554, 1433, 1882, 1437, 1556, 1952, 1560, 1439, 1885, 1443, 1562, 1955, 1566, 1445, 1888, 1449, 1568, 1958, 1572, 1451, 1891, 1455, 1574, 1965, 1578, 1457, 1894, 1461, 1580, 1978, 1584, 1463, 1897, 1467, 1586, 1991, 1590, 1469, 1900, 1473, 1592, 2004, 1596, 1475, 1903, 1479, 1598} = nel1 Using Progression 1;
//+
Transfinite Curve {2123, 2215, 2499, 2221, 2121, 2502, 2129, 2219, 2505, 2225, 2127, 2508, 2134, 2223, 2511, 2229, 2132, 2514, 2140, 2227, 2517, 2233, 2138, 2520, 2145, 2231, 2523, 2237, 2143, 2526, 2151, 2235, 2529, 2241, 2149, 2532, 2156, 2239, 2535, 2245, 2154, 2538, 2162, 2243, 2541, 2249, 2160, 2544, 2167, 2247, 2547, 2253, 2165, 2550, 2173, 2251, 2553, 2257, 2171, 2556, 2177, 2255, 2559, 2261, 2175, 2562, 2181, 2259, 2565, 2265, 2179, 2568, 2185, 2263, 2571, 2269, 2183, 2574, 2189, 2267, 2577, 2273, 2187, 2580, 2193, 2271, 2583, 2277, 2191, 2586, 2197, 2275, 2589, 2281, 2195, 2592, 2201, 2279, 2595, 2285, 2199, 2598, 2205, 2283, 2601, 2289, 2203, 2604, 2209, 2287, 2607, 2293, 2207, 2610, 2213, 2291, 2613, 2297, 2211} = nel1 Using Progression 1;

//+
Transfinite Curve {401, 402, 439, 439, 440, 440, 403, 403, 404, 437, 438, 405, 405, 406, 436, 436, 435, 435, 407, 407, 408, 408, 433, 434, 409, 409, 410, 410, 412, 412, 411, 411, 431, 431, 432, 432, 429, 429, 430, 430, 413, 413, 414, 414, 427, 427, 428, 415, 415, 416, 416, 426, 426, 425, 425, 417, 417, 418, 418, 424, 424, 423, 423, 419, 419, 420, 420} = nel2 Using Progression 1;
//+
Transfinite Curve {2623, 2621, 2698, 2696, 2696, 2627, 2625, 2625, 2694, 2694, 2692, 2631, 2629, 2629, 2690, 2688, 2635, 2633, 2686, 2684, 2639, 2637, 2682, 2680, 2641, 2643, 2678, 2676, 2645, 2647, 2674, 2672, 2649, 2651, 2670, 2668, 2653, 2655, 2666, 2664, 2657, 2659} = nel2 Using Progression 1;
//+
Transfinite Curve {1621, 1621, 1601, 1662, 1642, 1622, 1602, 1643, 1663, 1623, 1603, 1644, 1664, 1624, 1604, 1665, 1645, 1625, 1605, 1666, 1646, 1626, 1606, 1667, 1647, 1607, 1627, 1648, 1668, 1608, 1628, 1649, 1669, 1629, 1609, 1650, 1670, 1610, 1630, 1651, 1671, 1631, 1611, 1652, 1672, 1632, 1612, 1653, 1673, 1633, 1613, 1654, 1674, 1634, 1614, 1655, 1675, 1635, 1615, 1656, 1676, 1636, 1616, 1657, 1677, 1637, 1617, 1658, 1678, 1638, 1618, 1659, 1679, 1639, 1619, 1660, 1680, 1640, 1620} = nel2 Using Progression 1;
//+
Transfinite Curve {2122, 2120, 2218, 2220, 2224, 2222, 2128, 2126, 2133, 2131, 2226, 2228, 2139, 2137, 2230, 2232, 2144, 2142, 2234, 2236, 2148, 2150, 2238, 2240, 2153, 2155, 2242, 2244, 2159, 2161, 2246, 2248, 2164, 2166, 2250, 2252, 2170, 2172, 2254, 2256, 2174, 2176, 2258, 2260, 2178, 2180, 2262, 2264, 2182, 2184, 2266, 2268, 2186, 2188, 2270, 2272, 2190, 2192, 2274, 2276, 2194, 2196, 2278, 2280, 2198, 2200, 2282, 2284, 2202, 2204, 2286, 2288, 2206, 2208, 2290, 2292, 2210, 2212} = nel2 Using Progression 1;

Transfinite Curve {1641, 1681, 441, 442, 2619, 2618, 2216, 2214, 2294, 2662, 2660, 2296, 2701, 1661, 1682, 2700} = nel2/2+1 Using Progression 1;

//+
//+
Transfinite Curve {2104, 162, 1963, 2075, 2076, 1967, 1969, 2106, 161, 1962, 1970, 1973, 2107, 1976, 2078, 2079, 1980, 1975, 2109, 1982, 1983, 1986, 1986, 2110, 1989, 2081, 2082, 1993, 1988, 1995, 2112, 2113, 1999, 1996, 2002, 2084, 2085, 2006, 2001, 2115, 2008, 2009, 2012, 2116, 2087, 2015, 2014, 2019, 2088, 2118, 2021, 2024, 2119, 2022, 2027, 2090, 2091, 2029, 2026, 2125, 2031, 2032, 2034, 2130, 2037, 2093, 2094, 2039, 2036, 2136, 2041, 2044, 2141, 2042, 2047, 2096, 2097, 2049, 2046, 2147, 2051, 2054, 2152, 2052, 2057, 2099, 2100, 2059, 2056, 2061, 2158, 2163, 2064, 2062, 2067, 2102, 2103, 2069, 2066, 2169, 2071, 2072} = nel3 Using Progression 1;
//+
Transfinite Curve {1835, 2801, 2702, 2803, 2705, 2704, 2707, 2804, 2709, 2806, 2807, 2712, 2710, 2715, 2809, 2714, 2717, 2810, 2719, 2812, 2813, 2722, 2720, 2815, 2725, 2727, 2816, 2724, 2729, 2818, 2819, 2732, 2730, 2821, 2735, 2737, 2822, 2734, 2739, 2824, 2825, 2742, 2740, 2827, 2745, 2744, 2747, 2828, 2749, 2830, 2831, 2752, 2750, 2833, 2755, 2754, 2757, 2834, 2759, 2836, 2837, 2762, 2760, 2839, 2765, 2767, 2840, 2764, 2769, 2842, 2843, 2772, 2770, 2845, 2775, 2777, 2846, 2774, 2779, 2848, 2849, 2782, 2780, 2851, 2785, 2784, 2787, 2852, 2789, 2854, 2855, 2792, 2790, 2857, 2795, 2794, 2797, 2858, 2799, 2859, 2496} = nel3 Using Progression 1;
//+
Transfinite Curve {1907, 1122, 1839, 1838, 2861, 1840, 1841, 1910, 1909, 1911, 1912, 2864, 1844, 1843, 1845, 1846, 2867, 1915, 1914, 1916, 1917, 2870, 1848, 1849, 1851, 1850, 2873, 1919, 1920, 1922, 1921, 2876, 1853, 1854, 1856, 1855, 2879, 1925, 1924, 2882, 1926, 1927, 1859, 1858, 1684, 1683, 1860, 1929, 1686, 1687, 1689, 1930, 1862, 1691, 1692, 1694, 1863, 1932, 1696, 1697, 1699, 1933, 1865, 1701, 1702, 1704, 1866, 1935, 1706, 1707, 1709, 1936, 1868, 1711, 1712, 1714, 1869, 1938, 1716, 1717, 1719, 1939, 1871, 1721, 1722, 1724, 1872, 1941, 1726, 1727, 1729, 1942, 1874, 1731, 1732, 1734, 1875, 1944, 1238, 1736, 1241, 1945, 1877, 1739, 1742, 1878, 1740, 1745, 1744, 1947, 1948, 1747, 1880, 1749, 1750, 1752, 1881, 1950, 1754, 1755, 1757, 1951, 1883, 1759, 1762, 1884, 1760, 1953, 1764, 1954, 1767, 1765, 1886, 1769, 1772, 1887, 1770, 1774, 1956, 1957, 1777, 1775, 1889, 1779, 1782, 1890, 1780, 1784, 1959, 1960, 1787, 1785, 1892, 1789, 1792, 1893, 1790, 1794, 1966, 1972, 1797, 1795, 1895, 1800, 1802, 1896, 1799, 1804, 1979, 1985, 1807, 1805, 1898, 1810, 1809, 1812, 1899, 1814, 1992, 1998, 1817, 1815, 1901, 1820, 1822, 1902, 1819, 1824, 2005, 2011, 1827, 1825, 1904, 1830, 1832, 1905, 1829, 1834, 2018} = nel3 Using Progression 1;
//+
Transfinite Curve {2498, 2298, 2500, 2300, 2303, 2501, 2301, 2305, 2503, 2504, 2308, 2306, 2310, 2506, 2507, 2313, 2311, 2315, 2509, 2316, 2318, 2510, 2320, 2512, 2321, 2323, 2513, 2515, 2325, 2326, 2516, 2328, 2330, 2518, 2519, 2333, 2331, 2521, 2335, 2338, 2522, 2336, 2340, 2524, 2525, 2343, 2341, 2527, 2345, 2348, 2528, 2346, 2350, 2530, 2531, 2353, 2351, 2533, 2355, 2358, 2534, 2356, 2360, 2536, 2537, 2363, 2361, 2539, 2365, 2540, 2368, 2366, 2370, 2542, 2543, 2373, 2371, 2545, 2375, 2546, 2378, 2376, 2380, 2548, 2549, 2383, 2381, 2551, 2385, 2552, 2388, 2386, 2390, 2554, 2555, 2393, 2391, 2557, 2395, 2558, 2398, 2396, 2400, 2560, 2561, 2403, 2401, 2563, 2405, 2564, 2408, 2406, 2410, 2566, 2567, 2413, 2411, 2569, 2415, 2570, 2418, 2416, 2420, 2572, 2573, 2423, 2421, 2575, 2425, 2576, 2428, 2426, 2430, 2578, 2579, 2433, 2431, 2581, 2435, 2582, 2438, 2436, 2440, 2584, 2585, 2443, 2441, 2587, 2445, 2588, 2448, 2446, 2450, 2590, 2453, 2591, 2451, 2593, 2455, 2594, 2458, 2456, 2461, 2596, 2597, 2463, 2460, 2599, 2465, 2600, 2468, 2466, 2471, 2602, 2603, 2473, 2470, 2605, 2475, 2606, 2478, 2476, 2481, 2608, 2609, 2483, 2480, 2611, 2485, 2488, 2612, 2486, 2491, 2614, 2615, 2493, 2490, 2617, 2495} = nel3 Using Progression 1;

//+
Transfinite Curve {1961, 1964, 1968, 1971, 1974, 1977, 1981, 1984, 1990, 1987, 1994, 1997, 2003, 2000, 2007, 2010, 2016, 2013, 2020, 2023, 2028, 2025, 2030, 2033, 2038, 2035, 2040, 2043, 2048, 2045, 2050, 2053, 2058, 2055, 2060, 2063, 2068, 2065, 2070, 2073} = nel4 Using Progression 1;
//+
Transfinite Curve {2703, 2706, 2708, 2711, 2716, 2713, 2718, 2721, 2726, 2723, 2728, 2731, 2736, 2733, 2738, 2741, 2746, 2743, 2748, 2751, 2756, 2753, 2758, 2761, 2766, 2763, 2768, 2771, 2776, 2773, 2778, 2781, 2786, 2783, 2788, 2791, 2796, 2793, 2798, 2800} = nel4 Using Progression 1;
//+
Transfinite Curve {2860, 2862, 2863, 2865, 2866, 2868, 2869, 2871, 2872, 2874, 2875, 2877, 2878, 2880, 2881, 2883, 2884, 2885, 1685, 1688, 1690, 1693, 1695, 1698, 1700, 1703, 1705, 1708, 1710, 1713, 1715, 1718, 1720, 1723, 1725, 1728, 1730, 1733, 1735, 1737, 1738, 1741, 1743, 1746, 1748, 1751, 1753, 1756, 1758, 1761, 1763, 1766, 1768, 1771, 1773, 1776, 1778, 1781, 1783, 1786, 1788, 1791, 1793, 1796, 1801, 1798, 1803, 1806, 1811, 1808, 1813, 1816, 1821, 1818, 1823, 1826, 1831, 1828, 1833, 1836} = nel4 Using Progression 1;
//+
Transfinite Curve {2299, 2302, 2304, 2307, 2309, 2312, 2314, 2317, 2319, 2322, 2324, 2327, 2329, 2332, 2334, 2337, 2339, 2342, 2344, 2347, 2349, 2352, 2354, 2357, 2359, 2362, 2364, 2367, 2369, 2372, 2374, 2377, 2379, 2382, 2384, 2387, 2389, 2392, 2394, 2397, 2399, 2402, 2404, 2407, 2409, 2412, 2414, 2417, 2419, 2422, 2424, 2427, 2429, 2432, 2434, 2437, 2439, 2442, 2444, 2447, 2449, 2452, 2454, 2457, 2462, 2459, 2464, 2467, 2472, 2469, 2474, 2477, 2482, 2479, 2484, 2487, 2492, 2489, 2494, 2497} = nel4 Using Progression 1;

s[] = Surface "*";
Extrude {0, 0, h} {  Surface{ s[] }  ; Layers{lyr}; Recombine;}

Transfinite Surface "*";
