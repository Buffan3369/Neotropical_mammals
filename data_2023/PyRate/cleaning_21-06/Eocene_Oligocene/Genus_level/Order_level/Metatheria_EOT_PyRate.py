#!/usr/bin/env python
from numpy import * 


data_1=[array([24.554459,27.29517,23.823208]),
array([27.027508]),
array([45.911068,53.706343,38.819187,46.371181,50.077613,54.674625,45.853353,40.769132,44.878773,46.354607,39.594147,41.957959]),
array([26.151223]),
array([44.939714]),
array([24.867074,24.953012]),
array([34.715114]),
array([47.514663,41.902184,41.588934]),
array([40.709634,50.327153,45.145083,44.391507,40.12354,40.446117,39.966061,44.197268,44.646524,44.194239]),
array([26.69192,25.978244,26.061475,27.182037,23.995526]),
array([52.758818,47.498276]),
array([49.458292,50.21516,52.344573]),
array([51.865333,36.70636]),
array([51.283676,50.911751]),
array([25.141091,23.17569]),
array([36.414276]),
array([34.205164,34.862007]),
array([35.33481]),
array([34.584132]),
array([42.685713]),
array([30.137418]),
array([52.681029,25.605625,33.671708]),
array([48.005116,51.677162,47.944578]),
array([29.741478]),
array([38.21387,39.753748,39.634639,40.173985,40.224143,39.392032,39.336121,38.559513,37.818426]),
array([32.86963,25.129173,25.596873]),
array([26]),
array([51.629714,54.786533,54.210043,46.138047]),
array([42.898177,45.780383,53.924205,50.763243]),
array([33.83616]),
array([30.760554]),
array([32.497595,29.31693,31.134326,28.057773]),
array([33.470341,29.694981,43.722075,28.174189,28.810273,36.883004,35.092336,34.083673,31.667663]),
array([29.37124]),
array([54.845242,49.892082]),
array([40.106281,40.899833,40.47948]),
array([23.593306,27.446246,24.7436,24.977956,23.960511,23.135202,24.42908]),
array([23.888221,23.400132,23.040559,30.683298,29.702738]),
array([45.974511,49.917707,44.110344,51.954643]),
array([27.421366]),
array([23.484817,25.610835]),
array([23.763219]),
array([43.274735,33.563771,38.656237,40.434305,44.866475,43.123639,53.789162,53.60491]),
array([34.727431]),
array([41.608974,39.948563,37.746116,36.285102,34.604071]),
array([27.170112,24.759455,23.554746,24.307274,26.475348,25.634416,26.709737,27.610047]),
array([32.488928,30.727682,23.476878,25.184316]),
array([35.402335,34.562716,40.005294]),
array([50.530047,38.09532,47.45251,46.179733,53.56041,47.831902,54.674284,47.097227,40.772015,39.992378,39.999698,41.657028,42.602911,47.383872,46.551736,38.755617,46.809697,39.470641,39.633877,38.928891,46.639976,40.729434,38.126859,43.362659,44.162831,34.446791,39.153528,42.231778,44.721013,39.708595,40.927331,42.628697,43.110257,41.047383,40.890882,42.327742,54.554187]),
array([33.482024]),
array([51.977728,47.266704]),
array([31.036507,34.211041,25.530366,25.910849,25.241908]),
array([25.125765,27.162642,23.245536,27.214897,25.246819,26.821253]),
array([38.298391,36.303068]),
array([31.18754]),
array([38.360083]),
array([43.663509,41.052002,46.619878]),
array([50.490129]),
array([23.623671,23.510029,23.407053]),
array([42.811874,33.84917]),
array([55.836079]),
array([33.470234]),
array([46.957795,46.652632,46.052217,46.603135,46.191527,32.453808]),
array([53.611231])
]


