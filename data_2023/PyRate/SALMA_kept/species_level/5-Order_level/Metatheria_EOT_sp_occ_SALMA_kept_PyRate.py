#!/usr/bin/env python
from numpy import * 


data_1=[array([25.724307,25.210027,26.31247]),
array([25.338841]),
array([26.480956]),
array([46.555858,53.165282,38.845682]),
array([42.811611,52.586455]),
array([48.629779]),
array([40.558995,48.885132,40.419567,49.591295,48.233471,38.468485,48.09495]),
array([27.197462]),
array([40.992877]),
array([25.412265]),
array([25.094365]),
array([35.663861]),
array([38.851198,52.532201]),
array([40.261079,40.188336,41.098264,40.33931,41.170344,40.230499,39.482839]),
array([40.283571]),
array([29.357114,24.6395,24.651643,25.539294,29.031716]),
array([54.103135]),
array([47.086569]),
array([51.77205]),
array([35.086307]),
array([49.673304,47.427514]),
array([24.253754,25.83696]),
array([37.708347]),
array([34.708454]),
array([44.49424]),
array([32.015983]),
array([48.559792]),
array([52.940884]),
array([29.045066,33.637789]),
array([49.100346]),
array([55.066001,50.232985]),
array([40.482322,38.938145,40.223537,40.915178,48.616487,48.294165,38.115335,38.524746,49.457597]),
array([31.926418]),
array([24.404145,24.965339]),
array([27.75967]),
array([49.607787,52.878809]),
array([52.685725]),
array([41.362786,43.343072,54.688369,52.461191]),
array([32.088002]),
array([35.129311]),
array([32.537514,32.232155]),
array([32.703448,31.360485]),
array([28.729533]),
array([33.087831]),
array([48.454218]),
array([28.801979]),
array([31.71109,38.028083,38.181873,38.070534]),
array([33.526579]),
array([33.529782]),
array([53.587586]),
array([52.5522,52.726474]),
array([41.519391,37.86409]),
array([51.785893]),
array([43.119959]),
array([39.572386]),
array([27.256116,27.847093,27.854504,25.485737,28.56932,25.132778,27.804631]),
array([28.045389,26.497249,27.67161]),
array([29.547061]),
array([28.246109]),
array([24.864435]),
array([28.101535,29.309546]),
array([43.297005]),
array([36.811574]),
array([39.622422,39.876027]),
array([45.225269,43.262071,52.435599,52.43377]),
array([40.971141,41.590028,46.890318,33.996971]),
array([36.361277]),
array([31.175783]),
array([24.780668]),
array([26.889767,26.029796,25.13063,24.732683,24.632336,25.269175]),
array([27.358036]),
array([33.575614]),
array([30.744649]),
array([27.775108,25.670598]),
array([36.14535,36.193705,36.354106]),
array([50.791032]),
array([39.909581]),
array([46.781744,38.486572,55.289728]),
array([50.216619]),
array([48.914164,45.079288,24.792752]),
array([52.04066,49.830088]),
array([38.454536]),
array([39.939087,40.138811,42.35755,46.029163,48.575582,48.809368,39.196618,49.696461]),
array([38.126411,38.198204,38.110912,47.073727,48.897056,39.450171,48.0461,48.680994,38.003681,39.708204,41.679462,42.742317,38.300588,38.750886,49.918543,48.893079,38.784867,40.124053]),
array([45.28242,54.486301]),
array([49.415502]),
array([45.565223]),
array([29.956869,35.211794,35.680986,35.803051]),
array([27.949127,24.205165,25.829059]),
array([26.91255]),
array([29.280962,25.936408,27.844455,29.239481,26.08008]),
array([40.453147]),
array([38.113375]),
array([40.071895]),
array([49.755296]),
array([39.507926]),
array([36.207752,35.537893,41.577879]),
array([52.853874]),
array([26.368035,28.733862,28.192766]),
array([41.698044]),
array([35.310122]),
array([29.221466]),
array([46.234955,44.436045,42.03011,44.110376,46.873307]),
array([35.259415]),
array([53.052732])
]


