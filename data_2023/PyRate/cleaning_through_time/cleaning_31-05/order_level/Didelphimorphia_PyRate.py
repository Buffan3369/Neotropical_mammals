#!/usr/bin/env python
from numpy import * 


data_1=[array([0.009636,0.010966,0.006633,0]),
array([0.011537,0]),
array([9.367614,11.272749,0.571477,0]),
array([0.001817,0]),
array([4.933473,5.155853,5.228475,4.055233,1.394565,0.003709,2.34815,3.460221,2.596847,3.299346,4.117382,4.20193,0.074329,1.947864,0.543388,0.181415,0.299375,5.277552,0.004879,0.002299,0.004384,10.893907,0]),
array([0.004829,0]),
array([0.930069,0.816965,1.039482,2.229103,0]),
array([5.081559,4.962434]),
array([0.006664,0]),
array([5.226496,5.151132,3.781127,7.653418,5.209961,3.908113,5.099994,3.920196,4.839456,4.596791,2.671354,3.410833,5.634085,4.671061,4.086332,0.049636,3.799812,2.641619,3.979964,4.006101,5.102472,2.017791,4.072408,4.95945,4.070001,5.076711,4.357391,4.738488,8.168199,9.251248,8.257971,7.0203,5.528656,7.332658]),
array([61.918022]),
array([2.320554,1.039219,0.134884,0.090139,2.699747,0.005684,1.086972,2.095603,0.003534,0.004585,0]),
array([11.119079,0.353991,0.16888,5.142838,4.257782,5.223143,2.806199,3.986194,5.057405,4.638055,0.454023,0.00699,10.490724,4.749823,4.401473,4.515708,0]),
array([3.619471,0.001665,0.010443,0.001892,0.002162,0.006719,0.870123,1.057018,1.012161,1.489183,14.051333,0.113634,1.79463,0.010062,3.69107,0.007508,0.00168,0]),
array([0.00291,0]),
array([0.002704,0.005235,0.005801,0]),
array([0.009275,0.756592,15.409847,12.541264,15.112598,13.975429,17.86594,12.694038,14.004002,12.673967,12.37877,0]),
array([64.434076]),
array([0.009948,0.005022,0.003637,0.227872,0.725128,2.568877,1.36683,1.718433,0.306578,2.07853,2.266312,0]),
array([4.887997]),
array([9.514854,10.406043,0.011092,3.873704,0.001265,0]),
array([0.560682]),
array([4.968188,3.710021,5.038379,4.173877,5.310655,4.499838,5.230121,2.716152,4.171775]),
array([63.208455]),
array([1.299087,8.04654,2.209106,1.462826,6.415524,0.001868,0.262142,1.151186,1.078546,13.37051,12.705797,5.327729,4.659166,15.808302,14.676985,14.31978,15.68577,0.001432,0.010124,0.002004,0.011457,7.699257,10.831419,7.781362,7.261591,0.011623,5.153102,7.498906,0]),
array([7.727023,7.875503,3.062299,9.674571,9.877555,8.447545,10.377247,9.382602,7.619732,7.931626,10.052551,7.695702,6.787608,10.773307,4.60464,4.823618]),
array([2.994479,3.755786,5.038682,4.660903,4.728717,4.117455,5.183512,3.251755,3.323187,4.179264]),
array([63.443614]),
array([10.293514,10.280648,5.853021])
]


