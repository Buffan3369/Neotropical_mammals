#!/usr/bin/env python
from numpy import * 


data_1=[array([40.55444,44.041545]),
array([42.283164,39.856767,38.468935,46.793084,38.405184,49.890004,36.14295,48.310546,38.514859,41.149805,40.522334,39.182906,40.479448,48.229943,48.052642,48.469379,40.897665,49.003918,40.314965,48.151905]),
array([47.795271]),
array([54.180831,48.996739,48.024764,47.370311,40.425203,38.790732,48.939973,48.582534,38.901221,42.516863,48.585646,49.953384,38.369287]),
array([43.591268,51.40182,48.004429,46.525708,41.89043,47.845126,47.778562,49.643125,40.59654]),
array([37.449113,39.26867,39.319016,34.978274,35.681847,48.790275,34.261156,36.8817,36.883442,37.201634]),
array([28.766035,31.387953]),
array([54.477361,54.802193,50.51048]),
array([35.339407]),
array([26.936897,27.488696,25.817726,27.264348,25.147491]),
array([27.784245]),
array([26.93733,25.437061,27.11289]),
array([45.916485,48.110927,49.204022,47.187419,40.314637,40.135038,43.394732,45.895232,38.406022,38.286027,38.031842,48.836348,41.462378,40.198965,38.435108,49.458942,48.069685,48.256339,49.468119,40.248462]),
array([48.928977]),
array([48.082581,48.915023]),
array([34.918066,54.368395,44.555609,49.382516,53.355431,39.58616,38.525222,39.742185,49.782624,49.648597,40.457708,38.412217,49.733451,50.660306]),
array([38.531982,38.361741,29.17749,33.380249,32.29529,42.196122]),
array([38.625014]),
array([34.292886]),
array([31.306545,32.043796,30.857328,29.110498,30.062167,31.690994,31.311915,33.393793]),
array([46.572031]),
array([49.131424,23.690207]),
array([54.132262]),
array([25.555884,27.40603]),
array([30.629414]),
array([54.367688]),
array([24.713171]),
array([50.749764]),
array([25.490054,27.548708,21.645324,23.831552,27.520625,24.426605,24.009394,23.322903]),
array([40.245871,35.230297,40.576524,38.567703]),
array([42.530904]),
array([36.180626,36.088724,34.278847,35.23559,37.369756]),
array([34.647018,35.477724,36.39351,35.79515]),
array([24.662183,23.148898,26.815349]),
array([40.197754,48.329982,40.832876]),
array([24.026169]),
array([37.467277,37.033198,37.972883,36.335656,34.079894,34.314674,36.02908,35.39536]),
array([24.524343]),
array([26.270958]),
array([50.095927]),
array([54.552343]),
array([26.542415,24.72988,27.136523,26.359301,23.673857,23.692466,25.098171,26.220562,24.270198,26.677748,27.555547,26.600532,27.113928,25.963419,27.127746,25.834481,25.278408]),
array([49.930319]),
array([51.46576,48.384981,48.330041,39.781339,49.912304,38.36]),
array([28.907526,29.490499,31.919555,40.560047,49.223318]),
array([39.388896]),
array([26.864833,27.537304]),
array([49.056812]),
array([48.673074,37.918093]),
array([47.4773]),
array([40.644158,51.818558,52.71499]),
array([25.714652,23.137168]),
array([23.697872,25.000178,26.267905,25.798567]),
array([49.033914,40.203323,49.284989,39.98791,53.063091,49.502507,38.388512,55.656997,50.046798,48.626762,52.620843,45.621125,41.197003,38.764143,40.144995,38.234318,40.068783,39.93335,38.855966,38.902646,38.794393,39.337099,38.086743,43.362932,48.603538,38.173797,48.814067,45.930546,39.564856,48.506708,48.669599,39.094907,40.8998,40.481291,40.510419,48.608183,49.728835,40.93686,48.845593,40.147075]),
array([53.32176]),
array([24.683054]),
array([49.19985,41.499017,51.577141,54.680944,47.651577,49.149297,48.303801,49.163502,49.462985]),
array([25.169881]),
array([35.876175,37.304736])
]