data_2=[array([24.342037,23.438829,25.086833]),
array([25.384477]),
array([26.233044]),
array([42.615499,49.88606,38.713734]),
array([45.855579,52.606157]),
array([53.190034]),
array([40.863426,49.259642,39.075106,49.832589,49.36827,39.345094,48.134903]),
array([27.237749]),
array([40.928366]),
array([24.966242]),
array([25.599453]),
array([38.417369]),
array([38.521566,51.112388]),
array([41.163048,37.828833,38.126359,39.447898,40.129612,40.382014,40.791865]),
array([41.598743]),
array([25.45107,24.973467,29.169258,24.484129,28.827328]),
array([47.93784]),
array([47.069051]),
array([55.019404]),
array([37.044507]),
array([46.6008,51.129758]),
array([25.324954,26.295869]),
array([37.904937]),
array([34.849188]),
array([46.852636]),
array([32.087521]),
array([50.95098]),
array([50.529771]),
array([29.0165,33.661878]),
array([52.326261]),
array([53.793193,51.599685]),
array([39.468902,39.746309,40.511604,38.021965,49.592804,48.478223,38.23004,39.294402,49.276601]),
array([30.886583]),
array([24.524153,25.252596]),
array([29.096607]),
array([55.686242,48.713421]),
array([51.027457]),
array([47.091647,46.120626,48.854079,50.671333]),
array([36.02457]),
array([36.695622]),
array([29.838504,31.339854]),
array([31.681783,31.513716]),
array([31.340164]),
array([31.376792]),
array([49.004911]),
array([29.864502]),
array([32.580136,38.02559,38.021657,38.052546]),
array([33.068903]),
array([32.327869]),
array([55.041125]),
array([52.429054,52.232503]),
array([40.051215,37.944105]),
array([51.068083]),
array([44.560269]),
array([39.444761]),
array([26.938618,25.267392,24.350074,28.536712,27.415855,28.574904,28.04303]),
array([25.088148,26.573053,25.350327]),
array([28.855269]),
array([29.790803]),
array([24.462158]),
array([28.597005,28.975115]),
array([46.649047]),
array([37.491735]),
array([40.238087,41.110742]),
array([42.909746,42.75041,52.693913,52.707648]),
array([41.345162,39.045797,44.987907,34.41491]),
array([33.908421]),
array([34.016574]),
array([24.91518]),
array([24.772729,27.039938,26.781601,24.200982,29.279456,24.615846]),
array([29.044144]),
array([33.594977]),
array([30.620109]),
array([28.391113,27.998318]),
array([34.425092,35.369614,37.431656]),
array([50.369044]),
array([41.154014]),
array([44.05536,51.614314,47.998751]),
array([50.317328]),
array([53.367632,45.090964,27.340402]),
array([54.288337,49.783128]),
array([39.403051]),
array([39.037272,38.623453,43.649252,44.103675,48.743017,48.679186,40.803138,49.571218]),
array([40.012805,38.580295,40.515193,42.189424,48.88097,40.194057,49.153757,49.865746,38.183711,39.372688,44.317818,45.294001,40.962449,40.937823,48.514966,49.273318,39.048899,37.882012]),
array([44.207032,54.224244]),
array([51.670815]),
array([45.987043]),
array([29.901628,36.419213,36.306433,35.535073]),
array([28.767241,28.02552,25.767474]),
array([26.880258]),
array([27.910881,26.078119,28.086103,25.108695,25.255344]),
array([38.464032]),
array([38.142044]),
array([38.232242]),
array([49.657108]),
array([39.114371]),
array([34.196492,34.008597,44.227572]),
array([52.340705]),
array([24.643655,24.532602,25.177362]),
array([47.66974]),
array([37.4701]),
array([32.345675]),
array([43.326051,38.412642,38.022713,41.089082,39.442031]),
array([28.968505]),
array([52.346385])
]


data_3=[array([24.404041,27.781009,25.018343]),
array([25.969942]),
array([27.401882]),
array([42.830777,52.514087,38.318313]),
array([43.027628,48.453148]),
array([52.583135]),
array([39.597496,49.173259,39.377593,49.399264,48.019127,40.629692,48.767833]),
array([25.369267]),
array([40.107777]),
array([24.782201]),
array([25.074706]),
array([38.198237]),
array([39.8751,48.662916]),
array([41.164708,41.084215,39.969231,40.04636,41.011217,39.286887,41.353422]),
array([40.468043]),
array([29.170017,27.266089,29.203076,27.578595,26.303062]),
array([48.2556]),
array([47.799994]),
array([53.728412]),
array([35.625737]),
array([52.427091,51.93637]),
array([24.496412,28.274922]),
array([37.537571]),
array([34.657943]),
array([44.81984]),
array([32.689892]),
array([51.080865]),
array([50.258844]),
array([29.193804,33.35759]),
array([50.893767]),
array([52.465824,49.500815]),
array([39.481518,40.163946,38.679875,39.322363,48.372832,48.175903,38.073208,40.768729,49.844125]),
array([31.093426]),
array([26.556809,25.758955]),
array([28.646757]),
array([55.074724,53.264599]),
array([50.292585]),
array([42.477144,41.60454,53.364923,48.4785]),
array([28.624146]),
array([31.432307]),
array([28.747783,29.666531]),
array([33.127681,33.003812]),
array([31.190839]),
array([32.256286]),
array([49.462482]),
array([30.226203]),
array([32.546117,38.108025,38.073043,38.195735]),
array([30.699813]),
array([33.248694]),
array([50.729983]),
array([52.023733,52.923257]),
array([39.207858,39.984601]),
array([54.11514]),
array([46.477148]),
array([41.078942]),
array([27.36577,24.2211,27.30613,25.097205,28.79446,28.465141,28.191272]),
array([28.010886,24.39638,28.021954]),
array([32.055345]),
array([33.570876]),
array([25.38823]),
array([24.531886,27.762358]),
array([41.813628]),
array([34.753228]),
array([41.213366,38.602617]),
array([47.349837,44.109459,52.067542,52.456215]),
array([47.161999,41.210537,40.339058,37.185386]),
array([32.191771]),
array([33.793172]),
array([25.206425]),
array([24.615146,27.277904,27.073533,29.029928,27.864362,26.850288]),
array([25.636497]),
array([33.579745]),
array([30.65378]),
array([28.307101,26.499288]),
array([36.053711,35.094096,34.701932]),
array([50.322695]),
array([38.860201]),
array([47.234151,49.340806,49.44532]),
array([50.022827]),
array([55.382783,45.013114,26.073511]),
array([54.842488,48.708532]),
array([40.868739]),
array([38.777866,38.438285,42.860047,41.413515,48.06502,48.302247,41.051846,49.804982]),
array([41.135505,41.068964,40.04911,43.015051,49.073124,41.197802,48.284333,49.230972,38.199669,40.867335,43.97289,41.938409,39.396285,38.346415,48.035289,49.731225,38.617289,40.072707]),
array([45.126916,48.080057]),
array([50.715705]),
array([43.27143]),
array([32.77938,36.969151,35.748434,35.095062]),
array([28.488393,24.772255,26.416075]),
array([25.359876]),
array([26.72409,25.852499,24.467333,26.672699,27.1179]),
array([38.469832]),
array([38.121924]),
array([38.548698]),
array([49.297701]),
array([39.581331]),
array([35.478404,34.556957,43.382318]),
array([52.947835]),
array([27.104908,24.539606,27.456949]),
array([43.060222]),
array([37.080659]),
array([31.332788]),
array([38.661918,45.635042,38.92982,38.292056,40.917315]),
array([29.442783]),
array([52.976512])
]


