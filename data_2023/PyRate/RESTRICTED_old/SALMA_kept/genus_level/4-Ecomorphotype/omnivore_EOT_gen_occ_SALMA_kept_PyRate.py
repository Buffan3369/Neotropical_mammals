#!/usr/bin/env python
from numpy import * 


data_1=[array([38.053036]),
array([26.171443]),
array([27.605687]),
array([44.082126,54.783441,38.159926,45.051751,55.021742,48.096383,40.878023,48.483719,39.735252,49.224836,48.420027,40.438265,48.778076]),
array([25.563692,25.779271]),
array([36.589851]),
array([50.08487]),
array([51.158825,47.09294]),
array([52.06819]),
array([54.890871,54.572477,51.124077]),
array([48.214159,34.983923]),
array([25.532652,25.890864,25.694221,25.570359]),
array([27.2401]),
array([31.619727]),
array([25.525703,27.506652]),
array([38.41048,40.279359,38.352073,39.08766,38.963996,48.972702,39.336834,48.800417]),
array([53.845188]),
array([51.902406,50.479482]),
array([53.070565,57.150557]),
array([25.779995,24.637018]),
array([43.008367]),
array([39.97962,38.854634,49.672335,48.157808]),
array([48.700386,55.403204,49.022191,55.785884]),
array([50.518977,54.004969]),
array([51.227529]),
array([48.030795,53.46025,49.509273]),
array([32.78992]),
array([38.190385,39.401253,38.870119,41.156416,49.652349,49.287224,38.909588,39.195928,48.917309]),
array([32.529907,25.048093,25.162263]),
array([25.245426]),
array([51.726612,53.467189,50.143817,44.94323]),
array([51.723634,52.713517,50.795712]),
array([24.811928,24.222693,25.37751,26.325366,38.065269]),
array([54.146447,49.118197,54.743541,44.422384]),
array([32.626503,33.553354,29.843681,32.723963,33.326569,31.470447,28.788688,30.645179]),
array([42.746077,44.996802,53.270934,48.823693]),
array([28.53934]),
array([49.727265,50.853031]),
array([31.630008]),
array([30.918057,32.043779,32.384436,32.05448]),
array([31.072475,32.740364,49.372191,30.225559,33.397194,38.127359,38.122986,38.031044,32.775298]),
array([38.010815]),
array([42.927404,48.904374,53.264196]),
array([51.175508,55.564956]),
array([55.938498,50.499801]),
array([28.407081,26.716217,26.833162,25.340833]),
array([28.078281,25.872183,28.818285,28.734741,32.749923]),
array([46.000542,50.528632,45.804795,51.861686]),
array([25.938216]),
array([46.593019,49.434411]),
array([26.878797,28.774318,29.188468,27.659182,30.051827,28.596729,27.130312]),
array([52.28094]),
array([32.756914]),
array([49.115532]),
array([27.747057]),
array([50.034624,38.490357,43.850702,39.646508,54.521409,50.826703,55.233696,47.278217,26.003719,50.566871,48.538482,38.224783,38.34428,38.383708,47.124335,46.38653,48.354815,49.061195,39.82687,49.571376,40.347161,38.117447,40.283374,43.887994,49.078304,38.014235,48.173787,49.899382,38.013299,39.93556,45.409612,47.427071,39.951434,39.712615,49.485159,49.221557,39.307193,42.196042,41.421001,52.084598,53.492125,55.182173]),
array([33.437678]),
array([54.9177,46.28148]),
array([33.576697,35.427198,36.254272,35.475589,26.189062,26.702802,26.830348]),
array([53.051182,53.947064]),
array([39.393255]),
array([41.648345,43.13915,52.127696,48.488655,51.514992,48.739068,53.456244]),
array([25.220676,28.013545,26.66075,24.659638,28.948756,26.006534]),
array([40.89084]),
array([35.932886,33.954734,41.513152]),
array([34.509103]),
array([52.53881]),
array([26.238399]),
array([32.024817,31.884354,32.40765,41.163978,49.353201]),
array([39.135677,28.18881,34.984039]),
array([41.268199]),
array([40.678045,28.503121]),
array([57.570583]),
array([24.352102]),
array([27.041636,33.290685,27.973828,24.471371,28.394733,26.961618,25.373719,25.078268]),
array([52.874225]),
array([32.4413]),
array([28.540057]),
array([27.779794]),
array([44.889303,46.443928,41.94912,42.257211,41.276909,36.001259]),
array([53.277484]),
array([32.226145,32.534368]),
array([52.86012])
]


