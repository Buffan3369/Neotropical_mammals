#!/usr/bin/env python
from numpy import * 


data_1=[array([30.837258,29.062653,32.553828,25.385977,24.607777]),
array([31.978582,31.721512,50.214494]),
array([32.284351,33.19441,33.182997,38.089238,31.425053,32.160202]),
array([49.970558,51.350469,52.207154]),
array([34.985711]),
array([45.430594,48.980797,48.610759,40.525999,38.493602,41.052506,42.405629,46.69569,40.397165,39.122878,38.415817,49.855657,45.729931,39.148031,39.426481,49.883622,49.005939,49.220483,49.386625,38.510728]),
array([53.168815,55.911535,29.058598,33.439112]),
array([36.505663,51.347716,44.766824,49.956703,50.685173,39.039233,43.692662,40.118907,49.540278,48.426993,39.134165,40.189242,50.289536,50.090705]),
array([38.063606]),
array([42.387873,48.580719]),
array([46.511481]),
array([37.431771,40.855764,41.491149]),
array([36.332127]),
array([28.086801]),
array([52.852021]),
array([47.848229]),
array([32.003037,28.882607,40.823416,38.102056,32.816421,38.082511,38.058678,38.036203]),
array([38.106015]),
array([29.388439,40.43588,26.395721,26.272025,32.344304,28.544461,31.57175,31.376061,29.214729,26.402901,29.362413,25.578452,28.158557,26.248235,26.653812,33.288613,38.110631,32.468594,33.519847,31.893468,29.018424,32.777701,38.16272,33.444811,32.265145,32.058597]),
array([31.735711]),
array([55.091019,52.297306,52.115235]),
array([51.584329]),
array([35.764837,31.848612,31.560169,32.595629]),
array([40.511666,38.154637,38.135792,32.701696,33.217907,32.511221,24.652807,31.385486,38.067444,38.05393,38.095742,45.449966,38.019408]),
array([40.230614,38.181091,39.419246,40.325287]),
array([38.26247,46.0142,41.535101,36.687272,34.114489,29.110732]),
array([38.166308]),
array([33.567088,30.761843,28.566915,25.216293]),
array([41.023601,48.985482,39.050568]),
array([39.139349]),
array([38.0669,38.0352,48.748401,39.159149,39.930585,38.192682,44.473575,49.167641,41.250849,39.917115,55.830729,38.195122,40.728296]),
array([38.168304,38.150461,38.192922,38.154435,38.142945]),
array([49.861618]),
array([40.682879,38.027327]),
array([38.156694,48.480282,44.20707,39.02011,44.959538,50.777659,40.393691,38.156355,52.849809]),
array([38.030889]),
array([49.251422]),
array([50.144382,47.775222,52.279986]),
array([25.052384,26.116929]),
array([54.329745]),
array([45.394046,47.125185,41.170504,38.172425,38.093506]),
array([38.150773,38.000231]),
array([54.697712]),
array([38.166309,39.583655,39.813506,39.182913,41.607044,49.768016,49.341086,48.627217,40.455478,39.503972,47.585319,40.061265,40.29115,39.73461,40.188536,41.596824,41.390935,50.66908,39.866247]),
array([34.081756])
]