data_2=[array([46.732644,44.924642]),
array([45.732384,40.637055,40.807682,46.881961,40.57189,51.584476,36.666602,48.744063,38.5363,38.051982,41.100532,39.924318,40.964342,49.470664,48.463782,48.402186,38.280178,48.277374,38.10072,49.826623]),
array([41.501918]),
array([54.457281,48.513167,54.314959,43.184762,38.114644,40.122131,49.585734,49.945814,42.557751,46.748115,49.889648,48.886393,38.301227]),
array([41.6002,53.739058,51.189252,46.153268,46.440914,47.878072,40.047399,48.36608,41.646789]),
array([35.233595,38.810082,37.187252,37.253426,37.682009,48.861729,35.785474,37.464545,36.711028,35.141688]),
array([32.407821,30.048553]),
array([50.371371,49.891541,55.652477]),
array([34.480591]),
array([23.686089,27.273363,26.832573,24.277665,27.371475]),
array([27.368859]),
array([23.103574,26.553003,27.50715]),
array([41.532565,48.708559,48.267305,47.126401,40.625845,38.500457,42.5058,42.415636,39.47238,39.811146,40.445768,49.764663,42.174206,41.04384,40.167109,49.938953,48.630247,49.338215,49.376114,40.603024]),
array([49.170934]),
array([48.104955,48.969662]),
array([34.278785,55.022828,42.212655,49.987791,48.530771,39.487489,41.801706,40.770685,48.198953,48.4147,40.278514,40.342004,52.528363,53.035827]),
array([47.448838,44.869325,32.748855,33.832949,30.446996,43.841289]),
array([40.424336]),
array([34.188989]),
array([31.220628,28.33033,30.045883,31.86322,31.343447,29.670273,28.337983,31.929842]),
array([47.106661]),
array([48.695425,25.61438]),
array([50.70851]),
array([24.657653,27.70091]),
array([30.643749]),
array([47.955158]),
array([23.6764]),
array([55.586693]),
array([27.173382,23.955604,21.277079,26.740374,25.738758,23.896232,25.993206,26.678438]),
array([39.418007,37.691748,39.129891,38.903783]),
array([40.227543]),
array([36.137142,36.842755,34.701409,36.271528,37.390932]),
array([34.583051,34.660503,35.605851,34.563434]),
array([24.515196,25.19524,26.942001]),
array([39.879574,48.783267,38.010337]),
array([26.621788]),
array([37.651219,38.851425,36.021056,34.079035,34.338765,36.095368,36.329659,37.44633]),
array([26.278715]),
array([26.952668]),
array([55.095451]),
array([49.234091]),
array([25.088724,23.899169,25.150655,25.70277,25.640543,24.532378,26.771538,25.116665,24.085047,27.818557,26.661537,26.308089,26.328387,23.297116,23.678614,23.657959,27.354789]),
array([51.638871]),
array([49.899676,49.743795,48.605487,40.554925,48.546625,40.675944]),
array([32.531134,32.780922,28.347407,38.706527,48.184168]),
array([40.104466]),
array([27.801669,27.130759]),
array([42.045521]),
array([48.864428,47.069183]),
array([43.965611]),
array([45.985497,49.486394,55.208999]),
array([27.380274,23.230419]),
array([26.266863,27.546355,27.439014,25.024605]),
array([48.913039,38.601905,49.678268,40.913661,54.989998,48.617275,39.439286,50.006573,54.121013,55.031848,50.92436,38.787271,40.100784,40.839697,38.10801,40.047239,39.17392,38.076143,38.603795,39.346716,38.314519,40.766009,38.163958,43.76328,48.146396,39.456163,49.858777,41.719734,39.624171,48.132109,48.266824,39.961854,39.389579,39.429935,40.427344,48.507139,49.856933,39.452272,49.018471,40.879278]),
array([47.883662]),
array([24.135764]),
array([49.521739,42.32329,48.518136,48.526681,45.317471,52.879121,49.459317,49.55761,50.113585]),
array([24.870454]),
array([35.186179,36.41668])
]


data_3=[array([44.691715,39.998489]),
array([46.323927,38.751073,39.676007,45.124831,39.913271,51.363883,36.909423,49.661705,40.506423,39.982188,41.141866,40.311269,41.040466,48.67632,49.75733,49.933623,41.181274,48.564476,40.050908,48.975711]),
array([39.564506]),
array([52.872589,49.765508,55.982783,46.792002,45.92845,40.013667,48.297102,48.518927,46.399881,41.504689,48.692408,48.36303,40.416946]),
array([43.753024,55.873446,54.265217,46.738613,44.841219,47.861128,45.698222,49.139122,40.875911]),
array([39.600025,37.110718,40.021046,36.131424,37.317078,49.04116,36.777072,35.433347,34.463568,37.261325]),
array([29.065571,31.754648]),
array([52.809888,51.919091,53.515094]),
array([35.866984]),
array([26.258865,23.578867,23.226258,24.728529,25.828188]),
array([25.827023]),
array([23.891358,25.309367,23.891148]),
array([41.848954,48.545538,48.941903,39.323978,40.756468,38.46055,46.505238,42.885648,40.665758,39.029751,39.223652,48.052073,44.51347,38.166973,38.663939,48.325128,49.191053,49.323026,48.428255,40.498166]),
array([49.27417]),
array([49.851855,48.853195]),
array([34.152603,49.920509,45.725924,49.788985,49.530087,38.575652,40.315501,38.212998,48.03657,48.917695,38.41992,40.920764,54.30462,49.317523]),
array([43.872839,42.033003,31.189904,29.30266,30.824655,43.875206]),
array([39.109519]),
array([37.139552]),
array([29.308598,33.191115,28.850843,37.653422,31.085388,29.978884,32.754055,32.584754]),
array([47.542684]),
array([48.298267,23.106903]),
array([49.663598]),
array([26.437155,26.66986]),
array([30.620683]),
array([49.26046]),
array([25.579231]),
array([52.221039]),
array([27.315208,26.292897,22.968706,23.4184,26.4346,24.953177,24.034052,27.208711]),
array([39.976491,35.519037,40.344543,38.608025]),
array([39.031423]),
array([35.505981,34.421547,35.581652,35.614677,34.689374]),
array([34.229044,37.085447,35.877474,37.641512]),
array([27.736394,26.224096,27.143621]),
array([39.993585,48.314046,39.835246]),
array([23.25925]),
array([36.678928,39.361218,38.078713,36.635576,36.381383,34.457672,37.519624,35.452823]),
array([23.073881]),
array([27.780015]),
array([54.667597]),
array([50.595715]),
array([26.474604,23.498491,24.642061,27.537294,24.388037,24.568781,25.703691,27.219228,23.511178,24.429335,26.041189,23.225674,27.415771,23.410202,24.32137,26.809968,23.329822]),
array([49.215415]),
array([48.748134,49.935676,49.889804,40.696004,48.233107,40.104881]),
array([33.122051,29.506849,30.083214,39.966291,49.011885]),
array([40.986102]),
array([27.445826,25.514648]),
array([44.320072]),
array([49.772509,44.997907]),
array([42.852034]),
array([40.369344,50.498294,49.011247]),
array([26.227167,25.638377]),
array([26.036735,26.986103,25.19289,23.807907]),
array([49.953022,40.263236,48.67049,38.651739,48.108864,48.902416,34.695959,49.59305,50.177139,48.190308,54.87555,43.964796,40.905805,40.436639,40.467579,40.671687,40.9241,40.18411,38.186564,38.518655,40.898358,40.339019,40.803397,45.814696,49.734138,41.045135,49.135216,47.785539,38.052791,48.073956,48.144052,39.567133,40.891606,38.988145,38.297044,48.426677,48.305595,41.096069,48.178936,41.218354]),
array([48.987452]),
array([23.942606]),
array([48.95586,42.797779,54.365812,55.572609,42.470462,51.103902,49.825518,49.693565,53.426543]),
array([23.355121]),
array([34.261434,37.275238])
]


