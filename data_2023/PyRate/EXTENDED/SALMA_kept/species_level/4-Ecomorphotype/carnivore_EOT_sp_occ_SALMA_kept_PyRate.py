#!/usr/bin/env python
from numpy import * 


data_1=[array([20.353358,20.310518]),
array([17.177192,17.243696,17.420115,17.421464]),
array([17.330082,20.392317,17.406096,16.71259,17.051399]),
array([27.663763]),
array([39.017379]),
array([16.550363,17.17616,16.842515,16.40776,17.025687,16.991955]),
array([20.236544,20.378438]),
array([39.572439]),
array([38.683739,53.118028]),
array([38.819912,39.876373,37.83447,40.734575,38.441776,39.613977,40.499004]),
array([40.310379]),
array([28.599735,27.929124,28.647258,25.103483,28.777848]),
array([20.13378,20.185624,20.347397]),
array([16.541416,17.119791,16.459236,16.724065,16.36444,16.651957,17.106556,17.494384,17.153247,17.082952,16.920197,17.114731,17.463919,16.571913,16.763434,16.675876,17.456157,17.108839,16.595797]),
array([48.48185,49.659445]),
array([37.359775]),
array([20.100715,20.329257,16.887347,16.957524,17.159619]),
array([20.141982]),
array([16.645518,20.367587,16.286306,16.648998,16.984976,16.743633,16.393702,16.610808,17.13236,17.1963,17.210672,17.109096,16.918519,16.453477,16.485383,17.036603,16.563637,16.607215,16.433677,16.843389,16.738174,16.818214,16.572221,16.384374,16.761582,16.591072,17.088322,17.12005,17.312002,16.331747,17.212698,17.051116,16.450394,17.008828,17.442432,17.137117,17.125542,16.442079,16.997582,17.248601]),
array([52.082739]),
array([31.310732]),
array([26.80039]),
array([17.237866,16.707145,17.222142,16.34427,16.439092]),
array([20.002694]),
array([41.055639,41.094577]),
array([54.130581]),
array([43.641883]),
array([40.762063]),
array([24.882887,24.347383,26.280035,28.441018,28.64223,24.259756,26.369301]),
array([24.784688,29.004914]),
array([46.462882]),
array([35.543027]),
array([40.222643,39.155995]),
array([44.421248,46.677687,52.000501,52.287407]),
array([16.672325,16.984064,16.544468,16.525193,16.94043]),
array([26.061484]),
array([28.380273,24.758347,26.715749,26.609,24.454372,26.77745]),
array([28.604917]),
array([35.183227,34.571628,34.966463]),
array([29.121549]),
array([27.709129,24.556824,26.481491,27.709413,26.608363]),
array([39.066358]),
array([35.442183]),
array([16.426007,16.546032,16.558821,17.103449,17.006469,16.544609,17.091402,17.461889,16.417438,17.190087,16.517259,16.462679]),
array([16.801896,17.185933,16.363679]),
array([20.294298]),
array([28.940166,26.365378,24.405582]),
array([20.386509,20.297456,17.271338,16.424247,15.845419]),
array([20.193857]),
array([17.460569,16.302029,17.336526,16.903062,17.238963,16.545209,17.000414,16.811549,17.326057,16.349181,16.790038,16.787669,17.206166,16.797686,16.361548,17.44599,16.879662,17.279717,17.3125,17.489186,16.491051,16.306234,16.864876,16.519122,17.309293,16.799357,17.460888,17.326464,17.069229,16.953589,17.114991]),
array([17.100389])
]