data_4=[array([26.861353,26.144301,24.723647]),
array([28.055559]),
array([26.082404]),
array([43.759774,55.584463,40.246077]),
array([43.237598,51.75471]),
array([49.188429]),
array([40.895334,49.698327,38.3702,48.623165,48.313293,40.307261,49.691943]),
array([28.484611]),
array([40.658405]),
array([25.685029]),
array([25.071025]),
array([44.325655]),
array([40.527507,54.910008]),
array([40.49604,37.964541,40.993027,40.551222,41.194679,40.952951,40.162542]),
array([40.748775]),
array([27.054743,26.235331,25.890497,28.850941,25.416473]),
array([55.044667]),
array([47.475851]),
array([50.527698]),
array([34.548372]),
array([51.636617,46.424781]),
array([26.832492,24.548156]),
array([37.930555]),
array([33.973027]),
array([45.915339]),
array([31.622334]),
array([51.268423]),
array([48.954829]),
array([29.152706,33.35769]),
array([51.580799]),
array([52.648296,50.797814]),
array([41.078736,38.530281,38.215135,41.096359,49.287929,49.42281,39.659343,40.560135,49.801567]),
array([30.429909]),
array([28.141604,25.972775]),
array([24.515441]),
array([48.839898,53.78694]),
array([48.678229]),
array([47.015725,42.921251,47.856861,48.07697]),
array([28.464321]),
array([36.203335]),
array([30.537261,32.967638]),
array([33.265521,33.091392]),
array([31.679445]),
array([32.922636]),
array([49.65203]),
array([30.590075]),
array([31.419771,38.070345,38.105418,38.085905]),
array([33.50721]),
array([32.446391]),
array([51.970222]),
array([52.603283,52.878446]),
array([41.069628,38.65433]),
array([49.191644]),
array([42.536735]),
array([39.046972]),
array([25.338376,29.341243,29.35376,26.297505,26.031048,28.803621,28.657257]),
array([26.253812,25.724781,28.684415]),
array([30.714745]),
array([31.463603]),
array([25.873485]),
array([27.554683,27.943112]),
array([44.982106]),
array([34.072162]),
array([38.70239,38.760313]),
array([41.928185,42.276811,52.987847,52.957603]),
array([38.136566,46.808716,43.007082,35.980899]),
array([35.413942]),
array([34.928635]),
array([29.313854]),
array([24.423403,27.718938,25.565531,25.594476,29.038948,24.431646]),
array([24.751522]),
array([33.580267]),
array([30.683628]),
array([27.711008,25.347045]),
array([35.567237,37.07262,34.13512]),
array([50.71069]),
array([38.333104]),
array([42.742372,42.255225,53.862719]),
array([50.114352]),
array([49.220112,46.244629,27.422728]),
array([53.950972,48.981429]),
array([38.305047]),
array([39.751121,38.31867,45.238973,44.718142,48.975409,48.987178,39.642942,49.112775]),
array([39.431063,39.844455,38.012669,45.11916,48.314369,39.024673,48.825392,48.469781,38.005571,39.409734,43.15325,42.514254,38.809819,39.729695,49.045311,49.803288,39.131583,39.493987]),
array([45.145759,48.589262]),
array([53.180118]),
array([41.350858]),
array([29.920191,36.589606,34.807037,35.929377]),
array([28.199922,25.065648,27.14825]),
array([24.728833]),
array([26.842181,29.014831,26.858002,26.385889,28.196019]),
array([40.454558]),
array([38.024725]),
array([40.820584]),
array([49.542873]),
array([39.620012]),
array([35.234408,36.425156,47.103844]),
array([52.236734]),
array([25.475491,28.679199,27.896934]),
array([42.448582]),
array([32.925296]),
array([28.539959]),
array([45.706717,44.022768,47.75946,47.391694,46.647549]),
array([32.27423]),
array([55.025938])
]


