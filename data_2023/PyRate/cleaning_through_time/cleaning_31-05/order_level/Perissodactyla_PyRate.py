#!/usr/bin/env python
from numpy import * 


data_1=[array([0.807528,1.518861,0.020979,0.298088,1.392722,0.472415,2.177991,2.334586,0.427767,0.663885,0.23895,1.544576,1.587529,2.398745,1.798537,1.634387,1.611914,0.459539,0.562866,1.007391,2.441152,0.645102,2.350959,1.959012,1.017296,0.03795,2.498116,2.397693,0.580156,0.401057,0.393889,1.501669,1.563048,1.697542,0.743569,1.367162,1.888905,0.580001,2.498279,1.968002,0.021841,1.632864,2.558708,2.48692,0.258192,1.797814,0.369543,2.092606,1.461558,1.686321,0.573195,0.153437,0.576397,0.259254,1.867192,1.470855,0.241411,1.465221,0.369398,1.96477,2.239337,0.521331,2.500889,0.001499,1.830243,0.287708,0.930868,1.999112,0.563043,1.692171,0.603842,0.239845,1.024327,0.360147,2.28914,1.791328,0.070055,1.164415,1.162724,0.081393,0.953407,0.110719,1.043413,2.282038,0.089761,0.642643,1.783492,2.526756,0.167468,0.621048,1.424934,0]),
array([1.18477,1.090389,2.063939,0.764869,1.066182,0.02447,1.984864,1.953392,0.225228,2.490627,0.460475,1.027671,1.83296,0.79449,1.431141,1.615648,2.569394,2.384692,1.520976,0.419064,1.270354,0.417899,1.797013,0.048406,2.226968,1.867152,0.011677,1.139336,0.835846,1.522967,0.396193,1.562331,1.300941,1.240087,0.947512,0.319665,2.028629,0.916245,0.024966,1.327126,0.000512,0.109111,1.056455,1.081589,2.542242,0.235501,2.305275,1.897001,0.460245,1.876805,2.339612,1.978576,0.001492,0.485222,0.8004,1.78845,2.1237,2.346644,1.013952,2.78304,1.430342,2.080592,1.322758,2.601559,2.028181,2.000499,0.998564,0.866381,1.205619,0.010426,2.379613,2.339232,1.941528,0.73125,0.879478,0.054071,1.977773,1.053351,1.657773,0.31219,2.538841,0.7863,0.286276,2.089944,0.310232,2.431055]),
array([1.994585,1.218231,2.339516,0.159976,2.362964,0.854372,0.279017,0.518446,2.201515,1.652062,0.382047,0.012632,0.104912,0.007105,2.016255,0.004687,0.203017,1.273065,0.35911,1.914822,0.038467,1.290767,0.008473,0.001616,0.007893,2.225271,0.767178,1.216728,2.441963,1.982105,0.328409,0.63549,0.779197,1.401134,2.413518,2.360578,2.174874,0.532492,1.311152,0.007733,0])
]