data_2=[array([20.303534,20.245055]),
array([16.66035,17.322297,16.841151,17.160977]),
array([16.424174,20.19377,17.470509,17.28701,17.151651]),
array([28.149733]),
array([40.540999]),
array([17.460182,16.787535,17.431654,17.412029,16.570022,16.467379]),
array([20.229429,20.161]),
array([35.696267]),
array([37.98164,54.811279]),
array([40.964596,38.92877,40.256569,37.862022,41.200157,40.445445,40.653266]),
array([40.088619]),
array([24.341111,25.835961,26.525426,26.698627,25.594382]),
array([20.167495,20.265546,20.302236]),
array([16.877311,16.742728,17.319645,17.217894,16.904351,16.301612,16.890078,17.25728,17.225656,17.133054,16.463128,16.727801,17.109506,17.016157,16.393818,16.800188,17.055045,16.637898,17.053788]),
array([51.14305,52.36638]),
array([35.568114]),
array([20.336031,20.339998,17.06015,16.479571,17.420562]),
array([20.182056]),
array([17.990138,20.260389,16.094358,16.989132,16.376812,16.69231,17.234075,16.747509,16.83647,17.000188,16.496926,16.458289,17.451521,17.300075,16.462256,16.507689,16.554921,17.34783,17.208473,17.405129,17.294436,17.032684,17.050463,16.430892,17.185681,16.442856,16.846958,16.392651,16.631223,17.383806,16.638643,16.467865,17.295612,17.216726,16.372585,17.162022,17.409498,16.721409,16.381996,16.540482]),
array([49.85254]),
array([32.430017]),
array([26.2676]),
array([17.405549,17.323833,17.11729,16.526201,17.379523]),
array([18.98156]),
array([40.242022,39.414974]),
array([54.913161]),
array([42.389532]),
array([39.624521]),
array([28.27507,28.198365,26.175784,27.511847,26.334672,28.80978,27.086432]),
array([28.237089,28.890292]),
array([46.134793]),
array([34.824981]),
array([38.289596,39.118447]),
array([43.438698,47.529782,52.147547,52.385659]),
array([16.856414,17.006368,16.752716,17.099248,17.327605]),
array([27.77064]),
array([28.530711,26.076429,28.116456,26.535224,29.020781,26.067017]),
array([25.899265]),
array([35.72375,37.17934,35.722459]),
array([27.873723]),
array([24.976777,28.126972,28.526164,28.428948,28.713787]),
array([40.152338]),
array([36.559326]),
array([17.344151,17.256403,17.310174,16.62453,16.76612,17.292057,16.591676,17.24435,17.402535,17.341882,16.341357,16.466359]),
array([16.89959,17.124034,16.93475]),
array([20.370536]),
array([24.544234,27.764687,29.391098]),
array([20.128282,20.331482,17.083299,17.167067,16.374028]),
array([20.183112]),
array([16.852683,17.029333,17.408361,16.705444,16.40512,17.480271,16.711425,16.316703,16.358116,17.113645,17.071667,16.900352,16.307151,17.281633,16.820634,17.48056,17.480098,16.476645,16.835271,16.969991,16.487184,16.565663,17.451509,16.587421,17.498869,16.877719,16.969789,17.027641,16.982206,17.138881,17.189769]),
array([17.496981])
]


data_3=[array([20.214832,20.282199]),
array([17.485089,16.366585,16.305545,16.659904]),
array([17.213583,20.343159,17.207237,17.015557,16.822178]),
array([25.406667]),
array([40.360637]),
array([16.633919,16.417777,16.375256,16.413224,17.1143,17.157994]),
array([20.356984,20.10853]),
array([36.80783]),
array([39.381542,53.48312]),
array([40.794118,40.346329,39.514979,38.096599,39.023926,40.693763,40.981518]),
array([39.929829]),
array([24.317726,29.195339,26.686433,25.367684,28.580822]),
array([20.251388,20.15515,20.310904]),
array([16.646045,17.062783,16.455966,16.978469,16.605995,17.096019,16.649872,17.408485,17.354325,16.596768,17.364153,16.640815,17.288027,17.09452,16.336481,16.963453,16.676156,17.028931,17.192418]),
array([46.540627,48.376947]),
array([37.006875]),
array([20.157766,20.141895,16.870888,17.202849,16.536699]),
array([20.108384]),
array([17.199322,20.12438,16.210303,17.390673,16.552638,16.584802,17.213805,16.622023,16.352317,16.933277,16.534045,17.184494,17.260907,17.318347,16.585047,16.350502,17.122588,16.327542,17.023119,16.842367,17.493358,17.920301,16.490006,16.602484,16.473625,17.382194,16.758234,17.355584,16.394368,16.868329,16.375372,17.428004,17.402903,16.493484,16.630886,16.571542,16.324337,16.636114,16.89731,16.458138]),
array([55.776794]),
array([32.951823]),
array([28.345035]),
array([16.895682,17.115146,16.515415,17.433827,16.983583]),
array([18.103303]),
array([41.517358,39.826955]),
array([48.200866]),
array([45.576983]),
array([41.292702]),
array([26.500465,28.258489,24.680038,28.059841,26.404135,28.002548,27.9221]),
array([28.873673,27.008786]),
array([42.122953]),
array([36.061705]),
array([37.916025,38.343005]),
array([42.144451,45.248476,52.970885,52.313733]),
array([16.535713,17.025313,16.587143,16.757377,16.997212]),
array([29.260366]),
array([26.588713,26.981135,29.308206,27.407687,28.3242,28.509939]),
array([24.632763]),
array([35.78184,36.518805,40.868237]),
array([27.035391]),
array([24.625268,27.970321,27.509238,26.574462,26.891621]),
array([38.615458]),
array([35.103821]),
array([16.393145,16.753294,16.948397,16.820341,16.747479,17.078153,16.695375,16.629457,17.186046,17.488545,16.884845,17.090931]),
array([17.309096,16.81382,16.404834]),
array([20.22938]),
array([28.197572,26.112217,26.970005]),
array([20.328045,20.216264,17.103848,17.170385,16.917582]),
array([20.342568]),
array([17.254183,16.880476,16.496019,16.356629,17.295681,16.419893,17.079686,17.204483,16.955783,17.196405,17.061739,16.522294,17.215874,16.498758,16.468141,16.357997,17.128937,16.375531,16.649389,17.138453,16.685414,17.083151,16.595378,16.766887,17.304807,16.679602,17.37923,16.599815,17.100317,16.572577,17.320525]),
array([16.780378])
]