data_5=[array([24.675129,27.024381,24.992196]),
array([25.95947]),
array([24.99439]),
array([41.726105,48.210216,39.564037]),
array([43.209773,51.73051]),
array([51.209899]),
array([38.602398,48.841905,40.615481,48.59311,49.668006,39.57316,49.18556]),
array([24.50273]),
array([41.219019]),
array([27.409839]),
array([25.58007]),
array([39.438488]),
array([38.691983,55.395811]),
array([38.423317,39.023311,41.012669,40.907263,41.158361,40.567755,39.655616]),
array([39.246952]),
array([26.636126,27.504277,25.05702,28.679078,28.712792]),
array([49.125039]),
array([47.601573]),
array([55.240029]),
array([37.580029]),
array([47.747435,51.201368]),
array([25.282133,28.081697]),
array([37.995923]),
array([34.313178]),
array([43.090617]),
array([32.218584]),
array([51.120157]),
array([50.486424]),
array([29.147348,33.577531]),
array([50.423712]),
array([50.169948,53.637697]),
array([40.82451,38.24193,39.494321,40.104884,48.10106,49.330283,40.589038,39.106034,49.358884]),
array([29.306732]),
array([26.62636,24.746155]),
array([25.895922]),
array([50.734707,51.277507]),
array([51.847043]),
array([44.680366,43.21519,52.104134,52.858625]),
array([36.471769]),
array([30.206767]),
array([33.880599,28.922338]),
array([31.410695,31.536892]),
array([29.136436]),
array([32.683079]),
array([49.493279]),
array([32.526853]),
array([31.427315,38.095944,38.198178,38.174684]),
array([31.465813]),
array([31.959955]),
array([52.581078]),
array([52.814798,52.057313]),
array([40.592213,40.96753]),
array([54.269988]),
array([41.469968]),
array([39.108708]),
array([28.055175,27.299289,29.053995,29.091566,26.493706,26.295187,27.144549]),
array([26.419001,25.108645,28.072172]),
array([30.972583]),
array([30.306489]),
array([27.891944]),
array([28.729833,26.641474]),
array([46.393725]),
array([34.128823]),
array([38.076627,38.523005]),
array([42.315755,42.803974,52.574538,52.80752]),
array([44.301724,38.211354,47.697562,34.192499]),
array([30.231605]),
array([34.93092]),
array([25.983352]),
array([24.804217,27.69015,26.522903,26.150685,28.902042,29.019677]),
array([29.106]),
array([33.573551]),
array([30.755862]),
array([27.00867,25.912459]),
array([36.519998,34.602775,37.566577]),
array([50.502963]),
array([40.124679]),
array([41.323481,52.648005,55.622555]),
array([50.055612]),
array([49.867038,46.729951,26.105325]),
array([54.258294,48.421936]),
array([39.935284]),
array([41.051313,40.036807,45.822154,41.451771,49.45805,49.888988,38.574663,48.509542]),
array([39.60632,38.009519,41.008885,46.820641,48.644386,38.60425,48.066173,48.203895,38.166633,40.786237,41.714781,43.287077,39.731723,40.362386,48.458874,48.527077,38.102065,39.955971]),
array([46.504822,51.984629]),
array([54.445493]),
array([44.944421]),
array([33.420893,36.109698,35.494224,34.923869]),
array([25.366398,27.067491,27.789763]),
array([26.528594]),
array([28.265476,28.336153,27.443137,26.759411,25.671553]),
array([39.353969]),
array([38.152113]),
array([40.568553]),
array([49.037627]),
array([40.552318]),
array([35.894126,36.238576,42.667815]),
array([52.62981]),
array([27.605761,24.766447,25.52266]),
array([41.945196]),
array([35.421063]),
array([28.164021]),
array([39.76177,40.153155,45.893941,43.653265,43.054161]),
array([29.39981]),
array([54.814432])
]