data_2=[array([25.945753,26.213895,26.614576]),
array([27.423467]),
array([45.140718,48.468229,38.138216,47.788066,51.663889,50.525924,39.215096,40.661068,47.186347,38.286975,40.969829,44.60246]),
array([26.112669]),
array([45.059874]),
array([24.678286,25.039717]),
array([35.809347]),
array([43.341141,40.207785,39.178902]),
array([38.004158,55.704298,44.852402,41.952723,38.423058,41.413961,47.597373,41.084714,45.110118,39.742539]),
array([24.853383,27.21512,26.825683,24.773125,23.807889]),
array([49.009348,47.550775]),
array([52.648457,50.647722,52.911974]),
array([52.145392,34.920006]),
array([50.128938,47.660496]),
array([25.130221,25.889429]),
array([37.078568]),
array([34.181608,37.491003]),
array([37.555477]),
array([34.943949]),
array([46.700173]),
array([32.555924]),
array([54.591123,23.464483,33.834205]),
array([51.109005,55.428574,49.954915]),
array([33.59693]),
array([40.333551,39.562284,40.714971,40.303692,44.966986,43.06451,39.942283,39.635035,47.289792]),
array([32.460814,25.121104,25.24047]),
array([26]),
array([50.173228,48.029718,52.309724,43.327334]),
array([45.752202,45.643501,49.07851,55.470812]),
array([31.69942]),
array([34.062858]),
array([28.787911,27.865237,33.777801,30.127877]),
array([28.039825,32.610238,39.942383,31.955899,32.749601,34.591281,34.162448,36.673697,28.723586]),
array([29.90545]),
array([51.807594,49.65984]),
array([38.801515,40.41037,43.890966]),
array([25.196271,24.15196,23.682306,26.056418,26.354267,24.598999,25.470266]),
array([24.045778,26.698643,24.269059,33.266722,28.220629]),
array([45.870287,49.375626,43.116723,50.780832]),
array([26.301543]),
array([24.678842,23.17469]),
array([24.90409]),
array([47.352058,31.094499,41.034185,38.731817,43.565194,47.095995,54.652782,49.035768]),
array([35.783528]),
array([42.109172,40.126425,46.232589,37.493672,31.335349]),
array([26.864358,26.471367,23.886616,23.070168,23.089435,25.957931,26.312569,24.629553]),
array([29.766707,30.621848,25.745556,27.614585]),
array([35.337734,34.313765,37.160621]),
array([48.993734,39.709043,42.160013,54.102551,53.96672,54.841154,54.522904,44.206542,40.594521,39.367585,40.301155,44.611163,41.991075,39.641775,43.745249,39.168139,38.87272,38.358043,38.655046,39.69018,44.726478,41.866474,40.659192,47.027912,43.971112,34.836902,39.013228,46.322962,47.773645,41.138721,39.82175,38.308006,40.344357,40.783027,45.182565,43.085834,55.851379]),
array([28.7316]),
array([49.410057,45.289682]),
array([31.975501,35.336223,25.663063,24.639129,24.629537]),
array([25.10441,26.652826,25.010137,25.867305,26.968006,27.514114]),
array([39.283717,37.56544]),
array([30.664232]),
array([38.157368]),
array([44.864703,40.859928,38.177384]),
array([53.246389]),
array([23.192793,26.636872,24.92593]),
array([40.259976,31.913695]),
array([53.54779]),
array([32.903962]),
array([43.733949,41.159461,47.113136,43.395973,45.381982,33.641065]),
array([49.105448])
]


data_3=[array([24.423209,26.778907,26.503841]),
array([24.255356]),
array([46.311711,52.591837,39.273287,44.214906,54.845566,52.40301,38.274416,40.252376,46.3622,45.823919,40.512511,46.873651]),
array([27.706428]),
array([47.530521]),
array([25.196124,25.898343]),
array([34.599617]),
array([43.445282,43.38781,40.684287]),
array([38.639555,48.426968,40.222074,45.570109,39.43663,40.837771,42.450169,47.590174,42.476257,38.977738]),
array([27.605093,27.688762,25.764678,24.563424,27.384225]),
array([52.587662,47.369377]),
array([54.311938,47.868172,54.783336]),
array([49.165117,36.100844]),
array([48.431169,50.974176]),
array([25.772428,26.336698]),
array([35.764972]),
array([34.510417,35.913169]),
array([36.141914]),
array([34.500067]),
array([42.857049]),
array([32.161727]),
array([49.094805,25.034406,33.811017]),
array([55.210543,49.267942,48.291077]),
array([28.79791]),
array([38.727324,41.0752,40.1403,38.874198,37.982332,38.763596,40.54812,40.192431,46.90574]),
array([30.314262,24.97958,25.865407]),
array([26]),
array([50.050942,53.088852,51.486355,45.757656]),
array([42.9833,44.407885,55.520917,48.535521]),
array([32.707303]),
array([31.528539]),
array([28.052191,28.155688,31.934127,31.913945]),
array([33.099652,30.587862,41.455382,33.425179,30.551971,34.296601,36.33414,34.552259,33.198242]),
array([31.60468]),
array([52.873341,48.050074]),
array([38.304975,39.876407,37.938412]),
array([23.242435,27.059507,25.493591,25.102664,23.187701,25.285978,26.972027]),
array([25.564138,25.472372,24.075481,32.556687,33.603206]),
array([44.689584,51.652865,43.606309,54.995749]),
array([23.907852]),
array([24.864459,25.765581]),
array([23.923431]),
array([42.489065,30.923384,40.300499,39.529181,43.375264,46.244785,53.780135,53.201514]),
array([36.21]),
array([39.34154,43.178956,39.239785,35.824703,35.518257]),
array([26.87326,24.63396,27.785509,24.442617,24.624934,24.015128,23.094656,23.813736]),
array([31.480481,30.679762,26.994223,25.383008]),
array([34.88672,35.152533,38.322195]),
array([47.930979,39.464767,42.528623,51.387618,49.392315,54.814767,53.52977,42.655121,38.866383,40.839701,38.53866,42.488425,47.289765,38.157103,44.003844,38.585913,39.617157,40.480547,39.156302,40.786501,46.055833,46.779551,40.771849,40.272422,40.906521,35.454315,40.245939,44.973683,44.535197,40.655819,39.841408,46.845017,38.85546,39.957101,40.271496,43.672482,50.713942]),
array([29.265247]),
array([50.723088,43.230666]),
array([33.773437,37.328932,25.247378,25.804779,25.311511]),
array([23.122376,24.880288,23.365951,27.412233,27.037267,23.088673]),
array([38.598988,35.264942]),
array([31.509504]),
array([39.700625]),
array([47.363908,46.883739,41.222641]),
array([51.416921]),
array([27.467273,25.500673,25.277011]),
array([42.415008,31.917387]),
array([48.076184]),
array([32.152961]),
array([38.517914,43.719499,45.058791,39.935727,38.421056,30.004453]),
array([49.607929])
]