data_2=[array([1.685184,1.125735,0.044828,2.552924,0.733367,0.675837,2.482003,2.401953,0.663686,1.528026,2.505488,1.328474,2.517224,1.858331,0.553557,2.424449,1.300533,0.020897,0.424953,2.001092,1.762901,1.43149,1.903866,2.333353,2.550142,0.90365,1.66723,1.26451,2.018019,1.359011,1.117663,1.999608,1.223462,1.75805,0.171234,2.170105,1.486625,2.280538,2.104435,2.46716,0.455912,0.988769,2.453627,0.384799,0.989439,2.247989,1.705581,1.604085,0.443894,1.216658,2.399147,1.032027,0.968381,1.170049,2.127562,0.951788,0.578746,2.555282,0.825681,1.092775,2.207056,0.050773,1.020281,0.002475,2.173196,2.452605,1.079047,0.938988,2.429605,0.692115,1.862358,1.476951,0.667248,0.784912,1.25768,0.236194,0.021333,2.272268,0.341859,1.290592,2.132465,2.267449,1.23991,0.564926,0.021872,1.89563,1.206179,2.417607,0.356224,2.087172,0.701059,0]),
array([2.561726,0.441138,0.57285,1.863675,1.817302,0.232608,0.582418,1.703376,1.749309,0.764923,0.598101,1.546524,1.326118,1.292918,0.569353,2.485177,0.75289,2.277232,2.031692,0.413248,0.01192,0.989931,2.369035,0.113288,1.706523,1.746967,0.004841,1.102472,0.144283,1.874546,0.73927,2.348972,2.289734,0.742307,3.302428,1.630288,0.970128,0.923796,0.006285,1.712679,0.000213,0.097002,1.043485,0.41267,2.552141,2.025119,2.451981,1.212899,2.008951,0.487398,1.919019,2.431684,0.004374,1.392704,1.402387,0.625852,0.800692,0.646836,0.872812,2.968943,1.139538,1.911429,1.362384,3.175076,1.682795,1.451098,1.025273,1.04368,0.808799,0.010468,0.444667,1.916753,1.607859,0.142011,1.008092,0.395489,0.150087,2.367397,0.611226,0.526122,1.162711,0.808458,1.300978,1.327622,2.352064,1.83353]),
array([2.433856,1.224855,0.277285,1.523775,1.24828,2.394677,0.895691,1.388423,3.187044,2.389637,2.039774,0.011309,0.038048,0.011302,2.176538,0.011656,0.041387,2.496903,1.435715,0.286707,0.111517,0.538187,0.011017,0.003008,0.008361,2.163778,0.854019,1.630718,2.472028,1.946762,0.354506,0.038242,0.729384,0.780326,0.673232,2.003579,0.538478,1.752457,2.202517,0.004959,0])
]


data_3=[array([1.311626,1.853391,0.019461,0.622659,0.890959,1.04339,2.516669,0.183589,0.197335,0.068084,0.268897,0.68132,2.315008,0.182656,1.73745,0.931283,1.136835,1.877653,0.016348,1.252497,2.202098,0.832798,2.282293,1.372721,0.023807,1.87253,1.655624,2.08873,1.693338,1.903162,2.092547,1.648099,1.823905,2.245299,0.201672,0.140747,2.34573,0.237677,0.722147,1.458556,1.678099,0.136387,1.275929,1.580829,0.087021,1.144867,2.193165,1.71967,1.800514,2.302306,1.566823,1.177601,0.852513,1.143165,1.035456,2.33954,0.675127,0.430657,2.459394,0.773469,1.501537,0.839254,0.186426,0.006362,0.875073,0.248686,2.197822,2.098572,0.127466,1.051076,1.52664,2.252128,0.092833,1.090636,0.63044,1.792192,0.062715,1.910813,2.288766,1.687015,2.030181,1.785128,0.220854,0.661213,0.051905,1.01564,2.43143,0.932844,0.8064,1.528195,2.561103,0]),
array([0.494403,1.950431,2.518549,2.393479,1.601629,0.205074,1.115599,0.694112,0.600682,0.950482,2.572473,0.709985,0.980889,1.396272,0.815064,1.040526,1.25247,1.43303,0.329792,0.922867,1.262474,0.086509,1.798844,0.121378,0.382891,0.914506,0.006043,0.419261,0.490248,0.268103,0.345247,0.168922,2.386398,1.417455,1.618294,0.691282,0.127979,0.528252,0.120654,1.484815,0.010658,0.016489,1.598535,1.916679,1.682883,1.036554,0.31784,0.817611,1.233644,2.494569,0.609822,0.884576,0.000121,2.04553,0.660111,1.034515,2.212406,0.220799,1.004506,3.20991,1.021536,1.185785,0.125595,3.114838,1.181737,1.914969,2.301616,0.864997,2.535079,0.011188,0.137388,1.67814,1.499597,1.548311,0.936777,1.964672,0.85679,0.081589,0.693437,1.8814,1.468089,1.485258,1.924171,0.0485,0.46083,0.756086]),
array([2.447637,0.423901,0.654176,0.342139,0.010642,0.752822,0.283325,1.656171,2.515757,0.915741,1.353029,0.035891,0.124161,0.004121,2.144772,0.008944,0.762418,1.142718,0.894691,0.272256,0.055253,1.11473,0.003027,0.010378,0.010164,1.412953,1.514122,1.208159,0.036132,1.148398,2.070273,2.295677,1.117822,1.456389,0.017614,0.721686,0.24053,1.368517,2.243957,0.011472,0])
]