data_4=[array([43.222937,47.468932]),
array([44.188406,39.491342,39.73087,43.412761,38.88333,48.894324,36.617958,49.089285,41.166816,38.118238,39.557951,39.070986,39.083237,48.863939,48.964573,49.603896,40.777105,49.087826,39.511733,49.926616]),
array([39.274223]),
array([55.219867,49.623253,48.661186,42.970759,46.438247,40.037059,49.271537,49.759577,44.242373,46.915449,49.301176,49.434622,40.455455]),
array([44.57758,55.248788,50.063785,47.076453,43.896799,47.866071,41.325281,49.446448,42.175992]),
array([35.682253,38.760467,37.488577,34.694224,37.252432,48.426711,34.126824,35.754342,37.473479,34.293424]),
array([33.528488,29.857541]),
array([49.798699,50.79068,51.09526]),
array([35.32885]),
array([24.27065,26.644186,23.984816,26.133653,27.169961]),
array([25.747386]),
array([23.518158,27.073377,24.5357]),
array([43.970021,48.139793,49.021765,43.761724,40.473165,40.028449,45.296648,46.221329,41.187844,38.659105,38.247099,48.223764,41.57397,38.455317,39.871693,48.709862,48.609311,48.987519,49.329882,39.565451]),
array([48.188101]),
array([49.87917,48.770078]),
array([34.49695,51.587006,46.884094,48.991709,49.504522,39.330715,41.201143,39.137031,48.867957,48.338329,39.130808,40.873255,51.546174,54.892929]),
array([45.372728,45.074176,29.321908,28.746025,31.510914,39.659054]),
array([38.055347]),
array([37.200315]),
array([29.987271,28.74418,29.681395,37.477778,29.813533,31.174267,31.853914,30.107246]),
array([47.620554]),
array([49.732601,25.250134]),
array([49.920913]),
array([26.277309,25.319915]),
array([30.656125]),
array([52.193256]),
array([26.472727]),
array([51.907059]),
array([23.619101,26.729048,21.487105,24.867823,27.703468,23.60796,25.14475,27.58016]),
array([39.593188,37.134066,38.92702,40.156808]),
array([43.162847]),
array([36.102374,35.026006,35.992512,33.939547,35.534826]),
array([36.130182,37.515213,36.796215,37.338358]),
array([23.511634,24.350509,26.671196]),
array([40.947179,49.717225,38.233857]),
array([27.389674]),
array([36.675411,36.726931,37.135618,34.128913,35.106389,35.57163,34.216122,37.172453]),
array([26.667408]),
array([25.225349]),
array([54.611221]),
array([49.305087]),
array([25.528554,25.531505,24.828492,27.359507,27.020259,27.610662,24.120351,23.943786,27.063676,24.046627,27.084465,23.375418,26.338883,26.239322,25.354903,25.546607,25.156299]),
array([52.893075]),
array([49.384108,48.743632,49.354136,40.03429,48.350836,38.164278]),
array([31.846263,31.997338,28.807583,39.528065,49.827562]),
array([40.637735]),
array([25.241031,23.857345]),
array([44.573427]),
array([49.650529,40.564274]),
array([41.629077]),
array([45.130294,54.178609,55.997316]),
array([24.841624,24.949391]),
array([27.72195,24.117531,26.648928,24.063177]),
array([48.141265,40.634519,49.654417,37.804785,52.548274,49.367482,39.909237,53.075499,53.160036,49.03914,54.756234,41.842383,40.283937,38.294163,38.948695,38.462383,38.244666,40.169111,40.02236,38.534598,40.628123,40.945136,38.829562,43.037438,48.437326,40.486973,48.652761,43.140158,38.609433,49.157339,48.661405,39.288259,40.111154,39.107764,39.756966,48.27221,49.200363,40.206093,49.854527,39.196832]),
array([58.144243]),
array([25.215848]),
array([49.438575,47.448597,49.795505,54.35542,46.874855,50.849595,48.048061,48.523917,51.984421]),
array([24.609102]),
array([35.695638,36.84129])
]