data_4=[array([20.174295,20.390663]),
array([17.449883,16.321396,17.278432,17.245822]),
array([16.759179,20.358446,17.38342,16.921713,16.979705]),
array([28.749162]),
array([39.356762]),
array([17.037566,16.911919,16.967397,16.823812,16.60238,17.458151]),
array([20.357294,20.200934]),
array([35.955594]),
array([40.618343,54.956294]),
array([40.537364,38.329675,39.943057,38.301523,39.852093,39.273023,41.47228]),
array([39.800356]),
array([26.43539,26.399578,26.38046,26.385504,25.570521]),
array([20.320026,20.289997,20.233783]),
array([17.178272,16.3489,16.694557,16.710231,16.656893,17.313132,17.354863,16.484286,17.284783,16.662041,16.566503,16.748925,16.513366,17.227683,16.806457,17.356948,17.461924,17.267772,17.109448]),
array([49.046757,49.319269]),
array([36.100578]),
array([20.282172,20.180381,16.559217,16.93555,17.137941]),
array([20.147605]),
array([17.182094,20.157874,16.053153,16.889896,17.485403,17.101137,17.272585,17.425247,17.321113,16.729187,16.563067,16.922333,16.377441,17.09799,16.894595,16.367205,17.374415,16.663443,16.579155,17.335435,17.195454,16.632726,16.497825,17.181503,16.692482,17.357907,16.739204,16.784291,17.088705,16.32499,17.062338,17.052926,16.555788,16.442284,16.482502,16.442291,17.281936,17.212439,16.949833,16.826459]),
array([55.481194]),
array([32.702285]),
array([26.145853]),
array([16.893571,16.740111,16.437742,16.309481,16.529067]),
array([18.639516]),
array([41.527933,40.368936]),
array([54.52564]),
array([46.299799]),
array([40.990987]),
array([27.141457,27.289905,27.732249,27.456518,26.92313,25.582208,24.326702]),
array([26.621899,27.639061]),
array([46.422335]),
array([34.477681]),
array([39.26191,38.178535]),
array([44.976124,41.474562,52.76647,52.756075]),
array([17.488332,16.349172,16.63768,17.010814,16.555548]),
array([29.26157]),
array([26.028424,26.31652,26.469523,24.264096,25.818176,26.744019]),
array([28.808052]),
array([35.906008,35.770698,40.911778]),
array([27.885653]),
array([26.452501,24.834771,28.724651,24.952266,27.703198]),
array([39.805276]),
array([38.130705]),
array([17.319055,16.8304,16.534265,16.855157,16.716062,16.773605,16.752022,16.923988,17.457752,16.505631,16.480412,17.247658]),
array([17.385292,17.323069,16.780637]),
array([20.215818]),
array([26.207064,24.946418,28.155115]),
array([20.180218,20.128224,16.497296,16.464998,15.952416]),
array([20.245819]),
array([16.94244,17.489482,17.361789,16.901339,17.197061,16.746372,17.345147,16.926246,16.362687,16.724598,17.11807,16.939373,17.380265,17.170743,17.163782,16.707589,16.963991,16.746793,16.951777,17.467858,16.77771,17.280206,17.263723,17.428562,16.890525,17.202907,16.309467,16.819492,16.672389,16.394853,17.247029]),
array([17.092811])
]