data_4=[array([25.242121,25.664557,25.798884]),
array([23.39768]),
array([45.082094,54.999615,39.255178,47.07115,49.421632,50.049064,41.983085,38.479523,40.45641,38.011166,41.165638,46.475291]),
array([24.434138]),
array([46.01485]),
array([25.722748,25.302184]),
array([37.587953]),
array([38.180216,44.320718,42.84211]),
array([41.287303,50.747505,42.848552,43.181508,46.948119,45.726038,39.007789,47.102239,40.408217,41.340033]),
array([27.599466,25.03436,23.764834,23.231263,25.085264]),
array([52.372062,47.269665]),
array([48.499673,50.932578,51.409273]),
array([53.822845,36.681965]),
array([51.074708,47.113449]),
array([24.399374,26.429096]),
array([37.21251]),
array([35.921852,34.518942]),
array([37.53207]),
array([34.214138]),
array([45.173682]),
array([29.754168]),
array([55.136592,25.592783,33.572825]),
array([55.388147,50.989892,49.696202]),
array([32.961479]),
array([38.704714,40.145124,40.563682,40.642196,37.805077,41.959595,38.181405,40.664914,41.606091]),
array([29.912726,25.067104,25.632058]),
array([26]),
array([55.992054,49.506566,53.581345,43.389575]),
array([43.708339,43.574948,54.551959,55.23039]),
array([32.056076]),
array([34.625845]),
array([28.262166,28.923275,28.70219,32.053255]),
array([31.361854,30.340564,37.939021,31.570279,27.969682,35.079571,35.039214,35.665388,29.240518]),
array([31.888112]),
array([54.354523,54.695884]),
array([40.732668,38.198012,41.837264]),
array([26.909229,25.973372,25.966636,27.104719,26.208598,27.781726,27.750969]),
array([23.810886,27.277116,26.361595,30.524572,31.628561]),
array([41.76317,48.628689,44.586379,54.314935]),
array([26.981479]),
array([26.980513,25.179198]),
array([26.622079]),
array([42.561126,30.933328,38.751803,37.835194,47.750939,46.597029,53.773994,54.204507]),
array([34.493144]),
array([46.145514,46.860323,43.042605,36.61828,31.841593]),
array([27.218726,25.538197,26.262638,26.23396,23.245916,24.836121,23.233847,24.241492]),
array([32.757154,30.701392,27.524826,24.221352]),
array([34.605161,34.716535,41.139095]),
array([54.165156,39.112788,43.579825,42.685626,52.718499,54.041496,52.385218,42.863271,38.3389,40.461541,39.63141,41.52977,44.016256,45.606024,46.310833,40.006923,46.753891,39.714236,40.734182,38.858447,46.746433,45.198843,38.377206,38.572421,47.690919,34.359083,39.597533,45.384536,42.746092,38.847674,41.18214,39.636546,43.682552,39.334095,43.742008,44.869609,54.208958]),
array([30.492362]),
array([48.389516,47.125519]),
array([31.470896,37.558863,24.565959,24.864912,25.245748]),
array([25.071723,23.606014,23.951391,26.788607,24.343941,25.7506]),
array([40.726131,36.90216]),
array([32.240766]),
array([40.276156]),
array([37.756753,41.289259,37.800324]),
array([50.288734]),
array([25.0736,26.896726,23.184708]),
array([46.776585,33.489788]),
array([50.778867]),
array([30.124532]),
array([41.754056,46.239033,38.097554,37.78527,38.912944,31.573672]),
array([55.536046])
]