data_5=[array([43.539942,43.886006]),
array([46.58658,40.151497,38.976349,47.303242,38.530676,49.685192,35.98259,49.728947,39.795358,40.930202,38.502739,38.985288,41.074304,48.550805,48.588802,48.256801,39.888427,48.998596,40.368797,48.464722]),
array([42.063344]),
array([52.612699,48.218052,51.948547,43.087899,42.153611,39.717005,48.904304,49.382431,44.407874,45.7572,49.924564,48.258254,38.458898]),
array([42.892186,54.781009,48.558008,44.672251,45.991822,47.866152,46.181914,48.520745,38.083301]),
array([39.739339,35.68711,36.747798,36.21224,35.233679,49.264151,35.507197,35.963881,34.243849,34.97672]),
array([32.882558,32.677532]),
array([52.939201,52.530971,48.931219]),
array([34.690808]),
array([24.707474,23.376031,25.056333,25.977183,26.778541]),
array([26.910828]),
array([23.362187,26.554647,23.054237]),
array([43.452534,49.733948,49.37426,47.731079,39.332922,39.825109,43.703785,45.528625,38.908264,38.669843,40.628181,49.139078,39.699539,40.504167,41.119842,48.944943,48.110523,49.099452,48.097564,40.344162]),
array([49.421759]),
array([48.561922,48.202919]),
array([37.07982,53.810295,41.506151,48.546322,54.079532,39.037582,44.787277,39.076635,49.885683,49.812591,41.168443,39.404205,50.652443,54.695382]),
array([40.422194,38.426107,32.063724,31.372273,33.461987,41.830819]),
array([38.674845]),
array([36.237922]),
array([27.957726,31.357805,33.764416,33.504601,30.652933,30.470165,31.96243,30.030608]),
array([47.212249]),
array([48.992766,25.263947]),
array([54.873412]),
array([26.613333,23.877827]),
array([30.763158]),
array([48.749531]),
array([25.275136]),
array([51.922604]),
array([25.623534,23.345701,22.775363,24.264241,24.111755,23.201152,26.109013,25.593031]),
array([39.021293,37.048233,39.317495,40.04919]),
array([42.505457]),
array([36.192846,34.382848,36.321725,34.95045,35.54896]),
array([36.914421,36.909997,35.225146,33.962004]),
array([26.198838,25.880792,24.094011]),
array([40.91748,48.31341,40.318981]),
array([24.496554]),
array([33.99845,37.609133,35.026102,34.080377,36.137211,36.580488,34.366264,34.7451]),
array([23.949156]),
array([23.129822]),
array([54.052573]),
array([48.143878]),
array([25.641531,27.076976,25.315249,26.081221,24.230488,23.898924,25.866462,24.451555,24.608807,27.152526,23.873698,23.571433,24.682135,25.632449,27.019766,25.447305,23.204206]),
array([50.620859]),
array([51.707348,49.11403,48.974318,39.800216,49.713174,38.01521]),
array([29.525827,33.657299,31.209004,40.980267,49.329353]),
array([40.054232]),
array([23.879867,23.886833]),
array([51.618778]),
array([48.830734,40.275272]),
array([44.317577]),
array([40.312916,52.049308,49.233091]),
array([23.062167,24.493091]),
array([27.136616,24.148317,23.59172,24.470473]),
array([48.299291,38.809693,48.552107,41.614491,49.668617,48.948338,35.011002,54.405034,55.974745,53.719156,50.164024,42.066653,40.2931,38.950401,38.127654,40.353964,40.316023,38.439492,41.046357,40.351059,39.96421,39.518726,39.698616,43.72918,48.091568,39.173555,49.664611,41.406343,40.766406,49.051998,48.864809,39.0103,40.120316,39.796788,38.138843,49.124305,48.868789,41.073975,49.718116,41.760102]),
array([52.225497]),
array([24.459726]),
array([49.253434,45.029333,53.388918,54.976146,45.83291,55.696931,49.124558,48.762459,53.753673]),
array([25.126218]),
array([36.110582,36.311807])
]