data_2=[array([30.25831,28.828613,32.060744,26.902767,24.677983]),
array([31.795066,32.637276,53.523072]),
array([33.04732,32.138041,32.904671,38.120693,31.74875,31.445881]),
array([50.240005,55.649375,52.742736]),
array([34.885413]),
array([43.793617,48.158583,49.295566,40.754193,38.963139,38.8061,47.130797,47.213898,39.750057,38.569869,38.180121,49.829352,43.944558,38.007651,38.904542,49.180914,49.327352,49.377144,49.979775,39.283747]),
array([54.825088,55.567198,29.096524,33.604069]),
array([37.320968,52.704841,44.153227,49.563233,50.085539,40.401554,44.737126,41.187065,48.357019,48.663776,39.800079,39.105437,50.477553,50.283237]),
array([38.010833]),
array([43.958432,49.913164]),
array([45.349561]),
array([41.868253,41.493768,38.893115]),
array([35.135416]),
array([24.333607]),
array([55.098518]),
array([47.162817]),
array([33.481614,25.472753,39.746763,38.14728,26.160533,38.087687,38.169022,38.13726]),
array([38.035415]),
array([28.193877,41.674185,25.924091,25.327299,31.376417,27.086452,32.257432,32.446143,28.978545,27.591235,29.333799,24.86275,24.60711,24.76168,27.755202,27.438432,38.083885,31.646894,33.253499,33.27614,26.664958,31.842918,38.001653,32.214037,31.386176,31.932807]),
array([31.561006]),
array([51.536335,52.16255,52.531045]),
array([49.814439]),
array([35.299152,32.958551,31.965649,31.542968]),
array([39.444474,38.105368,38.025901,32.565866,32.091427,31.868335,25.502061,31.940308,38.164839,38.157369,38.00748,44.693734,38.156048]),
array([41.014665,38.142928,39.107783,39.420501]),
array([46.508694,38.619176,39.873949,35.264848,32.316357,37.049188]),
array([38.062007]),
array([33.569883,30.720892,27.994006,28.179894]),
array([39.694195,49.179261,41.074302]),
array([38.756737]),
array([38.158938,38.06093,48.571399,41.214879,40.963517,38.158993,45.005704,49.00224,41.196732,39.911449,47.676808,38.08265,40.128495]),
array([38.057278,38.084716,38.129096,38.125245,38.102994]),
array([48.900333]),
array([39.991757,38.027715]),
array([38.177485,48.019054,44.187381,39.715272,44.409579,49.47863,40.614546,38.043958,53.936659]),
array([38.078484]),
array([50.630746]),
array([50.899155,47.256126,53.563985]),
array([26.358462,28.083038]),
array([48.771689]),
array([42.019375,47.484385,40.279395,38.169554,38.093924]),
array([38.04557,38.120261]),
array([50.14418]),
array([38.161957,40.365361,40.07182,41.653565,39.205368,49.649471,49.332824,48.702643,40.306663,40.607037,47.94741,38.183943,40.877351,39.418593,40.012226,39.513581,40.518073,48.168315,41.181719]),
array([37.262327])
]


data_3=[array([30.469764,25.805288,31.732884,24.378762,27.462632]),
array([32.289754,32.406235,50.797535]),
array([32.275302,32.002914,33.485674,38.170351,32.046016,32.195046]),
array([48.681809,52.374165,52.403246]),
array([33.71712]),
array([47.138201,49.883935,48.640563,39.892004,40.910391,41.137556,42.49426,42.182061,38.888115,39.057958,40.534359,48.143302,43.104753,40.034279,39.344693,49.248354,49.778693,48.277919,49.44712,40.819228]),
array([52.817122,51.142198,29.106116,33.469647]),
array([35.259039,54.683526,42.158407,49.543418,50.337899,38.350246,46.627487,39.279435,49.788467,48.312338,40.938702,39.479626,50.242036,50.301196]),
array([38.140006]),
array([46.801643,49.687947]),
array([45.308704]),
array([40.79097,38.302662,36.542593]),
array([33.343629]),
array([26.623225]),
array([54.042127]),
array([47.283948]),
array([33.048734,25.035262,39.73832,38.018117,29.602215,38.168692,38.005017,38.114171]),
array([38.032293]),
array([27.366498,40.688178,24.565069,28.205629,31.734654,28.839219,31.995664,33.147609,24.251082,29.372681,26.721953,26.402322,26.369083,26.584323,26.566065,27.217245,38.055578,32.565469,31.687298,32.239726,25.893208,33.050826,38.083969,33.256456,31.507679,32.090149]),
array([31.834859]),
array([54.764866,52.461801,52.341039]),
array([49.016354]),
array([32.788844,33.351551,31.488506,31.745731]),
array([41.101881,38.175716,38.155967,31.32873,33.230377,33.027882,27.251067,32.867205,38.027358,38.011815,38.060173,45.393195,38.171535]),
array([38.430929,38.068125,41.081984,38.714433]),
array([40.373473,44.022456,40.503256,34.576102,31.973299,28.683999]),
array([38.07237]),
array([33.584058,30.653018,26.59089,28.595565]),
array([38.841845,49.990494,39.366614]),
array([38.279359]),
array([38.1099,38.131939,49.313413,40.992379,39.523655,38.090705,49.746801,47.581459,41.253385,40.058584,53.233764,38.019447,39.376818]),
array([38.111242,38.070373,38.188756,38.037353,38.106637]),
array([49.820867]),
array([40.3504,38.056197]),
array([38.116282,49.531342,44.959354,41.260125,44.457728,48.906427,40.922457,38.136123,52.048411]),
array([38.119779]),
array([50.620972]),
array([50.908057,47.850578,52.522078]),
array([24.886887,27.003266]),
array([51.739349]),
array([45.211171,47.214725,39.782626,38.103294,38.13005]),
array([38.192023,38.012417]),
array([51.424843]),
array([38.117819,41.645511,41.62327,40.855576,41.516639,49.816624,49.968309,50.013059,40.66465,41.110841,47.974731,38.589303,39.490596,39.618691,41.265249,39.81641,40.658285,49.929921,39.101713]),
array([35.87852])
]