data_2=[array([38.020455]),
array([24.390052]),
array([24.830589]),
array([43.122379,51.238462,41.189349,47.402057,49.48028,48.579278,38.621163,48.24745,40.220103,49.627818,49.257042,39.13473,49.156952]),
array([28.763029,25.592164]),
array([35.604245]),
array([51.847803]),
array([53.933288,47.13]),
array([51.213393]),
array([55.157952,52.871501,54.21151]),
array([49.556807,36.007511]),
array([25.19615,25.13714,25.961767,25.775289]),
array([26.040438]),
array([33.289871]),
array([27.492964,26.977013]),
array([39.368602,40.808152,40.53166,40.112006,40.857478,48.818927,40.388953,49.16598]),
array([50.04106]),
array([52.391475,51.406338]),
array([51.994628,55.492158]),
array([28.466433,29.063978]),
array([46.556641]),
array([39.650304,38.606188,49.702572,48.669599]),
array([49.493301,53.524435,48.893428,50.311246]),
array([50.431497,54.77024]),
array([53.319165]),
array([54.520807,52.447813,52.19795]),
array([30.953067]),
array([39.646826,38.432374,38.53018,40.202798,48.675761,48.147835,39.387983,38.918784,48.791974]),
array([28.199288,25.952489,24.85316]),
array([28.715982]),
array([51.620794,51.209066,50.125063,44.161314]),
array([50.618125,51.898008,54.767382]),
array([27.137301,25.797175,24.994601,25.477386,38.093113]),
array([54.302669,55.363317,50.994676,52.016058]),
array([33.318896,31.906797,28.585772,32.507927,33.088655,32.374406,32.838915,31.622131]),
array([47.084547,47.612191,53.514303,52.770647]),
array([34.802725]),
array([53.169269,49.49209]),
array([32.980395]),
array([28.928026,30.035332,32.941481,33.230597]),
array([29.267059,32.853517,49.859081,33.545177,30.587985,38.01327,38.162136,38.136259,30.653398]),
array([38.002918]),
array([42.141915,51.251711,50.151466]),
array([54.901167,51.590708]),
array([54.299418,52.218192]),
array([25.82472,27.701996,29.26581,24.556447]),
array([26.604442,25.385024,28.082741,31.620945,32.162116]),
array([43.81109,50.804597,45.038012,55.109685]),
array([27.005939]),
array([47.280581,49.779186]),
array([28.266507,28.303202,25.864073,27.197972,32.073667,27.680822,27.033682]),
array([55.976067]),
array([32.13299]),
array([49.175169]),
array([28.602798]),
array([50.469344,38.903576,47.641376,38.981764,52.014326,50.477232,47.905844,46.568579,28.279192,48.115594,49.996439,38.469532,38.08455,38.498793,41.786514,44.530743,48.035331,48.282715,38.889759,48.160856,38.61403,38.951227,40.054818,42.706383,48.564202,40.186543,48.332304,48.466247,38.022831,39.913243,42.704266,45.323647,39.751617,39.306282,48.532706,49.885486,38.651842,40.587067,47.449446,54.144458,55.715701,49.242312]),
array([32.930971]),
array([49.545232,41.911016]),
array([30.813931,35.842301,36.737719,36.271627,26.353744,27.346018,27.013118]),
array([51.843046,50.971431]),
array([40.952799]),
array([43.011352,41.535374,50.481291,49.20575,44.899587,49.967542,54.814825]),
array([28.28077,24.744941,27.264728,29.191832,28.862514,26.118248]),
array([39.572931]),
array([37.348343,34.2797,43.41618]),
array([34.050261]),
array([52.779435]),
array([27.992158]),
array([32.158065,31.943536,32.81496,40.889429,49.747305]),
array([41.400107,32.467824,37.522882]),
array([42.079242]),
array([37.911953,36.638298]),
array([48.317088]),
array([27.494026]),
array([25.479078,33.287914,28.207691,26.93318,28.732787,27.797826,27.56978,27.790802]),
array([47.138761]),
array([31.440042]),
array([29.551021]),
array([28.762127]),
array([38.947648,40.189191,44.04832,47.369636,44.164532,37.35301]),
array([51.364608]),
array([33.163215,31.786023]),
array([49.278219])
]


data_3=[array([38.020556]),
array([25.750989]),
array([26.156595]),
array([42.947918,49.270742,40.670215,44.752783,53.420742,54.07532,41.188336,49.033196,39.339022,48.726182,49.930226,40.131272,49.35167]),
array([27.70992,25.587769]),
array([34.270234]),
array([53.339749]),
array([54.107427,47.452863]),
array([50.510304]),
array([50.580197,50.115037,55.105049]),
array([54.378453,35.088909]),
array([25.921239,25.701739,25.783558,25.722915]),
array([27.51445]),
array([31.861404]),
array([24.813998,24.551015]),
array([38.719773,41.039736,39.971894,38.262567,40.086624,49.974299,40.831469,49.737961]),
array([53.983756]),
array([48.574624,52.790364]),
array([54.907495,51.808813]),
array([24.93065,25.230538]),
array([42.319717]),
array([38.310998,40.650246,49.009236,48.702172]),
array([51.371406,53.081409,53.746332,55.481778]),
array([48.647098,53.713616]),
array([49.265226]),
array([49.318526,51.271417,50.50418]),
array([30.74615]),
array([38.560267,39.208404,38.284018,40.523215,48.920362,49.028244,40.051583,38.91964,49.368247]),
array([30.86915,24.689793,25.328554]),
array([25.659911]),
array([54.848647,49.553376,50.936122,43.304385]),
array([53.150936,53.597608,51.514818]),
array([28.690661,29.061908,25.486957,26.806425,38.100919]),
array([49.957239,49.554888,54.064792,50.80827]),
array([32.090073,31.718203,31.451026,34.46971,31.716934,31.352489,31.513041,31.400576]),
array([47.78969,45.129248,52.539972,50.77792]),
array([29.358553]),
array([55.68433,52.583428]),
array([37.20937]),
array([32.584547,31.990751,32.818944,31.813257]),
array([32.984297,32.771918,48.068618,30.797692,31.804993,38.00015,38.190936,38.155947,32.287915]),
array([38.086131]),
array([43.812708,55.420901,50.868529]),
array([53.466009,53.492472]),
array([53.728433,50.142948]),
array([28.544682,27.295346,24.871265,28.692987]),
array([27.645343,24.514443,28.87517,31.560589,30.511624]),
array([42.30481,50.267312,47.573983,54.511287]),
array([27.505452]),
array([42.273976,49.934006]),
array([24.672831,27.208708,27.649022,28.733146,31.659257,27.932359,26.773555]),
array([52.569082]),
array([32.298345]),
array([52.726796]),
array([30.858882]),
array([50.114679,38.831686,42.406978,46.404668,55.080375,50.456234,54.919976,43.55113,26.78863,49.99042,48.146989,40.22207,41.024634,40.279147,45.355622,46.106421,48.999046,49.896102,39.481399,49.751143,38.682476,38.287132,41.125925,44.294821,49.045942,39.830142,48.864794,48.031955,38.061822,38.406479,46.774928,41.809274,39.833522,40.452297,48.018888,48.257698,39.597209,44.913778,44.790167,51.329766,53.265366,48.506325]),
array([31.414123]),
array([48.965434,46.298676]),
array([33.60508,36.036138,34.984459,35.722818,28.478782,28.95488,24.574899]),
array([54.162443,49.74338]),
array([40.052465]),
array([42.737829,44.385022,52.422199,52.702066,41.771867,53.20768,49.921179]),
array([28.372928,26.123131,27.571905,27.634991,24.424909,27.7935]),
array([40.018907]),
array([37.090098,36.250504,43.428507]),
array([35.072726]),
array([52.786067]),
array([28.737391]),
array([33.104035,31.342884,33.309218,38.495299,48.6426]),
array([47.126585,36.170631,37.073139]),
array([44.959455]),
array([46.297106,34.377701]),
array([49.286394]),
array([25.967541]),
array([26.687096,32.304295,25.423126,27.497912,27.904788,24.201343,26.481458,24.914532]),
array([49.036203]),
array([29.405687]),
array([30.576778]),
array([24.38943]),
array([46.628597,41.812421,43.852841,46.95222,39.891215,36.327532]),
array([51.851231]),
array([32.060354,31.699978]),
array([55.415034])
]