data_6=[array([26.005576,23.982506,23.487507]),
array([28.609728]),
array([26.233854]),
array([43.263003,48.949554,39.513097]),
array([45.015004,55.082974]),
array([52.294652]),
array([40.286617,48.684506,38.775618,48.297204,48.274358,39.643131,48.352853]),
array([25.583024]),
array([41.34023]),
array([28.991634]),
array([25.886651]),
array([40.56215]),
array([39.437872,50.603846]),
array([39.213488,40.813526,38.164728,38.145717,40.997841,39.489777,39.636072]),
array([39.625033]),
array([26.296639,24.520843,25.411679,24.723302,27.019383]),
array([53.748574]),
array([47.798204]),
array([54.093114]),
array([36.9107]),
array([51.574656,46.575351]),
array([27.322195,24.96704]),
array([37.814968]),
array([33.746842]),
array([46.729835]),
array([32.878069]),
array([49.590979]),
array([50.529775]),
array([29.020672,33.692251]),
array([50.619239]),
array([51.546852,48.64486]),
array([38.127196,39.366389,39.005816,40.275649,49.161544,49.767084,38.238931,39.373936,48.975475]),
array([30.271522]),
array([25.497674,25.261286]),
array([25.653589]),
array([52.086806,53.509824]),
array([53.114227]),
array([46.315816,46.753386,55.703356,49.775701]),
array([37.535837]),
array([29.152328]),
array([28.60541,32.416988]),
array([31.459049,31.632585]),
array([31.217565]),
array([31.801304]),
array([48.841313]),
array([28.269515]),
array([29.788665,38.119653,38.155914,38.151147]),
array([32.782211]),
array([31.90622]),
array([49.83823]),
array([52.689415,52.892543]),
array([41.29504,39.992194]),
array([54.812237]),
array([43.817145]),
array([41.208803]),
array([24.562834,28.8612,25.453168,27.393459,24.835293,28.927632,26.557837]),
array([25.803057,26.165047,26.283057]),
array([31.605571]),
array([32.742018]),
array([24.750728]),
array([28.338394,27.246187]),
array([46.926811]),
array([35.792614]),
array([37.933407,40.112769]),
array([44.698793,46.287167,52.459757,52.365878]),
array([39.787592,40.579144,38.999237,34.707583]),
array([30.337609]),
array([29.611391]),
array([28.089953]),
array([25.391303,28.375315,29.300197,27.188211,26.068862,24.445021]),
array([24.679028]),
array([33.586667]),
array([30.766686]),
array([26.337772,24.277336]),
array([36.909462,37.043076,41.161693]),
array([50.817153]),
array([41.176311]),
array([44.476145,38.157673,50.271299]),
array([50.358456]),
array([49.465387,43.243611,25.689266]),
array([50.044153,49.151322]),
array([38.164219]),
array([40.774842,38.711815,44.022495,46.290421,49.231572,49.74987,40.509564,48.117892]),
array([40.194637,40.895347,40.308653,47.759608,48.806728,41.071377,49.751871,49.663503,38.183724,38.120777,45.467068,45.116588,41.130394,41.136181,49.924994,49.688138,40.55013,40.950808]),
array([47.425719,50.225623]),
array([50.512576]),
array([42.37612]),
array([32.037385,34.041052,35.522145,35.141875]),
array([26.562563,27.857345,27.16522]),
array([28.323584]),
array([27.787935,24.412685,26.966752,28.504488,29.306625]),
array([38.510178]),
array([38.065142]),
array([38.820149]),
array([49.142204]),
array([39.778064]),
array([34.079959,35.467064,46.466131]),
array([52.739404]),
array([27.978785,26.360092,27.849671]),
array([45.341034]),
array([31.598782]),
array([30.878359]),
array([45.328967,39.917251,45.402079,46.602681,44.404929]),
array([30.14193]),
array([53.417212])
]


data_7=[array([24.039833,25.502969,27.105597]),
array([25.501434]),
array([28.988179]),
array([44.150521,53.261126,39.09974]),
array([46.27995,52.120301]),
array([48.286325]),
array([38.814206,49.708034,40.729375,48.851421,48.625046,38.736077,48.280237]),
array([27.686445]),
array([39.641359]),
array([28.827827]),
array([25.641277]),
array([34.660458]),
array([39.946423,52.0458]),
array([40.609318,40.544558,38.995058,39.555178,40.310922,41.065368,39.028922]),
array([39.311791]),
array([25.095379,28.497218,28.140075,24.557844,27.68698]),
array([50.639921]),
array([47.089886]),
array([53.339909]),
array([35.263059]),
array([51.017797,51.964427]),
array([26.450753,27.652202]),
array([37.562244]),
array([34.995351]),
array([44.670361]),
array([31.948848]),
array([54.808561]),
array([47.280071]),
array([29.094669,33.838904]),
array([55.999676]),
array([50.257503,49.492779]),
array([39.068106,40.676078,40.023699,40.467958,48.14106,49.672325,38.919371,39.577637,48.639158]),
array([31.991117]),
array([26.944169,25.201878]),
array([25.466462]),
array([55.508967,53.544142]),
array([50.209699]),
array([45.348319,46.945735,55.172424,52.348659]),
array([31.586755]),
array([30.183426]),
array([33.105883,28.723293]),
array([31.800762,33.140909]),
array([30.051019]),
array([32.45457]),
array([49.853208]),
array([31.994799]),
array([29.817812,38.102629,38.182165,38.05054]),
array([33.664591]),
array([32.453366]),
array([52.576227]),
array([52.133561,52.598429]),
array([39.875601,39.16873]),
array([50.795939]),
array([45.324545]),
array([40.062432]),
array([25.537192,24.997674,25.071746,25.370985,25.109159,26.953284,26.46936]),
array([26.408247,26.061763,24.821901]),
array([31.585477]),
array([33.405315]),
array([28.425603]),
array([24.71058,26.057299]),
array([45.062319]),
array([35.288554]),
array([40.633827,40.826446]),
array([42.226528,47.578392,52.140154,52.360777]),
array([43.355587,38.441,44.524832,36.543074]),
array([33.823262]),
array([35.726519]),
array([26.273175]),
array([29.294685,28.621204,29.278629,25.989875,27.957048,27.527024]),
array([28.922599]),
array([33.595294]),
array([30.683012]),
array([27.635971,25.837788]),
array([35.770731,36.430048,35.969907]),
array([50.612039]),
array([40.49197]),
array([45.950974,37.861671,55.509807]),
array([50.918694]),
array([51.852573,42.987905,25.670806]),
array([55.029961,48.551871]),
array([40.947605]),
array([40.617419,38.143974,44.490111,46.782158,49.91828,49.84221,40.598858,49.240039]),
array([39.293043,40.831137,40.232628,46.105783,49.12882,39.964024,48.312091,48.919191,38.158013,39.3022,43.668105,46.105417,40.114676,41.165572,48.380443,49.409351,39.684763,46.175535]),
array([41.80781,55.801837]),
array([55.893737]),
array([44.375998]),
array([33.637702,35.36953,34.472228,35.41757]),
array([27.248034,28.990115,25.817649]),
array([27.097943]),
array([24.916963,26.713421,26.792095,24.478509,26.711861]),
array([38.94479]),
array([38.051997]),
array([39.520583]),
array([49.52897]),
array([39.625339]),
array([35.678556,37.295836,44.398244]),
array([52.580429]),
array([24.68093,26.210861,27.81978]),
array([39.448073]),
array([28.94527]),
array([33.620227]),
array([40.630218,42.219709,42.330895,45.693797,40.129594]),
array([36.945299]),
array([49.100944])
]


