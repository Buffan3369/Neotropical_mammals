#!/usr/bin/env python
from numpy import * 


data_1=[array([24.5]),
array([27.424761]),
array([35.390342,37.102926]),
array([29.028335]),
array([25.537878,26,24.5,26,24.5,26,24.5,26,24.5,23.518591,27.178227,25.716065,27.162266]),
array([31.830226,36.579292,34.269819]),
array([26,24.5,26,24.5]),
array([37.14018,34.413672,37.258759,34.733538,34.61307,34.776281,37.108435,37.972824,29.950058]),
array([37.441653,28.216653]),
array([26.310554,27.310256,26.641805]),
array([26.081403,25.383373,26.221253,23.599354,26.980921,26.416542,23.463928,23.267731,27.763107,27.630845,27.00408,24.116047,23.806986,26.931224]),
array([29.34342,28.213689]),
array([34.417428]),
array([29.577978]),
array([37.146124]),
array([37.469821,36.510599]),
array([24.411317,26.962082]),
array([24.773434]),
array([26]),
array([24.37227,23.825507,26.101105]),
array([24.050338,23.887618,25.853982]),
array([30.735556]),
array([28.943956,37.562085,38.341835,28.19713,29.718642]),
array([31.020771]),
array([35.397726,36.548837,28.998664]),
array([28.978456,37.138959,29.331707,30.449334,30.756538,35.039158,35.221465,32.810984,30.966141,29.909258,36.404851,28.385384,36.333813,28.70155,31.392698]),
array([27.842522]),
array([36.729653,29.981911]),
array([29.990782]),
array([25.834407,28.105334,30.57302]),
array([25.054978,26.19638,26,26.10057,30.828168]),
array([26.719162]),
array([24.629805]),
array([25.566738,23.934782,25.8821,24.5,26,24.5,27.572085]),
array([34.106081]),
array([26,24.5]),
array([26.839043]),
array([26.228956,23.354517]),
array([25.401156]),
array([25.317099]),
array([26.745417]),
array([29.368103]),
array([26,24.5,26,24.5,26,24.5,27.686276]),
array([26.639398,26,24.5]),
array([23.203579]),
array([25.890082]),
array([23.290956]),
array([24.966831]),
array([28.88609,30.316606,35.008939]),
array([25.312047]),
array([23.965902,26.671035,24.782609,27.352321,24.434371,25.01376,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([25.17502]),
array([27.154658,26.505299]),
array([33.800257]),
array([33.278509,28.845005]),
array([28.12665]),
array([24.302303]),
array([32.312442,36.03983,34.57922,33.525205,28.116727]),
array([28.693085,26.965057]),
array([30.683988,30.674104]),
array([29.26085]),
array([27.711014])
]


data_2=[array([24.5]),
array([25.662274]),
array([34.331902,35.045017]),
array([32.345363]),
array([26.025757,26,24.5,26,24.5,26,24.5,26,24.5,26.091033,25.910779,24.326819,26.70244]),
array([31.21135,35.603126,35.373908]),
array([26,24.5,26,24.5]),
array([34.340331,39.677774,35.829817,33.966934,39.746612,34.569995,35.371861,34.552521,33.339364]),
array([38.962923,29.328221]),
array([23.533181,24.614756,26.850739]),
array([24.88081,26.14671,25.202051,26.080226,24.181392,26.363677,24.005873,25.065019,25.539389,23.491628,24.446786,25.603274,25.233021,23.83682]),
array([29.857133,30.022716]),
array([37.058042]),
array([29.712608]),
array([37.254133]),
array([39.939398,35.569308]),
array([23.290261,27.043925]),
array([26.535385]),
array([26]),
array([25.576853,23.263614,27.207402]),
array([24.350615,24.22438,24.616963]),
array([30.669291]),
array([33.242941,35.5127,35.033039,29.992149,30.640044]),
array([30.699497]),
array([35.812985,36.506771,29.428699]),
array([29.834244,37.329265,28.591669,30.590614,31.400101,35.287447,34.225294,30.579035,29.60798,29.514086,33.915861,28.255605,36.406207,29.909375,28.539979]),
array([28.045105]),
array([37.33169,28.982577]),
array([28.099062]),
array([27.153924,29.984892,30.946947]),
array([23.081995,23.936933,26,26.733547,32.378704]),
array([26.414681]),
array([23.049802]),
array([25.164883,26.934704,27.50809,24.5,26,24.5,26.499112]),
array([34.388102]),
array([26,24.5]),
array([26.789567]),
array([24.129388,25.74713]),
array([26.160383]),
array([25.091415]),
array([24.450898]),
array([33.099441]),
array([26,24.5,26,24.5,26,24.5,26.867958]),
array([26.131819,26,24.5]),
array([23.168422]),
array([24.120486]),
array([25.821694]),
array([23.163915]),
array([28.452701,28.38586,36.11752]),
array([26.923953]),
array([27.326088,24.093043,26.421618,26.598878,25.461271,25.943381,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.899216]),
array([23.540908,23.078597]),
array([29.936245]),
array([31.103232,29.047864]),
array([31.568328]),
array([23.886702]),
array([29.908488,36.682835,34.848289,32.730558,30.130356]),
array([30.769864,26.870756]),
array([30.652879,30.748738]),
array([30.323021]),
array([25.774405])
]


data_3=[array([24.5]),
array([25.682554]),
array([37.109768,34.495629]),
array([31.083292]),
array([24.666112,26,24.5,26,24.5,26,24.5,26,24.5,26.192939,24.344413,25.116921,23.296854]),
array([33.744124,37.59794,37.107421]),
array([26,24.5,26,24.5]),
array([36.633361,35.138481,34.173947,40.829515,39.866737,40.068158,34.685019,34.000209,30.199705]),
array([38.77205,30.990718]),
array([23.993562,25.034309,26.124097]),
array([26.005413,26.33425,27.638648,24.316859,23.196954,25.541888,25.917472,27.013309,24.930025,24.616463,25.918747,25.997313,23.582398,26.113663]),
array([31.070476,30.866813]),
array([35.783398]),
array([27.911634]),
array([34.014696]),
array([37.625808,34.437655]),
array([23.115931,23.770937]),
array([26.453602]),
array([26]),
array([24.093014,26.732851,24.793449]),
array([23.99248,26.372896,27.746176]),
array([30.669633]),
array([29.422059,34.490616,35.1047,29.731337,29.463011]),
array([29.68085]),
array([35.376099,34.497638,30.798344]),
array([29.612705,36.835615,31.205553,28.429059,29.586771,34.197127,36.355785,33.789078,28.160807,30.025665,37.603349,33.542796,35.286284,32.58316,31.347091]),
array([30.358705]),
array([36.977761,28.058077]),
array([30.222071]),
array([25.328363,29.004344,29.239416]),
array([24.468878,24.735221,26,25.51525,31.752104]),
array([25.689536]),
array([25.84479]),
array([25.363431,26.705319,25.551361,24.5,26,24.5,25.423487]),
array([34.272922]),
array([26,24.5]),
array([23.96626]),
array([26.991829,24.017803]),
array([27.747946]),
array([26.650149]),
array([25.909186]),
array([30.149444]),
array([26,24.5,26,24.5,26,24.5,23.485605]),
array([23.235436,26,24.5]),
array([27.263088]),
array([24.069158]),
array([23.466399]),
array([23.459515]),
array([28.290683,30.949472,38.014274]),
array([25.862632]),
array([23.051946,23.578436,24.919107,26.73697,24.278149,24.32426,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.354429]),
array([23.768917,23.234922]),
array([28.658842]),
array([33.224512,28.795749]),
array([30.012478]),
array([23.745021]),
array([29.750165,34.778463,37.704302,28.305352,32.68426]),
array([28.885256,25.645698]),
array([30.718693,30.721751]),
array([28.24407]),
array([25.005722])
]


data_4=[array([24.5]),
array([24.391176]),
array([36.569169,35.887022]),
array([31.161322]),
array([27.351495,26,24.5,26,24.5,26,24.5,26,24.5,24.257046,23.907028,25.909172,27.816759]),
array([32.351366,36.85522,37.682441]),
array([26,24.5,26,24.5]),
array([36.622884,41.098277,35.679829,38.914616,36.971916,39.752754,34.888227,34.460047,29.01595]),
array([38.069167,31.0841]),
array([26.522656,23.130022,23.219423]),
array([25.087699,26.325727,25.660075,27.628934,23.338067,25.091162,23.152425,27.688387,23.738886,27.523502,25.022731,23.125995,24.218648,23.794709]),
array([30.073669,30.397751]),
array([36.696262]),
array([28.074949]),
array([34.922155]),
array([35.49342,34.315259]),
array([25.437682,24.957075]),
array([25.142096]),
array([26]),
array([26.576415,26.394119,24.20324]),
array([25.36051,26.742155,23.117894]),
array([30.765059]),
array([30.22817,35.895847,38.721154,30.843021,29.039161]),
array([28.16293]),
array([40.917681,35.104598,31.072992]),
array([28.330268,34.383661,33.265843,28.509359,29.134583,36.515645,34.900287,32.876412,28.120796,33.418248,34.032269,28.552497,34.328361,27.947673,31.727639]),
array([30.605409]),
array([36.036243,28.955648]),
array([28.218285]),
array([24.987027,29.954654,28.957909]),
array([25.481096,25.986125,26,25.146073,31.477093]),
array([27.420393]),
array([25.96318]),
array([25.116947,25.401392,23.727219,24.5,26,24.5,23.12339]),
array([34.828873]),
array([26,24.5]),
array([23.567288]),
array([25.98465,23.249366]),
array([27.447059]),
array([24.903546]),
array([23.476955]),
array([29.80437]),
array([26,24.5,26,24.5,26,24.5,24.313983]),
array([26.542069,26,24.5]),
array([26.063139]),
array([23.77856]),
array([26.435736]),
array([26.765177]),
array([28.610109,30.477761,40.907686]),
array([23.55462]),
array([24.714148,27.504853,27.671504,26.87716,25.897773,24.869109,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.085832]),
array([24.78003,24.469356]),
array([33.642942]),
array([32.411621,29.070607]),
array([30.540893]),
array([25.30887]),
array([29.552711,36.961704,35.605446,30.513646,30.494744]),
array([30.957133,26.939911]),
array([30.754839,30.638466]),
array([28.437323]),
array([25.821283])
]


data_5=[array([24.5]),
array([23.31835]),
array([35.818668,33.962433]),
array([33.655742]),
array([24.930589,26,24.5,26,24.5,26,24.5,26,24.5,24.006294,27.463695,27.463688,24.211028]),
array([28.17716,37.58242,34.650468]),
array([26,24.5,26,24.5]),
array([36.942986,38.174084,36.679957,35.486107,35.871505,34.337594,35.510119,36.4789,32.35424]),
array([37.338614,28.505278]),
array([27.310744,24.21982,27.427467]),
array([25.689618,24.648292,27.702414,26.024236,24.253379,23.896541,27.440759,27.628248,25.842485,23.886263,26.460032,27.02934,27.766383,26.472008]),
array([28.88616,28.536954]),
array([34.052775]),
array([28.288053]),
array([37.419277]),
array([39.545434,35.219619]),
array([24.670978,24.17932]),
array([27.610657]),
array([26]),
array([26.429481,25.377559,24.371064]),
array([24.215425,26.418247,26.522587]),
array([30.743743]),
array([29.397433,36.142333,35.888668,28.055505,30.043444]),
array([30.925806]),
array([41.193336,34.602333,29.258959]),
array([31.325768,35.36882,31.555911,28.695948,27.877195,35.755178,36.509967,32.186309,30.709357,31.864473,37.460984,32.373775,36.951363,33.317353,29.924941]),
array([27.982188]),
array([34.327235,29.877858]),
array([29.129384]),
array([27.640387,28.879676,31.050387]),
array([27.069227,24.714783,26,23.663729,30.470052]),
array([24.70265]),
array([27.150965]),
array([25.550168,25.07341,25.71457,24.5,26,24.5,25.45187]),
array([34.597794]),
array([26,24.5]),
array([25.389561]),
array([24.194963,27.405428]),
array([23.687087]),
array([26.632366]),
array([27.345378]),
array([31.777618]),
array([26,24.5,26,24.5,26,24.5,23.458666]),
array([24.06659,26,24.5]),
array([25.336213]),
array([23.916949]),
array([26.251452]),
array([24.715143]),
array([28.939534,29.739558,35.9653]),
array([24.088193]),
array([23.880019,23.216825,27.738038,25.019907,27.519237,23.639275,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([26.879497]),
array([26.323544,24.853363]),
array([30.666386]),
array([28.3521,28.420207]),
array([33.190643]),
array([26.50947]),
array([27.970348,36.752374,35.294278,33.680447,29.337682]),
array([29.065566,26.629624]),
array([30.725297,30.739079]),
array([29.204768]),
array([24.081549])
]


data_6=[array([24.5]),
array([24.315926]),
array([34.164035,35.977978]),
array([30.957736]),
array([24.394504,26,24.5,26,24.5,26,24.5,26,24.5,26.338085,24.053679,26.576189,26.024371]),
array([31.620339,37.48923,34.752878]),
array([26,24.5,26,24.5]),
array([35.569568,34.776623,34.870541,34.383689,38.849893,38.936587,36.859203,36.087557,29.65551]),
array([39.465574,27.961244]),
array([24.01333,23.953294,27.463057]),
array([25.349826,24.883172,24.671573,27.169691,24.816105,26.085425,27.262928,24.244409,24.833077,23.035048,26.152184,27.718002,25.982896,24.754711]),
array([28.356952,28.073206]),
array([36.310492]),
array([30.371267]),
array([34.089127]),
array([34.804669,36.765368]),
array([27.107679,25.573027]),
array([24.370545]),
array([26]),
array([26.739658,26.769502,24.119719]),
array([24.512987,23.200417,26.472914]),
array([30.738919]),
array([30.494034,37.06966,39.683605,29.635146,29.789107]),
array([30.945001]),
array([34.217582,36.611817,29.771547]),
array([31.641815,34.489113,29.451155,28.257004,31.576151,35.299246,34.083768,29.886012,29.596223,27.998365,34.511839,30.989822,37.117559,29.934083,33.079903]),
array([28.64463]),
array([35.130823,29.574615]),
array([30.77112]),
array([24.304946,28.257905,30.354026]),
array([25.32938,26.857946,26,23.951682,30.469167]),
array([24.400814]),
array([27.761982]),
array([27.429583,25.498471,26.860587,24.5,26,24.5,26.63008]),
array([34.312031]),
array([26,24.5]),
array([27.497398]),
array([24.38691,25.298839]),
array([27.474951]),
array([27.511855]),
array([23.36188]),
array([28.307087]),
array([26,24.5,26,24.5,26,24.5,23.40636]),
array([27.284087,26,24.5]),
array([26.781789]),
array([25.287204]),
array([25.90345]),
array([24.088903]),
array([28.306601,28.065447,39.334034]),
array([25.626133]),
array([26.547984,24.713073,24.343272,25.1333,25.177646,24.163512,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.227597]),
array([26.21073,27.193961]),
array([29.717856]),
array([29.564044,30.180167]),
array([31.209605]),
array([24.053333]),
array([30.013687,34.197678,37.073638,33.379968,32.674639]),
array([29.409243,27.095513]),
array([30.702233,30.710224]),
array([29.66756]),
array([24.962327])
]


data_7=[array([24.5]),
array([23.788392]),
array([37.04721,36.261156]),
array([33.100476]),
array([27.673808,26,24.5,26,24.5,26,24.5,26,24.5,23.606096,25.573148,27.001,26.206466]),
array([28.8913,34.204906,34.197641]),
array([26,24.5,26,24.5]),
array([36.667434,35.6136,37.556087,39.225066,37.993775,34.836904,35.077238,34.222097,28.22737]),
array([37.267445,28.157587]),
array([27.416306,26.309653,23.19207]),
array([25.987788,27.744845,26.20981,25.409937,23.212352,26.790519,26.680449,25.263654,23.271314,24.005286,24.507025,25.683301,25.942498,23.128763]),
array([31.073034,29.263562]),
array([34.537156]),
array([28.615394]),
array([36.666643]),
array([39.581796,33.957332]),
array([27.29635,27.353901]),
array([23.08615]),
array([26]),
array([26.774726,24.763242,23.666205]),
array([24.617168,24.771411,27.007059]),
array([30.729702]),
array([29.831063,34.362083,37.455001,28.743266,30.131434]),
array([30.074624]),
array([34.007567,35.993862,28.281461]),
array([29.197422,36.944437,31.032806,28.763382,29.812799,35.242896,36.579128,30.671683,30.477179,29.470614,37.67164,31.308004,37.048025,28.930675,28.446052]),
array([29.467661]),
array([34.431491,28.880464]),
array([30.239448]),
array([24.267684,28.646094,28.839846]),
array([23.419839,23.243535,26,27.772834,32.455043]),
array([26.098492]),
array([27.281832]),
array([25.590322,27.73149,25.897237,24.5,26,24.5,26.605073]),
array([34.822483]),
array([26,24.5]),
array([25.621829]),
array([25.984442,24.725608]),
array([23.510767]),
array([25.24145]),
array([26.056257]),
array([33.272003]),
array([26,24.5,26,24.5,26,24.5,26.985999]),
array([25.467706,26,24.5]),
array([27.567743]),
array([26.982427]),
array([23.289786]),
array([27.346276]),
array([29.839695,28.56968,40.922436]),
array([27.571942]),
array([23.326176,25.728204,25.443213,24.699766,24.431561,26.798711,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.987532]),
array([27.20034,23.112024]),
array([32.52752]),
array([32.71662,28.571688]),
array([28.019899]),
array([23.995208]),
array([30.730814,34.559964,34.267873,30.799072,29.172785]),
array([29.135569,23.98258]),
array([30.720542,30.640982]),
array([30.895234]),
array([27.326609])
]


data_8=[array([24.5]),
array([26.96135]),
array([34.742141,36.688681]),
array([31.208875]),
array([27.621025,26,24.5,26,24.5,26,24.5,26,24.5,24.662706,26.275259,25.055934,24.739309]),
array([31.956462,35.578411,35.812929]),
array([26,24.5,26,24.5]),
array([35.564066,37.324239,35.482981,36.60652,40.682912,36.924018,34.751277,38.047844,30.19043]),
array([36.583594,30.692643]),
array([26.273323,25.741244,25.743401]),
array([23.421709,26.476495,24.901906,24.070652,23.682611,26.303212,27.093602,23.67342,25.75602,26.565414,25.983333,25.254983,25.397002,23.874084]),
array([28.504931,29.554046]),
array([36.433556]),
array([30.607815]),
array([37.589396]),
array([39.591187,35.537779]),
array([25.270389,23.281478]),
array([27.607979]),
array([26]),
array([24.250682,26.356816,27.033328]),
array([25.474446,26.006586,24.290572]),
array([30.635447]),
array([32.130777,34.533199,38.660655,29.239928,28.678986]),
array([30.54607]),
array([36.842497,35.753681,29.185969]),
array([31.650301,35.887029,29.075,31.093906,32.006078,36.948777,37.444698,31.402031,30.610838,28.43268,34.471913,29.716676,34.129559,33.444946,33.084679]),
array([28.18768]),
array([35.198672,31.005326]),
array([28.95898]),
array([25.588962,28.820878,30.327163]),
array([23.705864,27.726874,26,27.079501,33.868388]),
array([25.48008]),
array([25.134116]),
array([23.158424,24.461792,24.982408,24.5,26,24.5,27.743964]),
array([34.859559]),
array([26,24.5]),
array([27.772153]),
array([26.482856,25.426477]),
array([26.252127]),
array([24.881838]),
array([27.683677]),
array([29.679031]),
array([26,24.5,26,24.5,26,24.5,24.10984]),
array([27.356608,26,24.5]),
array([27.358666]),
array([27.249251]),
array([26.362672]),
array([24.30819]),
array([28.220936,28.052717,40.978609]),
array([24.718015]),
array([27.721889,24.091844,27.107052,26.520051,24.14244,25.501329,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.985104]),
array([27.564801,25.622995]),
array([31.212697]),
array([32.757161,30.689384]),
array([28.906025]),
array([24.018027]),
array([27.936183,36.865084,36.491974,30.401806,32.425431]),
array([28.869677,24.101449]),
array([30.749927,30.629756]),
array([28.003735]),
array([27.758042])
]


data_9=[array([24.5]),
array([25.963685]),
array([36.513098,34.242078]),
array([33.81136]),
array([25.131075,26,24.5,26,24.5,26,24.5,26,24.5,26.55174,23.936114,24.385025,23.973617]),
array([33.693217,34.505794,34.551918]),
array([26,24.5,26,24.5]),
array([36.239381,35.059697,36.336466,35.63604,34.47169,40.315868,37.173827,34.590114,32.646295]),
array([34.787827,27.995478]),
array([24.509042,25.914848,26.813848]),
array([25.831721,26.853905,27.600538,26.402244,25.34536,24.673242,24.32323,23.47278,25.938537,24.217502,27.348226,25.990317,24.104575,24.614075]),
array([28.296376,30.417919]),
array([34.651953]),
array([30.862924]),
array([36.021079]),
array([36.834476,35.294847]),
array([23.692021,26.893611]),
array([27.570979]),
array([26]),
array([27.080978,25.366033,23.758288]),
array([24.496962,27.626133,25.970429]),
array([30.715086]),
array([33.594722,35.841586,39.001916,29.453339,28.04228]),
array([30.623157]),
array([37.369164,35.235828,30.822502]),
array([29.56458,34.808739,31.132108,28.210805,29.881321,36.390834,36.10701,30.66117,29.330873,29.4127,34.138782,30.232486,36.303533,29.450334,33.834538]),
array([30.999925]),
array([36.525017,28.535356]),
array([27.887785]),
array([23.767806,29.737412,28.789001]),
array([25.565588,26.347747,26,27.399763,29.223457]),
array([26.612151]),
array([23.095641]),
array([26.506278,27.428632,23.940559,24.5,26,24.5,23.430224]),
array([34.838766]),
array([26,24.5]),
array([24.037632]),
array([24.73405,27.288399]),
array([23.041986]),
array([27.565563]),
array([23.717381]),
array([32.656044]),
array([26,24.5,26,24.5,26,24.5,26.020297]),
array([25.796015,26,24.5]),
array([24.484688]),
array([23.471616]),
array([25.809923]),
array([23.15796]),
array([29.993943,29.071175,40.930462]),
array([26.444863]),
array([27.751323,27.677304,26.290469,23.060735,26.833222,26.259696,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([23.210137]),
array([27.653903,23.462347]),
array([29.344107]),
array([28.050823,30.10705]),
array([32.412354]),
array([23.681705]),
array([30.884415,35.202893,36.567449,29.751519,30.260302]),
array([29.605661,25.514482]),
array([30.677872,30.732339]),
array([30.18652]),
array([27.596531])
]


data_10=[array([24.5]),
array([23.839307]),
array([35.367462,37.687294]),
array([32.771755]),
array([26.910354,26,24.5,26,24.5,26,24.5,26,24.5,27.511386,24.588299,26.650597,27.199664]),
array([29.887276,37.160004,35.777467]),
array([26,24.5,26,24.5]),
array([36.230976,37.469059,35.627799,39.084394,38.303777,34.145315,35.578086,34.93247,28.222724]),
array([34.249662,30.404134]),
array([27.739232,26.932875,27.323447]),
array([27.317546,24.444872,23.532566,23.921756,25.136543,27.135998,23.930122,27.525356,23.302512,24.195318,25.325411,25.919041,24.18575,26.001241]),
array([28.685203,28.76582]),
array([35.629949]),
array([29.663861]),
array([34.652533]),
array([40.825287,37.015583]),
array([23.799106,23.979202]),
array([25.36584]),
array([26]),
array([26.677614,23.61633,26.400703]),
array([25.512718,24.252074,23.17994]),
array([30.643716]),
array([31.63893,34.694221,37.912146,29.466598,28.636841]),
array([30.70368]),
array([37.330007,35.836418,30.094501]),
array([33.624732,35.346047,31.044591,28.722231,30.404781,34.566137,35.127971,31.511565,30.040414,32.042279,35.298053,31.221916,34.416704,29.652634,29.92346]),
array([29.699514]),
array([36.178974,30.195128]),
array([30.166398]),
array([27.395823,29.330169,29.039121]),
array([23.049278,27.675946,26,26.487907,30.096141]),
array([25.837747]),
array([25.420624]),
array([23.978594,24.742873,23.600077,24.5,26,24.5,23.722182]),
array([34.096289]),
array([26,24.5]),
array([26.344103]),
array([27.136212,25.464153]),
array([24.294365]),
array([24.153861]),
array([27.185175]),
array([32.576771]),
array([26,24.5,26,24.5,26,24.5,27.434691]),
array([24.855583,26,24.5]),
array([27.338368]),
array([24.633067]),
array([24.982196]),
array([27.37955]),
array([31.090813,28.911758,40.613389]),
array([24.582001]),
array([25.276814,26.567673,24.600442,25.478528,24.186324,26.832566,24.5]),
array([26,24.5,26,24.5,26,24.5]),
array([24.491823]),
array([24.353995,23.520747]),
array([30.118917]),
array([30.932964,31.096778]),
array([30.772898]),
array([27.635278]),
array([33.502728,34.717665,36.893916,32.772876,30.545861]),
array([28.58316,24.523687]),
array([30.698205,30.72398]),
array([28.280761]),
array([24.168803])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Rodentia_EOT_1',  'Rodentia_EOT_2',  'Rodentia_EOT_3',  'Rodentia_EOT_4',  'Rodentia_EOT_5',  'Rodentia_EOT_6',  'Rodentia_EOT_7',  'Rodentia_EOT_8',  'Rodentia_EOT_9',  'Rodentia_EOT_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['?Sallamys','Acarechimys','aff._Tarapotomys','Andemys','Asteromys','Balsayacuy','Branisamys','Cachiyacuy','Canaanimys','Cephalomyopsis','Cephalomys','cf._Cachiyacuy','cf._Eoespina','cf._Pozomys','cf._Tarapotomys','Chachapoyamys','Chambiramys','Changquin','Cholamys','Chubutomys','Deseadomys','Draconomys','Eobranisamys','Eodelphomys','Eoespina','Eoincamys','Eopicure','Eopululo','Eosachacui','Eosallamys','Eoviscaccia','Ethelomys','Galileomys','Incamys','Kichkasteiromys','Lapazomys','Leucokephalos','Litodontomys','Llitun','Loncolicu','Loretomys','Mayomys','Migraveramus','Neoreomys','Palaeosteiromys','Paulacoutomys','Platypittamys','Plesiosteiromys','Pozomys','Protacaremys','Protosteiromys','Sallamys','Scleromys','Scotamys','Selvamys','Shapajamys','Steiromys','Tacheria','Tarapotomys','Ucayalimys','Vallehermosomys','Vucetichimys','Xylechimys']
def get_taxa_names(): return taxa_names