data_2=[array([0.003906,0.010618,0.007404,0]),
array([0.002596,0]),
array([9.689512,8.758758,0.715867,0]),
array([0.010498,0]),
array([4.654564,4.596471,4.451044,4.859325,1.658992,0.000531,0.840932,3.504956,0.913308,3.580506,4.117158,3.86715,0.115582,0.275125,0.115612,0.301017,0.423973,4.787192,0.006625,0.004029,0.007805,8.473524,0]),
array([0.003707,0]),
array([2.485987,1.957106,0.742812,1.85417,0]),
array([4.239614,4.042643]),
array([0.001461,0]),
array([4.731625,4.892523,3.802888,8.802904,3.982633,4.762116,3.810121,4.492779,3.701786,5.250345,2.752647,3.163753,4.106095,5.153815,4.736112,1.535092,5.267751,3.10309,5.035603,4.299831,4.422271,1.404356,4.267026,4.232611,4.060044,3.873032,4.822662,3.733899,6.793074,7.332178,11.047103,11.191095,6.960123,5.125773]),
array([64.818596]),
array([0.659865,2.033079,0.127428,0.098497,2.894836,0.003424,1.254035,0.341288,0.000217,0.004398,0]),
array([7.338683,1.406936,2.555849,3.869077,4.29715,4.937786,3.306974,4.573003,4.811545,4.824767,1.405825,0.011026,8.839904,4.074592,4.713921,5.093605,0]),
array([3.962551,0.002103,0.008448,0.003003,0.006937,0.009613,0.649015,2.044657,1.565229,0.924221,13.544176,1.24067,1.631663,0.008939,3.826772,0.006597,0.009953,0]),
array([0.001901,0]),
array([0.006939,0.001456,0.006022,0]),
array([0.004636,0.969733,14.730702,13.161882,12.534482,13.511211,19.50378,11.659475,12.611207,15.826774,15.945855,0]),
array([63.813469]),
array([0.003378,0.005585,0.009133,1.83518,0.383977,1.631099,1.504427,0.816914,1.845961,1.556851,1.464017,0]),
array([3.69343]),
array([8.307188,6.157854,0.001727,4.756716,0.010516,0]),
array([1.212275]),
array([4.942248,3.754204,4.059281,5.017989,4.571537,4.257373,4.933065,3.123957,4.084744]),
array([64.700623]),
array([2.548933,10.957832,0.453465,2.019359,7.417709,0.006611,1.404613,0.557277,2.370038,15.579784,14.036317,4.9717,4.213814,13.978857,12.147157,12.671807,14.867287,0.004833,0.011097,0.003121,0.009288,11.269128,11.499351,8.905964,10.238138,0.008127,5.182424,10.190754,0]),
array([7.833439,11.535218,2.847589,11.345618,6.225815,7.067499,5.958909,7.419,7.322753,10.837139,8.73395,9.256135,5.756671,7.590848,5.193795,4.586152]),
array([2.69074,4.989829,3.614573,4.605118,4.235217,4.366067,4.083991,3.33958,2.753976,4.539991]),
array([63.115447]),
array([9.045608,10.881683,6.836372])
]


data_3=[array([0.010713,0.010229,0.01008,0]),
array([0.011549,0]),
array([8.868281,9.768415,0.70324,0]),
array([0.002251,0]),
array([4.420421,4.525885,4.229336,5.324295,2.490591,0.011147,1.09814,2.937895,3.421008,2.962241,3.890545,5.324277,0.120553,2.357687,0.92377,0.244202,0.548487,4.33159,0.004199,0.00564,0.000135,10.986942,0]),
array([0.000713,0]),
array([0.511161,1.435195,0.282555,0.071062,0]),
array([4.092023,4.613531]),
array([0.010015,0]),
array([4.928654,3.954075,4.220489,11.484599,5.200655,4.967138,4.912865,3.661223,3.839777,3.825094,3.452271,2.758709,4.594269,4.093639,4.647859,2.371194,3.961869,3.241642,5.030619,4.113282,4.151172,1.834854,3.8279,4.605562,4.926628,5.087702,5.068137,3.667438,7.00335,10.810912,6.191578,6.743325,5.502531,4.170482]),
array([62.977543]),
array([0.037837,2.507175,0.874426,0.034466,3.335112,0.009308,1.40006,1.993069,0.008265,0.003513,0]),
array([8.951263,0.744991,1.63088,4.944332,5.267027,5.092645,2.794343,3.942307,4.284229,3.729045,0.37993,0.007725,11.475466,4.78198,4.753242,4.202342,0]),
array([5.299745,0.004647,0.002928,0.000235,0.008774,0.006322,2.459575,0.568469,0.414179,1.163034,13.47527,1.908947,0.867049,0.001912,5.288859,0.007311,0.009375,0]),
array([0.010142,0]),
array([0.010061,0.004911,0.010285,0]),
array([0.004527,2.284752,11.920457,13.984652,15.547532,14.528174,20.090625,12.26861,15.23164,12.966826,13.979697,0]),
array([65.250379]),
array([0.003201,0.002692,0.004356,0.228161,0.44206,1.085974,1.420754,2.114531,0.755997,2.473413,2.477214,0]),
array([4.71885]),
array([6.29452,8.000503,0.006033,4.034639,0.007809,0]),
array([1.907579]),
array([4.367245,3.64087,4.858345,4.567354,4.114804,4.256977,4.449377,2.646536,4.230914]),
array([65.027706]),
array([0.660196,9.060712,1.475633,0.746184,8.518837,0.002049,1.901505,0.742169,1.586,11.850085,14.60962,5.026309,4.312313,13.04501,15.085228,12.016826,13.066033,0.001594,0.010408,0.009237,0.002741,8.317847,8.554024,6.161545,11.079726,0.004075,4.307017,8.198609,0]),
array([7.361399,8.538653,3.120629,11.579825,8.351296,6.221333,6.892794,11.254393,10.775717,5.50435,11.246222,10.124835,7.413324,7.953681,3.717411,3.844207]),
array([2.790274,3.781139,4.122498,4.563936,3.704863,4.469218,4.808304,2.610576,2.875439,4.178384]),
array([63.660745]),
array([7.338621,9.586783,5.94048])
]