data_4=[array([0.731887,0.221882,0.107768,0.370242,1.808726,1.304309,0.466274,2.523585,1.874215,2.194358,2.159703,1.290605,2.04282,1.228623,0.773489,0.830033,0.299205,1.086903,0.848167,1.811026,1.667528,0.203497,0.975964,2.535285,1.627764,0.289787,0.298781,0.921874,1.125404,2.385514,1.675738,1.212685,2.553359,0.508128,2.552505,1.448865,1.613154,1.845462,1.9227,1.982873,1.60834,2.291901,1.632485,2.254947,1.025642,0.623108,2.137439,1.314026,2.18003,1.679646,2.161115,1.692717,1.620241,2.086378,0.858222,0.014737,1.230301,1.430921,1.112139,1.167616,1.543633,0.213356,1.64415,0.000785,1.948211,2.200898,1.343554,1.735441,1.791457,1.967114,0.229537,1.054008,0.277907,0.071443,2.446034,0.771946,0.105289,2.230118,0.980137,0.311559,1.754858,1.045656,2.568143,2.194512,0.036952,0.50583,2.277998,1.142095,1.298977,2.264659,2.023643,0]),
array([2.25657,1.839128,0.913863,0.723405,1.498272,1.942294,0.394048,2.570566,2.466477,0.342131,0.33501,1.069704,2.372346,1.5016,0.026155,1.414117,2.214425,0.686207,0.883148,0.093112,1.568855,1.758283,0.346148,0.01851,0.046596,0.244298,0.003755,1.098845,0.984896,1.209701,0.468048,0.043957,1.455628,0.992771,3.413943,1.528458,1.998778,0.968026,0.011434,0.087356,0.006383,0.001745,2.155629,0.109311,0.289899,1.285653,1.448095,2.196809,1.804105,1.234022,1.889484,1.408978,0.002962,0.685327,2.513794,0.701956,1.805615,0.772236,0.938045,2.675815,1.904077,2.04562,2.222911,2.742839,2.505631,1.948395,1.902615,0.796767,0.416221,0.010317,2.069693,2.420986,0.320937,0.888674,0.539437,1.69927,1.519991,0.774658,1.679131,1.403929,0.286531,1.926141,0.427167,0.219437,0.555569,2.080762]),
array([2.501446,0.078836,1.279849,1.182574,1.72714,0.182542,0.286587,0.303529,2.277672,0.769154,1.337255,0.055168,0.120435,0.007474,1.329539,0.004246,2.206042,0.749418,0.675857,0.489351,0.010221,2.360419,0.009465,0.006111,0.005433,0.440628,0.490033,0.570497,0.115937,1.266016,1.609137,0.824548,2.057508,2.560145,2.318184,0.295264,1.416448,0.658332,2.524154,0.007794,0])
]