data_4=[array([29.92901,28.361975,32.352005,25.767805,28.601997]),
array([31.644219,32.17555,53.920695]),
array([33.361234,32.836209,33.572316,38.078448,32.868698,32.958143]),
array([53.989552,54.659841,52.517253]),
array([33.69871]),
array([41.589181,49.171707,49.971358,47.545813,38.057882,38.931506,42.386523,46.007239,38.091534,40.986715,40.706618,49.535196,46.361639,39.33098,39.734161,49.164438,48.139383,49.113188,49.188355,40.016023]),
array([49.602895,41.74717,29.097053,33.801415]),
array([35.355287,54.252983,45.43278,48.396794,50.197388,39.034294,38.79854,40.465317,48.466392,48.724474,39.585253,40.482846,50.918465,50.794586]),
array([38.049201]),
array([46.863069,48.662739]),
array([45.049853]),
array([38.298842,37.614575,38.145887]),
array([31.017833]),
array([26.318911]),
array([52.113193]),
array([46.468347]),
array([32.558792,25.487582,41.011731,38.04905,30.151767,38.120882,38.136981,38.048016]),
array([38.159491]),
array([24.59008,41.469936,28.035335,26.508318,31.858829,29.306437,31.306314,32.593988,27.135038,27.134457,29.206268,28.536959,28.123188,27.191504,26.556504,25.60798,38.00117,31.72816,32.615386,32.276707,24.862635,31.758283,38.002492,33.104076,32.141762,32.641968]),
array([32.374089]),
array([54.460352,52.191866,52.964411]),
array([53.766931]),
array([35.52718,32.945613,32.210927,31.656527]),
array([40.870388,38.046969,38.153296,32.192624,31.605913,33.258268,26.017161,32.313268,38.160798,38.118606,38.16664,44.265608,38.014006]),
array([39.631562,38.177834,40.383152,38.177487]),
array([37.767083,43.49241,40.214683,36.841395,29.639467,31.297297]),
array([38.029188]),
array([33.583078,30.733331,28.243404,25.849274]),
array([39.185989,48.091855,38.101837]),
array([40.640453]),
array([38.037113,38.048718,49.687231,40.454321,40.830321,38.099562,49.709465,48.388922,40.381667,41.28322,48.671899,38.111482,41.637361]),
array([38.042945,38.105668,38.193193,38.067342,38.05413]),
array([49.513444]),
array([39.718263,38.078592]),
array([38.153977,49.314136,44.29668,41.490526,44.354433,48.766952,39.022808,38.015311,53.064804]),
array([38.026823]),
array([51.860466]),
array([50.925254,47.586965,52.831904]),
array([25.478688,27.037676]),
array([51.532887]),
array([41.403197,47.818301,41.577508,38.06743,38.097188]),
array([38.157889,38.199807]),
array([58.22017]),
array([38.109449,40.777192,40.430923,39.977234,41.397546,50.64206,48.527555,49.822716,40.27484,39.438383,47.902821,40.657445,41.041957,41.091622,41.548093,40.572674,40.674705,49.737028,39.037823]),
array([32.961173])
]