data_4=[array([0.006951,0.006073,0.00914,0]),
array([0.006072,0]),
array([11.394447,8.024062,2.431918,0]),
array([0.011407,0]),
array([4.755406,5.138517,5.332959,3.863722,1.987766,0.004087,0.357881,3.211418,2.355226,3.530296,4.807971,3.627106,0.08165,0.671056,1.940267,1.357921,1.890498,4.598873,0.008706,0.010896,0.002581,8.876337,0]),
array([0.011234,0]),
array([1.458733,0.656897,0.860465,0.621943,0]),
array([3.712053,5.056834]),
array([0.002082,0]),
array([4.799921,3.946008,4.333259,8.74856,4.363579,4.172702,4.643393,4.225228,5.03979,3.700342,3.464729,3.540996,4.998795,4.99242,5.241202,0.406865,3.883992,3.192829,4.432749,4.860206,4.166903,2.10035,4.036888,4.391397,4.741318,4.076777,5.161898,5.137972,7.171262,7.738616,10.236507,6.289838,6.564666,4.441918]),
array([63.532715]),
array([1.60695,1.915772,1.760766,0.091691,3.305218,0.001769,1.08102,1.324953,0.000792,0.010192,0]),
array([10.897129,2.521944,0.253677,5.019398,5.060876,4.538521,2.594778,5.204929,3.743604,4.54321,1.609796,0.008623,11.204476,4.637226,3.758211,4.872636,0]),
array([3.990971,0.007832,0.007574,0.008729,0.008415,0.001059,2.336944,1.506296,1.967343,2.539291,11.750544,0.722991,0.882035,0.010621,3.736111,0.009819,0.003372,0]),
array([0.007868,0]),
array([0.003428,0.004237,0.005208,0]),
array([0.008862,1.678662,12.723788,12.612893,13.398892,11.829709,18.933656,12.840767,12.016782,12.230017,12.9524,0]),
array([64.700419]),
array([0.004487,0.000804,0.009253,2.092429,1.011501,1.438339,2.207094,2.369507,2.028315,1.553008,0.677301,0]),
array([5.038264]),
array([11.269495,8.90159,0.000904,3.751396,0.004204,0]),
array([0.578768]),
array([5.331139,4.758251,4.014202,3.774921,4.640665,4.975209,5.302469,3.033216,4.138605]),
array([65.815403]),
array([1.666668,8.482557,0.945257,0.128531,5.49665,0.00675,0.169943,1.641396,2.344654,13.789104,12.705755,3.671386,3.803836,14.032711,14.203569,13.272313,14.367145,0.009754,0.001201,0.011599,0.001421,10.779036,6.544438,10.850269,10.060411,0.002286,3.800277,7.524038,0]),
array([10.114049,7.268355,3.361736,7.031583,8.322527,8.908592,10.928712,6.403294,6.881461,7.01451,5.755678,8.34661,11.474775,10.71669,5.082649,5.010179]),
array([3.301139,4.33669,4.389848,3.814057,5.035093,3.908965,4.730854,3.599784,3.389234,5.043294]),
array([64.557948]),
array([6.2481,5.41261,6.523693])
]