data_5=[array([1.155293,2.133105,0.113577,0.875476,1.254102,1.820973,0.960771,0.435684,0.252464,0.659697,2.345081,2.561172,0.915752,1.770954,0.090046,1.236978,0.278063,0.91355,0.25365,0.808942,1.018068,1.115679,1.962528,0.832986,1.078142,1.274328,0.822133,0.974505,1.469632,0.937072,1.05126,1.711652,1.774252,0.522765,1.081182,2.537203,1.870862,0.933956,0.018732,0.603017,2.305205,0.505569,2.200813,0.735197,0.702255,0.072857,2.431194,1.662451,0.637222,0.8176,1.671432,0.962535,0.666745,1.405138,1.464596,2.435928,1.293473,0.533326,0.681829,2.276365,1.130468,0.062665,0.34178,0.007515,0.267719,1.030887,0.594951,0.690701,1.501913,2.298868,1.91755,2.525408,0.512234,0.438799,1.202101,0.707104,0.042981,1.824017,0.869335,1.43425,0.939482,1.105657,0.742004,1.505305,0.012795,1.818026,1.284302,0.192029,0.504951,0.092434,0.606463,0]),
array([0.193979,1.489083,2.536807,2.083924,1.030703,1.642352,0.633788,1.478844,2.304521,0.340029,1.821792,0.630371,0.042521,1.793458,2.487316,0.315562,2.378314,2.248009,1.649683,0.879331,1.595996,1.428126,1.11222,0.020006,1.579318,0.514639,0.000507,2.255974,1.068044,1.12141,0.220769,2.025272,1.695654,0.314071,2.770695,0.155697,0.027901,1.531393,0.080542,0.463302,0.000181,0.034077,2.167249,0.360743,2.319619,2.233142,1.58534,1.982467,1.798207,2.42922,2.339993,0.992632,0.008464,0.869982,0.426199,0.055563,1.970346,2.340376,0.976346,3.009164,2.467683,2.418833,1.372261,3.459758,1.529071,0.856226,1.365788,0.905156,1.703735,0.01101,0.473169,0.635933,1.794036,2.531838,0.50686,2.431931,2.141806,0.485659,1.37636,0.591595,0.50644,0.533283,0.629952,2.411328,1.695912,0.633747]),
array([2.108373,2.458697,1.251832,2.537956,2.365741,0.774182,0.212506,0.806541,2.455827,1.300099,0.899706,0.024182,0.11657,0.004828,2.434987,0.011299,0.412933,2.007945,1.918839,1.010764,0.041367,0.495972,0.005065,0.001735,0.008358,2.349912,1.303482,1.407981,1.468854,0.66036,2.012315,0.188759,0.876738,0.511067,1.068354,0.689206,1.548268,0.702025,1.491066,0.003666,0])
]


data_6=[array([2.297588,0.865982,0.116612,0.159131,0.945073,1.215017,2.145144,1.300861,0.078478,1.18479,0.373569,2.307392,0.186144,2.094932,2.509328,1.332421,1.166453,1.850397,0.550386,0.308244,1.424429,0.385265,1.968757,0.354365,1.515461,1.521061,1.784216,0.328071,1.483889,0.150728,1.968409,1.288722,1.108836,0.922803,1.052661,1.165698,2.417238,1.698961,0.156699,1.744075,0.650388,1.30532,0.657791,1.427534,1.671728,2.445664,1.134698,0.754032,0.245123,2.002179,1.145969,0.872626,0.274991,2.486015,1.189114,0.966195,1.970012,2.027448,1.350694,2.186564,2.059317,2.263532,2.561042,0.000591,2.562244,0.846345,2.57971,0.054153,1.287669,1.490484,2.040831,1.208755,1.720268,1.518042,0.536972,1.723352,0.119853,2.095548,1.529124,1.967375,2.016377,1.320216,0.063909,1.878772,0.094385,0.55185,0.555711,0.742516,0.347651,1.046042,0.527952,0]),
array([0.865165,1.849192,0.263526,0.992699,1.000211,0.252699,0.310895,0.864219,1.947927,0.261175,1.081772,2.205728,1.776105,0.495547,1.286441,2.070593,0.879254,2.395583,2.402093,1.235756,2.45674,2.169885,1.803056,0.003768,1.146965,0.51588,0.001126,2.354825,2.125679,1.349147,0.672946,2.382927,2.270273,0.274212,3.057018,1.692461,0.229714,1.328252,0.046497,1.084769,0.009229,0.015135,0.078857,0.519102,1.638079,0.511186,2.130193,2.460039,0.646592,1.81176,1.921397,0.064223,0.000104,2.263651,2.20871,1.325596,0.949491,2.155212,0.950102,2.877801,2.448357,1.677033,1.402274,3.387894,0.899104,0.976819,0.347974,1.027464,1.850076,0.010038,1.043425,0.694894,2.252916,0.966021,2.333783,1.146378,2.230756,2.024076,0.457605,1.600659,2.452954,1.501726,2.187596,0.726274,0.113638,1.25015]),
array([2.14743,0.015229,2.229849,1.430255,0.298107,1.379552,0.836836,2.571019,2.043572,1.802697,1.640924,0.072422,0.01036,0.010571,1.360327,0.003194,0.039215,1.176724,1.986379,1.382204,0.103942,1.172123,0.008155,0.007787,0.010447,0.488705,0.233924,2.365673,1.241901,0.228685,0.894493,2.456731,0.464736,2.226922,0.441368,2.191469,2.028242,0.362214,0.938304,0.005303,0])
]