data_5=[array([29.43416,26.308342,33.207894,25.355265,26.323906]),
array([32.605879,33.217474,51.763488]),
array([33.572767,33.33326,33.162092,38.196982,31.968744,32.426255]),
array([53.953923,51.39835,52.980827]),
array([33.814782]),
array([46.321121,48.504113,49.903093,41.083256,38.378041,39.188483,42.332582,45.635346,39.701427,39.323208,39.794359,49.808129,40.873546,39.77373,40.442901,48.586811,49.59681,48.623457,49.827894,38.371678]),
array([49.804312,48.386656,29.12444,33.772111]),
array([34.340554,47.833071,47.009341,49.573698,50.4142,39.992839,41.264145,40.133235,49.509037,49.093782,38.481782,41.043902,50.775442,50.805421]),
array([38.023384]),
array([45.746305,49.094307]),
array([46.736536]),
array([41.529788,39.965992,38.694842]),
array([32.320964]),
array([25.705935]),
array([52.679932]),
array([46.691386]),
array([32.004561,27.122011,41.176579,38.057923,27.806949,38.091814,38.168123,38.127126]),
array([38.113505]),
array([26.715641,40.59072,24.325004,25.079224,32.772717,26.561942,33.587559,31.81389,28.235637,24.25475,24.664619,24.916771,25.670083,28.219885,25.237151,30.031335,38.033111,31.710863,31.930728,31.435118,26.713588,33.008299,38.155558,32.021254,33.512743,31.727447]),
array([32.376919]),
array([55.786591,52.086994,52.654142]),
array([54.973137]),
array([37.074248,31.808991,31.631737,31.718291]),
array([40.778688,38.185668,38.177766,32.21287,32.432858,33.365703,29.092153,33.309627,38.019537,38.07541,38.032943,45.077225,38.142462]),
array([38.920673,38.028663,40.057165,40.813806]),
array([40.021852,43.321693,42.394726,35.855953,32.124601,33.941825]),
array([38.195042]),
array([33.573661,30.682973,28.573017,25.025526]),
array([39.761441,48.604697,38.808329]),
array([39.79801]),
array([38.198326,38.053611,49.307703,39.178563,39.145136,38.148858,46.954143,45.293101,39.871584,39.088962,44.665544,38.156712,41.330352]),
array([38.142023,38.125649,38.170474,38.056669,38.131182]),
array([48.220499]),
array([41.06277,38.054499]),
array([38.180178,50.794236,44.770698,40.470104,44.674976,48.155093,39.028033,38.163887,53.79607]),
array([38.038593]),
array([49.190111]),
array([50.302876,47.422024,53.284451]),
array([26.371099,24.338549]),
array([47.329717]),
array([43.616177,47.167864,39.07793,38.071178,38.180579]),
array([38.186056,38.010236]),
array([54.465348]),
array([38.109749,40.316156,41.16815,41.43324,40.898772,48.346482,50.650234,49.109133,41.1252,41.298938,47.025761,39.885262,40.708686,41.635275,40.209054,39.331643,40.238163,49.773367,39.616216]),
array([34.721039])
]