data_4=[array([38.077424]),
array([24.98796]),
array([28.089456]),
array([45.256995,50.229382,39.886179,42.164824,48.14994,49.599584,38.397008,49.83922,40.723211,49.755769,48.154153,39.622619,48.491206]),
array([27.590259,24.78021]),
array([35.36653]),
array([52.216492]),
array([49.134509,47.671044]),
array([50.507531]),
array([51.742501,51.957543,51.593516]),
array([49.564386,36.079862]),
array([25.456246,25.080321,25.836288,25.542866]),
array([24.117371]),
array([32.096427]),
array([28.027433,28.922331]),
array([39.974809,38.757399,40.553317,38.063751,39.845076,48.537507,38.264318,49.034119]),
array([48.699197]),
array([51.58727,51.556619]),
array([58.883733,54.993865]),
array([28.119059,25.010044]),
array([41.718619]),
array([38.578481,38.238976,48.579487,48.563958]),
array([49.861432,52.018035,53.236856,48.675517]),
array([55.576068,49.258753]),
array([50.4738]),
array([49.906729,54.058353,48.760843]),
array([32.820283]),
array([40.012953,40.216156,39.894313,39.546342,48.560521,49.213995,39.355992,40.822713,48.785785]),
array([28.695587,28.067862,24.762277]),
array([24.956299]),
array([52.315292,48.70731,50.759439,46.912341]),
array([48.678554,53.901166,54.278815]),
array([25.87827,25.751041,25.419977,25.985128,38.039097]),
array([48.703649,52.551634,54.013505,53.534032]),
array([33.330124,32.550025,30.435764,35.506222,32.631408,32.768588,30.717626,33.338885]),
array([47.672769,43.648444,49.312692,48.654945]),
array([34.547497]),
array([50.545012,53.851719]),
array([33.84483]),
array([32.334686,31.357432,31.760313,31.648243]),
array([30.759315,33.538489,48.862295,30.113317,33.503927,38.146907,38.023621,38.109452,32.294243]),
array([38.120958]),
array([45.403808,50.31092,48.833302]),
array([51.057728,50.335567]),
array([51.719385,49.589146]),
array([27.971204,24.936475,29.111637,26.782722]),
array([25.016546,28.55072,28.023759,28.948624,28.94327]),
array([47.449449,50.404068,45.72377,53.528041]),
array([28.588152]),
array([45.369402,55.588869]),
array([25.832594,24.437633,25.766587,24.690638,33.331979,24.918313,26.704597]),
array([56.078053]),
array([32.96743]),
array([55.660731]),
array([30.696966]),
array([50.26706,39.590445,45.10116,46.779056,50.189817,50.750453,48.301059,43.469055,27.773114,48.219614,49.248592,39.666083,38.621938,40.214662,44.227687,46.868829,48.156281,49.55913,40.226193,48.687535,40.745213,39.084348,39.502397,46.320344,48.742322,40.920027,49.195911,49.586858,38.05006,39.666,47.457789,45.734557,40.9243,39.405186,49.828768,49.182067,38.228806,37.719038,45.287397,53.797135,42.498647,55.461731]),
array([33.353584]),
array([55.30165,46.792839]),
array([29.609414,36.105329,34.480568,36.283585,26.564155,27.575355,26.594805]),
array([53.73704,52.430208]),
array([40.648039]),
array([45.867762,46.711547,50.776032,53.610976,47.402286,49.994486,55.255614]),
array([29.386266,24.841467,31.873121,27.50743,29.282089,25.817504]),
array([38.910568]),
array([37.55949,37.274392,41.704252]),
array([36.692251]),
array([52.64666]),
array([27.923063]),
array([31.513219,32.953673,30.546,38.822472,49.036288]),
array([39.937164,35.37207,28.145946]),
array([41.676159]),
array([45.428279,34.66388]),
array([50.129821]),
array([25.09051]),
array([26.61575,33.576853,26.353718,26.623802,24.879597,26.47596,25.926621,25.21931]),
array([47.02484]),
array([29.264544]),
array([28.13675]),
array([26.264631]),
array([41.029012,44.710135,39.089372,46.736803,43.365319,35.798132]),
array([51.103703]),
array([33.269058,32.624042]),
array([49.650231])
]