data_5=[array([26.85491,27.336809,23.892873]),
array([23.791198]),
array([43.159548,55.696677,40.025724,46.289602,52.071525,51.838905,42.32188,39.747689,47.45417,44.343085,38.382724,42.823659]),
array([27.638647]),
array([38.185632]),
array([24.614884,25.108316]),
array([34.457657]),
array([41.451479,38.062477,44.265053]),
array([40.345695,49.74063,40.609915,46.532877,46.805534,38.232474,38.408867,41.493813,38.851704,42.529698]),
array([26.23703,27.711282,27.665015,23.725471,26.738461]),
array([51.537324,47.612036]),
array([51.052841,54.521207,54.245645]),
array([55.602231,37.5739]),
array([50.666108,49.911733]),
array([24.606565,23.999213]),
array([35.076729]),
array([37.573785,37.674791]),
array([35.245989]),
array([33.474226]),
array([44.589242]),
array([31.338704]),
array([48.820894,23.78779,33.702706]),
array([52.072796,54.518078,54.19564]),
array([31.863728]),
array([40.234858,39.877549,40.762392,39.186439,40.147652,45.362828,38.154588,40.189866,39.70772]),
array([33.758806,25.655545,24.625]),
array([26]),
array([54.191862,55.46311,49.738667,43.506867]),
array([46.39946,47.689124,50.22406,48.157521]),
array([29.621065]),
array([35.19947]),
array([32.877994,32.952304,28.460787,33.613681]),
array([31.766437,30.403089,43.97681,30.590741,33.452036,37.404399,36.501887,37.541075,30.320337]),
array([31.975094]),
array([52.711889,53.398916]),
array([47.286229,39.851352,45.933441]),
array([25.601521,25.134554,23.433892,25.944991,27.354314,24.212234,23.722023]),
array([27.626145,26.846708,26.792363,31.114777,30.955306]),
array([44.06315,55.573803,42.552575,55.409368]),
array([26.830188]),
array([27.016466,26.071237]),
array([23.31055]),
array([47.391643,32.510531,38.202961,38.254582,46.966266,44.283179,51.41041,54.250176]),
array([34.233236]),
array([38.331875,46.239863,40.939182,29.013875,33.873976]),
array([27.094306,24.407468,25.363018,25.228339,24.813463,24.456528,25.793035,26.881851]),
array([33.071648,30.658131,23.547442,25.753367]),
array([36.347303,36.409128,37.781763]),
array([54.606811,39.2618,43.095199,43.951704,51.196672,52.871985,49.091679,42.578373,39.607333,39.221386,38.966479,45.511666,42.035869,38.514231,40.148487,40.773698,40.679719,38.232076,38.512688,40.341441,44.496669,44.140821,40.429398,42.350344,40.789786,34.699244,40.449522,46.613382,47.226192,38.045624,39.574346,45.467268,39.589246,39.347861,47.435005,46.440708,52.721321]),
array([28.557473]),
array([52.747816,46.448602]),
array([29.311421,34.178399,25.374635,25.790679,24.648878]),
array([27.647041,23.386018,26.378729,24.241993,25.75015,26.301563]),
array([38.438633,37.110898]),
array([29.880188]),
array([39.946651]),
array([47.558313,45.837537,40.310518]),
array([55.270409]),
array([25.992873,27.265423,27.531981]),
array([39.163766,30.339075]),
array([49.399038]),
array([28.207776]),
array([43.913593,46.69063,39.475314,39.477332,40.654253,28.260512]),
array([54.516207])
]