data_8=[array([24.781457,27.048806,23.296974]),
array([28.604008]),
array([28.205469]),
array([41.620471,54.603043,39.755421]),
array([46.166979,55.746894]),
array([50.538831]),
array([40.441923,48.501404,38.169687,49.528747,48.48969,39.655044,48.704712]),
array([26.47861]),
array([41.269834]),
array([26.775065]),
array([25.186118]),
array([41.504553]),
array([38.661176,53.149468]),
array([38.619407,38.105258,39.701562,38.619146,38.28208,39.763404,41.354558]),
array([39.702173]),
array([26.913235,26.094505,24.312664,27.952731,24.26746]),
array([49.761112]),
array([47.574624]),
array([55.751175]),
array([36.324519]),
array([48.113702,51.376855]),
array([25.927097,25.422026]),
array([37.76257]),
array([33.970855]),
array([45.986628]),
array([31.943181]),
array([49.513455]),
array([43.922765]),
array([29.145993,33.530488]),
array([49.891718]),
array([53.388661,50.112646]),
array([38.088836,40.325213,39.073985,39.152362,48.640905,49.408952,38.645678,40.076888,48.252179]),
array([33.815756]),
array([26.658072,25.216607]),
array([28.63245]),
array([48.848607,54.634979]),
array([49.254876]),
array([41.403529,45.502635,51.01372,51.458311]),
array([31.663722]),
array([34.155901]),
array([33.590846,33.828266]),
array([31.906497,33.009942]),
array([31.648203]),
array([33.406844]),
array([48.251318]),
array([29.826465]),
array([33.640829,38.163609,38.05819,38.028533]),
array([32.30034]),
array([32.89324]),
array([52.735152]),
array([52.477599,52.75649]),
array([40.767207,39.774608]),
array([52.271157]),
array([42.209944]),
array([41.103207]),
array([24.341967,29.258361,27.154796,25.630129,28.747715,25.760562,27.462117]),
array([25.930523,24.964019,25.681464]),
array([31.926021]),
array([31.068611]),
array([27.276766]),
array([25.672787,27.232056]),
array([43.482546]),
array([34.781526]),
array([40.069703,40.712342]),
array([44.941637,41.891182,52.063214,52.356388]),
array([46.468412,43.775577,42.847288,37.066122]),
array([29.215985]),
array([30.590902]),
array([25.077597]),
array([28.508308,26.444179,26.883549,27.052133,24.283135,29.269515]),
array([24.945059]),
array([33.58353]),
array([30.753682]),
array([25.506766,26.825654]),
array([34.378949,35.021577,40.133406]),
array([50.206981]),
array([40.503598]),
array([42.416322,40.527465,51.690137]),
array([50.430858]),
array([49.783776,46.160018,28.287092]),
array([53.765984,49.614449]),
array([39.554757]),
array([40.517098,38.146555,45.319305,42.352834,49.12279,48.91825,39.320395,49.624111]),
array([38.478718,40.24076,40.413735,44.598552,49.355086,38.994278,48.552424,48.310528,38.098444,40.730318,44.330785,41.762748,40.851006,38.664536,49.043786,48.107931,39.967071,46.153458]),
array([46.835437,51.686578]),
array([52.904988]),
array([45.03285]),
array([33.775909,34.867516,36.530889,36.610229]),
array([26.065543,24.473689,28.297739]),
array([24.300296]),
array([27.164299,25.532703,28.893642,25.55433,25.01856]),
array([38.633239]),
array([38.080755]),
array([39.449976]),
array([48.919002]),
array([38.436917]),
array([36.368905,37.688123,45.944608]),
array([52.713766]),
array([29.282179,24.245632,25.750488]),
array([45.844822]),
array([28.767078]),
array([32.891776]),
array([41.277605,41.929969,39.18104,46.781205,39.99635]),
array([34.428313]),
array([52.863461])
]