data_5=[array([0.008398,0.003155,0.002531,0]),
array([0.005083,0]),
array([9.337778,10.205256,0.827939,0]),
array([0.001916,0]),
array([4.618311,4.492956,3.963578,3.678856,1.289973,0.003116,2.460571,3.090435,1.286895,2.62805,4.729487,3.628965,0.103816,0.664866,0.566264,1.481534,1.480916,4.828052,0.011202,0.000653,0.006365,8.883602,0]),
array([0.011015,0]),
array([0.886219,2.01569,0.94587,1.797708,0]),
array([4.099796,3.648057]),
array([0.009521,0]),
array([4.891861,5.109016,4.392618,10.243102,4.020457,5.109866,3.910357,3.75757,4.10102,5.031383,3.435624,3.063944,4.757632,4.716436,5.081416,0.931765,4.82066,3.200335,4.532836,4.049298,4.28674,1.46078,4.363773,5.106942,5.260944,4.970822,4.706928,4.76101,7.395188,9.364182,8.531801,11.304667,5.406659,5.494475]),
array([65.920134]),
array([1.364747,0.978925,0.875954,0.068802,3.040418,0.002944,2.384133,1.37117,0.008599,0.0019,0]),
array([9.971055,1.754416,0.730191,4.576734,4.122796,4.829003,3.579111,3.922778,5.04838,4.651145,2.198706,0.00933,5.406423,5.2449,3.867719,4.418022,0]),
array([4.991757,0.003825,0.005135,0.000167,0.005574,0.007412,0.115034,0.10991,1.838788,1.627584,15.332166,2.233641,2.227584,0.010106,3.760508,0.011084,0.000832,0]),
array([0.00077,0]),
array([0.006633,0.005841,0.001251,0]),
array([0.007438,0.935225,13.17551,12.665305,14.093436,15.271613,17.536508,13.135632,12.45422,11.931244,15.477632,0]),
array([62.039772]),
array([0.004542,0.007999,0.002898,0.090872,2.161907,0.456977,1.664284,0.950415,1.549431,1.138964,2.260632,0]),
array([4.101739]),
array([11.010558,10.03743,0.010385,4.182267,0.008286,0]),
array([2.146772]),
array([4.083248,4.489961,4.663161,4.034678,4.548582,4.692928,5.035068,3.210622,4.157568]),
array([64.237306]),
array([2.205065,9.025335,0.421083,2.033259,9.621376,0.006602,2.158568,1.214948,2.189739,11.662454,14.599267,5.040572,5.246265,12.770834,14.108003,12.740491,11.713116,0.008059,0.000736,5.9e-05,0.008116,9.717055,7.143048,9.153198,6.058924,0.009866,4.335647,10.668425,0]),
array([6.210651,10.306289,3.000442,7.76069,5.502034,9.455319,8.483831,9.189842,6.770587,5.875776,5.354456,10.205503,10.70886,8.524415,3.791371,4.915789]),
array([3.247469,4.807038,5.258155,3.741802,5.069092,4.453415,4.431923,3.281205,2.973166,4.741966]),
array([64.560783]),
array([5.995494,10.800984,7.206707])
]