data_5=[array([38.168692]),
array([28.085654]),
array([28.180171]),
array([43.97791,50.246913,39.202137,43.444018,48.301817,52.022218,40.087466,48.800216,40.058259,48.282163,48.573412,38.403827,49.413084]),
array([27.409703,24.715836]),
array([35.620182]),
array([53.321737]),
array([52.720503,47.2249]),
array([55.680439]),
array([54.50419,55.414173,49.327703]),
array([51.172295,36.020997]),
array([25.16382,25.937875,25.111386,25.611688]),
array([23.597836]),
array([32.272408]),
array([25.896042,27.850404]),
array([38.271238,40.642465,39.527519,39.16808,40.69614,49.728834,38.664,49.655787]),
array([54.958788]),
array([53.069667,49.564519]),
array([56.949176,54.72575]),
array([25.541412,27.791994]),
array([42.846169]),
array([38.805894,38.494345,49.891554,48.857806]),
array([52.252935,50.397218,55.008163,54.040506]),
array([49.016388,53.66308]),
array([49.527472]),
array([49.020152,52.299247,49.999695]),
array([28.533691]),
array([38.260179,38.507119,39.150951,38.331354,49.966472,48.88013,39.210643,38.10383,48.686228]),
array([31.873834,26.603918,24.54994]),
array([28.616817]),
array([52.815109,50.58268,50.54272,45.368311]),
array([54.74453,50.066111,49.724523]),
array([26.784611,28.175486,24.657159,25.646116,38.19102]),
array([50.225248,50.569177,55.108055,46.417311]),
array([31.354604,32.351228,28.365009,32.031531,31.473163,32.02254,29.138297,29.391043]),
array([45.819192,43.173875,48.552452,54.560676]),
array([35.241867]),
array([49.144791,48.752958]),
array([31.589759]),
array([30.173173,32.164393,31.485773,32.201284]),
array([33.616102,32.414301,49.771836,29.920575,29.490577,38.087573,38.027862,38.009299,32.789472]),
array([38.108988]),
array([42.982041,49.34342,52.520873]),
array([48.717118,50.516481]),
array([48.172428,50.715609]),
array([27.084446,26.447178,27.237709,25.113319]),
array([28.740911,24.796216,26.516127,32.782398,29.415364]),
array([45.327125,50.383821,42.795518,54.641093]),
array([26.768901]),
array([46.40147,53.673104]),
array([25.329887,25.816255,26.369296,24.572026,30.7277,26.086236,26.51119]),
array([55.130467]),
array([32.757689]),
array([52.053751]),
array([31.006967]),
array([50.222056,39.493528,45.932772,42.274498,50.279496,50.666305,54.577074,45.358387,24.682343,49.963157,49.789777,40.478576,38.260163,39.295908,47.069994,44.563863,49.90344,49.006889,41.097345,48.648382,39.91093,39.301062,39.899467,46.497072,48.216479,40.275457,48.436218,48.672277,38.170198,40.114102,45.845467,42.496722,38.710218,38.656856,49.052206,49.687012,41.046421,41.262615,43.139321,49.26322,50.175759,46.134321]),
array([31.98241]),
array([49.728246,43.309068]),
array([28.656086,34.185043,36.80045,36.959923,24.650587,24.744318,25.940272]),
array([50.609592,50.98392]),
array([40.263921]),
array([45.555708,46.531408,52.537091,52.881508,51.028725,51.036961,54.794267]),
array([26.517742,25.54655,27.155861,26.694417,24.922043,28.419778]),
array([39.175486]),
array([36.387351,35.57877,45.852228]),
array([36.890515]),
array([52.266685]),
array([25.19185]),
array([32.805017,31.80917,33.671779,39.544145,49.345354]),
array([42.698339,31.520501,36.524262]),
array([43.627112]),
array([45.039843,31.437425]),
array([53.286704]),
array([24.808518]),
array([27.788534,32.615443,26.242364,28.785453,24.906825,25.917772,25.972008,28.343395]),
array([50.959631]),
array([31.242588]),
array([28.565849]),
array([25.060503]),
array([39.425192,42.335616,40.046662,38.332599,37.715302,37.402513]),
array([55.808902]),
array([32.63481,31.99394]),
array([55.373307])
]


