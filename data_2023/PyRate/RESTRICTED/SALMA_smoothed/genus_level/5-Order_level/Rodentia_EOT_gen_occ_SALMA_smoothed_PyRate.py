#!/usr/bin/env python
from numpy import * 


data_1=[array([27.802209]),
array([25.759826]),
array([36.270031,36.467698]),
array([33.792001]),
array([26.555542,23.667314,24.785254,26.009978,25.824674,26.02161,23.117469,24.297809,24.143793,24.346119,25.920845,23.394704,23.791747]),
array([27.755504,34.777474,35.317223]),
array([25.093302,27.671356,27.275676,24.270554]),
array([37.194817,35.916831,34.872304,38.092031,34.294897,36.700359,33.99746,37.948213,28.188995]),
array([40.841271,30.455497]),
array([27.749358,25.202714,27.096487]),
array([25.126032,26.623144,24.187609,23.500362,23.249251,23.36662,24.101639,25.382693,25.461777,23.897254,24.872794,23.828127,25.780586,23.49344]),
array([27.974221,28.044089]),
array([35.865821]),
array([29.134894]),
array([36.889513]),
array([36.361442,35.275599]),
array([26.784925,23.499055]),
array([25.802141]),
array([27.71233]),
array([24.659654,24.065475,23.169285]),
array([24.565256,23.722973,24.789691]),
array([30.751517]),
array([30.604997,38.326248,34.721237,30.446373,28.500805]),
array([29.10334]),
array([37.878722,34.705941,29.469808]),
array([31.275913,36.953905,28.517814,29.933064,31.425612,37.132476,35.924327,33.602742,28.614837,33.197639,34.640725,31.813269,35.558809,30.662567,33.289803]),
array([29.554781]),
array([36.766037,28.332969]),
array([30.613719]),
array([30.86665,29.714066,25.316982]),
array([24.196257,24.123564,24.820842,26.483925,31.319429]),
array([23.983219]),
array([27.4887]),
array([26.754271,26.9926,26.219173,23.806148,24.459886,26.310902,25.391267]),
array([34.453849]),
array([26.923068,24.577559]),
array([26.151806]),
array([26.769355,25.756147]),
array([23.395166]),
array([26.839905]),
array([27.514837]),
array([28.711186]),
array([26.904365,23.792708,23.588058,27.406837,25.477235,25.109547,26.975399]),
array([24.837893,26.602951,23.20073]),
array([26.563286]),
array([23.865035]),
array([24.701707]),
array([24.331747]),
array([30.593441,30.966514,34.75795]),
array([25.990385]),
array([23.659367,26.70472,25.051097,24.948534,25.449302,27.743207,26.834362]),
array([25.003294,23.455798,23.712342,26.786872,27.187991,27.342886]),
array([24.113138]),
array([24.962365,24.371903]),
array([30.522565]),
array([31.454048,30.309899]),
array([33.356025]),
array([26.408537]),
array([29.633332,36.109901,35.382434,28.757321,29.698618]),
array([28.096088,26.943377]),
array([30.630649,30.738445]),
array([28.925457]),
array([27.464251])
]