data_6=[array([0.003708,0.010204,0.005503,0]),
array([0.001565,0]),
array([10.080527,6.382952,1.552462,0]),
array([0.000176,0]),
array([3.655688,4.134771,4.232265,3.904753,2.499828,0.003296,0.329522,3.522085,1.085014,2.700531,4.234705,4.872532,0.053914,1.610168,1.619047,0.114946,0.716394,5.310494,0.010908,0.001236,0.007266,11.385239,0]),
array([0.005885,0]),
array([1.165809,1.607326,0.584761,0.107918,0]),
array([5.190944,4.707677]),
array([0.006306,0]),
array([4.208161,4.034221,5.026782,6.571841,3.775554,4.857952,4.288296,3.742522,5.139619,4.601754,3.569906,3.052931,4.187075,3.998959,3.745383,1.026138,3.784539,3.268155,3.798041,5.249553,5.258725,0.529414,4.211469,3.679657,5.218137,5.243347,5.279329,5.129579,11.151449,9.979594,9.115017,11.043323,6.36763,5.437464]),
array([64.082573]),
array([1.29815,0.859215,2.509949,0.075491,2.640538,0.003624,0.062255,1.459255,0.000345,0.006483,0]),
array([5.546675,0.984135,1.641413,3.95909,3.610504,3.829663,3.469718,4.509407,5.201587,3.608312,2.355089,0.007507,7.110119,4.215746,4.915186,4.417388,0]),
array([3.690792,0.009012,0.00728,0.005627,0.011642,0.004673,2.469124,0.062467,1.022754,1.194212,14.842247,1.666811,2.292525,0.007762,4.277703,0.003186,0.009625,0]),
array([0.00083,0]),
array([0.006353,0.001583,0.009711,0]),
array([0.003709,1.353948,15.818674,14.881324,13.614548,12.407251,18.072767,11.999328,14.387145,12.106538,14.319678,0]),
array([63.090115]),
array([0.003083,0.007192,0.000622,1.065676,0.524418,1.608224,1.467653,1.874084,0.5019,0.90822,2.401352,0]),
array([5.15543]),
array([11.569473,7.98528,0.008926,5.030988,0.01053,0]),
array([1.213049]),
array([4.716369,5.171582,3.891594,4.328505,4.692018,4.352825,5.194837,2.676278,4.99899]),
array([65.74673]),
array([1.176509,7.594016,1.831048,0.578976,5.974518,0.010601,1.488257,1.048167,0.882382,13.880406,12.617067,3.607332,5.088048,14.33662,14.419888,14.478809,14.552053,0.009565,0.001473,0.010541,0.003762,10.517135,5.968916,6.512639,10.489452,0.005281,4.688605,11.38803,0]),
array([7.003319,11.330789,2.855167,7.075005,11.616266,8.929144,9.425023,5.753918,10.936595,8.730976,7.065398,11.146514,11.364217,10.036749,4.165634,4.154993]),
array([2.894575,4.185614,5.211157,4.81223,4.928473,4.358187,4.662132,3.598033,2.589723,3.633045]),
array([65.115876]),
array([8.271395,8.989403,8.93835])
]