data_6=[array([38.039515]),
array([28.994284]),
array([24.717191]),
array([45.083212,48.130541,39.787633,45.175332,50.033097,55.001353,38.193352,49.923068,38.217768,49.252336,48.229144,38.434648,49.792397]),
array([25.486237,25.443289]),
array([36.762876]),
array([55.063509]),
array([52.196275,47.506073]),
array([50.308707]),
array([49.801247,54.140581,52.711823]),
array([53.066807,36.990001]),
array([25.646848,25.51321,25.335374,25.607478]),
array([25.953566]),
array([32.844646]),
array([28.773385,27.528712]),
array([39.906674,40.656095,40.807486,38.799576,38.858058,48.691412,39.00806,49.676654]),
array([50.957046]),
array([48.81549,51.612463]),
array([58.003208,56.492784]),
array([24.939402,25.079761]),
array([42.083288]),
array([39.283719,40.491954,48.537041,48.712349]),
array([50.998848,53.559952,47.840445,54.417749]),
array([50.231143,55.454011]),
array([50.156468]),
array([51.435331,52.977269,49.500498]),
array([29.220444]),
array([39.385868,38.013369,40.05832,39.038295,48.192438,49.699103,38.742543,41.071335,48.485222]),
array([30.438361,28.163215,24.938115]),
array([25.597412]),
array([55.835479,50.737511,50.416667,44.225553]),
array([53.695731,54.106771,54.063189]),
array([24.370395,28.498714,25.654676,26.948679,38.129557]),
array([51.853801,47.892627,49.901455,47.721707]),
array([33.370199,33.162358,28.819859,30.004192,32.358027,32.516615,33.329572,29.865883]),
array([45.884189,42.304034,54.479623,49.47489]),
array([31.138431]),
array([55.143068,53.216494]),
array([33.75806]),
array([31.999297,31.804828,31.988103,33.259331]),
array([29.298885,33.396085,49.2224,30.212221,28.809593,38.045206,38.073653,38.00961,29.126879]),
array([38.13486]),
array([45.768881,49.544861,55.390329]),
array([53.963827,52.699384]),
array([52.682148,51.597352]),
array([25.757248,25.715744,26.917221,25.115862]),
array([28.486722,25.542214,27.442007,32.742521,30.288671]),
array([41.588193,50.70881,41.76076,48.496896]),
array([25.400319]),
array([46.393328,48.897444]),
array([28.486439,24.587909,29.071266,26.708618,31.922309,27.050948,29.263219]),
array([59.123835]),
array([32.295683]),
array([54.171959]),
array([29.649752]),
array([50.495808,40.202932,42.221657,50.049566,52.510041,50.226936,50.664185,41.870762,27.379263,51.850591,48.8913,40.641479,39.707987,38.149316,41.627185,41.640865,48.871891,49.699022,40.254308,48.751505,38.575069,39.059207,40.908195,43.424242,48.347329,40.497137,48.776188,49.154952,38.087805,40.693515,42.603413,47.467702,40.475754,38.529233,49.339804,49.972204,39.950661,46.409344,43.489539,52.46381,44.851864,48.847628]),
array([31.768332]),
array([52.607761,47.279942]),
array([28.668087,35.310205,37.150062,34.587082,28.233626,28.252799,26.871572]),
array([53.239061,52.405137]),
array([39.924482]),
array([43.607701,44.852757,53.097845,53.404233,47.735328,50.094907,52.426577]),
array([24.642908,28.261301,26.798905,24.636608,28.807296,28.10858]),
array([40.118067]),
array([34.859194,35.602602,42.332423]),
array([35.932615]),
array([52.284642]),
array([27.095798]),
array([31.920546,31.856892,30.691342,40.982666,48.398818]),
array([39.014863,36.140539,29.245286]),
array([41.796973]),
array([43.49991,37.681454]),
array([57.256682]),
array([27.201535]),
array([25.326804,32.163809,28.055579,28.662504,27.677099,26.053915,26.115873,25.084136]),
array([52.887744]),
array([32.677886]),
array([29.98769]),
array([28.915013]),
array([45.279736,45.840524,46.845205,41.462373,39.194661,30.003188]),
array([53.656461]),
array([33.13338,32.78855]),
array([50.519743])
]


data_7=[array([38.079585]),
array([25.10195]),
array([28.006816]),
array([45.994491,54.321036,39.533985,41.492781,55.571479,54.698318,40.351831,49.883272,39.708002,48.669155,49.464649,39.606216,49.237575]),
array([24.212851,24.731386]),
array([36.776546]),
array([54.348988]),
array([53.556788,47.500917]),
array([54.859808]),
array([49.888725,53.305879,52.618578]),
array([48.674585,37.028008]),
array([25.507477,25.939936,25.800044,25.709329]),
array([27.586406]),
array([31.880217]),
array([28.930657,26.112321]),
array([40.963353,39.818557,38.524919,39.576873,38.19657,49.817245,39.644832,49.7861]),
array([53.210897]),
array([49.489324,49.224156]),
array([50.304074,52.93391]),
array([28.365705,24.925528]),
array([47.434868]),
array([40.155346,41.076298,49.458292,49.908277]),
array([50.553217,52.944111,54.688741,50.310007]),
array([54.856027,53.876642]),
array([53.748447]),
array([51.433437,54.509727,50.685317]),
array([28.535388]),
array([39.932865,38.761362,40.325091,40.617357,48.353632,48.302003,38.869214,38.69616,49.949309]),
array([30.54095,26.134807,25.047314]),
array([24.251809]),
array([55.913146,51.234488,50.681439,42.528904]),
array([48.948274,52.023922,55.555257]),
array([28.992573,28.330471,24.988729,25.462183,38.187118]),
array([52.337442,49.326544,54.081188,44.739042]),
array([32.99727,33.010194,32.516133,33.543807,32.441712,31.453979,29.660094,32.017141]),
array([46.519152,46.642083,55.951872,49.652553]),
array([36.543928]),
array([53.957434,51.933482]),
array([29.885479]),
array([32.989649,29.163904,31.516233,32.425343]),
array([32.857784,32.0144,49.176116,30.108079,32.779898,38.181527,38.130558,38.091733,28.657779]),
array([38.183375]),
array([45.811655,55.709175,51.310145]),
array([49.757059,52.361616]),
array([49.810416,50.104184]),
array([26.478136,29.11029,28.777328,27.290047]),
array([25.195328,28.466046,27.252271,33.424482,28.652597]),
array([44.026335,50.446067,47.566761,48.740131]),
array([25.075297]),
array([47.776345,50.863166]),
array([24.86157,26.909174,27.257177,27.061394,33.218291,27.731383,25.46488]),
array([57.320645]),
array([32.175762]),
array([51.18749]),
array([30.829346]),
array([50.375522,39.858196,46.041398,43.384135,49.449494,50.513212,47.846652,46.45055,28.553895,55.350989,48.916119,41.031356,38.152113,38.12774,41.342568,41.747638,49.494244,48.812651,41.028402,49.579951,39.492147,39.687982,40.108855,42.023642,49.981004,39.739466,49.617268,49.621337,38.008612,38.301889,42.824693,46.511385,39.355717,38.460411,49.950686,49.948324,39.879047,45.870906,44.32207,55.182787,44.785465,42.171289]),
array([32.191676]),
array([55.064786,47.038824]),
array([29.526764,33.941951,36.170093,36.123951,27.358021,25.74203,28.185032]),
array([50.487158,51.569343]),
array([40.709501]),
array([45.623537,42.600567,50.235641,55.840017,54.162691,49.721519,49.236364]),
array([28.604075,26.391111,31.157863,24.355438,27.134189,24.851219]),
array([39.974672]),
array([34.105116,36.696789,42.785606]),
array([36.55967]),
array([52.766971]),
array([27.877067]),
array([32.324331,31.414983,30.283923,41.132599,48.911295]),
array([38.663288,33.472314,37.052835]),
array([45.573595]),
array([45.95242,28.97553]),
array([56.285845]),
array([29.073148]),
array([24.661103,33.000423,27.450483,27.381155,26.640595,24.239537,26.734154,25.606363]),
array([52.131259]),
array([29.219092]),
array([28.40505]),
array([25.285579]),
array([38.710738,37.892877,39.408909,47.427992,38.2408,29.13378]),
array([49.224409]),
array([31.442879,33.476071]),
array([50.712057])
]