data_2=[array([23.630342]),
array([27.676426]),
array([37.18177,37.169968]),
array([29.472683]),
array([25.39503,26.880298,25.95963,27.340257,26.019006,23.7644,23.971567,23.220972,23.852073,27.706545,23.361392,27.577806,23.949401]),
array([29.825676,34.352563,36.31858]),
array([24.857551,24.670996,24.40375,27.07292]),
array([34.692135,38.496716,35.194445,38.160064,35.569468,34.562051,34.058191,36.658738,28.922413]),
array([40.244667,29.987864]),
array([25.973967,24.431272,27.07627]),
array([26.081341,25.12345,27.445063,23.207533,25.774575,23.19188,24.761669,25.563716,27.400056,26.064466,23.802736,23.596972,25.153578,26.351392]),
array([29.651038,29.841235]),
array([36.553032]),
array([30.150751]),
array([36.571381]),
array([37.052707,33.959131]),
array([26.638441,26.485947]),
array([23.107357]),
array([26.938049]),
array([27.312296,24.912714,26.787363]),
array([24.270516,27.468908,23.3341]),
array([30.63085]),
array([31.255317,39.287764,37.926731,29.953725,31.041926]),
array([30.07086]),
array([40.016783,35.861706,28.640777]),
array([31.748336,34.18522,33.221234,30.578414,33.074106,35.565553,34.023179,33.47036,30.535352,30.870932,37.089601,33.241167,35.525194,33.764568,30.629441]),
array([28.017637]),
array([33.941001,28.673322]),
array([28.305167]),
array([29.27434,28.71051,23.937347]),
array([26.304483,24.112822,25.382743,24.463895,29.760146]),
array([27.0451]),
array([25.582458]),
array([24.435047,24.159959,23.207195,27.088382,23.173724,26.307388,24.43251]),
array([34.224538]),
array([24.091125,26.740991]),
array([25.646786]),
array([27.430698,25.20455]),
array([24.707352]),
array([25.630656]),
array([27.5383]),
array([28.961812]),
array([24.534396,26.598269,23.462187,24.168855,24.448118,23.820251,23.425006]),
array([24.237873,24.931826,25.406585]),
array([27.572262]),
array([26.68944]),
array([26.69546]),
array([23.272468]),
array([30.689434,28.970492,35.983893]),
array([23.92275]),
array([24.604525,23.827701,27.25495,25.375552,26.849754,27.312494,24.085417]),
array([23.688188,23.576255,26.925262,27.377422,24.051072,27.587674]),
array([24.448733]),
array([25.262426,26.665251]),
array([31.827953]),
array([31.700449,30.350302]),
array([29.471877]),
array([26.898188]),
array([30.453078,37.179673,34.045751,31.59007,32.645976]),
array([30.34146,27.148086]),
array([30.619447,30.654682]),
array([28.107282]),
array([26.090959])
]


data_3=[array([25.57501]),
array([26.473383]),
array([35.751216,35.900912]),
array([29.451551]),
array([27.174389,24.595064,26.700869,26.44191,25.531236,26.114886,25.47377,24.941156,23.842499,23.81498,25.488844,26.57043,24.519385]),
array([31.092221,36.981676,33.938009]),
array([26.696476,27.720642,27.153424,23.594678]),
array([36.871645,38.576305,36.819938,34.423284,40.77984,37.700621,36.197644,38.013745,27.862525]),
array([35.947487,30.790676]),
array([24.422908,23.662537,23.69144]),
array([24.717041,25.651448,24.708035,23.040922,24.970349,25.329515,24.334537,24.602416,25.065177,25.158001,25.714984,26.367532,24.792596,25.181852]),
array([29.804961,28.646235]),
array([36.315094]),
array([30.611829]),
array([34.489752]),
array([36.018103,35.007272]),
array([27.754679,25.581616]),
array([26.974814]),
array([23.871081]),
array([26.518826,24.449596,25.072573]),
array([27.638297,23.977005,26.434601]),
array([30.709527]),
array([30.645909,38.957783,34.701996,29.880715,30.419328]),
array([27.857418]),
array([37.100135,35.682712,28.045265]),
array([32.450619,36.863251,28.607768,28.837687,31.018511,36.706472,35.366589,29.559668,30.452038,33.432574,37.163385,31.38182,34.672992,31.495185,33.075684]),
array([29.396222]),
array([35.032839,30.827786]),
array([29.22489]),
array([30.800319,30.047477,23.883489]),
array([27.178541,27.262409,23.707346,25.582316,28.464802]),
array([24.248136]),
array([25.193262]),
array([24.841513,26.208071,23.602588,27.396513,24.476213,25.610742,23.099207]),
array([34.82238]),
array([24.625212,26.186384]),
array([23.030011]),
array([26.708292,26.848165]),
array([23.324374]),
array([24.756955]),
array([26.579756]),
array([33.046965]),
array([25.486389,24.084686,25.447444,26.546062,25.439797,26.719722,24.544395]),
array([26.100311,24.110074,27.470989]),
array([27.083977]),
array([26.506183]),
array([26.826182]),
array([24.644019]),
array([30.674189,28.874987,35.807934]),
array([26.004438]),
array([25.128552,25.176162,25.648167,24.225641,25.144947,27.031802,25.943104]),
array([23.421904,24.022196,23.059305,23.882625,24.322869,24.881014]),
array([25.354568]),
array([24.247007,27.751356]),
array([31.061384]),
array([30.229611,30.183318]),
array([33.685999]),
array([26.741624]),
array([33.4175,36.289185,36.62616,31.488451,29.233148]),
array([29.999023,26.788965]),
array([30.740961,30.754944]),
array([28.837033]),
array([23.93473])
]