data_6=[array([31.235786,28.153774,32.776019,25.035576,25.552566]),
array([32.530807,32.919878,53.140388]),
array([31.620983,33.289855,31.873,38.001527,32.579263,31.440823]),
array([54.0434,52.043615,52.952765]),
array([34.208219]),
array([46.703611,48.96513,48.822181,39.971757,39.81327,39.902846,42.928645,41.412265,41.08895,40.583377,38.125613,48.248068,39.548842,39.707427,40.788746,48.387758,49.434846,49.453804,49.262798,41.105918]),
array([51.932344,49.042846,29.0216,33.509354]),
array([34.456255,48.607015,47.777385,49.975659,50.811475,39.509793,45.83288,40.606623,48.893938,48.293143,40.006709,38.12111,50.939332,50.832565]),
array([38.02194]),
array([45.148355,48.206037]),
array([45.571743]),
array([41.363807,41.559588,38.874303]),
array([32.968574]),
array([29.274234]),
array([52.995044]),
array([47.917345]),
array([31.32933,27.365968,41.208936,38.039751,29.176912,38.152478,38.08731,38.167558]),
array([38.003459]),
array([25.936796,41.351255,25.548214,24.225503,32.798455,27.965451,32.71675,32.331097,26.704785,28.137302,29.306501,24.934297,29.24502,28.721212,26.454989,29.051058,38.046313,31.395549,33.396811,32.93649,26.30062,31.332369,38.167542,32.341137,31.474231,32.344903]),
array([31.597749]),
array([48.679308,52.216227,52.064257]),
array([48.701216]),
array([35.750544,32.677807,32.590778,32.482533]),
array([40.197362,38.072097,38.082145,32.854006,32.31651,31.75809,27.479735,32.306648,38.085476,38.064877,38.033837,45.308738,38.189229]),
array([40.426339,38.171772,39.400041,39.524288]),
array([45.612861,47.321028,41.81797,34.074842,29.127897,33.374967]),
array([38.189124]),
array([33.584238,30.756429,27.183991,24.870404]),
array([40.386578,49.41757,39.79023]),
array([39.745824]),
array([38.013557,38.190579,48.168262,41.456581,41.662871,38.002637,48.110487,48.878721,40.881215,41.357852,49.213503,38.162932,41.585271]),
array([38.02819,38.193095,38.15107,38.150852,38.167063]),
array([48.55773]),
array([40.313732,38.065454]),
array([38.039698,48.078753,44.930271,39.298497,44.595793,48.042603,39.154592,38.027293,52.182414]),
array([38.164396]),
array([50.52982]),
array([50.221129,47.554048,53.539804]),
array([25.787437,25.232262]),
array([47.973056]),
array([45.083524,47.499113,40.434771,38.175474,38.14746]),
array([38.147594,38.091415]),
array([54.261004]),
array([38.09051,40.394889,40.563509,41.151084,41.678463,48.656407,48.633458,48.642145,39.809758,40.014632,47.658667,39.190205,39.544734,40.497969,40.581932,41.345026,39.895782,49.699857,40.835441]),
array([32.502338])
]


data_7=[array([30.838105,26.65651,31.956667,27.755357,24.453824]),
array([31.339838,31.616455,55.871373]),
array([31.737656,32.394139,31.581704,38.047764,33.021582,32.156042]),
array([49.011254,52.43106,52.588809]),
array([33.474731]),
array([44.497051,49.480739,48.65061,43.878037,40.075266,40.124609,44.974981,44.569007,40.514516,40.333172,38.567426,48.693687,46.400271,38.321048,40.253821,49.192837,49.475788,49.132427,49.80208,39.026668]),
array([48.045913,41.988098,29.005206,33.596807]),
array([36.722081,52.681242,44.169799,48.773712,50.578041,39.883423,40.486926,38.867491,48.239652,48.272179,38.797636,40.902119,50.953527,50.195791]),
array([38.010884]),
array([42.715243,48.193449]),
array([47.342441]),
array([38.684315,38.988222,41.445582]),
array([36.695633]),
array([26.996506]),
array([51.47166]),
array([47.885459]),
array([33.156524,25.495859,41.634073,38.197536,29.252774,38.107086,38.120738,38.188075]),
array([38.140258]),
array([28.712051,40.410064,26.410751,25.041568,32.018243,26.80589,32.220971,31.613857,27.567669,28.732743,27.839693,25.688725,29.027799,27.946516,26.538528,31.527034,38.183838,32.100513,32.452795,32.538118,29.320298,33.527595,38.146137,31.45789,32.058686,31.978803]),
array([32.079838]),
array([50.014471,52.027063,52.194773]),
array([53.766642]),
array([35.886517,33.119716,32.573365,32.09915]),
array([39.256086,38.081555,38.113822,31.547896,32.346184,32.916206,26.965413,32.13734,38.045303,38.175191,38.138176,45.672027,38.021786]),
array([39.483515,38.000462,40.443582,38.437303]),
array([47.369922,43.965112,45.228557,36.636082,28.509092,34.458706]),
array([38.170193]),
array([33.591259,30.742511,25.102746,26.427308]),
array([38.945825,49.023004,38.333175]),
array([39.736483]),
array([38.058198,38.184075,49.0093,40.379453,40.230877,38.023298,48.833165,45.614848,39.46584,40.93277,44.724747,38.068938,39.702274]),
array([38.049134,38.010707,38.191394,38.134868,38.012018]),
array([49.319917]),
array([40.069393,38.098747]),
array([38.075726,48.424638,44.305485,41.562597,44.384919,48.055187,40.680391,38.19411,52.850276]),
array([38.154203]),
array([48.606664]),
array([50.524715,47.148152,52.131129]),
array([27.864583,26.169957]),
array([45.794463]),
array([47.417635,47.033021,39.559686,38.033423,38.156931]),
array([38.013258,38.146624]),
array([54.922686]),
array([38.170957,39.015626,41.366164,40.611759,41.330442,50.278656,49.956654,48.289649,39.125463,41.151997,47.620593,38.108876,39.24144,40.829893,40.567061,39.738375,40.369967,50.8268,39.484439]),
array([37.16414])
]