data_6=[array([26.705998,25.850077,25.906576]),
array([23.727211]),
array([45.365571,49.908492,38.361124,45.001811,48.498362,49.138803,38.357079,40.364866,46.101552,39.158767,40.647234,40.212637]),
array([23.916828]),
array([46.449336]),
array([25.409471,25.128874]),
array([37.606354]),
array([47.742502,42.713406,44.253807]),
array([40.201666,51.427378,46.490199,44.902165,45.588272,46.721772,38.727336,44.557438,41.25332,41.933841]),
array([27.554031,23.508165,24.332761,24.659921,25.846919]),
array([51.946304,47.377855]),
array([50.437367,51.217559,49.439562]),
array([50.425631,37.43522]),
array([46.438927,46.866672]),
array([24.668426,27.495522]),
array([35.212624]),
array([37.338753,35.962409]),
array([36.507661]),
array([34.827009]),
array([43.253438]),
array([30.07663]),
array([53.627192,23.951511,33.692373]),
array([49.57305,51.028825,51.687879]),
array([33.547225]),
array([38.166017,40.10123,40.961668,40.837566,38.498749,46.048334,38.816723,38.0741,44.345544]),
array([30.013684,24.907664,25.188451]),
array([26]),
array([49.844823,50.833617,50.593116,44.599795]),
array([41.932766,43.174254,53.733807,55.696649]),
array([33.078179]),
array([28.685997]),
array([27.992948,28.737412,29.728527,33.634298]),
array([33.639251,28.924353,41.529343,33.698647,29.633649,36.49039,36.730483,36.299263,29.13136]),
array([31.550983]),
array([49.514047,48.756955]),
array([46.8327,40.075998,46.597317]),
array([27.798474,26.583668,24.212779,26.619482,24.995749,26.722359,24.098366]),
array([24.190705,26.112043,25.877437,29.742072,31.23004]),
array([43.559668,52.717879,46.805733,52.385912]),
array([24.99743]),
array([26.363388,24.467823]),
array([27.622642]),
array([44.995239,32.47065,38.403012,40.054784,45.220777,43.115088,52.65095,49.795801]),
array([37.602291]),
array([42.35519,46.169854,41.347644,33.611235,28.194943]),
array([27.191677,23.64777,25.139326,26.168917,24.570281,23.08111,24.729836,23.173524]),
array([30.125804,30.750525,25.334013,26.637098]),
array([35.690138,33.946385,34.090172]),
array([55.849093,40.74081,45.928643,51.927086,52.385466,49.239386,51.301501,45.753389,39.564915,39.690907,40.097893,44.942975,43.636523,44.254008,44.221411,40.475078,41.959962,40.322012,40.816641,40.656281,47.581745,45.660334,38.317762,42.955964,38.232888,35.368816,39.626574,44.871996,45.685377,41.197659,38.301373,39.840903,43.534477,40.928125,45.810622,41.962093,49.638566]),
array([32.675943]),
array([55.847729,41.768592]),
array([29.853153,35.627319,25.739815,24.995008,24.793264]),
array([25.260057,23.288422,27.522665,26.365367,25.086662,26.279987]),
array([40.52702,34.32961]),
array([28.602763]),
array([40.355704]),
array([43.122723,37.7878,46.949681]),
array([53.061839]),
array([26.750454,23.581971,26.728647]),
array([42.084065,30.627763]),
array([53.413447]),
array([29.430771]),
array([38.546802,46.019265,45.338296,41.85324,45.320879,30.901263]),
array([49.743782])
]


data_7=[array([27.607862,24.377168,27.576167]),
array([25.422744]),
array([47.605048,50.978242,38.337486,46.914727,50.153628,49.851675,47.714493,39.303052,40.241597,45.274146,38.379263,41.782125]),
array([25.21383]),
array([47.053743]),
array([24.726112,25.392382]),
array([35.92903]),
array([43.21307,40.071256,46.444618]),
array([39.241168,51.615132,44.335496,43.919778,46.675284,43.262863,43.024153,41.403382,45.354824,45.163764]),
array([25.45008,25.973498,24.992514,26.982524,26.222424]),
array([54.614731,47.692658]),
array([47.868842,49.619337,49.020192]),
array([51.289118,37.367998]),
array([50.438566,49.346208]),
array([25.57255,25.700327]),
array([37.434526]),
array([36.428677,35.144516]),
array([36.652553]),
array([34.17299]),
array([47.317093]),
array([29.092659]),
array([55.048856,26.101215,33.687482]),
array([51.907322,49.011646,54.05375]),
array([32.507034]),
array([39.816003,39.946274,40.666465,38.597887,38.096746,40.883271,40.752332,38.456505,39.705684]),
array([29.552198,24.699141,24.77456]),
array([26]),
array([51.779973,49.226954,49.600942,41.810529]),
array([42.747352,44.915442,48.718663,51.59456]),
array([33.11223]),
array([32.461906]),
array([31.695252,28.786556,30.402115,29.23263]),
array([29.059734,32.794561,45.146757,28.61387,31.262987,36.236232,35.556212,34.786916,28.222535]),
array([32.032593]),
array([51.653895,55.83738]),
array([45.015962,38.765596,46.736929]),
array([25.423802,25.293154,24.087959,24.984454,24.452234,23.381515,24.989797]),
array([24.057119,27.502811,25.555941,28.534965,32.072002]),
array([46.15945,50.23192,44.4722,53.212333]),
array([24.749544]),
array([27.481378,26.373336]),
array([25.210793]),
array([47.190545,31.877731,41.059007,38.309955,46.375007,43.901409,54.264617,55.32473]),
array([36.813516]),
array([43.783827,38.909923,47.492129,30.964074,31.954984]),
array([25.444706,27.639399,27.237825,26.268423,23.461958,25.500241,23.206761,24.449208]),
array([31.496071,30.661251,24.668912,23.561791]),
array([34.578751,35.569539,34.495767]),
array([52.543326,38.451768,43.490343,38.400226,52.315055,48.45341,53.181903,44.133889,40.797843,40.915717,40.663985,47.735958,44.286461,41.77275,40.893844,38.804166,44.69368,40.986088,41.194829,38.969602,43.300914,44.45216,39.186384,47.218451,40.934949,36.228342,39.535256,45.673283,43.683528,40.233356,40.42412,38.069814,41.122722,39.637092,37.879447,46.73197,52.835431]),
array([32.959128]),
array([53.447861,44.045857]),
array([32.578652,36.110732,24.539111,25.971606,25.575347]),
array([27.056191,26.18577,23.776606,27.461442,25.28565,25.707249]),
array([40.963145,37.099381]),
array([32.879815]),
array([38.987483]),
array([42.639285,38.733438,43.438654]),
array([52.21296]),
array([27.454793,23.980308,26.853975]),
array([47.653796,33.804762]),
array([55.051388]),
array([33.808375]),
array([43.304224,44.594023,42.739376,39.220151,41.417589,29.354029]),
array([53.245454])
]