data_4=[array([23.200371]),
array([25.026481]),
array([35.998351,34.359329]),
array([33.824632]),
array([24.31363,27.697407,24.208861,23.598521,27.669845,26.743888,23.863346,27.010418,26.142627,24.757659,26.479478,26.668685,25.386424]),
array([27.341332,36.713331,35.378967]),
array([27.306758,23.840524,24.348008,25.664131]),
array([35.17396,39.09618,35.236647,36.807131,35.344405,35.156143,35.211013,35.550346,29.927712]),
array([36.953186,29.595293]),
array([25.217505,27.249891,27.212079]),
array([27.532709,27.484339,23.037292,27.34881,27.457283,26.601897,27.42501,24.38154,24.544821,24.862538,25.560289,23.66449,25.052758,25.700064]),
array([29.455265,30.811055]),
array([36.899965]),
array([28.970267]),
array([36.669251]),
array([40.572471,36.566071]),
array([26.879209,23.452956]),
array([25.642311]),
array([25.161934]),
array([26.90601,26.56563,26.439056]),
array([27.515059,25.088553,25.011457]),
array([30.720886]),
array([30.857555,39.002499,36.532067,29.913947,28.7335]),
array([29.535674]),
array([33.971762,37.009974,30.928302]),
array([29.269952,34.453464,33.153474,29.665025,31.120931,34.327746,34.280591,33.218392,28.401589,32.007535,35.5191,31.472488,36.831971,28.96106,33.330421]),
array([28.935159]),
array([35.862863,30.29422]),
array([29.392313]),
array([28.869827,30.394474,23.863168]),
array([26.683288,24.615616,26.788835,25.449841,28.772155]),
array([23.169763]),
array([25.027373]),
array([23.360574,23.326412,25.767947,27.48606,25.43135,24.240812,23.370797]),
array([34.889362]),
array([24.770355,25.929999]),
array([24.348373]),
array([26.549792,27.09784]),
array([25.109865]),
array([27.117692]),
array([26.805534]),
array([30.983589]),
array([23.996016,24.212793,25.987348,26.181784,27.496176,24.69008,26.691693]),
array([25.569572,23.409445,25.736205]),
array([26.893573]),
array([23.208887]),
array([23.603263]),
array([23.389208]),
array([29.377214,28.284453,40.348379]),
array([25.898514]),
array([27.041365,23.679191,24.761097,26.397679,24.417831,27.309981,25.475662]),
array([24.978577,27.512194,24.723131,23.933567,26.321003,25.527312]),
array([23.139803]),
array([27.43622,26.411111]),
array([33.335478]),
array([30.562353,28.632508]),
array([30.047849]),
array([23.894152]),
array([31.834132,36.78978,34.976193,29.691783,28.529232]),
array([30.713841,26.82067]),
array([30.679309,30.728932]),
array([29.576166]),
array([26.989796])
]


data_5=[array([26.496726]),
array([27.309279]),
array([34.517763,35.186472]),
array([31.31707]),
array([25.678809,25.080599,27.752401,26.892201,23.565177,24.090567,24.609833,27.248873,24.514933,27.554343,27.500557,25.765554,23.910091]),
array([27.293053,34.234393,34.253478]),
array([27.574268,24.666202,23.560403,26.248823]),
array([34.870532,34.773809,35.917508,36.680587,40.938378,39.453791,33.98535,36.139194,29.538166]),
array([40.811491,30.611624]),
array([24.473679,23.131683,24.920726]),
array([27.183655,26.419092,23.271622,26.807306,24.029982,26.685041,23.943861,25.50753,27.402767,27.203805,27.617177,27.149575,25.33664,24.398746]),
array([28.795836,29.052662]),
array([35.270573]),
array([28.681169]),
array([34.877732]),
array([38.55323,36.524395]),
array([27.30687,24.600762]),
array([27.769766]),
array([25.793183]),
array([27.418434,23.582259,26.456382]),
array([26.753189,26.303423,24.650579]),
array([30.637949]),
array([28.557666,38.385061,40.715891,29.933429,29.738671]),
array([30.266426]),
array([37.231615,36.67464,28.55731]),
array([30.990661,36.630758,33.332815,28.416788,28.962342,36.719436,35.198055,30.267324,30.573358,31.677487,34.325094,30.105183,35.582756,33.059138,30.255222]),
array([28.301314]),
array([34.92815,30.305556]),
array([29.39719]),
array([30.962237,29.878151,24.495174]),
array([23.51831,27.140001,24.091042,24.852258,33.788814]),
array([27.158381]),
array([26.835473]),
array([23.259791,23.807913,27.611422,23.606476,27.015577,23.105787,24.565555]),
array([34.745921]),
array([25.735646,25.862433]),
array([23.265288]),
array([24.901435,23.184994]),
array([23.91146]),
array([23.449924]),
array([27.765663]),
array([33.282057]),
array([26.959766,24.335942,24.425263,24.392551,24.001566,24.292759,25.168521]),
array([27.818698,23.198137,25.688209]),
array([27.354787]),
array([24.39271]),
array([26.930478]),
array([23.634677]),
array([28.814447,30.967177,37.165935]),
array([27.102517]),
array([25.749786,23.158394,24.848231,26.497859,27.80709,25.640922,25.097155]),
array([23.743205,24.088639,24.201156,23.246389,26.218258,27.02884]),
array([26.039704]),
array([23.068258,24.794776]),
array([31.809555]),
array([31.856132,28.8802]),
array([29.950417]),
array([26.668686]),
array([30.689774,34.922601,34.998495,32.5073,32.08918]),
array([29.265649,27.506238]),
array([30.639587,30.657495]),
array([28.195846]),
array([25.268704])
]