data_8=[array([30.651793,28.532585,32.797372,25.299121,26.153552]),
array([31.925408,33.064198,54.135759]),
array([31.341291,33.351981,33.566758,38.021073,31.900139,33.592789]),
array([50.540694,51.465439,52.245226]),
array([34.436889]),
array([44.845634,48.816245,49.666554,47.763403,40.173997,38.721239,41.529335,42.082619,39.58479,41.088928,39.107051,49.906088,43.267993,40.903289,38.774328,48.702004,49.868208,48.20669,49.008198,39.581287]),
array([48.234429,44.238733,29.138967,33.334663]),
array([34.082949,49.576059,47.284253,49.488819,50.264329,40.5584,44.720053,40.73139,48.92272,49.470033,39.535931,40.209795,50.501562,50.409691]),
array([38.034281]),
array([45.726496,49.462084]),
array([42.838219]),
array([39.496784,36.703763,40.177324]),
array([30.97671]),
array([27.864532]),
array([53.062638]),
array([46.437518]),
array([32.658602,26.117896,40.253562,38.180944,33.343611,38.171462,38.122775,38.194618]),
array([38.028593]),
array([27.922334,40.152255,25.306485,25.363746,33.494629,24.734469,32.117192,32.005477,26.93237,28.014296,25.996672,24.830661,25.92379,25.114443,28.380056,26.152495,38.190158,32.315378,32.075214,31.721736,27.408237,31.370446,38.023898,32.584049,31.963312,33.592538]),
array([33.579014]),
array([51.336556,52.225316,52.401801]),
array([49.80348]),
array([35.580456,31.915121,31.731469,31.949552]),
array([40.532377,38.198415,38.096377,33.482971,33.143173,33.051962,26.866761,32.494924,38.142837,38.052992,38.046865,44.640078,38.123367]),
array([39.875999,38.031682,39.827771,40.561614]),
array([47.235204,41.217655,39.671618,35.337553,33.296746,30.111267]),
array([38.084382]),
array([33.582867,30.71195,28.571159,28.117693]),
array([38.809248,49.707725,39.827905]),
array([40.223207]),
array([38.065864,38.12876,48.154858,41.36262,40.724135,38.110051,48.154891,45.567301,39.876919,41.570317,44.881358,38.180107,41.050951]),
array([38.109921,38.05316,38.117569,38.012762,38.15162]),
array([48.143013]),
array([40.298046,38.054226]),
array([38.104447,50.877375,44.761862,39.487417,44.351665,50.897212,39.384651,38.044178,52.896991]),
array([38.133294]),
array([51.149942]),
array([50.088037,47.442267,53.087077]),
array([25.185287,27.238664]),
array([55.061643]),
array([41.943788,47.754109,41.672695,38.175719,38.058007]),
array([38.149819,38.163411]),
array([55.9497]),
array([38.032131,41.40176,39.152114,39.16872,41.536929,50.493162,50.710747,50.365473,39.428442,40.152033,47.656362,39.632586,41.105114,39.597672,41.464734,41.290025,40.655925,50.229279,41.126264]),
array([29.995626])
]