data_8=[array([23.879058,26.937683,25.099708]),
array([23.493715]),
array([47.452201,48.325849,38.543112,45.41528,52.228984,55.94926,40.415766,40.165302,43.227923,38.932573,38.020793,45.400228]),
array([27.471447]),
array([44.174246]),
array([24.911941,25.321687]),
array([35.387435]),
array([40.166314,38.889197,38.190594]),
array([37.939012,55.783355,38.713022,42.300681,42.118774,38.940786,39.797598,38.125663,38.245588,38.47315]),
array([24.239573,23.792742,23.951376,24.196988,24.684927]),
array([49.536601,47.623883]),
array([55.930602,50.531986,52.924589]),
array([49.041974,35.046095]),
array([50.17911,51.519876]),
array([24.291369,25.956238]),
array([35.81369]),
array([35.376849,35.977896]),
array([36.59906]),
array([34.084425]),
array([43.580208]),
array([32.944627]),
array([51.829633,25.753819,33.537529]),
array([51.102246,48.807071,48.966026]),
array([31.425788]),
array([38.923615,38.925523,40.334825,41.103375,38.316515,37.80457,38.561746,39.625716,38.91468]),
array([28.123273,25.029774,25.746322]),
array([26]),
array([48.221275,50.990156,52.831235,43.06404]),
array([42.895392,46.422147,55.385624,52.680285]),
array([31.525144]),
array([36.46255]),
array([31.682536,28.640294,32.577674,30.353208]),
array([33.898885,32.963224,40.645337,32.018408,30.227648,34.522397,37.604642,37.11213,30.945779]),
array([33.637143]),
array([50.527471,52.817952]),
array([42.049891,39.433915,39.78823]),
array([26.391716,24.164874,26.319144,23.435051,27.348858,25.984812,25.893075]),
array([24.892256,25.951863,25.444168,29.040117,33.612901]),
array([45.714489,48.618156,44.52297,52.918981]),
array([26.838267]),
array([23.95947,27.702629]),
array([23.357457]),
array([44.161144,27.865616,37.77653,40.218222,45.971446,47.609609,55.769715,48.777013]),
array([35.009273]),
array([42.582637,43.991035,42.414001,36.719137,34.683751]),
array([25.649651,24.964211,24.672904,23.210363,25.373362,27.240616,26.007197,26.262115]),
array([30.809746,30.709248,25.099907,26.495629]),
array([34.867284,36.330094,34.270781]),
array([55.232271,38.002393,47.069179,52.709541,48.783506,49.954999,55.516127,44.905134,38.30788,39.656968,38.882228,44.12582,47.611598,46.408438,43.319852,38.657111,45.016111,38.513701,40.421631,41.088094,42.350571,39.75191,41.028376,43.872907,42.865314,35.315521,39.111864,44.188975,46.828127,38.215951,38.417352,43.725123,40.730083,40.177667,42.778257,42.399575,49.812403]),
array([30.510036]),
array([54.67976,46.543662]),
array([31.790045,34.127743,25.312955,24.77525,25.476932]),
array([23.080518,27.511634,24.84603,26.13986,27.602137,24.294788]),
array([40.274556,35.739728]),
array([29.775352]),
array([39.626103]),
array([38.839909,41.031108,39.692669]),
array([52.321367]),
array([26.548123,25.068467,27.626868]),
array([44.809258,31.177487]),
array([48.866601]),
array([28.509814]),
array([38.824068,40.249384,39.520921,41.460901,45.214271,32.238715]),
array([47.972581])
]