data_7=[array([0.010649,0.001101,0.010264,0]),
array([0.009403,0]),
array([7.684581,8.203503,1.505133,0]),
array([0.0051,0]),
array([5.219497,3.620087,5.070557,3.721413,1.853237,0.001109,2.316363,3.229207,3.301157,3.267239,5.255721,5.237348,0.027495,1.816458,1.038098,2.430087,0.281414,5.126622,0.005323,0.011413,0.003572,8.022358,0]),
array([0.010447,0]),
array([2.453553,0.53324,1.076621,1.690976,0]),
array([4.600337,5.187632]),
array([0.008542,0]),
array([4.353756,3.745265,3.779402,5.681983,3.90103,3.958077,5.045323,4.337417,5.145902,4.559597,2.637944,2.957567,4.766371,3.814111,4.362058,1.613404,5.033287,3.356058,4.958548,3.831994,4.720245,1.599543,4.777589,4.802489,4.630615,3.982385,4.142069,3.82002,5.436769,7.733287,7.227723,7.615544,7.126788,4.877527]),
array([62.800347]),
array([1.564133,2.007965,2.431172,0.055488,2.640122,0.006907,1.926156,0.018572,0.003869,0.004332,0]),
array([8.135602,0.333236,0.53277,4.344508,4.771385,5.039789,3.300108,4.102321,4.388515,4.072646,1.013787,0.007388,5.503927,4.475897,4.414535,4.226217,0]),
array([4.689881,0.002797,0.000304,0.002969,0.007697,0.005415,0.833753,0.030208,1.080388,0.465985,12.694617,1.939652,1.096837,0.008779,4.834134,0.011127,0.000751,0]),
array([0.002585,0]),
array([0.000935,0.009707,0.010506,0]),
array([0.001281,2.00967,12.408753,15.675159,14.975759,15.777799,20.115031,15.936009,12.271153,13.514225,15.081832,0]),
array([62.488932]),
array([0.009116,0.011513,0.004825,0.871564,1.319878,0.324474,1.137511,1.428136,1.286215,1.478357,2.274287,0]),
array([3.411167]),
array([7.567145,5.816133,0.010794,4.530948,0.006243,0]),
array([2.304801]),
array([3.811594,3.869164,5.028041,4.031187,5.029937,3.943683,4.589205,3.557154,3.617296]),
array([65.437899]),
array([0.255058,7.30937,0.928118,2.078895,7.138191,0.009066,0.436267,2.021569,2.423024,12.229452,12.024397,4.334452,4.945086,13.51624,11.98186,14.484483,12.706371,0.001361,0.000962,0.002708,0.011666,11.344471,8.525697,9.053672,5.775207,0.007122,4.891899,5.381224,0]),
array([11.376899,7.348681,2.853037,9.486261,5.482938,9.40717,6.517534,6.126334,10.951751,5.40115,9.213944,8.269923,10.692779,6.847063,5.178512,4.097778]),
array([2.9711,4.167329,5.23839,4.601159,3.842968,3.759296,4.307555,2.920683,2.798423,5.236245]),
array([62.837459]),
array([6.801387,7.859197,6.802308])
]


data_8=[array([0.008337,0.006425,0.004109,0]),
array([0.003394,0]),
array([8.785038,7.311073,2.472984,0]),
array([0.006134,0]),
array([3.680666,4.70451,4.78694,4.75955,0.986997,0.005975,0.151282,3.143432,2.283618,3.006693,4.090976,4.134974,0.021254,1.751736,2.180354,0.268242,1.800887,4.500486,0.000506,0.000441,0.005446,8.264832,0]),
array([0.006526,0]),
array([0.380974,2.555905,2.551285,0.668334,0]),
array([3.70321,3.674375]),
array([0.000506,0]),
array([5.235829,4.055883,3.695806,6.715896,4.681824,5.029457,5.262473,4.427917,4.622681,5.085542,3.33468,2.699177,4.65715,4.98563,5.208871,0.347112,3.929503,2.724151,4.794162,5.00111,4.478989,1.609739,3.90873,5.104974,5.192865,4.608537,4.399001,4.837597,7.484039,6.278189,11.590508,11.005137,6.464002,7.837998]),
array([63.504294]),
array([2.259792,0.961977,0.854081,0.087012,2.971255,0.00393,1.634227,1.167906,0.002642,0.000682,0]),
array([9.700545,2.550798,1.296224,5.197541,5.036109,4.731631,2.937374,5.261068,4.97024,5.176705,0.288453,0.010644,10.21942,5.222153,3.985099,3.847805,0]),
array([4.008753,0.005781,0.001137,0.008426,0.008306,0.004315,2.539197,0.683428,0.048963,0.569614,14.320478,2.547671,1.069517,0.00786,3.782227,0.003516,0.010601,0]),
array([0.002405,0]),
array([0.006324,0.009762,0.000703,0]),
array([0.001557,0.905377,14.326834,15.072732,14.357914,13.346311,14.807069,14.629218,13.82766,11.886411,12.870826,0]),
array([65.769522]),
array([0.006228,0.003271,0.004435,2.508119,0.559976,0.56088,0.355751,2.498124,1.684033,1.825132,1.899792,0]),
array([4.256864]),
array([11.330314,9.200891,0.011134,4.719015,0.009661,0]),
array([1.177002]),
array([3.965229,4.799855,4.683204,3.989856,4.643924,4.112259,4.730828,3.402897,4.262347]),
array([65.161949]),
array([1.289503,9.683879,0.678252,1.085044,11.535484,0.000756,1.992733,2.348575,2.107914,15.153319,14.398008,5.312191,3.861907,14.282962,11.677182,15.473446,14.809643,0.002668,0.011669,0.000449,0.001103,9.310127,9.608481,7.698974,5.357418,0.006125,4.453194,9.322756,0]),
array([6.459986,7.61943,3.428754,8.063777,7.811053,7.215082,9.62191,8.3601,5.706831,10.279113,8.947009,10.602185,5.758419,7.192356,4.249916,5.300845]),
array([3.468666,4.103109,4.958183,4.982155,5.242586,3.780467,5.047595,3.561614,3.132103,4.32949]),
array([63.672685]),
array([9.766553,11.457979,9.613362])
]