data_7=[array([1.576276,0.493421,0.072699,1.24948,1.277788,0.431524,0.925493,0.480279,0.47385,0.210929,2.471054,1.895113,2.492678,0.461304,1.460025,0.060226,1.712927,2.56343,0.113955,1.964046,0.79463,2.50276,1.205004,0.907628,0.259379,1.249906,0.82767,1.058415,0.401963,1.688614,0.341408,1.455314,0.754002,1.095594,1.115261,1.521136,1.6272,1.024909,1.568379,2.529128,2.552326,0.303711,2.281011,1.227489,2.551064,0.576597,2.337705,2.095288,1.356029,0.472992,1.146431,0.841273,0.165859,2.542531,0.596584,2.446203,1.968833,2.558401,0.339425,0.360658,2.217067,0.882193,0.697592,0.001527,2.165984,0.548235,1.188458,0.55011,1.006841,1.474854,0.575914,1.986525,1.981113,1.962318,1.367994,0.531325,0.059818,2.399113,0.825548,0.863615,0.815443,0.326263,0.735761,0.223499,0.01122,0.912808,0.280624,2.532853,0.14877,2.446514,2.441476,0]),
array([1.375958,0.058904,1.269058,1.124426,1.246105,2.38814,0.481823,0.483351,0.981717,0.08104,2.159251,0.662376,0.774595,1.611726,0.904941,1.10655,0.399928,0.982594,0.361562,0.756809,2.514682,0.73793,1.296979,0.124484,1.761779,0.16162,0.001798,0.085616,0.121499,0.944413,0.736796,0.644705,0.559078,0.012573,3.288447,1.802081,1.29695,0.354518,0.055443,1.944324,0.005891,0.067081,0.436823,1.618812,1.622785,0.098702,0.111542,1.202715,2.279156,2.128217,1.478026,1.161547,0.009225,1.293212,1.797653,2.126327,1.022009,2.414269,1.024863,3.191738,1.564645,0.804912,1.132072,2.868171,2.084952,1.739579,1.567413,0.939184,1.734839,0.011264,2.147206,1.04598,2.379732,1.968951,2.510555,2.488184,2.577355,0.384073,2.097642,1.190983,2.424322,1.187633,1.874776,0.493092,0.175321,2.061484]),
array([1.986824,1.295699,0.752318,0.922141,0.047835,0.791239,0.645265,0.860581,1.14059,1.286075,0.346599,0.087657,0.122946,0.009727,1.111304,0.003668,1.718125,2.061994,0.849795,2.361956,0.006715,1.162769,0.008579,0.011332,0.005017,0.206547,2.289056,0.687552,2.321346,2.263031,0.878297,0.048161,1.353429,1.019026,1.965196,0.763821,1.421123,1.766034,2.12027,0.012123,0])
]