data_9=[array([25.465885,23.914889,27.256283]),
array([24.648624]),
array([28.047208]),
array([46.118718,49.091258,39.103769]),
array([46.25432,55.894522]),
array([52.846903]),
array([39.665541,48.905908,38.111224,48.879186,48.484009,40.58724,49.220159]),
array([28.693307]),
array([41.032489]),
array([25.747552]),
array([24.956281]),
array([39.417908]),
array([39.517318,49.204368]),
array([40.728153,40.805716,40.523323,39.663711,40.160065,40.55449,39.545885]),
array([39.679814]),
array([25.119792,25.923351,25.861419,25.766418,29.314493]),
array([52.324545]),
array([47.389187]),
array([48.162498]),
array([36.111328]),
array([49.744875,50.282246]),
array([28.895209,24.210659]),
array([37.403464]),
array([33.780211]),
array([44.548006]),
array([32.732703]),
array([52.767086]),
array([41.58591]),
array([29.000184,33.730672]),
array([54.86834]),
array([53.46426,54.023041]),
array([41.147792,38.106368,40.272321,39.636227,49.134363,48.820048,40.199777,38.097956,49.569389]),
array([28.551034]),
array([25.755658,24.961824]),
array([25.761859]),
array([52.678458,50.751023]),
array([53.744622]),
array([43.892708,42.869585,55.263111,53.984144]),
array([31.725004]),
array([33.544902]),
array([31.594621,29.767218]),
array([31.532609,33.333126]),
array([31.653959]),
array([32.538948]),
array([49.94325]),
array([29.001608]),
array([33.317579,38.07713,38.149066,38.089271]),
array([29.03305]),
array([31.859266]),
array([53.471446]),
array([52.985898,52.78792]),
array([39.986202,41.171817]),
array([48.453995]),
array([47.555363]),
array([39.931632]),
array([28.191947,28.275325,24.819356,29.12722,26.127236,29.341114,27.044218]),
array([28.281072,25.405737,26.587212]),
array([31.210268]),
array([31.723986]),
array([26.24914]),
array([27.313295,29.145391]),
array([47.218348]),
array([34.488342]),
array([41.044646,40.681574]),
array([46.604041,42.913189,52.161429,52.563605]),
array([44.829099,40.270322,41.046869,36.513651]),
array([29.778383]),
array([31.370682]),
array([27.655845]),
array([24.52438,29.379295,25.175828,28.791486,27.122109,28.79946]),
array([28.494927]),
array([33.587686]),
array([30.742204]),
array([28.352119,25.797576]),
array([36.831213,34.412331,36.882002]),
array([50.099098]),
array([38.952036]),
array([47.227281,49.364913,51.678195]),
array([50.224682]),
array([48.054634,41.575554,25.858361]),
array([50.469735,48.190321]),
array([38.068734]),
array([39.963011,40.400611,42.670936,43.350413,49.001329,48.163265,38.086849,48.383942]),
array([40.566948,38.836659,40.226132,44.692792,49.715861,40.574314,48.837096,48.23129,38.011929,39.355588,43.79501,44.922203,38.418704,40.706051,49.71702,48.094479,41.092883,45.876978]),
array([41.871593,55.749877]),
array([48.684775]),
array([43.645269]),
array([32.516992,35.394412,34.114608,36.248511]),
array([27.672295,28.90196,28.947913]),
array([26.658207]),
array([27.298212,26.308406,24.32013,27.729975,26.024439]),
array([39.538637]),
array([38.000453]),
array([40.939773]),
array([48.970785]),
array([38.022913]),
array([35.99605,36.628076,42.465123]),
array([52.123586]),
array([25.806542,25.010051,24.211036]),
array([39.657761]),
array([29.335746]),
array([30.029311]),
array([40.332947,44.263988,45.697573,44.777487,42.419306]),
array([36.562672]),
array([50.511203])
]