data_8=[array([38.017012]),
array([28.213809]),
array([27.94657]),
array([42.511106,52.59762,40.17939,43.624841,49.124585,48.761917,38.108364,49.690237,40.521987,49.402099,49.366556,39.279729,49.33578]),
array([25.756494,25.842206]),
array([35.953006]),
array([52.280914]),
array([54.982646,47.292502]),
array([54.388601]),
array([54.485457,50.72421,53.325685]),
array([49.189441,34.879422]),
array([25.970316,25.647107,25.463418,25.490908]),
array([26.84282]),
array([31.903219]),
array([26.899251,26.578116]),
array([39.795043,40.045005,40.512376,38.002626,39.27519,49.475366,41.197655,49.700924]),
array([53.53158]),
array([50.102593,50.11653]),
array([50.884721,51.683456]),
array([26.413526,28.626622]),
array([41.844628]),
array([40.656729,39.073282,49.9675,49.606945]),
array([53.984535,54.253086,52.059155,50.255939]),
array([47.813685,53.966967]),
array([54.715413]),
array([50.452289,51.837457,49.762897]),
array([29.245486]),
array([40.618026,39.683725,39.816322,38.365202,48.412679,49.165508,39.930576,38.071635,48.048674]),
array([33.253936,27.733992,25.582009]),
array([26.188782]),
array([50.569319,48.608988,50.920481,45.940718]),
array([51.41796,52.508728,49.098041]),
array([27.14862,28.908997,28.184292,27.68266,38.113321]),
array([49.619355,50.332735,53.19863,50.385962]),
array([31.736734,32.675937,30.551362,32.091623,33.114891,33.024001,29.843702,28.663678]),
array([44.304887,45.919056,51.766676,53.018507]),
array([33.208943]),
array([51.147569,55.737258]),
array([34.988598]),
array([29.216912,32.475431,32.587327,32.751968]),
array([30.181137,31.581905,49.445653,30.727761,33.117063,38.118168,38.116529,38.030464,30.965747]),
array([38.036507]),
array([43.45797,55.460405,53.800626]),
array([51.020417,51.787379]),
array([53.598218,51.398115]),
array([25.071293,29.276078,25.076467,27.022211]),
array([27.44855,26.496283,24.741183,30.516433,33.872484]),
array([45.937852,50.107343,47.579808,53.000013]),
array([26.289177]),
array([42.602238,52.743796]),
array([24.578329,26.340019,27.329464,28.068836,33.595688,26.184638,28.39179]),
array([51.559756]),
array([31.780945]),
array([49.114656]),
array([28.331255]),
array([50.222747,41.12549,43.307454,49.919079,50.277798,50.001292,48.642125,43.41316,28.3215,51.64871,49.431669,39.077376,40.214504,39.517953,43.433808,42.196255,49.170131,49.002438,41.088007,48.448615,39.428242,39.515027,39.078115,44.141274,48.685838,39.205331,49.661347,48.478509,38.028237,39.720313,41.811308,43.476502,40.08757,39.873621,49.570885,48.940066,39.768738,40.866667,45.590487,48.265412,43.985123,47.605552]),
array([33.25229]),
array([55.80897,42.302141]),
array([29.292991,36.463318,35.133813,35.122459,24.574939,25.522929,27.39492]),
array([51.170979,54.702088]),
array([41.081375]),
array([47.749336,41.969276,52.173122,48.719022,50.638701,52.315769,51.966822]),
array([29.074755,24.671245,31.70856,24.724906,27.179149,25.646438]),
array([39.793748]),
array([37.250313,34.821495,46.54953]),
array([33.95004]),
array([52.234537]),
array([29.193518]),
array([32.405026,31.726931,32.109355,40.838418,49.271463]),
array([39.737659,34.404845,32.84825]),
array([40.267709]),
array([43.560741,33.794379]),
array([52.949969]),
array([28.733288]),
array([28.491807,32.734566,25.812948,25.175391,25.534555,27.907259,28.494414,25.476629]),
array([48.305344]),
array([33.193088]),
array([29.400971]),
array([24.757196]),
array([45.313018,44.423344,42.698283,38.147474,41.15103,33.643557]),
array([47.99795]),
array([31.850721,32.482934]),
array([52.477537])
]