data_5=[array([20.302357,20.334459]),
array([16.910935,17.084428,16.460966,16.977923]),
array([17.030772,20.278117,17.168539,16.982447,16.521972]),
array([24.874716]),
array([41.364339]),
array([17.365647,16.451023,16.751249,16.62047,16.855556,16.493324]),
array([20.34309,20.307883]),
array([42.151288]),
array([39.53391,54.742192]),
array([40.242786,40.064188,41.128738,40.200775,38.130362,41.025112,40.766582]),
array([40.625619]),
array([27.141223,25.886256,25.972886,25.848456,27.310347]),
array([20.326874,20.342207,20.232132]),
array([16.822913,17.358998,17.184832,16.676693,17.128362,16.324851,16.399533,17.082594,16.424764,16.387231,16.427335,17.483019,16.826085,16.510668,16.580074,17.127888,17.37641,17.393466,17.072202]),
array([48.363028,50.688909]),
array([36.892867]),
array([20.351583,20.116346,16.454231,17.175327,16.630555]),
array([20.180029]),
array([17.845372,20.135597,16.151672,16.698547,17.142172,17.213795,16.886365,16.511762,16.828987,16.38448,16.702582,17.01201,17.281908,16.964863,16.759834,16.375491,16.806117,16.348413,16.735794,17.47532,17.188464,17.496917,16.361994,16.781746,17.012992,16.719568,17.385351,17.416143,17.212772,16.737712,17.235371,17.394225,16.343894,16.964622,17.075342,16.668626,16.964648,16.818241,16.585312,17.088297]),
array([51.870834]),
array([32.299975]),
array([27.891175]),
array([16.951781,17.154133,17.076139,16.47342,17.371852]),
array([16.637802]),
array([39.285943,40.264478]),
array([50.221762]),
array([45.504774]),
array([39.000929]),
array([29.18712,24.639371,25.102946,24.288435,27.367866,26.288931,27.11657]),
array([27.169059,25.815891]),
array([43.345298]),
array([36.832678]),
array([39.364064,40.462631]),
array([47.430328,43.654937,52.744681,52.831024]),
array([16.322543,16.323477,16.954216,17.330389,17.058666]),
array([26.905293]),
array([25.930078,29.299974,27.377153,25.81455,27.707106,28.478129]),
array([27.962682]),
array([35.278925,34.579867,36.055168]),
array([25.412285]),
array([25.412732,28.339911,25.107602,27.77608,27.252315]),
array([39.02891]),
array([35.131288]),
array([16.742055,16.359919,17.123594,16.824501,17.079776,17.464568,17.283608,17.177612,16.432528,17.118438,17.320988,16.863315]),
array([16.378046,16.673233,17.43223]),
array([20.282261]),
array([28.380932,25.621383,24.903052]),
array([20.185057,20.187599,16.433106,17.13258,16.095604]),
array([20.180141]),
array([16.472665,17.453334,17.125978,16.509644,17.160655,16.892405,16.476674,17.329079,17.326272,16.894195,17.321295,16.311309,17.154831,17.031579,16.465097,16.383478,16.493283,16.541954,16.31925,16.455299,17.484218,16.556039,16.781756,16.735006,17.159238,16.947903,17.285786,16.734973,16.362865,16.515455,17.375743]),
array([17.311614])
]