data_9=[array([0.008247,0.011493,0.009419,0]),
array([0.000365,0]),
array([10.074186,9.011658,0.381909,0]),
array([0.006565,0]),
array([4.328807,4.467145,4.369964,4.630685,1.502666,0.004119,2.521286,3.034349,0.980629,2.88764,4.700129,4.949962,0.02515,0.757187,1.628835,2.090774,1.173625,4.711004,0.011116,0.010309,0.00931,11.024868,0]),
array([0.004981,0]),
array([0.347354,1.721912,0.432949,1.643683,0]),
array([3.735844,4.509492]),
array([0.002674,0]),
array([5.182014,3.867871,3.786203,11.156692,4.750772,5.157771,5.036158,4.630181,4.835506,4.866123,2.939387,2.879138,6.847864,4.674802,3.947262,2.205983,3.841208,2.695225,4.984783,4.258466,5.102517,0.295698,3.732996,3.894381,5.107375,3.957322,5.279335,4.282252,7.777095,8.383515,11.460881,5.936157,5.697921,4.456627]),
array([62.384372]),
array([0.447902,0.485599,1.579321,0.086454,2.970342,0.008038,0.786861,2.230621,0.002799,0.008383,0]),
array([10.016755,2.088413,1.220736,5.174455,5.13613,4.441998,3.241302,3.992231,4.052093,3.803281,1.526582,0.007435,9.221083,3.856327,4.355503,3.69124,0]),
array([4.707196,0.009105,0.006808,0.009318,0.000398,0.010213,1.056609,2.18962,0.823958,2.07057,13.855933,0.110873,1.030096,0.00163,4.17093,0.005317,0.003907,0]),
array([0.003379,0]),
array([0.009366,0.000845,0.001193,0]),
array([0.003324,1.570474,11.73328,14.910568,15.305703,15.419164,18.979976,14.958783,14.197582,15.965594,13.300304,0]),
array([61.692195]),
array([0.011329,0.006294,0.005657,0.498412,2.223281,1.288832,2.173133,0.128233,2.24862,1.144789,1.732705,0]),
array([3.437184]),
array([5.730326,9.634468,0.011069,4.550093,0.011671,0]),
array([1.703576]),
array([5.081177,4.96275,4.237758,4.226781,3.942016,3.956123,4.258933,3.458982,4.660257]),
array([63.598862]),
array([2.248044,6.076877,1.72549,1.65742,6.552762,0.010064,0.099095,0.107571,0.889794,14.577695,13.55155,4.515365,4.876517,15.952043,14.889856,15.615521,14.613651,0.007229,0.011689,0.004283,0.009892,7.91058,10.902959,7.647353,5.422158,0.001639,4.250855,7.799063,0]),
array([8.339704,8.528064,2.937657,9.846471,6.656963,5.957497,9.657847,6.027707,10.898098,5.542185,6.571365,6.522463,6.728617,11.237522,4.721675,4.321774]),
array([3.186395,4.165244,4.637133,4.261774,5.1698,4.404551,4.669479,2.73995,2.764133,3.846823]),
array([65.787276]),
array([10.036333,8.607527,11.438343])
]