data_9=[array([26.242897,25.665401,26.395699]),
array([25.118788]),
array([45.222363,53.540356,39.171301,42.464113,48.08253,49.326838,45.10381,40.512651,44.396252,46.965401,40.343235,42.354813]),
array([24.773141]),
array([43.196655]),
array([25.650571,25.726846]),
array([35.597032]),
array([38.595132,42.119651,47.473177]),
array([38.73685,50.596485,41.492541,44.048493,43.8905,46.38579,42.300971,46.240984,46.996609,42.869608]),
array([26.07967,27.566806,25.010493,25.976754,25.555443]),
array([48.846229,47.590452]),
array([50.473956,51.11668,55.43147]),
array([52.827865,35.390956]),
array([50.953575,49.678871]),
array([25.638941,23.24485]),
array([36.282168]),
array([37.005217,34.55541]),
array([35.182005]),
array([34.750922]),
array([45.499619]),
array([28.504742]),
array([50.785507,25.876424,33.635679]),
array([54.649476,55.205319,53.670575]),
array([29.307217]),
array([38.620404,40.58022,40.718293,38.48411,46.840954,38.401199,39.86666,40.813891,47.466809]),
array([32.589616,25.621926,25.96958]),
array([26]),
array([53.593722,53.70913,48.27939,47.078087]),
array([43.851479,42.970943,54.673027,54.748836]),
array([31.954561]),
array([36.713457]),
array([30.063539,33.673076,28.206384,31.69002]),
array([29.142922,30.038144,47.00472,28.314463,30.658239,37.60879,34.640778,34.823282,33.675762]),
array([33.84928]),
array([55.708586,48.76328]),
array([39.737739,38.54298,42.002042]),
array([24.009597,26.046368,24.415844,25.27155,23.882396,24.372272,24.140317]),
array([26.047202,25.51508,26.326286,33.477969,29.164546]),
array([47.085262,51.066938,47.476283,51.882805]),
array([24.839563]),
array([24.227495,26.275846]),
array([23.264486]),
array([47.446118,31.370799,40.874275,38.845094,41.29078,41.273594,48.649644,54.601678]),
array([36.323545]),
array([47.509275,38.075486,45.540116,30.678671,30.321383]),
array([25.023108,27.714428,24.64283,27.651726,23.040243,24.531753,25.194766,24.202714]),
array([31.86076,30.711089,25.638882,27.181294]),
array([35.23999,34.261026,34.522274]),
array([54.742839,39.466022,46.892686,38.027075,54.813568,53.736694,50.56783,47.18898,38.388618,38.11976,38.235888,41.440438,47.629289,46.74466,47.492743,39.076159,46.899095,38.293866,39.071831,38.542723,42.539053,38.514948,40.451347,45.199738,38.731214,35.257808,38.620165,46.155207,42.849472,38.762844,41.149913,41.410661,38.787316,40.073587,39.465126,43.557558,53.727289]),
array([30.465492]),
array([55.232575,47.467422]),
array([31.750846,36.801239,25.338306,24.538187,24.865427]),
array([25.99449,24.326956,23.312056,25.140041,27.467575,26.177424]),
array([39.539207,36.420634]),
array([30.25818]),
array([39.046576]),
array([38.432797,46.526403,41.019948]),
array([50.470276]),
array([26.422113,25.569753,25.860648]),
array([46.398319,29.097192]),
array([54.107518]),
array([33.155797]),
array([39.599153,40.68307,41.317137,39.46297,45.777999,32.648867]),
array([49.836263])
]