data_9=[array([30.82694,29.22071,31.379959,25.506696,27.30454]),
array([32.807296,31.801926,50.368549]),
array([32.774022,31.687344,33.35926,38.103687,32.820276,32.016029]),
array([54.082035,52.655322,52.523995]),
array([34.805203]),
array([46.960658,48.735605,49.516666,40.392871,40.278475,40.820255,43.725928,47.143438,40.785567,41.191142,40.807565,49.108961,41.027155,38.780278,41.087717,48.936982,49.342626,48.53583,48.347375,39.847931]),
array([48.035414,42.310174,29.052927,33.577027]),
array([34.068313,50.285512,43.256792,48.919671,50.51808,40.143974,40.753016,39.635166,48.735343,49.345342,38.986746,38.086034,50.893834,50.854438]),
array([38.000817]),
array([45.060486,48.90918]),
array([43.207404]),
array([38.971889,41.630169,36.404391]),
array([33.866917]),
array([24.429785]),
array([49.717698]),
array([46.380794]),
array([31.435644,28.96616,39.155311,38.086514,25.674711,38.138179,38.053678,38.139591]),
array([38.189667]),
array([27.305178,39.162103,25.348661,27.506523,32.056802,27.575589,33.10108,31.331398,27.604691,24.240866,28.540553,27.105667,26.241223,27.793893,26.858579,24.93027,38.149966,32.350027,31.400547,31.869192,27.727747,33.074215,38.078412,33.427427,33.382053,33.391365]),
array([32.864117]),
array([52.065939,52.037066,52.714662]),
array([53.54709]),
array([35.171331,31.637855,31.697652,31.525874]),
array([40.390411,38.012998,38.190352,32.453429,33.28931,31.717735,25.024077,32.232344,38.054477,38.112471,38.002432,44.05404,38.177274]),
array([41.046127,38.170061,39.738809,40.275003]),
array([40.764368,46.044268,47.299699,36.660378,35.098962,36.642536]),
array([38.067852]),
array([33.581337,30.717463,26.19708,28.713795]),
array([40.664331,48.198902,38.615276]),
array([38.122429]),
array([38.006328,38.026634,48.002855,39.288065,41.296345,38.129881,49.017772,47.313343,39.919904,40.601811,54.002562,38.188805,39.475092]),
array([38.108287,38.022054,38.088147,38.116028,38.171226]),
array([49.265015]),
array([39.691082,38.109906]),
array([38.051752,50.131861,44.994333,39.586301,44.634744,50.228323,41.100122,38.021823,52.261204]),
array([38.022652]),
array([50.019819]),
array([50.790006,47.41174,52.909468]),
array([27.148488,26.57672]),
array([55.291265]),
array([44.028223,47.736838,40.787901,38.044569,38.08016]),
array([38.173444,38.067595]),
array([58.131408]),
array([38.045687,41.523241,40.03286,40.849809,40.936669,48.770804,50.911049,49.904412,41.253401,41.040632,47.827512,38.90167,39.913105,39.23647,39.215622,39.125951,40.362575,50.363532,39.920939]),
array([32.789597])
]