data_10=[array([0.001199,0.010431,0.007294,0]),
array([0.008945,0]),
array([11.388074,9.260057,2.412542,0]),
array([0.008259,0]),
array([4.773936,4.678961,3.933607,4.001662,0.933871,0.004117,0.224334,3.534694,2.574399,3.320902,3.831036,3.778583,0.106151,0.275638,2.419276,2.372804,2.00467,4.009977,0.002349,0.00842,0.007638,11.369885,0]),
array([0.008176,0]),
array([1.028429,2.004581,0.929719,0.110104,0]),
array([4.640926,4.863741]),
array([0.000389,0]),
array([4.571091,3.94878,4.547714,8.102244,3.664378,4.197809,4.156563,5.311788,4.755165,4.23478,3.089402,3.305927,5.26581,5.183883,3.793018,1.899224,4.517955,2.804979,3.856625,5.014047,5.119668,1.157315,4.89399,4.732842,5.240075,4.255464,4.134929,4.48427,9.637907,6.690172,6.74724,7.911937,6.943561,6.113405]),
array([65.858921]),
array([1.508081,1.320735,1.738468,0.055222,3.417745,0.010593,0.765151,1.703969,0.009099,0.001723,0]),
array([8.127778,0.54409,0.980399,4.505219,5.28965,3.709445,2.62118,4.578478,4.538697,4.598065,1.493933,0.002351,8.620828,5.195077,4.914386,5.053552,0]),
array([4.740776,0.004747,0.001118,0.00052,0.011216,0.010304,0.977181,0.794765,2.301704,0.003712,15.580931,1.81334,0.824832,0.004976,5.069012,0.008329,0.001903,0]),
array([0.006589,0]),
array([0.001466,0.008987,0.009044,0]),
array([0.010844,2.250544,15.634689,15.767832,13.211138,15.640448,17.808878,15.628188,13.295299,15.248745,15.624079,0]),
array([62.134484]),
array([0.011006,0.011154,0.004527,1.645169,2.330864,1.036162,0.297696,1.653436,1.910481,0.890704,1.152738,0]),
array([4.544611]),
array([9.178227,11.037279,0.008749,3.667696,0.004642,0]),
array([0.95726]),
array([4.524911,3.677993,4.062716,4.191673,5.11152,5.023493,4.611733,3.223268,5.08752]),
array([65.925361]),
array([1.804685,6.427627,1.799744,2.262649,11.56766,0.011456,2.32022,1.34604,1.17225,14.574813,12.396654,4.287573,3.838994,12.566603,12.959621,13.579385,14.732134,0.001134,0.007156,0.007044,0.003086,7.505897,7.919902,7.192431,10.926874,0.006869,3.648789,9.822369,0]),
array([11.32699,10.202935,3.250506,9.889582,6.428601,9.109795,7.156343,8.329126,7.786734,9.723662,9.122192,8.307616,8.038649,6.75983,4.635962,5.061765]),
array([2.686316,3.711322,5.1089,4.280367,3.978018,4.798124,4.849971,3.466442,3.331476,4.075941]),
array([64.863172]),
array([5.397382,6.387246,10.945023])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Didelphimorphia_1',  'Didelphimorphia_2',  'Didelphimorphia_3',  'Didelphimorphia_4',  'Didelphimorphia_5',  'Didelphimorphia_6',  'Didelphimorphia_7',  'Didelphimorphia_8',  'Didelphimorphia_9',  'Didelphimorphia_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Caluromys','Caluromysiops','Chironectes','Cryptonanus','Didelphis','Glironia','Gracilinanus','Hesperocynus','Hyladelphys','Hyperdidelphys','Incadelphys','Lestodelphys','Lutreolina','Marmosa','Marmosops','Metachirus','Micoureus','Mizquedelphys','Monodelphis','Paradidelphys','Philander','Sairadelphys','Sparassocynus','Szalinia','Thylamys','Thylatheridium','Thylophorops','Tiulordia','Zygolestes']
def get_taxa_names(): return taxa_names