data_6=[array([20.256459,20.352455]),
array([17.094475,16.307994,16.612247,17.377818]),
array([17.453126,20.166608,17.281142,16.801322,17.19763]),
array([29.111973]),
array([41.025102]),
array([17.264474,16.671853,17.08406,17.486736,17.108152,16.362654]),
array([20.372783,20.323132]),
array([34.861029]),
array([39.60884,49.202003]),
array([39.783572,40.404499,40.907989,39.808382,38.716373,41.119186,39.501373]),
array([39.816733]),
array([27.083292,26.80129,24.42261,24.357459,29.352842]),
array([20.244992,20.183876,20.328932]),
array([16.368788,17.158089,16.410553,16.903969,16.894436,16.564496,17.499044,16.797151,16.465529,16.852621,16.61537,16.573993,16.698886,16.615864,16.912144,16.786373,16.91811,16.88233,17.369883]),
array([48.198472,46.347162]),
array([36.476709]),
array([20.11761,20.358292,17.053257,16.724597,17.167639]),
array([20.304908]),
array([16.629355,20.206749,16.176857,16.883064,16.766304,16.933041,17.099003,17.194502,16.371078,16.96399,17.192948,16.749121,17.119809,17.363585,16.679943,16.645571,17.415935,17.125698,17.236082,16.945007,17.196727,17.433662,16.903317,16.783357,17.282235,16.396912,17.472281,16.642369,16.844006,16.770159,17.2513,17.242464,17.495792,16.687093,16.635844,16.511837,16.748088,17.059885,16.866845,17.497501]),
array([53.514379]),
array([31.657795]),
array([24.201527]),
array([17.128082,17.012032,16.72478,16.908891,16.320071]),
array([16.04741]),
array([39.915254,39.831482]),
array([48.73662]),
array([45.971912]),
array([41.039554]),
array([27.28856,29.050943,25.374691,27.095032,26.784777,27.842258,28.898257]),
array([24.730203,29.327772]),
array([46.779036]),
array([35.286047]),
array([39.573319,40.312722]),
array([43.306037,46.065695,52.371164,52.030775]),
array([16.717369,16.523212,17.335421,16.633359,17.223481]),
array([25.906641]),
array([24.848886,27.337611,27.67383,24.823622,28.208439,26.81127]),
array([24.615097]),
array([34.225365,33.986663,36.382085]),
array([25.718543]),
array([24.417145,24.580937,27.689609,29.349984,25.968086]),
array([38.986114]),
array([37.051037]),
array([16.896914,17.179055,16.796487,17.2787,17.213795,17.029602,16.306198,16.501817,17.489011,17.054595,16.621315,16.384963]),
array([17.221111,17.494742,17.292071]),
array([20.194054]),
array([25.555998,26.452399,24.628232]),
array([20.360288,20.319524,17.170071,17.157697,16.603037]),
array([20.287442]),
array([17.170568,17.088929,16.535401,16.315163,17.36555,16.796813,16.502551,16.71319,16.706406,17.202187,16.945232,17.067751,17.267835,17.234268,16.335957,17.027565,16.781203,17.186123,16.724655,17.380357,16.335735,16.984048,17.268496,16.373451,16.730561,16.352824,16.494506,16.581871,16.73627,16.324852,16.327936]),
array([17.001806])
]


data_7=[array([20.115446,20.164261]),
array([17.258892,17.456089,17.449828,17.406863]),
array([16.437014,20.142207,16.671069,16.544853,17.008178]),
array([29.06617]),
array([40.494692]),
array([17.45437,16.910602,16.841782,17.113431,16.614626,16.651033]),
array([20.175527,20.186932]),
array([35.197763]),
array([39.842962,49.199792]),
array([38.303505,40.619713,38.554032,39.072699,38.520301,40.757622,40.799647]),
array([39.949809]),
array([25.564965,26.790142,25.138219,24.576986,25.628319]),
array([20.162525,20.145214,20.395148]),
array([16.842672,17.267848,16.447366,17.020488,16.436659,17.254497,17.229441,17.328786,17.047811,17.123985,16.642523,16.723018,17.216471,16.679377,16.740399,17.30761,17.415288,16.945597,17.34276]),
array([48.989058,48.763205]),
array([35.673156]),
array([20.15878,20.293192,16.703614,16.530575,16.642439]),
array([20.201029]),
array([17.113346,20.313253,16.082272,17.144416,16.677894,16.315875,16.731627,17.226969,16.958536,16.451169,16.791633,17.276786,16.863133,17.218075,17.360604,17.431032,16.81898,16.862998,16.977831,16.921973,17.110633,17.852142,17.091094,16.904631,16.88628,17.196278,17.28547,17.065513,16.687399,16.510891,16.674867,16.574097,16.482372,17.358938,16.340548,16.589979,16.766147,16.427438,16.623449,17.033508]),
array([49.019815]),
array([32.898504]),
array([25.921947]),
array([16.747555,16.401363,16.917577,16.744967,16.531964]),
array([14.596127]),
array([40.557871,40.49674]),
array([53.810942]),
array([43.386425]),
array([41.458586]),
array([27.923668,26.701121,25.248198,27.627459,27.877157,27.779139,25.21759]),
array([27.429246,26.695621]),
array([46.294684]),
array([36.484114]),
array([39.622264,38.507423]),
array([46.540893,41.72929,52.199179,52.287184]),
array([16.815651,16.625393,16.49595,17.022685,16.927502]),
array([26.020467]),
array([29.01163,24.923,25.076386,25.181557,25.541473,26.234966]),
array([25.081232]),
array([34.615012,36.330215,36.451231]),
array([27.504682]),
array([27.164675,28.108782,27.548222,24.256793,27.712072]),
array([40.3947]),
array([37.166156]),
array([16.560113,16.729215,17.181792,16.524251,16.521902,16.853839,17.04354,17.472835,16.389945,16.325348,16.640983,16.318611]),
array([16.345428,16.864586,16.992379]),
array([20.332871]),
array([27.580019,29.328961,26.79408]),
array([20.287385,20.21083,16.689232,16.442946,17.241776]),
array([20.397592]),
array([17.018244,16.752097,17.158183,16.849968,16.640253,16.622151,17.499437,16.784603,17.069155,16.320051,17.361503,16.992089,17.366077,16.522887,16.588279,17.396421,16.486768,17.459557,17.107921,17.263225,17.298888,16.694533,17.070872,16.585113,17.153226,17.208508,17.408201,16.522659,16.310216,17.070787,17.064711]),
array([17.266117])
]