data_9=[array([38.081226]),
array([26.100657]),
array([24.796342]),
array([43.452518,51.29275,40.363419,45.912763,50.484943,50.34606,38.20731,49.617867,39.859425,48.042421,49.859536,39.312679,48.028404]),
array([26.470666,24.551541]),
array([37.600612]),
array([49.044209]),
array([49.273447,47.380081]),
array([53.530676]),
array([48.520322,51.061916,49.771802]),
array([47.93946,37.38826]),
array([25.356803,25.487132,25.746402,25.311455]),
array([27.083016]),
array([31.547088]),
array([25.444823,26.051624]),
array([38.501087,39.195141,39.180335,38.028037,39.49094,49.631838,41.059437,49.992077]),
array([51.599286]),
array([52.346914,54.742073]),
array([49.24055,53.944351]),
array([26.291661,27.147438]),
array([46.568745]),
array([38.189444,39.804105,49.095032,49.842016]),
array([55.581182,53.18258,54.247057,52.186649]),
array([53.773989,52.87473]),
array([53.2235]),
array([52.683875,55.518418,53.333068]),
array([28.731691]),
array([39.647402,38.536139,39.135153,38.219086,49.30632,49.657728,40.717637,40.666345,49.334732]),
array([33.122597,28.072293,25.940761]),
array([25.086762]),
array([52.506639,51.552832,50.47241,41.720819]),
array([48.851537,50.540757,49.468188]),
array([29.346395,25.910233,24.379684,27.560233,38.028381]),
array([49.893566,55.764657,54.809541,48.401039]),
array([32.703835,31.760293,32.743195,29.0938,31.737497,31.333645,33.731844,30.030363]),
array([44.604359,43.689067,49.74351,47.848045]),
array([37.202582]),
array([48.459717,55.592992]),
array([35.191283]),
array([31.511816,32.059462,32.275002,33.407824]),
array([32.534842,31.513019,48.883453,33.03388,30.784837,38.09479,38.162501,38.173628,31.42883]),
array([38.045586]),
array([45.929467,50.359325,48.647084]),
array([50.471684,49.111125]),
array([50.326868,50.957443]),
array([28.121689,29.241526,28.404157,25.158356]),
array([27.983032,28.092991,26.29957,28.26374,31.944176]),
array([46.315711,50.305899,46.183065,48.209732]),
array([28.161429]),
array([44.51535,55.862688]),
array([26.38893,27.51375,28.746237,27.940496,31.125287,25.027174,27.939419]),
array([56.332879]),
array([31.34854]),
array([54.558299]),
array([27.203019]),
array([50.965234,38.972552,42.734662,47.005312,49.497689,50.747168,49.751793,42.053119,26.273914,48.02118,49.070381,40.581569,40.346752,40.147006,44.960803,42.025778,49.787923,48.599683,38.818695,48.374603,40.755027,39.151172,40.847766,46.061945,48.605051,40.128979,49.780782,48.063695,38.028759,38.439714,43.330132,41.570541,39.248932,39.775877,49.785325,48.061338,39.816641,41.711521,46.896314,55.310089,51.496351,49.919184]),
array([31.890673]),
array([48.409955,47.397928]),
array([28.871924,37.180934,36.956606,34.383213,26.588859,26.996747,25.215658]),
array([53.09575,55.754278]),
array([41.487147]),
array([47.227538,45.59576,49.85718,55.470992,44.645312,51.947039,52.411501]),
array([26.294809,29.296194,30.356846,29.040753,28.919525,27.238376]),
array([39.96355]),
array([36.854808,36.028131,41.343106]),
array([34.235389]),
array([52.380916]),
array([27.214576]),
array([31.495807,31.931911,33.668431,38.331501,48.633637]),
array([44.859353,31.199077,35.537532]),
array([41.252672]),
array([42.509665,35.970442]),
array([54.370052]),
array([26.298297]),
array([25.437373,31.740827,25.657323,24.830559,24.553863,25.353048,26.650824,24.937242]),
array([52.32634]),
array([32.808683]),
array([28.718505]),
array([28.117679]),
array([43.562073,40.474562,39.8541,37.961138,45.265931,33.388602]),
array([50.659113]),
array([32.443422,32.479252]),
array([53.29855])
]