data_6=[array([24.502395]),
array([25.900647]),
array([34.326024,36.926426]),
array([32.821131]),
array([23.84324,25.174692,25.766642,25.571465,26.23099,24.675787,25.096123,26.871759,24.230364,24.130916,25.633198,26.78258,25.290395]),
array([27.893742,34.207525,35.645514]),
array([27.197684,24.357447,27.537635,25.745034]),
array([37.160457,39.915021,35.467123,36.494563,34.805711,36.064973,34.061411,35.775328,28.660142]),
array([40.813073,29.415093]),
array([23.960687,23.269185,23.103869]),
array([25.177844,25.019758,25.99908,25.784128,23.842802,25.974449,24.104488,27.671429,25.178039,23.097434,24.357956,27.521929,26.47675,23.950121]),
array([28.921925,30.16233]),
array([34.351836]),
array([27.920922]),
array([35.214866]),
array([35.08418,35.552125]),
array([26.565948,26.024632]),
array([27.547835]),
array([26.740816]),
array([25.2006,23.940574,25.483741]),
array([23.312598,27.349408,23.179982]),
array([30.691031]),
array([29.616121,40.303126,35.922056,28.568344,29.370277]),
array([29.393408]),
array([35.889605,34.949943,29.427605]),
array([31.674681,35.159421,29.250192,30.653433,28.924782,37.016987,35.831965,30.968624,28.533591,33.642017,36.784622,28.831581,34.525163,30.097478,32.228583]),
array([29.128341]),
array([36.728378,29.060721]),
array([28.589422]),
array([29.182167,28.080568,27.633459]),
array([26.781063,23.165413,25.783511,24.192881,30.497543]),
array([26.12529]),
array([24.993966]),
array([26.736617,27.158505,23.363273,26.190136,23.462093,24.268491,27.485597]),
array([34.722633]),
array([25.040757,27.176292]),
array([25.6212]),
array([26.755974,26.645703]),
array([26.728111]),
array([23.574655]),
array([26.713706]),
array([29.438806]),
array([26.189218,25.311743,26.921159,27.202237,24.02328,25.69403,24.272909]),
array([27.688794,25.946426,26.673662]),
array([27.158462]),
array([25.660771]),
array([24.775874]),
array([25.555182]),
array([30.188126,28.963615,38.052505]),
array([23.785665]),
array([27.20934,23.720826,23.505392,26.127827,24.636359,27.590496,23.945867]),
array([23.145954,23.181817,26.348793,27.267557,23.550595,24.136344]),
array([24.84582]),
array([25.065653,25.08673]),
array([30.279953]),
array([32.429695,29.507006]),
array([30.147767]),
array([23.204202]),
array([30.674194,34.881053,35.061014,30.727241,30.826142]),
array([30.259441,27.484989]),
array([30.726454,30.765753]),
array([30.970234]),
array([23.102777])
]