data_10=[array([30.921482,29.201909,32.059639,25.936703,28.401812]),
array([33.203961,33.153507,54.80696]),
array([32.107207,32.446622,33.077973,38.086341,31.323703,33.130491]),
array([49.880817,51.274813,52.598598]),
array([34.736454]),
array([43.890739,48.168815,48.099117,38.275396,41.007716,40.413107,44.532143,47.282383,38.985612,39.339785,38.306835,49.220805,39.638422,39.007287,39.234152,49.671781,49.850101,49.316862,48.563809,39.573041]),
array([51.423503,48.823778,29.115942,33.385157]),
array([37.64195,48.948243,44.156766,48.340595,50.064356,38.122667,39.711408,41.010413,48.728173,48.850349,40.830083,39.476508,50.370797,50.310476]),
array([38.090691]),
array([47.587904,49.933574]),
array([45.9386]),
array([37.377859,38.71744,38.012032]),
array([35.487744]),
array([27.815688]),
array([53.569717]),
array([47.343678]),
array([31.628397,24.340487,39.236885,38.07965,30.231387,38.092152,38.107707,38.171552]),
array([38.044072]),
array([25.656624,41.229235,28.644771,27.159079,31.963168,24.307751,32.21883,32.790003,26.404279,26.566742,27.409624,27.876797,27.940416,26.301518,26.332868,25.223409,38.088931,32.672498,32.719544,31.756383,29.388059,32.531935,38.121431,33.055184,32.672076,32.10986]),
array([32.525611]),
array([51.231195,52.369382,52.467678]),
array([55.594884]),
array([32.957458,32.272955,32.163431,32.080799]),
array([41.318127,38.168235,38.197416,31.675797,31.99917,31.357734,26.832273,33.493145,38.024252,38.047943,38.039158,44.263658,38.050459]),
array([40.024141,38.051918,38.988138,40.759179]),
array([44.709271,45.906719,44.028496,35.177904,29.645469,31.209536]),
array([38.176633]),
array([33.576173,30.74223,24.453707,27.694092]),
array([40.292449,48.524889,41.017464]),
array([38.461922]),
array([38.095844,38.149188,49.153837,41.547213,40.935468,38.027846,50.033166,50.286294,40.032874,41.559265,42.758342,38.06404,39.046532]),
array([38.059807,38.012945,38.117867,38.067643,38.100703]),
array([49.375207]),
array([39.207991,38.175616]),
array([38.108703,49.869339,44.64556,40.438108,44.048861,50.992,41.179768,38.18601,53.698836]),
array([38.110371]),
array([50.963713]),
array([50.411494,47.343357,52.550439]),
array([25.551838,28.656211]),
array([43.542052]),
array([45.502977,47.341613,39.182131,38.095749,38.115706]),
array([38.007695,38.088434]),
array([55.468974]),
array([38.040685,39.660854,40.374275,39.890502,40.36658,50.778622,48.559648,50.879821,41.575581,41.661552,47.103219,39.946818,41.674459,41.502571,41.196795,40.592709,39.840824,50.822763,41.005983]),
array([35.124995])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'insectivore_EOT_gen_occ_SALMA_kept_1',  'insectivore_EOT_gen_occ_SALMA_kept_2',  'insectivore_EOT_gen_occ_SALMA_kept_3',  'insectivore_EOT_gen_occ_SALMA_kept_4',  'insectivore_EOT_gen_occ_SALMA_kept_5',  'insectivore_EOT_gen_occ_SALMA_kept_6',  'insectivore_EOT_gen_occ_SALMA_kept_7',  'insectivore_EOT_gen_occ_SALMA_kept_8',  'insectivore_EOT_gen_occ_SALMA_kept_9',  'insectivore_EOT_gen_occ_SALMA_kept_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Archaeutatus','Astegotherium','Barrancatatus','Carodnia','Clenia','Didolodus','Eomicrobiotherium','Ernestokokenia','Eutrochodon','Florentinoameghinia','Greniodon','Groeberia','Kirutherium','Kuntinaru','Lamegoia','Lumbreratherium','Machlydotherium','Mazzoniphractus','Meteutatus','Microbiotherium','Mirandatherium','Palaeocladosictis','Parastegosimpsonia','Parutaetus','Paulogervaisia','Perulestes','Picunia','Pilchenia','Proectocion','Progarzonia','Prostegotherium','Pseudeutatus','Pseudhalmarhiphus','Pseudostegotherium','Pucatherium','Punatherium','Ricardocifellia','Riostegotherium','Salladolodus','Saltaodus','Stegosimpsonia','Trilobodon','Umayodus','Utaetus','Wirunodon']
def get_taxa_names(): return taxa_names