data_10=[array([38.071426]),
array([26.099725]),
array([28.590706]),
array([44.631126,49.352633,41.015426,46.450558,49.663604,48.385566,38.793442,49.925191,39.76091,49.659977,49.674419,38.572885,48.315318]),
array([27.647747,25.916773]),
array([34.740756]),
array([54.177622]),
array([49.062798,47.350356]),
array([49.614737]),
array([52.227914,52.348136,54.431536]),
array([54.38505,34.196777]),
array([25.323801,25.486326,25.116506,25.04611]),
array([26.494593]),
array([33.48121]),
array([27.416687,28.948931]),
array([39.819018,38.550043,38.839385,40.315668,39.275186,49.923462,38.556281,48.743923]),
array([51.779764]),
array([51.553599,52.2298]),
array([57.862874,50.129285]),
array([27.451704,29.342193]),
array([42.74552]),
array([39.596089,39.435493,48.540024,49.717151]),
array([51.321155,50.17262,52.840439,51.815854]),
array([50.041074,55.686265]),
array([54.02829]),
array([50.318444,50.14674,52.850975]),
array([33.382688]),
array([40.716085,39.143796,38.406485,41.18771,49.913598,49.483485,41.180461,39.588669,49.24236]),
array([29.453687,27.796107,25.267107]),
array([28.628174]),
array([48.507397,49.272991,50.026051,41.525186]),
array([54.708625,49.907159,51.963396]),
array([25.706253,26.032101,27.017893,26.108194,38.066245]),
array([55.345374,47.960108,53.227781,48.886165]),
array([31.401174,31.99932,30.475636,35.563861,32.626659,31.479327,30.276245,33.321842]),
array([43.775135,46.265387,48.966262,55.04318]),
array([35.222785]),
array([49.814952,52.622823]),
array([32.365945]),
array([33.833923,31.292004,33.26822,32.289201]),
array([31.679036,32.9477,48.65183,30.137033,33.267578,38.058296,38.160632,38.021431,30.621798]),
array([38.032706]),
array([46.240851,51.594573,55.157892]),
array([48.716261,49.155872]),
array([52.271688,55.713766]),
array([25.062298,28.549251,29.152688,25.02902]),
array([26.170968,25.361038,27.213004,29.815777,32.071322]),
array([44.497512,50.134725,42.490299,54.321272]),
array([24.359873]),
array([42.710025,51.220349]),
array([24.211067,26.241685,24.476497,26.690325,32.119404,24.642682,28.009923]),
array([57.497801]),
array([32.856761]),
array([55.203399]),
array([29.594667]),
array([50.604656,38.589649,43.441493,55.189553,54.508882,50.548418,51.800624,42.433268,27.01045,49.02125,48.613595,39.620282,38.999881,40.692657,44.14717,44.287926,48.006122,49.367601,38.455954,49.657734,38.779559,38.229029,40.048188,46.760822,49.66663,39.8399,48.898127,49.20635,38.055042,40.679807,47.379334,43.471948,39.339843,39.799009,49.041901,49.549102,38.929895,44.303222,43.639868,52.848691,48.385481,50.582466]),
array([31.500357]),
array([52.011034,42.383902]),
array([33.319306,34.137347,34.146395,35.746665,26.013947,28.615589,27.657666]),
array([55.330543,52.005818]),
array([41.669752]),
array([44.498028,45.954278,54.922278,49.320815,43.367872,55.541998,52.590997]),
array([27.742675,29.329023,28.740055,27.50376,26.884168,29.036644]),
array([39.488503]),
array([36.756025,35.036702,46.954957]),
array([34.781367]),
array([52.378438]),
array([25.874003]),
array([33.52176,31.300887,28.858162,38.216935,49.186401]),
array([42.683944,34.611313,31.609518]),
array([41.749881]),
array([44.611282,36.322335]),
array([56.310296]),
array([28.498196]),
array([25.700462,32.200738,27.918851,25.728141,26.127066,26.05292,26.238369,24.733553]),
array([47.820354]),
array([29.822908]),
array([30.916033]),
array([28.420017]),
array([41.765394,38.737803,43.380583,46.456888,41.351792,28.56748]),
array([53.026566]),
array([32.422831,32.580433]),
array([49.381712])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'omnivore_EOT_gen_occ_SALMA_kept_1',  'omnivore_EOT_gen_occ_SALMA_kept_2',  'omnivore_EOT_gen_occ_SALMA_kept_3',  'omnivore_EOT_gen_occ_SALMA_kept_4',  'omnivore_EOT_gen_occ_SALMA_kept_5',  'omnivore_EOT_gen_occ_SALMA_kept_6',  'omnivore_EOT_gen_occ_SALMA_kept_7',  'omnivore_EOT_gen_occ_SALMA_kept_8',  'omnivore_EOT_gen_occ_SALMA_kept_9',  'omnivore_EOT_gen_occ_SALMA_kept_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['?_Eocoleophorus','Acdestodon','Acdestoides','Amphidolops','Antawallathentes','Apeirodon','Austropediomys','Bardalestes','Bergqvistherium','Bobbschaefferia','Bonapartherium','Branisella','Canaanimico','Canchadelphys','Carlothentes','Caroloameghinia','Carolocoutoia','Carolopaulacoutoia','Chulpasia','Clypeotherium','Coloradolops','Coona','Derorhynchus','Didelphopsis','Diogenesia','Epidolops','Epiklohnia','Eudolops','Evolestes','Fieratherium','Gashternia','Gaylordia','Glyptatelus','Guggenheimia','Hondonadia','Hypodolops','Incadolops','Itaboraidelphys','Kiruwamaq','Klohnia','Kramadolops','Lomaphorelus','Marmosopsis','Minusculodelphis','Monodelphopsis','Palaeopeltis','Palaeothentes','Palangania','Parabderites','Pauladelphys','Peltephilus','Peradectes','Periakros','Periprotodidelphis','Perupithecus','Polydolops','Praedens','Prepidolops','Proargyrolagus','Procaroloameghinia','Proeocoleophorus','Protodidelphis','Prozaedyus','Pseudolops','Punadolops','Reigia','Riolestes','Ronwolffia','Rosendolops','Rumiodon','Saltatherium','Sasawatsu','Sillustania','Similhapalops','Stenotatus','tegotherium','Trelewthentes','Ucayalipithecus','Vassallia','Wamradolops','Woodburnodon','Yuruatherium','Zeusdelphys']
def get_taxa_names(): return taxa_names