data_7=[array([23.744607]),
array([23.881393]),
array([34.539498,35.826725]),
array([30.062717]),
array([25.758511,24.277289,26.952849,27.476688,26.039052,23.945071,27.762761,25.374632,24.124455,27.803372,25.420157,24.560608,24.759793]),
array([28.267534,35.599524,35.670061]),
array([27.050659,25.159249,27.49946,26.184897]),
array([34.663377,40.185965,37.042667,40.588345,36.071537,40.623512,36.17891,38.001332,29.877276]),
array([36.374725,29.638958]),
array([25.594716,27.091223,23.080912]),
array([24.746199,27.151379,25.405074,26.005492,25.768374,25.737831,23.773953,27.400503,25.132027,24.226245,26.569987,24.944907,27.550907,24.037273]),
array([30.995129,29.936895]),
array([34.336616]),
array([28.127922]),
array([37.021484]),
array([40.474828,37.050334]),
array([27.654589,24.726071]),
array([25.688528]),
array([27.499079]),
array([25.15552,27.687075,27.681215]),
array([26.266145,23.288124,26.547591]),
array([30.723835]),
array([29.369983,38.322635,37.64957,28.221907,28.15579]),
array([29.839113]),
array([39.375741,36.033359,30.461628]),
array([32.569617,36.381597,32.868301,28.031278,30.230002,36.772826,34.857062,29.948423,29.34255,29.979878,36.965314,33.24893,35.245871,32.571573,28.479468]),
array([29.482674]),
array([34.249614,28.280002]),
array([30.198191]),
array([29.47514,30.992102,24.194531]),
array([27.21145,23.164964,27.1772,25.234375,29.681416]),
array([25.772232]),
array([24.054109]),
array([25.207588,25.442082,25.626329,24.212913,27.673396,23.282166,23.768666]),
array([34.983108]),
array([25.313712,25.827377]),
array([27.618615]),
array([23.99373,23.416884]),
array([23.172839]),
array([24.999008]),
array([27.326298]),
array([30.453538]),
array([25.614618,24.005671,25.027667,26.637953,26.470614,23.0833,23.282303]),
array([23.088473,26.59569,24.465155]),
array([26.767838]),
array([26.995102]),
array([24.671057]),
array([26.447193]),
array([28.981808,29.471302,38.590519]),
array([24.523741]),
array([23.068896,23.907045,25.516168,27.710615,27.247865,27.657188,23.971306]),
array([27.374828,27.347762,26.337905,27.796163,27.159922,26.326089]),
array([23.206601]),
array([27.723228,23.494365]),
array([31.952053]),
array([33.635753,30.321991]),
array([33.169928]),
array([27.793131]),
array([29.113642,34.213411,36.070606,30.155849,29.943071]),
array([28.031292,26.667043]),
array([30.769937,30.702697]),
array([30.507523]),
array([23.389449])
]


data_8=[array([27.737707]),
array([23.037711]),
array([36.655031,36.856832]),
array([29.708401]),
array([26.468024,24.373507,23.040861,27.520936,23.43023,26.776708,24.091486,25.369194,27.712164,26.372214,26.157917,24.21663,24.018504]),
array([28.556747,34.791124,34.462504]),
array([26.060295,23.583995,24.940239,24.061525]),
array([34.800019,40.8075,35.258804,39.709196,40.089292,37.293726,34.466134,40.465492,29.622256]),
array([40.504471,28.612348]),
array([24.939077,26.851048,27.563826]),
array([23.820177,24.806763,24.881264,23.047806,27.439938,25.006551,25.947138,25.342265,26.602002,23.302833,23.031731,24.242328,25.914726,24.884625]),
array([28.217401,30.667592]),
array([35.363386]),
array([29.237709]),
array([35.364563]),
array([39.134465,36.325586]),
array([27.631764,24.918444]),
array([24.276969]),
array([24.111553]),
array([23.361897,23.507246,24.379391]),
array([23.636653,26.676268,24.326131]),
array([30.686109]),
array([32.621929,38.497689,39.195197,30.112451,29.135148]),
array([29.391613]),
array([34.02032,35.236747,30.285131]),
array([33.308168,36.639607,29.976623,29.088482,33.085818,36.910644,36.739362,32.389934,29.510934,30.309215,36.783724,30.19573,35.427833,30.135202,30.205014]),
array([30.218016]),
array([35.126805,30.951275]),
array([30.761476]),
array([29.941652,30.888737,25.78208]),
array([25.87267,23.234826,25.193947,23.974328,33.782171]),
array([26.934945]),
array([23.137369]),
array([25.273818,25.560364,27.777137,24.347553,23.119255,27.081823,23.645729]),
array([34.267959]),
array([23.985183,25.692483]),
array([27.589727]),
array([27.271965,23.978404]),
array([27.667143]),
array([23.172663]),
array([26.582848]),
array([28.50597]),
array([24.442537,25.172291,25.201082,24.934794,25.326236,26.815153,27.176011]),
array([27.776978,26.681687,24.481618]),
array([27.460911]),
array([26.606327]),
array([23.231629]),
array([25.282189]),
array([30.128424,30.934081,37.483767]),
array([23.209848]),
array([24.616437,26.476382,27.615613,27.144814,25.165109,27.556498,26.049251]),
array([27.719332,26.72372,24.935379,23.581253,24.107861,25.692159]),
array([25.361813]),
array([26.925415,26.355853]),
array([30.21513]),
array([30.582296,28.263085]),
array([32.392443]),
array([23.438492]),
array([30.488755,34.132127,34.909579,33.399554,32.174017]),
array([30.88816,26.990759]),
array([30.651851,30.700163]),
array([28.095457]),
array([27.391818])
]