data_8=[array([1.462573,0.692252,0.018779,0.86731,1.404618,0.331267,0.107402,0.349578,1.386397,1.04452,1.527813,1.541373,0.350763,1.424667,0.501438,1.988387,0.292899,1.772002,0.892359,0.524128,1.288199,0.754702,1.655787,1.735241,0.097012,0.730407,0.630476,2.270745,1.171135,1.61597,2.067003,0.160653,0.362493,0.935234,2.571928,0.615286,1.352365,1.837396,0.774569,1.52553,2.038194,2.233367,1.958095,1.402538,2.212545,0.26718,2.112373,1.539141,1.469444,1.487664,0.826412,1.791867,2.540039,0.154463,1.867926,0.819474,0.491379,0.145789,1.239561,1.919956,2.052924,1.340166,2.36684,0.007833,0.262206,2.066683,0.653604,0.405122,1.927363,1.1875,2.218057,2.453139,0.586011,0.097991,1.774558,0.961495,0.099433,0.965596,1.788909,0.721677,0.146717,0.593175,0.651573,0.61266,0.0799,0.280909,1.846214,2.115394,0.351515,1.239245,1.433537,0]),
array([1.654189,1.003773,0.854653,0.434208,0.260219,1.795638,1.682231,2.28188,1.960383,0.761672,0.758176,0.084975,2.467346,1.086099,1.22663,0.873737,1.285661,1.450705,0.885061,1.046549,0.650074,1.897831,1.732341,0.049695,0.153515,1.747695,0.011324,1.556709,1.209631,0.095016,0.329697,2.130582,1.10971,1.567216,1.974025,0.480764,2.009062,0.693117,0.094621,0.518713,0.008134,0.089056,0.268165,1.243689,2.036792,0.04647,0.08642,2.485232,2.138332,0.360721,1.638034,2.010526,0.007051,1.240972,1.914171,1.39185,0.626655,0.794581,1.022996,2.763161,0.416653,0.340227,2.000119,3.188701,1.87444,0.976537,0.682071,0.944312,1.881882,0.010636,2.486369,0.962987,2.544055,2.5657,0.342979,1.965746,2.025014,0.980317,2.216821,1.617223,0.180138,2.17057,1.330431,1.257455,0.345248,2.261651]),
array([1.325859,2.503562,2.005049,2.118327,1.414759,0.723625,2.231194,1.107255,2.221519,1.030558,0.109783,0.079331,0.122276,0.003387,0.520559,0.001564,1.942188,1.096521,2.265967,1.821336,0.112271,0.710042,0.004918,0.011162,0.00849,0.123988,2.295564,1.898881,1.773448,1.909448,1.455774,2.128427,2.056057,2.095221,0.610771,2.372253,0.325908,2.042096,0.700676,0.006358,0])
]


data_9=[array([0.370528,1.103271,0.003246,1.957814,1.130677,2.375835,1.987198,1.926864,0.624843,0.617343,2.111989,1.334187,1.386553,0.899335,1.570452,1.758679,0.954752,1.963305,0.423024,1.192964,0.758085,2.148889,1.668839,2.452135,0.656304,1.039723,0.754065,1.055777,2.508847,1.334971,2.363613,2.046501,1.713064,2.446373,0.507575,1.183064,2.32078,0.664512,0.450778,1.516314,1.55077,0.777221,1.816121,0.856077,1.452222,0.385949,2.548821,0.086759,0.858748,0.850686,0.861966,2.057807,0.106833,0.042983,0.165839,1.86661,1.315947,2.191076,0.624775,0.187364,1.380845,2.334765,0.582291,0.006594,1.294578,1.188302,0.118356,2.05421,0.798314,0.725585,0.779352,0.700925,0.1995,1.769693,2.445459,0.029252,0.063027,1.257701,2.317286,2.211811,0.158826,0.897764,1.039765,0.580401,0.092266,1.433631,2.330448,2.19602,0.59484,0.83809,0.637488,0]),
array([1.648068,0.095638,1.715458,1.923149,0.325389,1.41339,0.823332,0.587705,0.864137,1.648374,1.717495,2.335355,0.585899,0.62714,2.228569,1.18445,0.141311,1.080433,2.403181,2.297518,0.621446,1.720989,1.102247,0.123956,0.547825,1.032136,0.011354,0.541833,0.664349,0.958407,0.117812,0.264605,1.290038,1.507324,1.303049,0.305563,1.931916,1.126607,0.026315,1.249539,0.010987,0.124603,1.229016,2.463182,0.121763,1.035479,0.908363,0.552439,1.767102,1.003945,0.601127,0.480906,0.004294,2.411556,2.465686,1.287635,0.668201,0.551719,0.847858,3.340059,2.363751,0.95952,1.92673,2.915109,1.991782,0.186293,0.564916,0.856974,1.507129,0.010899,0.236549,2.532408,0.084933,1.711285,2.533806,1.867463,0.66666,1.638117,2.504324,1.558065,0.480876,2.346078,0.554584,0.747836,0.290471,0.576907]),
array([0.262125,0.204451,1.721528,0.8141,0.106869,1.584754,1.788002,0.544769,2.007558,1.102968,2.216164,0.014583,0.004355,0.011472,2.498492,0.011511,0.784363,1.438114,1.039983,0.693172,0.001138,1.575706,0.003321,0.005059,0.010798,0.778161,1.095148,1.767501,0.393927,1.894924,0.965933,2.283522,1.111759,1.099754,0.330023,1.195842,0.560313,1.350262,2.252594,0.010356,0])
]