data_6=[array([40.46063,42.535742]),
array([45.348755,40.357383,38.700386,43.982698,38.823354,48.533194,34.844874,49.040059,40.560082,39.037895,40.846926,39.748914,39.775001,49.46311,48.766353,48.569519,41.181383,48.996865,40.755293,49.830588]),
array([39.900443]),
array([48.402641,49.449961,52.804545,42.089257,45.408588,39.01486,48.564365,49.551557,40.684063,41.829772,49.125166,48.790131,38.856925]),
array([43.815291,51.830296,51.825005,43.844986,44.647027,47.856068,45.031147,48.944185,44.118715]),
array([35.034353,34.691865,34.971776,37.259433,33.910224,48.672447,35.557783,34.373025,35.168091,36.30667]),
array([31.776356,32.256854]),
array([51.60848,49.478023,50.126561]),
array([34.13485]),
array([27.36895,26.440528,23.039477,24.040058,27.723696]),
array([23.155627]),
array([23.212336,24.604327,25.255992]),
array([41.868368,48.001867,49.860148,39.559469,39.823399,40.770502,43.068597,41.327301,38.95964,40.980853,40.595715,49.346649,39.742944,39.774803,38.669152,49.041106,49.785311,48.40773,48.218413,38.458794]),
array([49.051218]),
array([49.361866,48.882057]),
array([35.08939,52.515893,43.270593,49.240278,52.921225,38.703136,42.821819,38.710915,48.918184,48.215616,40.942017,38.611026,54.861384,54.928391]),
array([42.81854,44.927014,29.153505,33.187302,31.664896,41.787329]),
array([39.918961]),
array([36.448036]),
array([28.971761,32.976229,29.557162,29.095409,29.533945,32.613616,29.172476,29.520037]),
array([47.583732]),
array([48.925527,24.720918]),
array([50.100857]),
array([27.173828,26.709682]),
array([30.661217]),
array([49.452105]),
array([27.494559]),
array([54.907848]),
array([27.066101,24.245587,23.335944,24.226635,24.88381,26.120135,25.985349,24.882097]),
array([38.865361,35.4668,40.600158,38.753333]),
array([40.144426]),
array([34.879267,34.18143,36.661717,37.061251,35.809826]),
array([34.902251,37.540237,34.115048,37.106412]),
array([26.531903,24.014603,23.507351]),
array([39.57938,48.005145,40.885964]),
array([24.965453]),
array([34.628976,35.818469,40.258779,37.247847,35.649989,37.198051,37.443164,37.338307]),
array([25.678235]),
array([24.057686]),
array([49.988994]),
array([51.182238]),
array([23.515612,25.707252,27.739343,23.053625,24.161085,26.160191,26.118631,25.656773,24.529537,25.292183,26.209855,24.396181,23.234453,27.513785,27.427807,23.301887,25.030851]),
array([52.095522]),
array([48.590347,48.927321,48.727534,39.840612,49.982228,40.595305]),
array([29.868022,31.538137,33.696527,39.266827,48.057991]),
array([38.831892]),
array([26.856573,26.779677]),
array([48.649112]),
array([49.013646,40.342296]),
array([45.946061]),
array([44.041009,53.565857,48.340798]),
array([25.295701,26.03675]),
array([23.375989,27.583301,27.762444,23.588006]),
array([49.41375,39.883535,48.190459,36.907679,55.775564,48.545973,37.519715,55.258244,55.426896,48.988753,49.194193,47.797683,39.868428,40.666626,39.972726,39.368821,38.388487,40.988637,39.421271,40.587762,38.117381,39.52455,39.301337,46.815324,49.833904,38.152822,49.334022,40.863392,40.48477,49.684871,48.175389,38.525013,38.306984,39.74249,39.889591,48.773454,48.552165,40.870387,48.494569,46.410123]),
array([49.162942]),
array([27.603738]),
array([48.209306,47.732135,50.679237,55.63383,42.663683,54.283276,49.514451,48.954446,51.502095]),
array([24.509446]),
array([36.745833,37.110022])
]