data_8=[array([20.194781,20.23017]),
array([16.493231,17.251974,16.509089,17.171034]),
array([17.398709,20.269774,16.625199,16.663293,16.62167]),
array([29.225211]),
array([40.68484]),
array([16.754733,16.371893,16.559803,17.100396,16.381543,17.419344]),
array([20.229852,20.396484]),
array([44.869775]),
array([37.77562,53.002876]),
array([39.412836,40.424235,37.847775,39.727156,40.593652,39.478939,39.610402]),
array([39.762268]),
array([28.617031,27.34063,25.810557,25.395308,28.08314]),
array([20.242648,20.398178,20.131619]),
array([17.356061,17.376408,16.832299,16.989979,17.125589,16.364518,16.416745,16.480188,16.367979,16.318047,16.802962,16.563962,16.300608,16.753888,16.901632,16.720359,16.657204,16.698908,16.662534]),
array([47.469026,46.505669]),
array([37.36471]),
array([20.180333,20.31085,16.379311,16.558781,16.973753]),
array([20.311994]),
array([16.537628,20.124642,16.201283,17.108979,17.25939,17.101107,17.155838,16.935034,17.222469,17.492395,17.342257,16.912785,16.754988,17.26116,16.974961,17.276544,17.208089,16.605831,16.733266,17.40229,16.903836,16.743127,17.047926,16.378274,16.644206,17.376677,17.259167,16.471324,17.158396,17.22129,16.80116,16.927867,17.230396,16.346912,16.395802,16.633691,17.02597,17.290854,17.389652,16.663594]),
array([55.677741]),
array([33.050954]),
array([27.698175]),
array([17.341078,16.931519,16.660956,17.29081,17.402732]),
array([20.035146]),
array([39.451158,40.71822]),
array([49.55518]),
array([45.691997]),
array([41.563441]),
array([26.105698,28.352014,28.818131,28.243336,27.340505,25.484043,28.239008]),
array([28.512043,25.922751]),
array([47.207001]),
array([35.738405]),
array([40.591339,40.212272]),
array([44.975249,46.945481,52.82965,52.354282]),
array([17.403714,16.310577,16.500397,17.019121,17.347004]),
array([25.101241]),
array([26.608223,27.92686,28.243667,26.241038,25.875598,27.175406]),
array([29.332871]),
array([35.704941,33.998364,37.32267]),
array([29.394256]),
array([25.582717,28.277124,27.141127,28.013774,26.976141]),
array([39.522387]),
array([37.999884]),
array([16.959261,17.151076,17.243793,16.525665,16.534829,16.357387,17.250969,17.461829,17.285199,17.430281,17.410899,17.34389]),
array([17.392682,16.320953,17.20138]),
array([20.381117]),
array([27.601519,25.6513,25.76631]),
array([20.330486,20.389018,16.429037,16.794831,15.944694]),
array([20.331742]),
array([17.401635,16.575939,16.597556,16.687984,16.958019,16.369016,16.390071,16.931569,17.236672,16.320877,17.311324,17.494648,16.885852,17.003225,16.782823,17.440113,17.460438,17.312654,16.470083,16.873353,17.017418,17.064519,16.974463,17.271342,16.796164,16.94715,16.641667,16.32734,16.923511,17.461699,16.993804]),
array([17.058122])
]