data_10=[array([24.13332,27.202863,27.180924]),
array([24.931113]),
array([27.165229]),
array([45.334968,49.915375,39.900932]),
array([43.081356,55.216648]),
array([53.538458]),
array([40.607069,48.471143,39.767664,48.015616,48.681548,39.01863,48.676168]),
array([25.722565]),
array([39.165982]),
array([28.211998]),
array([25.786637]),
array([35.724898]),
array([39.025052,50.60853]),
array([38.992684,38.776947,40.452357,40.26801,39.291091,39.811521,39.60941]),
array([39.79386]),
array([27.339033,26.149011,26.129028,24.80807,29.123175]),
array([49.117779]),
array([47.690299]),
array([55.09939]),
array([36.550528]),
array([50.551488,50.094568]),
array([24.400227,24.638018]),
array([37.917378]),
array([33.921109]),
array([46.744651]),
array([33.115313]),
array([54.329783]),
array([45.651862]),
array([29.059458,33.36538]),
array([55.53708]),
array([54.34218,53.743646]),
array([40.521749,39.084002,41.059916,39.273941,49.516013,49.805453,39.504073,40.296956,48.580007]),
array([29.2035]),
array([25.268761,24.66523]),
array([29.175852]),
array([55.506464,51.418355]),
array([52.594544]),
array([42.718401,46.643596,49.560291,48.932602]),
array([37.246258]),
array([30.972952]),
array([32.091914,29.695323]),
array([32.467585,31.610638]),
array([28.857018]),
array([33.239426]),
array([48.63075]),
array([33.867216]),
array([32.965102,38.155671,38.193977,38.063475]),
array([28.659128]),
array([31.377582]),
array([52.545614]),
array([52.927368,52.444844]),
array([40.253037,41.078494]),
array([53.713972]),
array([42.758765]),
array([40.793908]),
array([28.383002,25.893832,27.147507,24.226472,26.68907,25.147162,26.123683]),
array([27.291669,24.206636,28.52625]),
array([33.083981]),
array([33.238672]),
array([28.015482]),
array([26.574599,26.753733]),
array([42.978604]),
array([34.747352]),
array([38.641823,37.772565]),
array([43.062215,45.915792,52.806753,52.065154]),
array([46.150228,40.467366,41.286452,37.12405]),
array([37.460458]),
array([33.373992]),
array([28.612555]),
array([26.942341,29.211796,29.320121,27.226793,26.853155,28.4001]),
array([24.613138]),
array([33.570929]),
array([30.704495]),
array([28.746027,26.820555]),
array([36.027978,36.811663,38.419305]),
array([50.440255]),
array([38.831062]),
array([44.592029,54.659393,48.621074]),
array([50.325809]),
array([54.00097,45.144563,28.633103]),
array([55.058103,49.754904]),
array([39.189688]),
array([38.471992,38.005879,46.456112,43.616907,48.489743,48.367338,38.006526,49.620942]),
array([40.098749,38.878735,38.30485,45.691333,48.280689,39.361883,49.727338,49.997557,38.015593,39.451249,41.853006,42.229656,38.589247,39.40747,48.957535,48.83322,40.851268,41.746198]),
array([44.641284,52.501361]),
array([48.464138]),
array([47.255462]),
array([33.59142,34.879309,36.470644,35.466649]),
array([27.129541,28.8718,24.899872]),
array([26.165185]),
array([29.073586,28.283898,26.684587,25.658651,24.633585]),
array([38.612126]),
array([38.097711]),
array([40.014088]),
array([48.382521]),
array([41.022567]),
array([37.256977,35.26113,42.478316]),
array([52.581233]),
array([28.071643,25.792731,27.13931]),
array([37.910437]),
array([31.565399]),
array([30.298748]),
array([42.722788,44.150228,45.47436,47.777518,46.782273]),
array([31.721922]),
array([53.866625])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Metatheria_EOT_sp_occ_SALMA_kept_1',  'Metatheria_EOT_sp_occ_SALMA_kept_2',  'Metatheria_EOT_sp_occ_SALMA_kept_3',  'Metatheria_EOT_sp_occ_SALMA_kept_4',  'Metatheria_EOT_sp_occ_SALMA_kept_5',  'Metatheria_EOT_sp_occ_SALMA_kept_6',  'Metatheria_EOT_sp_occ_SALMA_kept_7',  'Metatheria_EOT_sp_occ_SALMA_kept_8',  'Metatheria_EOT_sp_occ_SALMA_kept_9',  'Metatheria_EOT_sp_occ_SALMA_kept_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Abderites','Acdestodon_bonapartei','Acdestoides_praecursor','Amphidolops','Amphidolops_intermedius','Amphidolops_minimus','Amphidolops_serrula','Andinogale_sallensis','Angelocabrerus_daptes','Antawallathentes','Antawallathentes_illimani','Argyrolestes_peralestinus','Arminiheringia','Arminiheringia_auceta','Arminiheringia_contigua','Australohyaena_antiqua','Bardalestes','Bardalestes_hunco','Bonapartherium','Bonapartherium_serrensis','Callistoe_vincei','Carlothentes_chubutensis','Chlorocyon_phantasma','Clenia_brevis','Coloradolops_cardonensis','Eomakhaira_molossus','Eomicrobiotherium','Eomicrobiotherium_diluculum','Eomicrobiotherium_matutinum','Epidolops','Epidolops_ameghinoi','Eudolops_tetragonus','Evolestes','Evolestes_hadrommatos','Fredszalaya_hunteri','Gaylordia_macrocynodonta','Gaylordia_mater','Hypodolops_sapoensis','Incadolops_ucayali','Kirutherium_paititiensis','Klohnia_charrieri','Klohnia_major','Kramadolops_abanicoi','Kramadolops_fissuratus','Kramadolops_hernandezi','Kramadolops_maximus','Kramadolops_mayoi','Kramadolops_mckennai','Microbiotherium','Mirandatherium','Mirandatherium_alipioi','Nemolestes','Nemolestes_brasiliensis','Nemolestes_lagunafriensis','Nemolestes_spalacotherinus','Notogale_mitis','Palaeothentes_boliviensis','Palaeothentes_marshalli','Palaeothentes_migueli','Parabderites_minusculus','Paraborhyaena_boliviana','Patene','Patene_campbelli','Patene_coluapiensis','Patene_simpsoni','Perulestes','Perulestes_cardichi','Perulestes_fraileyi','Pharsophorus','Pharsophorus_lacerans','Pharsophorus_tenax','Pilchenia_antiqua','Pilchenia_intermedia','Pilchenia_lucina','Plesiofelis_schlosseri','Pliodolops_kamektsen','Pliodolops_primulus','Pliodolops_rothi','Pliodolops_winecage','Polydolops','Polydolops_clavulus','Polydolops_crassus','Polydolops_serra','Polydolops_thomasi','Polydolops_unicus','Prepidolops','Prepidolops_molinai','Proargyrolagus','Proargyrolagus_bolivianus','Proborhyaena','Proborhyaena_gigantea','Procladosictis','Procladosictis_anomala','Progarzonia_notostylopense','Pseudhalmarhiphus_guaraniticus','Pseudolops_princeps','Punadolops_alonsoi','Riolestes_capricornicus','Sallacyon_hoffstetteri','Sasawatsu','Sasawatsu_mahaynaq','Trelewthentes_rothi','Wamradolops','Wamradolops_tsullodon','Woodburnodon']
def get_taxa_names(): return taxa_names