data_7=[array([37.761195,42.778535]),
array([47.326229,39.174701,39.130247,41.528986,40.143402,48.068871,34.344067,48.384095,40.911573,40.939126,40.518718,40.433519,39.357319,48.331371,48.073586,48.380984,39.587123,49.040629,40.965964,49.796323]),
array([41.589466]),
array([51.392875,49.925314,53.284129,44.119088,45.631191,39.392087,49.589176,48.304257,46.863938,47.186239,48.043122,49.510581,40.498278]),
array([43.609009,53.11635,55.330706,42.397854,46.43506,47.831156,40.909167,49.789202,41.952926]),
array([36.203141,36.496972,35.193424,35.219057,36.506842,48.59027,34.3536,36.059081,35.14364,35.838913]),
array([33.748824,29.562212]),
array([55.98071,51.405763,55.370478]),
array([37.047257]),
array([26.189726,24.054806,24.303175,26.006837,23.313495]),
array([23.920917]),
array([26.558666,24.920105,27.177377]),
array([47.467501,49.0331,49.342055,47.729217,41.108003,38.429423,43.597505,46.976731,39.381753,41.01585,39.919766,48.291271,39.136126,38.236696,39.688231,48.268246,49.510734,48.074643,48.216643,39.656388]),
array([49.029523]),
array([49.394449,48.242552]),
array([36.126804,55.885522,47.243991,49.609929,52.268471,40.65629,44.136609,41.087379,48.01699,48.493655,38.98013,39.672037,49.502942,53.109048]),
array([40.627299,47.583178,31.461773,30.214375,31.635665,45.082455]),
array([41.117403]),
array([37.244234]),
array([33.857646,32.279459,31.758968,30.417008,31.765088,28.271305,30.54991,31.412059]),
array([47.775405]),
array([48.694032,23.259943]),
array([53.931202]),
array([24.863689,24.557194]),
array([30.726074]),
array([51.335263]),
array([26.536942]),
array([47.887332]),
array([24.135512,27.726285,22.367082,23.046871,27.261669,25.792748,24.896502,23.946369]),
array([40.259608,35.171064,40.083708,40.601265]),
array([44.809302]),
array([36.15307,34.598708,35.575403,36.750023,34.051116]),
array([34.732351,37.284339,34.371044,37.187962]),
array([27.671882,25.109724,25.359666]),
array([39.796082,49.19171,39.528135]),
array([24.358923]),
array([37.632576,35.868743,35.595725,36.612768,34.483006,36.541803,35.633566,34.46337]),
array([24.83176]),
array([25.974334]),
array([49.841573]),
array([47.85332]),
array([23.601646,27.290166,23.462766,27.219544,27.721723,23.304487,26.016163,25.806045,25.988393,25.102657,24.510678,27.135279,24.386743,26.682693,27.231688,24.176776,26.265258]),
array([49.982907]),
array([48.764064,48.522583,49.427286,39.888977,48.001582,38.481442]),
array([30.973093,32.759275,30.497863,41.068414,48.35027]),
array([39.409261]),
array([23.791765,27.690043]),
array([43.311427]),
array([48.63938,40.912557]),
array([43.646176]),
array([41.245602,48.64985,51.631232]),
array([25.419467,27.450859]),
array([27.62408,27.640837,24.580828,27.754887]),
array([49.98599,39.967673,48.481763,37.362823,51.034468,48.943011,40.132624,51.046014,50.903659,55.545959,53.918948,41.81181,38.165203,39.232403,41.195712,41.109671,40.386714,39.865553,38.221693,39.049071,39.519077,40.460856,39.658103,47.026581,49.690463,38.487483,49.509354,44.083585,40.434625,48.295643,49.185446,40.642632,39.490402,38.630258,41.053097,48.958141,49.727797,38.186222,48.80301,41.601745]),
array([53.666118]),
array([25.777785]),
array([49.6971,43.539893,50.29579,54.186479,47.406345,55.916881,49.632663,48.977692,54.60505]),
array([26.145947]),
array([36.971553,34.195363])
]


data_8=[array([38.435191,40.959753]),
array([42.961843,40.122208,40.821569,45.534347,39.253138,51.156155,37.525527,49.066725,40.488504,40.853825,39.331431,40.538198,38.680408,48.687394,49.499276,49.3076,38.932862,49.633838,38.603618,49.61787]),
array([42.249923]),
array([51.487525,49.153393,51.466618,42.007062,40.696113,38.642158,49.328678,49.46073,40.230352,44.669484,49.301268,48.048898,38.975058]),
array([42.208341,52.837574,52.840101,46.227325,47.18601,47.803719,38.228176,49.620082,47.624772]),
array([34.458245,34.454917,40.226338,36.065541,37.574434,48.443084,36.086178,36.00819,34.768455,37.632624]),
array([29.408643,28.609471]),
array([55.105769,55.541939,55.619514]),
array([35.740878]),
array([23.462871,26.681086,24.984874,25.464424,23.386851]),
array([26.904804]),
array([24.282295,23.41164,26.164478]),
array([45.83673,49.877855,49.74953,47.257195,39.907107,39.67026,46.508242,46.589029,39.39649,40.880191,40.319728,49.608765,47.207708,39.962791,39.043885,48.440431,48.498882,49.092088,48.758496,40.597644]),
array([48.773985]),
array([49.912238,49.71559]),
array([34.0807,55.729782,44.524442,48.940096,52.303049,38.31028,47.681047,40.094611,49.439541,49.262127,38.075952,39.208015,51.62008,55.736366]),
array([39.543453,46.476073,30.142021,28.677107,29.525034,43.084717]),
array([39.488032]),
array([34.096658]),
array([27.919876,29.872875,31.165205,36.753051,28.081674,31.486367,28.412509,31.293898]),
array([47.117319]),
array([48.387984,24.737976]),
array([52.716105]),
array([23.712765,27.434505]),
array([30.757713]),
array([52.662608]),
array([23.425508]),
array([52.345699]),
array([23.257388,25.434098,21.283538,24.96416,26.3433,27.605645,24.485567,26.729539]),
array([40.087216,37.139752,38.01715,39.459615]),
array([42.652648]),
array([37.617691,36.294746,37.088738,34.923219,37.145335]),
array([34.610083,37.577961,35.197328,35.355775]),
array([26.412238,27.584629,26.498664]),
array([38.294242,49.751404,39.677724]),
array([24.20043]),
array([37.205022,40.322263,38.531846,36.111083,34.432486,36.960246,37.311792,36.615312]),
array([25.907582]),
array([26.582262]),
array([54.755734]),
array([52.195817]),
array([26.518289,25.091981,26.347984,26.172856,26.724908,23.255382,26.471929,25.237856,26.279708,26.082391,26.387387,27.140474,24.334749,27.001077,23.951453,25.145435,27.194464]),
array([54.043056]),
array([49.942896,49.926635,49.759172,40.018734,49.221251,40.504133]),
array([30.890502,30.640728,32.916912,39.997601,49.747787]),
array([40.576346]),
array([26.229079,25.339803]),
array([51.645106]),
array([48.816633,40.865061]),
array([44.546739]),
array([46.729592,51.624309,51.192701]),
array([27.428655,24.330969]),
array([27.52281,25.180156,23.86921,25.264978]),
array([48.123828,40.32039,49.886816,36.331862,54.840231,49.203608,37.854356,54.689513,54.889084,55.878093,50.920487,45.554816,38.391521,39.143746,40.456236,39.602987,38.3622,41.044098,39.408247,40.168326,38.471697,39.752371,39.954241,45.164338,48.889961,38.212773,48.304721,41.248377,39.721781,49.581052,48.294503,40.635767,38.623195,39.567798,38.464914,49.886248,48.865971,39.137489,48.111093,39.455564]),
array([56.592681]),
array([27.192511]),
array([48.824097,42.771201,52.586619,47.989253,47.657007,50.40903,48.118733,49.405073,50.178239]),
array([25.840915]),
array([37.484753,34.691911])
]