data_9=[array([25.98171]),
array([24.127483]),
array([36.626871,36.316737]),
array([29.169007]),
array([24.22548,26.569154,26.087855,24.032732,23.035749,26.982518,23.830567,27.188569,27.145078,26.26334,27.097755,25.746564,26.387893]),
array([30.356082,34.370032,33.964484]),
array([24.732423,26.089443,24.062758,25.776161]),
array([36.527015,37.549196,36.748651,34.194176,35.150668,35.229693,36.984533,35.117962,28.480599]),
array([40.331686,28.113658]),
array([27.550134,25.19421,27.539463]),
array([26.66391,27.681889,24.963171,27.195882,25.272072,23.509147,24.360743,24.998802,24.322547,25.209316,23.240406,23.735578,26.855523,25.180056]),
array([30.143491,29.886067]),
array([34.265667]),
array([27.883973]),
array([34.726921]),
array([37.40184,37.059786]),
array([27.418905,24.208883]),
array([23.918066]),
array([25.199104]),
array([23.421167,27.548458,27.758443]),
array([24.070599,25.237961,24.138238]),
array([30.656601]),
array([30.215242,40.621253,40.517003,28.965978,27.892567]),
array([30.501078]),
array([38.332193,34.614035,28.731095]),
array([33.658662,35.628604,32.883798,29.357501,31.206984,36.212221,35.042698,30.126501,29.311751,30.70056,36.564861,30.420902,35.774848,31.328313,30.382493]),
array([28.866472]),
array([36.574109,29.758642]),
array([30.882483]),
array([30.935773,30.105198,26.324622]),
array([23.892852,24.504595,23.536491,23.430858,32.651351]),
array([27.417062]),
array([23.172116]),
array([23.456182,27.037279,23.382042,26.607197,25.612685,24.933795,23.910672]),
array([34.420213]),
array([24.385731,27.634868]),
array([27.197199]),
array([24.49853,24.438677]),
array([25.809867]),
array([23.272988]),
array([27.721758]),
array([29.536665]),
array([27.432197,27.792396,23.86891,25.527958,25.311924,25.601602,26.829206]),
array([23.460631,24.353265,23.897761]),
array([26.98063]),
array([25.957703]),
array([24.905717]),
array([26.378201]),
array([29.527402,30.103833,39.665472]),
array([25.86789]),
array([26.0125,25.062557,23.08699,24.060243,24.567985,23.814193,23.253659]),
array([23.48795,24.712086,23.537908,26.438423,27.738166,26.667573]),
array([23.318018]),
array([25.727504,26.172015]),
array([32.551103]),
array([31.546869,27.873321]),
array([29.566731]),
array([23.451952]),
array([29.79594,35.60815,35.477586,28.893781,31.983495]),
array([30.867514,27.6017]),
array([30.762395,30.712757]),
array([30.29251]),
array([26.42458])
]