data_9=[array([20.142964,20.308304]),
array([17.038349,17.052445,16.598372,17.409698]),
array([16.952191,20.203733,17.255913,17.130078,16.887079]),
array([27.20341]),
array([40.058957]),
array([16.916536,16.77818,16.850807,16.942668,17.044405,17.018775]),
array([20.254679,20.249685]),
array([43.018655]),
array([39.664078,51.629387]),
array([41.117527,39.05884,39.909345,41.283534,40.134352,41.369175,39.946324]),
array([39.490418]),
array([24.501602,29.304035,24.222079,29.053602,27.501648]),
array([20.375369,20.108931,20.122501]),
array([16.76389,16.875422,17.395036,17.099032,17.098343,16.660162,17.257412,16.908062,16.762746,16.385965,16.489393,17.409986,17.329246,16.414052,16.741793,16.936948,16.836845,17.139142,16.518335]),
array([47.010883,47.125362]),
array([35.908253]),
array([20.18871,20.387718,17.30505,17.101588,17.365992]),
array([20.202905]),
array([17.913658,20.268152,16.024897,16.518604,16.775579,17.016642,17.017511,16.867479,17.448575,17.350654,16.706006,16.57938,17.342381,16.788535,16.409717,16.740133,16.423592,16.992548,16.871762,16.455113,17.467544,16.898493,17.401074,16.985623,17.487363,17.106285,16.600409,17.115634,16.598044,16.444889,17.16034,17.249079,16.880874,16.989368,16.937139,16.300253,16.525385,17.008211,16.836062,16.604461]),
array([51.756272]),
array([32.988397]),
array([28.498754]),
array([17.23505,17.09854,16.846023,16.869221,17.322963]),
array([16.654411]),
array([41.446996,40.660872]),
array([55.670885]),
array([46.447782]),
array([40.684608]),
array([29.298318,26.97169,26.785547,24.454842,28.012804,25.725966,29.1235]),
array([25.839917,28.130791]),
array([44.409379]),
array([34.639104]),
array([39.315664,39.848306]),
array([43.215699,46.678543,52.481544,52.984088]),
array([17.394754,17.203693,16.986498,16.607056,16.666246]),
array([26.878766]),
array([26.381377,24.544197,29.004202,28.437415,26.906859,25.20681]),
array([24.997381]),
array([36.271128,37.055772,35.279741]),
array([28.710194]),
array([29.312597,28.710522,25.21986,28.392009,24.760066]),
array([39.591681]),
array([35.484421]),
array([17.497463,16.380582,16.471504,16.61364,16.575431,16.999537,17.181417,17.005004,17.493107,17.413605,16.703241,16.47711]),
array([16.490036,17.1573,17.229443]),
array([20.11844]),
array([27.879786,28.922994,24.438155]),
array([20.267349,20.328228,16.638754,16.612467,16.750147]),
array([20.307307]),
array([17.121358,16.775626,16.617389,17.102528,17.149907,17.439839,16.874948,17.383642,16.36344,16.371742,16.918042,17.259041,16.508429,16.644709,16.926017,16.571269,16.924503,16.743311,17.272597,16.756798,17.058343,16.605636,16.597527,16.796419,17.495752,17.057017,16.369216,16.498525,16.460272,17.104925,16.678983]),
array([16.480261])
]