data_9=[array([45.835234,40.58123]),
array([42.205767,39.415432,39.292972,42.898998,38.652876,50.298631,36.698509,49.132012,40.698563,41.171393,38.732717,38.589214,39.163169,49.387469,49.82151,49.967237,39.683296,49.870309,38.880124,48.589776]),
array([47.287862]),
array([55.645063,49.71117,50.408309,45.806182,38.322838,40.714382,49.014628,49.234643,44.958262,46.543776,48.458268,48.212508,38.209513]),
array([46.981063,54.45618,49.711303,44.144248,45.008166,47.80473,40.64266,49.704454,38.652805]),
array([40.546844,35.811749,37.175662,34.270391,35.875178,49.19655,36.289759,33.93676,36.346963,37.167821]),
array([29.142835,32.844955]),
array([51.537795,55.551436,51.683159]),
array([35.197682]),
array([23.940504,24.464886,26.337072,23.393269,25.541233]),
array([23.678683]),
array([26.704346,23.585356,27.430867]),
array([44.624914,48.881308,49.724338,39.833053,40.54702,38.462977,42.506695,47.189549,40.435413,40.469016,39.187118,49.856299,38.963545,40.547058,39.214815,48.937362,48.864419,49.60765,48.261842,40.156175]),
array([48.507949]),
array([48.188518,49.366788]),
array([36.895536,51.340072,41.530019,48.942307,53.969313,40.545956,46.1455,39.885446,49.416422,48.093106,40.999891,39.734234,53.844991,53.04613]),
array([44.847503,39.114343,28.460598,32.057147,32.062962,39.96704]),
array([41.155025]),
array([37.037584]),
array([33.267251,30.958881,28.391648,30.220405,29.459037,29.163781,31.970431,32.705099]),
array([47.216954]),
array([48.185652,23.750965]),
array([55.462575]),
array([26.858029,27.212757]),
array([30.724235]),
array([50.707156]),
array([26.578319]),
array([49.752071]),
array([23.699722,26.216866,22.903144,25.252093,25.365573,24.090978,26.012805,27.744246]),
array([40.522271,34.320094,38.986747,38.84928]),
array([45.983026]),
array([34.444284,34.152691,36.113942,36.011636,35.150981]),
array([36.385432,36.421609,34.906352,33.974627]),
array([23.175744,26.067051,23.737778]),
array([39.812106,49.042437,38.230217]),
array([27.814465]),
array([34.044792,41.119098,39.056819,37.003019,37.640741,35.507971,35.36313,37.210751]),
array([24.632784]),
array([24.311887]),
array([55.294713]),
array([53.442298]),
array([24.279355,26.118641,24.513375,26.964104,25.020669,23.938855,25.382506,26.548194,24.335142,24.525363,26.029439,23.768765,27.171342,24.80089,23.267665,27.393011,25.400858]),
array([49.007065]),
array([49.494119,49.238046,49.139896,40.810952,48.46576,38.634604]),
array([28.550708,31.863554,33.20005,39.424657,49.417466]),
array([40.788142]),
array([27.117044,24.733097]),
array([49.991465]),
array([48.776507,47.799945]),
array([41.145012]),
array([38.919104,52.733944,49.242783]),
array([25.78794,25.372749]),
array([24.670755,25.79139,25.606148,23.67455]),
array([48.326052,39.704867,49.861949,36.428607,48.302461,48.911724,40.006,49.044316,49.577141,51.127757,51.139174,40.800739,39.202982,40.878648,40.181394,39.255482,39.559567,39.710019,38.507106,38.835929,39.592423,38.091041,39.104957,43.27834,48.726583,39.328826,48.035624,38.578466,38.399306,48.383886,48.959659,38.143771,39.201607,41.127612,38.772917,49.669546,48.301076,39.766185,48.545168,38.135066]),
array([51.969332]),
array([27.806877]),
array([48.892389,43.939377,54.646966,50.602311,41.777024,55.393292,48.311258,48.38194,52.284982]),
array([26.089883]),
array([34.37661,36.773103])
]