data_10=[array([2.161727,2.512866,0.017534,1.022494,0.199454,0.31866,0.992671,0.511905,1.986688,0.853294,0.241628,0.095043,1.84045,1.868638,2.535231,0.200462,1.711079,2.14033,0.695388,1.149938,2.113269,2.205142,1.441359,1.02261,0.874174,1.857224,1.320046,2.546037,0.043897,0.3238,1.504649,0.112303,0.428869,2.077275,2.273546,1.953152,2.368699,2.531039,0.164304,1.637932,0.021743,0.991431,1.783344,0.160393,2.456326,1.240978,2.477678,1.05782,0.658463,1.475077,1.092692,1.443363,1.262,2.182867,2.228366,1.406378,2.169524,1.43949,2.539599,0.58468,0.165859,1.877217,0.278067,0.009905,0.769217,2.528072,0.335246,0.807304,0.080579,0.140253,0.338871,1.376374,1.117616,0.885056,2.322428,1.051493,0.120651,0.321335,1.442835,0.828585,1.68447,0.45928,0.147758,1.551059,0.0072,1.948788,2.413866,0.027915,0.660656,2.265759,1.471219,0]),
array([2.090416,1.565192,0.344111,2.189965,2.533181,0.41151,2.343668,1.492702,2.450533,1.975847,0.529618,1.395007,2.52683,2.280265,2.082887,1.662174,1.829959,0.118837,1.821961,1.843818,2.168615,0.843568,1.725055,0.023486,2.310116,1.512125,0.004476,0.296127,2.540703,2.564223,0.232476,0.692743,0.788192,2.031033,1.305667,1.102442,0.038302,1.11677,0.006866,0.818193,0.011157,0.072499,0.563718,1.794981,0.231973,1.251131,0.087565,1.522207,0.467769,2.386427,0.955802,2.243909,0.002212,0.851791,2.093751,1.370412,1.214559,1.434084,0.941564,3.374312,0.623683,2.19548,0.072189,2.843984,2.430253,0.154237,0.621429,1.02936,2.142401,0.010035,2.131208,2.186448,0.683098,2.359721,1.353731,1.309273,0.885258,1.043113,0.21934,0.768721,1.87077,1.648543,1.197419,2.579947,2.329975,2.154744]),
array([1.250988,2.286279,0.531957,1.820393,0.408483,0.553199,0.823037,0.404693,2.600377,0.164819,1.510119,0.002429,0.104897,0.004423,2.498282,0.006807,0.479108,0.170601,2.225968,1.535028,0.029628,2.185145,0.001355,0.005207,0.009124,0.636972,0.607301,0.872537,0.126433,0.810426,2.346257,1.733661,1.098888,2.282118,0.337784,2.225175,0.551888,0.546585,1.234636,0.005677,0])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Perissodactyla_1',  'Perissodactyla_2',  'Perissodactyla_3',  'Perissodactyla_4',  'Perissodactyla_5',  'Perissodactyla_6',  'Perissodactyla_7',  'Perissodactyla_8',  'Perissodactyla_9',  'Perissodactyla_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Equus','Hippidion','Tapirus']
def get_taxa_names(): return taxa_names