data_10=[array([20.354567,20.237923]),
array([17.120447,17.493227,17.121777,17.106118]),
array([16.798013,20.30175,16.834459,16.331716,17.457507]),
array([29.12601]),
array([40.585015]),
array([17.076098,16.829009,16.864316,16.969982,16.555397,17.465774]),
array([20.163905,20.362814]),
array([38.725622]),
array([37.830935,53.330124]),
array([40.803071,38.875746,37.976347,40.284348,39.480686,40.743233,40.078643]),
array([40.131469]),
array([27.620058,28.842831,26.833878,27.882217,25.768987]),
array([20.280711,20.346237,20.214319]),
array([17.464704,16.736838,17.269345,16.957618,17.212653,17.470554,16.818614,17.105573,17.41289,16.901769,16.340255,16.761489,17.453182,16.980219,17.114102,16.750304,16.35209,16.800447,17.421238]),
array([48.927636,52.197003]),
array([35.00849]),
array([20.138127,20.18259,17.383892,16.539792,17.189145]),
array([20.125827]),
array([17.818815,20.207363,16.093021,16.803742,17.424778,16.731805,17.219243,16.789521,17.14906,16.779879,16.540196,16.557674,16.804936,16.932687,16.41431,16.719423,16.724767,16.565432,16.599455,17.099478,17.188362,16.583722,16.515554,16.319602,16.989722,17.040391,16.793525,16.776067,16.620651,16.447904,16.955429,16.407737,17.384008,16.422297,16.875863,16.313858,17.423785,17.045765,16.858274,16.903284]),
array([48.689441]),
array([31.764692]),
array([24.217847]),
array([16.861774,17.300262,17.166159,16.357643,17.37478]),
array([16.654009]),
array([39.512858,38.784347]),
array([50.027215]),
array([44.929895]),
array([41.14709]),
array([27.734868,26.618878,24.955474,28.939709,28.675266,25.330649,29.292118]),
array([29.225441,28.669863]),
array([43.323761]),
array([37.10871]),
array([38.948341,39.806137]),
array([44.49621,43.991567,52.407516,52.57174]),
array([17.285622,16.98136,16.539238,17.099161,17.017317]),
array([28.197451]),
array([27.297763,27.691744,28.405462,27.064456,26.011685,24.27591]),
array([26.320226]),
array([35.48554,35.143238,40.739244]),
array([27.433655]),
array([26.062296,25.881353,26.417785,27.081991,25.590887]),
array([38.642011]),
array([35.341934]),
array([17.049442,16.51777,17.271026,17.224745,16.357346,16.794113,16.300355,17.269834,16.410909,17.029516,17.20284,16.354695]),
array([16.764486,16.657396,17.088508]),
array([20.202608]),
array([26.530228,26.324417,26.631991]),
array([20.224084,20.149653,16.719587,16.828019,16.741059]),
array([20.333418]),
array([17.094823,16.91204,17.123411,16.543502,16.834417,16.862101,17.337527,17.016939,16.616096,17.27275,17.18963,17.315668,17.202735,16.587899,16.887632,17.23034,17.424292,17.475583,16.63181,16.917593,16.465384,16.669547,17.409568,16.989052,17.19685,16.384725,16.991903,17.297791,17.224177,16.538848,17.254167]),
array([16.597614])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'carnivore_EOT_sp_occ_SALMA_kept_1',  'carnivore_EOT_sp_occ_SALMA_kept_2',  'carnivore_EOT_sp_occ_SALMA_kept_3',  'carnivore_EOT_sp_occ_SALMA_kept_4',  'carnivore_EOT_sp_occ_SALMA_kept_5',  'carnivore_EOT_sp_occ_SALMA_kept_6',  'carnivore_EOT_sp_occ_SALMA_kept_7',  'carnivore_EOT_sp_occ_SALMA_kept_8',  'carnivore_EOT_sp_occ_SALMA_kept_9',  'carnivore_EOT_sp_occ_SALMA_kept_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Acrocyon_riggsi','Acrocyon_sectorius','Acyon_tricuspidatus','Andinogale_sallensis','Angelocabrerus_daptes','Arctodictis_munizi','Arctodictis_sinclairi','Argyrolestes_peralestinus','Arminiheringia','Arminiheringia_auceta','Arminiheringia_contigua','Australohyaena_antiqua','Borhyaena_macrodonta','Borhyaena_tuberata','Callistoe_vincei','Chlorocyon_phantasma','Cladosictis','Cladosictis_centralis','Cladosictis_patagonicus','Eobrasilia_coutoi','Eomakhaira_molossus','Fredszalaya_hunteri','Lycopsis_torresi','Micoureus_laventicus','Nemolestes','Nemolestes_brasiliensis','Nemolestes_lagunafriensis','Nemolestes_spalacotherinus','Notogale_mitis','Paraborhyaena_boliviana','Patene','Patene_campbelli','Patene_coluapiensis','Patene_simpsoni','Perathereutes_pungens','Pharsophorus','Pharsophorus_lacerans','Pharsophorus_tenax','Plesiofelis_schlosseri','Proborhyaena','Proborhyaena_gigantea','Procladosictis','Procladosictis_anomala','Prothylacynus_patagonicus','Pseudonotictis_pusillus','Pseudothylacynus_rectus','Sallacyon_hoffstetteri','Sipalocyon','Sipalocyon_externus','Sipalocyon_gracilis','Sipalocyon_obusta']
def get_taxa_names(): return taxa_names