data_10=[array([24.495034,26.056802,27.300756]),
array([27.623101]),
array([46.359251,55.81469,40.614194,43.989442,54.806432,55.986504,41.208486,40.123606,40.313788,45.410503,38.414857,42.67646]),
array([27.571845]),
array([44.633436]),
array([24.558261,24.924757]),
array([34.463984]),
array([46.404461,42.256861,39.901752]),
array([37.865273,54.77754,41.539537,45.814991,46.70488,42.959082,46.75544,40.222541,37.936423,43.968473]),
array([24.368876,23.207061,23.683433,23.560128,23.711587]),
array([49.001,47.297893]),
array([51.646762,53.340664,55.826866]),
array([48.903817,36.468502]),
array([50.252714,52.362059]),
array([25.871539,23.459802]),
array([37.026611]),
array([37.657022,34.184186]),
array([35.722997]),
array([33.303226]),
array([41.40169]),
array([28.500165]),
array([50.828848,23.956046,33.719742]),
array([53.196625,51.439554,52.523397]),
array([32.395431]),
array([39.820118,39.499082,39.374373,40.213631,46.848288,39.68586,40.232274,39.841013,45.120113]),
array([31.895906,25.649882,25.966917]),
array([26]),
array([54.186203,51.192404,49.42098,47.699268]),
array([42.360362,46.671108,50.613141,48.784701]),
array([31.26792]),
array([29.031322]),
array([30.552473,32.52434,28.054015,30.412024]),
array([33.683417,29.775967,41.905503,28.273557,31.190562,35.836566,34.410174,35.756513,29.050271]),
array([29.124227]),
array([50.515455,55.682159]),
array([45.395939,40.584951,39.718305]),
array([27.362922,26.268892,23.62009,26.609311,25.862906,24.60352,25.696507]),
array([26.720865,27.496674,25.816244,31.558202,30.66605]),
array([41.867588,53.872891,44.879952,52.564358]),
array([27.19192]),
array([26.759025,27.179855]),
array([24.55364]),
array([47.744074,28.841377,40.737693,37.736257,45.740949,46.805013,55.572065,55.075059]),
array([35.875576]),
array([45.292641,42.275886,41.610083,28.397506,33.543162]),
array([24.34661,27.077296,23.642256,24.800201,26.228567,27.464394,24.124119,24.427748]),
array([30.918348,30.676497,23.613819,24.833915]),
array([35.779108,36.878454,37.379315]),
array([53.099921,38.936753,42.900719,39.683431,54.078564,54.634039,54.841051,45.401088,40.335189,39.3508,40.357465,43.008523,43.993137,44.837428,45.392471,39.784229,46.926192,40.174102,41.061221,39.358716,42.458943,46.125584,38.274926,43.632468,38.230281,37.340561,39.10149,44.173382,46.565123,39.771836,40.498934,40.356634,40.847766,40.626569,42.282012,43.580767,52.709735]),
array([33.241257]),
array([48.289686,47.535117]),
array([33.679026,35.780733,24.86198,25.996331,25.103461]),
array([26.157865,24.018656,23.936388,27.594248,25.450854,24.937099]),
array([40.645814,36.719691]),
array([32.230996]),
array([40.350882]),
array([45.913408,44.972951,37.726026]),
array([49.61464]),
array([25.626265,25.764634,24.677014]),
array([39.974223,29.875901]),
array([53.377344]),
array([32.940689]),
array([44.394613,47.214511,47.110964,39.240702,45.409077,30.279114]),
array([51.463477])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Metatheria_EOT_1',  'Metatheria_EOT_2',  'Metatheria_EOT_3',  'Metatheria_EOT_4',  'Metatheria_EOT_5',  'Metatheria_EOT_6',  'Metatheria_EOT_7',  'Metatheria_EOT_8',  'Metatheria_EOT_9',  'Metatheria_EOT_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Abderites','Acdestis','Amphidolops','Andinogale','Angelocabrerus','Antawallathentes','Apeirodon','Archaeodolops','Arminiheringia','Australohyaena','Bardalestes','Bobbschaefferia','Bonapartherium','Callistoe','Carlothentes','cf._Perulestes','cf._Proargyrolagus','Chlorocyon','Clenia','Coloradolops','Eomakhaira','Eomicrobiotherium','Epidolops','Epiklohnia','Eudolops','Evolestes','Fredszalaya','Gashternia','Hypodolops','Incadolops','Kirutherium','Klohnia','Kramadolops','Microbiotherium','Mirandatherium','Nemolestes','Notogale','Palaeothentes','Palangania','Parabderites','Paraborhyaena','Patagonia','Patene','Peridolopidae_gen_A','Perulestes','Pharsophorus','Pilchenia','Plesiofelis','Polydolops','Praedens','Prepidolops','Proargyrolagus','Proborhyaena','Procladosictis','Pseudhalmarhiphus','Pseudolops','Punadolops','Riolestes','Sallacyon','Sasawatsu','Sillustania','Trelewthentes','Wamradolops','Woodburnodon']
def get_taxa_names(): return taxa_names