data_10=[array([47.238821,43.478165]),
array([43.433084,40.196717,39.54485,43.565051,40.539801,48.193444,34.706737,49.392762,39.515099,41.008799,39.646298,40.110989,39.626449,48.866122,49.877784,48.925138,39.623307,49.228451,40.258266,48.976133]),
array([43.969824]),
array([52.946399,49.756234,50.17368,47.230309,45.760942,39.251755,48.453612,49.586736,38.268216,44.212331,48.673416,48.217009,40.381361]),
array([46.187401,52.879351,55.654051,45.06618,41.445951,47.877851,45.514294,49.955763,37.865117]),
array([38.080898,36.383656,34.595472,36.641905,36.541498,48.408648,36.562786,35.501296,36.271654,35.542065]),
array([28.405424,29.733712]),
array([53.516789,49.233655,54.150397]),
array([34.876904]),
array([26.794248,24.01274,23.699013,26.364553,26.634653]),
array([23.233119]),
array([26.075226,26.017035,26.086254]),
array([45.855418,49.188276,49.18162,40.789675,40.836227,39.427256,42.89792,45.296364,38.336618,40.768637,38.679229,49.647106,47.039301,38.844648,39.094029,49.931165,48.60494,48.850773,49.016734,38.695432]),
array([48.187501]),
array([48.994123,49.679498]),
array([34.632179,53.457044,47.684436,48.785961,53.437958,40.994888,41.017411,38.538689,49.801003,48.826499,38.752766,40.778092,48.782292,49.336479]),
array([45.594449,44.594059,33.128965,32.126261,32.54388,47.172743]),
array([40.122351]),
array([35.222417]),
array([32.529651,32.820489,28.785467,33.752786,28.451356,29.480371,33.73383,33.605291]),
array([46.760389]),
array([49.841495,26.4367]),
array([49.40039]),
array([24.296853,24.887945]),
array([30.711239]),
array([48.625641]),
array([27.284856]),
array([48.786791]),
array([24.092378,27.345921,22.281748,26.451902,25.395954,24.657204,25.613537,24.999453]),
array([38.050458,36.706987,40.64991,40.252732]),
array([38.712304]),
array([37.164995,37.424952,35.226242,36.296661,36.135769]),
array([34.501899,36.432118,34.882648,34.155616]),
array([23.314615,23.051447,27.700253]),
array([38.957932,49.98354,38.691997]),
array([24.619397]),
array([37.709602,40.811578,37.263461,37.535272,35.264631,35.529864,34.722906,36.987264]),
array([26.464843]),
array([23.798431]),
array([52.795122]),
array([51.985148]),
array([24.257359,23.372366,26.626327,25.502666,25.305594,26.213157,23.337197,25.768453,23.33668,24.185378,25.598448,25.688168,25.901103,23.628061,24.523618,25.906301,25.738667]),
array([52.389689]),
array([51.771485,49.892503,48.492773,38.5706,49.417764,40.074522]),
array([33.792663,29.231885,28.098062,40.894157,48.971817]),
array([38.643672]),
array([25.308375,27.127039]),
array([53.717716]),
array([48.567282,47.772648]),
array([44.467574]),
array([44.594209,53.533115,48.249048]),
array([25.02884,24.881165]),
array([23.367979,23.123272,24.514978,23.274898]),
array([48.135161,39.348885,49.555772,39.749023,51.587219,48.873848,40.718194,47.839443,52.738095,51.84546,50.193052,41.67713,41.07249,40.310381,39.449655,40.1262,40.520412,40.212532,40.170657,39.936626,39.940253,38.74728,38.620735,41.875458,49.069558,40.799198,49.611581,39.357556,39.338395,48.942855,49.738243,40.474905,40.032904,39.20539,40.043538,49.268654,49.025807,40.079809,49.010154,45.454311]),
array([56.759051]),
array([26.666116]),
array([48.57708,45.373868,47.839899,55.529203,46.185954,50.406858,49.104523,49.546932,52.995194]),
array([25.764031]),
array([36.829496,36.639452])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_1',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_2',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_3',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_4',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_5',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_6',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_7',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_8',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_9',  'Other_SANUs_EOT_gen_occ_SALMA_smoothed_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Adiantoides','Albertogaudrya','Amilnedwardsia','Anisolambda','Asmithwoodwardia','Astraponotus','Baguatherium','Carodnia','Colombitherium','Coniopternium','Cramauchenia','Deuterotherium','Didolodus','Eolicaphrium','Ernestohaeckelia','Ernestokokenia','Griphodon','Guilielmofloweria','Heteroglyphis','Hondonadia','Indalecia','Lambdaconus','Lamegoia','Liarthrus','Maddenia','Miguelsoria','Notodiaphorus','Paranisolambda','Parastrapotherium','Paulogervaisia','Phoradiadius','Polyacrodon','Polymorphis','Proadiantus','Proectocion','Promylophis','Propyrotherium','Proterotherium','Protheosodon','Proticia','Protolipterna','Pyrotherium','Ricardocifellia','Ricardolydekkeria','Rosendolops','Rutimeyeria','Salladolodus','Saltaodus','Scaglia','Sparnotheriodon','Tetragonostylops','Thadanius','Tricoelodus','Trigonostylops','Umayodus','Uruguaytherium','Victorlemoineia','Xenastrapotherium','Xesmodon']
def get_taxa_names(): return taxa_names