data_10=[array([26.389545]),
array([25.547298]),
array([34.940952,37.085281]),
array([28.725938]),
array([23.35078,26.388464,25.719381,23.290622,24.54851,25.871511,25.704091,23.986947,24.740567,25.433367,26.400499,26.301973,25.816796]),
array([29.017337,34.356381,36.48571]),
array([26.963334,26.23439,26.885641,24.12281]),
array([34.856089,37.242745,37.000242,39.116911,35.429938,35.287547,34.601238,34.041083,30.669784]),
array([39.027911,29.002002]),
array([24.871365,26.641906,26.476311]),
array([25.270032,26.082877,26.920781,23.696916,24.615662,26.275927,26.745562,26.935626,26.797486,25.458697,26.108052,27.514767,26.69662,27.297778]),
array([29.836204,29.520105]),
array([34.861403]),
array([28.406555]),
array([36.579827]),
array([40.194246,34.009542]),
array([27.59675,23.339505]),
array([25.568495]),
array([27.027431]),
array([24.934744,23.428027,25.23177]),
array([26.795546,26.252859,25.499119]),
array([30.767533]),
array([31.8103,38.79399,39.083893,28.718512,30.081594]),
array([28.826014]),
array([37.262306,35.331957,29.937912]),
array([32.185315,35.245436,33.090867,28.569238,33.001248,34.7465,36.0683,31.560392,27.868444,29.312935,34.340089,31.989136,35.330752,31.935918,33.58589]),
array([29.880368]),
array([33.951434,29.1569]),
array([29.877079]),
array([29.333733,30.914108,23.631289]),
array([26.095503,24.970933,26.885297,25.619063,33.472985]),
array([24.708835]),
array([27.073286]),
array([23.289849,24.979348,24.812855,25.769404,25.073158,24.516341,24.883286]),
array([34.653998]),
array([24.850762,25.02167]),
array([24.275545]),
array([25.84807,24.240312]),
array([27.044664]),
array([26.314271]),
array([27.248139]),
array([29.078728]),
array([24.371319,27.693783,26.143997,25.977975,24.790921,26.207311,23.320045]),
array([26.718324,25.601059,26.496188]),
array([27.298446]),
array([25.25731]),
array([23.523365]),
array([24.261653]),
array([27.841403,28.134034,34.127228]),
array([25.809353]),
array([25.965904,24.990475,23.527026,27.112129,23.706856,24.851534,27.442348]),
array([26.636554,25.804468,23.269881,23.190917,27.643696,23.485316]),
array([25.567486]),
array([26.50248,25.491061]),
array([31.818654]),
array([30.404494,29.079797]),
array([29.876803]),
array([27.445464]),
array([30.28185,35.411667,37.169491,32.992371,30.552286]),
array([30.090883,27.773297]),
array([30.669292,30.667784]),
array([28.313871]),
array([23.6695])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Rodentia_EOT_gen_occ_SALMA_smoothed_1',  'Rodentia_EOT_gen_occ_SALMA_smoothed_2',  'Rodentia_EOT_gen_occ_SALMA_smoothed_3',  'Rodentia_EOT_gen_occ_SALMA_smoothed_4',  'Rodentia_EOT_gen_occ_SALMA_smoothed_5',  'Rodentia_EOT_gen_occ_SALMA_smoothed_6',  'Rodentia_EOT_gen_occ_SALMA_smoothed_7',  'Rodentia_EOT_gen_occ_SALMA_smoothed_8',  'Rodentia_EOT_gen_occ_SALMA_smoothed_9',  'Rodentia_EOT_gen_occ_SALMA_smoothed_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['?Sallamys','Acarechimys','aff._Tarapotomys','Andemys','Asteromys','Balsayacuy','Branisamys','Cachiyacuy','Canaanimys','Cephalomyopsis','Cephalomys','cf._Cachiyacuy','cf._Eoespina','cf._Pozomys','cf._Tarapotomys','Chachapoyamys','Chambiramys','Changquin','Cholamys','Chubutomys','Deseadomys','Draconomys','Eobranisamys','Eodelphomys','Eoespina','Eoincamys','Eopicure','Eopululo','Eosachacui','Eosallamys','Eoviscaccia','Ethelomys','Galileomys','Incamys','Kichkasteiromys','Lapazomys','Leucokephalos','Litodontomys','Llitun','Loncolicu','Loretomys','Mayomys','Migraveramus','Neoreomys','Palaeosteiromys','Paulacoutomys','Platypittamys','Plesiosteiromys','Pozomys','Protacaremys','Protosteiromys','Sallamys','Scleromys','Scotamys','Selvamys','Shapajamys','Steiromys','Tacheria','Tarapotomys','Ucayalimys','Vallehermosomys','Vucetichimys','Xylechimys']
def get_taxa_names(): return taxa_names