#!/usr/bin/env python
from numpy import * 


data_1=[array([27.82,24.504775,28.26716,23.133326,24.176656]),
array([31.059121,32.010052,51.605949]),
array([28.808078,30.739108,30.078134,39.956559,31.909924,31.649059]),
array([48.566853,51.044741,48.36536]),
array([33.600646]),
array([45.597088,48.630217,48.828315,43.164465,39.27083,39.984137,43.735739,42.680162,38.378851,40.939577,39.809985,49.497702,45.710269,40.659276,40.720759,49.474571,48.325197,48.281865,49.825558,40.81727]),
array([53.128046,53.368263,33.721614,25.639813]),
array([37.480622,49.43246,47.22007,49.260064,49.755759,41.040745,45.428295,38.97124,48.409678,49.105257,39.943989,40.390911,48.319926,54.241022]),
array([37.832353]),
array([44.146973,49.092588]),
array([42.708258]),
array([39.632267,38.852823,39.692919]),
array([33.539351]),
array([26.773151]),
array([51.907261]),
array([40.860501]),
array([29.295816,23.729654,46.499437,44.000257,23.86387,42.215679,44.367686,38.912524]),
array([44.917288]),
array([24.727916,39.407946,25.385046,27.811286,31.370312,23.476024,28.031234,30.040768,26.558023,27.313469,23.648696,23.75397,23.65481,26.482452,24.094137,23.938532,42.403629,33.552086,31.026909,31.992753,27.318933,33.58057,45.105415,31.150144,29.167783,30.892593]),
array([28.608508]),
array([53.671086,52.289052,54.249557]),
array([49.882822]),
array([39.842555,29.576676,29.812215,33.607378]),
array([46.419528,40.686889,43.648258,30.212546,30.271463,31.751038,27.27254,33.672558,38.906652,41.040365,46.131162,39.197772,38.72374]),
array([38.442011,41.162254,40.793595,38.751952]),
array([46.628076,37.791042,42.67701,35.057352,37.133925,36.150854]),
array([43.259319]),
array([31.684037,30.709483,24.605043,24.239452]),
array([38.464408,48.28805,39.343444]),
array([39.390724]),
array([45.156838,43.757739,50.302305,41.736933,40.865893,40.428506,41.445632,44.336005,48.359919,40.534381,43.015227,39.281717,41.127321]),
array([42.930628,40.468209,38.091994,46.214409,46.834197]),
array([48.183268]),
array([45.609381,38.001231]),
array([39.182575,46.476143,41.747271,46.522731,44.360813,37.857234,41.595225,41.418633,48.251676]),
array([43.835356]),
array([50.785492]),
array([47.541393,54.002225,49.373629]),
array([26.157745,25.523916]),
array([54.545449]),
array([43.140754,47.698445,40.185739,38.013483,40.307359]),
array([40.55925,45.215682]),
array([53.604891]),
array([41.764214,44.075667,41.237346,39.808384,44.40121,47.099837,54.297581,39.859111,41.119832,47.079845,39.055923,45.275581,37.899655,38.58933,43.5997,41.961919,41.674155,43.221014,41.111191]),
array([29.190228])
]


data_2=[array([27.82,25.677297,29.043213,27.327306,25.834557]),
array([30.607569,30.405465,54.634621]),
array([32.659257,29.147161,28.808817,42.63256,31.559668,28.639676]),
array([48.020815,49.680429,53.378782]),
array([34.518639]),
array([44.086083,49.62372,48.430824,45.53468,38.526831,40.272777,43.173949,44.079185,39.292745,39.806402,38.867463,49.781969,39.438371,38.908517,38.392475,49.841987,48.139457,48.683152,49.558874,39.395441]),
array([52.539629,47.903532,33.884916,26.649851]),
array([34.612347,53.893126,45.973534,48.167726,53.602886,39.133884,40.979128,39.499945,48.889889,48.592914,40.819053,39.094784,49.266752,51.836989]),
array([45.902238]),
array([45.482094,48.390528]),
array([43.218891]),
array([40.649061,39.896053,37.082154]),
array([37.25071]),
array([24.437326]),
array([48.699269]),
array([43.213237]),
array([31.177513,25.634995,45.420708,47.122854,25.571853,44.000338,41.970113,41.54626]),
array([47.38273]),
array([23.129099,41.851609,26.545327,26.12529,33.501709,24.391292,31.496646,30.543016,26.144345,23.281203,23.71388,24.471646,23.952081,26.419517,23.606328,25.570928,37.927098,28.433901,33.611609,28.957647,27.303087,33.531672,38.848583,29.781667,32.156617,30.491544]),
array([33.06136]),
array([52.005618,51.806952,55.866196]),
array([52.732006]),
array([28.093473,32.108808,33.318608,31.574859]),
array([45.842597,47.597318,47.79118,33.384647,30.373994,28.947245,25.78519,29.098352,41.331296,41.775611,41.380957,41.135945,46.674403]),
array([38.717405,44.376027,40.546089,39.222637]),
array([44.68524,45.085846,44.271938,34.328741,32.522555,35.953031]),
array([42.499354]),
array([31.989153,30.698373,27.249795,26.340301]),
array([40.802467,49.624444,40.47901]),
array([38.167233]),
array([45.674928,43.11946,53.566958,45.67282,44.494643,39.463428,38.893175,45.914837,55.523969,42.363805,42.293128,38.60849,41.904077]),
array([43.462335,44.362354,43.425746,40.772334,44.741128]),
array([49.356634]),
array([47.763169,40.864089]),
array([46.971502,45.023008,47.395555,39.487308,44.532517,50.234608,44.347926,46.630211,51.865637]),
array([45.711005]),
array([48.712058]),
array([47.093635,52.414429,51.138942]),
array([26.271056,27.573361]),
array([53.692738]),
array([43.804011,47.371458,44.63404,47.707866,42.186393]),
array([37.9658,39.545317]),
array([52.420674]),
array([38.982882,47.072754,40.862089,39.595551,45.588242,47.512626,51.602426,46.94089,48.383058,40.372311,38.383328,46.178974,38.15544,37.758761,44.145633,43.458778,41.361957,53.076779,43.595383]),
array([35.077264])
]


data_3=[array([27.82,27.624478,33.366697,26.702844,27.714849]),
array([32.34948,28.247468,49.009916]),
array([30.456937,29.18475,29.847785,40.912953,31.077199,31.749808]),
array([49.524727,51.390496,54.395124]),
array([33.829284]),
array([44.927663,48.827476,48.845906,39.995515,39.819727,40.441554,45.272928,46.148519,40.145447,39.092497,40.651501,48.132135,43.280337,38.136694,38.014592,49.452859,48.315755,49.500944,48.598362,40.013446]),
array([47.990443,47.118563,33.414489,24.840586]),
array([34.824066,54.586388,45.427455,48.837337,54.983504,38.998029,45.208404,40.33283,48.819031,49.853748,40.4039,38.78423,49.131813,50.147962]),
array([45.526028]),
array([45.304478,48.499944]),
array([46.927331]),
array([38.487281,36.823499,40.487291]),
array([29.102424]),
array([25.608279]),
array([54.348175]),
array([45.778862]),
array([32.009738,27.735801,46.981114,45.495623,24.242147,42.069246,45.628273,41.808441]),
array([39.107922]),
array([23.171019,44.382317,23.163818,27.578793,29.583342,25.219891,33.516995,29.511901,27.778658,25.124771,26.829394,23.112842,23.566645,24.286599,26.218911,32.424774,38.195905,28.585977,27.920781,31.674024,25.363728,29.782633,43.098055,29.408826,31.10158,32.507599]),
array([31.424874]),
array([51.21719,50.163671,48.749227]),
array([49.851801]),
array([28.529574,31.94951,29.573879,29.829426]),
array([37.894192,38.88601,38.412102,29.923009,30.733046,27.864849,26.229141,30.69007,47.012863,45.811501,45.322939,41.03929,43.532205]),
array([39.075237,42.705662,39.323836,38.541651]),
array([38.529261,46.565907,37.900054,34.149964,37.357557,29.537069]),
array([44.220489]),
array([28.125574,30.633819,23.827123,26.005266]),
array([40.597283,49.086273,39.214106]),
array([38.36107]),
array([40.334515,42.678498,55.190636,41.937014,44.551774,47.015176,50.550751,45.308375,47.817935,37.769322,45.516355,38.189988,45.057809]),
array([41.600632,37.71255,47.674912,45.916644,46.970756]),
array([49.484925]),
array([41.320906,43.971215]),
array([39.502689,40.334698,42.245592,43.862568,41.81162,50.384539,45.058614,39.603046,49.533069]),
array([39.143495]),
array([49.373703]),
array([47.413967,54.178566,51.065975]),
array([27.17239,23.585602]),
array([43.210925]),
array([47.587433,47.632087,42.627684,46.951847,47.067809]),
array([46.405405,47.689171]),
array([51.886724]),
array([45.618769,44.910176,38.032142,43.850227,45.372597,47.765383,52.162743,55.322816,42.517139,42.54315,44.063917,44.019251,47.122264,43.773592,37.795329,42.309784,40.088732,40.446896,40.385905]),
array([30.993063])
]


data_4=[array([27.82,24.142595,28.826911,25.809523,25.446076]),
array([33.332184,29.315707,55.384871]),
array([30.856401,33.139834,33.095328,39.742362,30.433564,33.802402]),
array([50.145405,50.354373,51.565808]),
array([33.720394]),
array([45.883875,49.633537,49.192529,45.224285,39.088999,38.7604,45.210981,45.107104,38.104925,39.6709,38.064882,49.128709,39.892911,38.137256,40.150353,48.579399,49.756715,48.961796,48.993579,39.469988]),
array([53.223978,47.81895,33.382985,23.782407]),
array([36.815235,49.092021,42.994232,48.269625,48.562733,38.121352,42.742569,40.202063,49.024824,48.554104,40.650105,38.071264,55.681512,55.574582]),
array([38.06586]),
array([45.89518,48.209542]),
array([45.507006]),
array([39.044085,40.425175,37.125753]),
array([31.813289]),
array([27.49852]),
array([53.702762]),
array([40.836423]),
array([27.975678,26.237216,44.864278,43.221209,24.567801,38.868957,43.446448,42.578526]),
array([45.689254]),
array([27.477676,42.705828,23.538306,26.337742,33.736455,26.858614,29.798771,31.441848,23.589287,27.65624,27.36081,25.212892,24.380782,23.851593,27.320699,30.025583,42.299079,29.412432,31.398188,32.404511,26.063923,32.807864,38.931234,32.680311,32.514055,33.888985]),
array([31.315005]),
array([49.611339,52.227707,53.472761]),
array([53.132949]),
array([37.186069,28.693498,32.180484,29.958814]),
array([42.989175,47.250121,42.343397,28.531299,32.130674,33.398774,24.245684,31.902462,45.042108,40.435402,39.184222,44.413666,39.526462]),
array([40.940511,44.001767,40.956261,38.565429]),
array([45.9232,44.259266,38.402256,36.629713,36.312263,29.441863]),
array([47.143741]),
array([33.782701,30.661573,23.14871,26.354423]),
array([40.20858,48.880502,41.13954]),
array([39.014676]),
array([46.895247,38.460466,54.299556,38.723256,37.979905,46.68571,48.616493,44.009042,43.244053,44.725911,40.895632,40.979871,44.218995]),
array([43.563641,39.784301,38.419309,47.053669,39.138958]),
array([48.449217]),
array([44.837886,46.960609]),
array([47.116914,49.924151,38.667927,38.403727,39.697504,41.921967,47.530157,45.08166,52.501894]),
array([46.232377]),
array([48.87171]),
array([47.311728,51.526483,54.427237]),
array([26.808808,23.858632]),
array([52.258482]),
array([43.905993,47.168214,38.493259,39.296744,42.793875]),
array([43.39721,44.945998]),
array([58.494976]),
array([45.746953,40.597628,42.399768,39.650359,41.134887,47.949837,46.667382,40.0461,39.633449,46.135998,37.856086,42.482565,38.377919,39.293337,45.092732,44.991179,46.922763,51.494923,47.164393]),
array([36.561951])
]


data_5=[array([27.82,27.617537,28.865788,27.549224,25.978538]),
array([28.487819,32.756072,48.166947]),
array([29.997365,30.086564,30.428113,40.635493,32.242756,28.894207]),
array([53.409427,51.069774,48.725956]),
array([34.996617]),
array([45.884908,49.60562,48.018857,39.550956,40.734931,39.34223,45.413922,42.940648,40.221304,41.123326,39.817631,48.93123,45.90349,40.051489,39.435797,49.525931,49.554276,48.799209,48.568076,38.121572]),
array([49.454993,55.584935,33.768614,23.236068]),
array([34.653846,54.656093,47.188243,49.323869,48.755312,38.9379,42.814249,38.891036,48.601152,49.168187,41.01575,38.153936,53.784436,47.945539]),
array([42.307938]),
array([43.128293,49.452625]),
array([47.293069]),
array([39.870006,37.096712,40.436273]),
array([31.247256]),
array([24.229536]),
array([49.458788]),
array([45.752159]),
array([27.891987,27.02363,46.638548,40.496991,29.435374,42.726298,46.521776,40.21889]),
array([46.60324]),
array([23.034978,39.79746,25.337411,25.738425,29.267222,27.154019,33.748364,28.143927,23.538815,24.736265,27.670471,27.810384,26.486357,25.842943,24.917077,33.550579,39.680162,28.745809,33.598158,28.678236,23.076258,31.010711,38.957641,30.410987,29.887339,30.939694]),
array([32.093371]),
array([51.229408,51.410234,53.45028]),
array([53.76029]),
array([28.561082,31.4948,30.031497,28.015742]),
array([45.971485,44.553252,38.168078,27.903609,30.975118,30.710691,25.98896,30.001987,43.921035,41.342282,45.450182,46.186479,40.020914]),
array([38.594867,44.536568,40.975884,40.49019]),
array([46.933405,44.658955,42.96808,37.157896,37.213518,36.650107]),
array([40.11783]),
array([30.001837,30.765515,23.159815,26.595032]),
array([41.125967,49.171544,40.765159]),
array([38.522556]),
array([45.714406,38.479245,38.483769,44.048336,38.891414,47.121433,50.878768,43.99106,42.332329,47.20159,44.647542,46.838445,44.008234]),
array([46.121696,40.291642,46.739944,46.208125,47.009606]),
array([48.168548]),
array([41.041888,40.338892]),
array([40.590373,51.141409,41.701326,41.897413,43.367536,55.867371,38.154415,46.994087,47.85815]),
array([45.84364]),
array([50.054795]),
array([47.462213,50.648522,48.804124]),
array([27.175447,25.093292]),
array([42.45811]),
array([43.268294,47.514617,45.310078,41.006103,46.8756]),
array([38.641046,39.037405]),
array([50.394448]),
array([44.50453,42.089068,43.502533,45.746793,45.451447,47.847808,54.489042,43.014441,47.500065,41.003151,40.865503,44.251045,45.726812,39.451511,40.419588,38.16416,43.804154,47.609072,42.049773]),
array([34.698613])
]


data_6=[array([27.82,26.301243,30.770756,24.260444,26.204747]),
array([30.967056,33.565412,52.217777]),
array([32.472878,33.234248,32.906022,40.660722,30.984285,32.15084]),
array([52.87395,52.801872,51.190976]),
array([34.478838]),
array([46.866787,49.091703,48.946675,41.120368,39.551196,39.025512,47.71807,45.056885,38.518201,39.811839,38.891609,48.005718,44.217772,38.710017,39.041645,49.784589,48.031949,49.581618,49.214985,40.13652]),
array([53.358688,41.833666,33.807036,23.736178]),
array([35.131305,51.950508,42.653287,48.464529,54.986794,40.094894,39.069626,39.883934,48.238598,49.901315,38.238101,39.801258,53.978429,50.515608]),
array([39.828356]),
array([42.647519,48.389329]),
array([43.789294]),
array([36.369289,41.052942,36.437815]),
array([32.703605]),
array([24.014139]),
array([49.150442]),
array([42.460953]),
array([33.729293,24.185367,46.283646,45.651722,30.426374,46.050284,46.554651,45.745811]),
array([37.833855]),
array([26.495192,42.152276,26.311346,23.603395,29.203087,26.990705,28.021949,30.601582,26.586937,24.726154,24.663575,23.110307,23.749276,27.227362,26.128491,29.784574,43.153149,32.358449,28.34533,29.835615,25.190361,29.75115,44.372576,33.605705,28.117751,33.787234]),
array([28.649507]),
array([49.818894,54.01323,52.556365]),
array([51.424686]),
array([34.949324,33.718105,28.644409,28.78723]),
array([41.204081,46.069491,41.332518,31.960961,33.693055,30.548447,23.395818,30.80217,42.164415,46.701846,44.95574,43.983226,45.682566]),
array([39.837696,41.07666,40.340589,38.974028]),
array([38.732281,41.642457,47.127804,37.10694,33.637684,34.2533]),
array([43.166494]),
array([31.059641,30.696421,23.078724,26.401213]),
array([40.261248,49.261681,39.463009]),
array([40.66349]),
array([38.277159,43.955281,53.993888,47.298045,41.463491,43.783606,48.027134,48.460206,51.798655,42.389366,46.646588,47.185631,40.599539]),
array([47.213113,39.863603,41.740739,47.332026,46.461403]),
array([48.914616]),
array([45.851748,45.616912]),
array([40.441818,39.781446,37.818538,43.316032,44.890481,45.286345,43.372957,40.663517,48.301811]),
array([43.518972]),
array([55.201851]),
array([47.024772,47.802898,54.143778]),
array([26.767471,25.504779]),
array([53.888033]),
array([42.5837,47.316236,41.108425,39.772934,41.595418]),
array([38.740484,38.988036]),
array([50.427062]),
array([45.189407,42.686667,40.219044,40.503065,47.306575,47.304008,37.757327,50.231713,41.310324,45.164648,47.667718,39.585073,47.76196,38.196616,43.314797,39.635153,46.412387,47.744373,41.167956]),
array([32.759696])
]


data_7=[array([27.82,24.251854,28.380844,26.395084,24.162148]),
array([30.976377,31.448954,48.551189]),
array([30.97301,31.211687,32.30142,43.943132,32.991829,32.460834]),
array([55.012024,54.194885,54.891524]),
array([34.474722]),
array([44.70218,48.203923,48.537027,46.928075,39.236987,39.999833,42.043467,41.382979,40.626315,40.89212,39.31099,49.247266,45.81855,39.199623,38.19638,48.213707,48.769237,49.109187,49.858124,39.322475]),
array([50.284209,41.40941,33.446349,24.18739]),
array([36.446218,48.12658,44.635339,49.534484,48.203266,38.711821,43.763585,39.239595,48.147471,48.986894,41.166167,39.482247,53.971566,51.91707]),
array([43.869255]),
array([45.886405,49.005555]),
array([47.207247]),
array([36.658997,38.010752,38.775111]),
array([35.03805]),
array([23.76177]),
array([49.896544]),
array([40.278208]),
array([29.562439,27.253594,39.270738,46.057414,33.13702,39.362005,47.033427,40.600992]),
array([47.400203]),
array([26.633318,44.697714,23.58237,26.085744,30.361476,25.839895,30.655019,28.098291,26.204734,23.655707,27.095289,27.575684,25.878322,23.810732,23.37129,31.668892,45.161999,32.614814,31.064939,32.459379,23.74801,28.673746,46.544021,31.709528,27.835029,32.182522]),
array([29.311341]),
array([50.623774,50.432652,55.955243]),
array([49.534203]),
array([44.40597,31.683535,30.972215,28.601402]),
array([42.095381,45.890725,39.115152,31.651124,32.632025,33.165273,24.742818,28.804411,47.55232,42.185587,41.110587,43.997802,40.707008]),
array([39.545578,40.324113,41.098888,39.186909]),
array([42.066307,44.061862,40.964325,35.419916,29.534613,35.605286]),
array([39.927088]),
array([28.247446,30.684066,25.350842,25.809614]),
array([39.011715,49.945251,38.272589]),
array([39.864703]),
array([38.170853,45.285308,39.252911,38.628775,42.181466,41.505357,51.85671,54.332748,52.933415,39.680909,45.63977,46.535129,44.138642]),
array([41.031414,39.720686,43.306098,40.910742,46.317628]),
array([49.887854]),
array([47.483959,39.054846]),
array([41.195768,40.469891,46.943795,43.897905,43.760569,48.485265,39.849703,46.250676,48.950971]),
array([41.600311]),
array([49.3044]),
array([47.936258,49.003543,52.360693]),
array([25.89242,24.358965]),
array([55.733684]),
array([43.18959,47.286788,38.474519,41.40618,39.08485]),
array([45.532511,39.842104]),
array([56.446102]),
array([43.161721,42.261533,47.42509,38.031582,47.267164,47.004159,53.899954,42.1701,38.743421,45.186988,40.679802,45.185292,39.792557,44.193164,42.563203,39.471141,46.82351,49.176592,41.803915]),
array([34.868123])
]


data_8=[array([27.82,23.672737,29.580835,24.758587,27.147341]),
array([29.659639,30.854721,54.873999]),
array([33.173316,33.705882,27.987689,40.703427,30.386591,30.606957]),
array([48.878848,52.550657,50.166355]),
array([34.202471]),
array([42.128245,48.883943,49.885486,39.521498,41.076722,40.92906,44.03429,42.450226,40.401404,40.688789,38.869496,48.09484,40.111898,39.525323,38.029208,48.806218,48.253839,48.663406,49.854991,39.600295]),
array([52.593624,48.412746,33.706451,26.944297]),
array([36.138195,51.212656,42.51225,48.359873,52.586534,39.39041,45.545051,40.711619,48.697067,49.610196,38.41582,38.397449,49.058181,53.655319]),
array([44.076394]),
array([44.969477,48.61354]),
array([42.758762]),
array([39.822949,36.645659,41.2069]),
array([33.224127]),
array([26.99914]),
array([51.147208]),
array([39.461619]),
array([31.233488,27.033906,44.769069,44.668453,32.957371,45.589949,41.717829,46.870601]),
array([41.505558]),
array([24.053293,46.583985,23.058073,25.77697,30.694511,24.794838,28.42122,29.879173,23.364872,24.726675,27.052042,27.503414,25.373045,23.233409,23.284826,25.66525,40.751845,29.111993,32.593872,33.395323,27.27723,31.341598,40.097679,33.576121,28.154085,30.013137]),
array([30.475275]),
array([51.449168,50.264285,53.177404]),
array([54.806154]),
array([35.365965,31.301462,31.040813,32.136825]),
array([47.477378,40.685603,41.411612,31.98315,28.907745,31.077053,23.071749,30.801093,40.922439,47.017892,41.859314,39.425483,38.875252]),
array([39.453448,45.261867,40.568772,39.368212]),
array([41.518557,40.489154,43.207045,37.004026,35.176826,28.597795]),
array([46.083169]),
array([33.034656,30.641367,27.641808,25.040764]),
array([40.131139,49.562252,39.480581]),
array([38.519153]),
array([41.161093,45.174129,41.135205,40.950764,43.721527,46.639029,41.316794,50.725109,52.488922,43.072652,44.325535,44.438423,39.698363]),
array([37.778818,38.829097,45.636664,40.759851,47.673233]),
array([49.689732]),
array([39.626868,43.193042]),
array([45.059269,44.340103,43.268772,44.999157,43.518495,51.866399,38.836338,46.784211,54.050334]),
array([39.409383]),
array([49.506682]),
array([47.381265,49.508153,48.607076]),
array([23.542055,26.016107]),
array([44.757902]),
array([42.047006,47.321118,46.280239,40.401219,44.463651]),
array([41.562047,41.236126]),
array([50.393395]),
array([46.178042,38.168668,44.625061,45.99206,47.254928,47.967522,39.959863,50.455462,53.006311,44.147443,43.14458,42.894757,39.561216,46.920155,42.005071,42.410141,44.336215,41.782563,43.884254]),
array([37.015585])
]


data_9=[array([27.82,27.642927,32.696081,26.485378,27.547937]),
array([30.227356,28.377042,52.518112]),
array([28.515547,27.957408,30.627068,45.203305,31.21351,33.090703]),
array([49.66211,51.423148,51.617123]),
array([34.356411]),
array([42.964867,49.343991,49.335354,46.971535,38.748991,39.639311,42.428225,44.936006,40.206253,38.498235,39.89666,49.299327,45.791071,39.162007,38.751359,48.56711,49.004413,48.404053,49.451479,38.699603]),
array([49.97814,50.850829,33.639293,24.329197]),
array([37.224368,53.07411,45.509844,48.292624,54.172026,41.087902,46.910462,38.794218,49.497889,49.019829,39.339947,38.7284,51.148519,48.818954]),
array([44.920312]),
array([43.487193,48.264868]),
array([45.538389]),
array([38.665354,41.106794,40.226118]),
array([29.369505]),
array([24.414699]),
array([53.497235]),
array([47.13618]),
array([32.575559,27.140942,43.955135,39.516233,24.22344,41.607421,38.414019,42.489137]),
array([42.581409]),
array([27.292731,46.079518,26.340163,27.575116,30.823538,25.192624,33.187887,32.724337,23.822273,24.902003,25.328912,23.31072,23.981189,25.303536,26.433567,26.250704,37.842011,29.901494,32.103289,31.825819,26.780228,29.774242,44.922527,30.010646,32.797952,29.336366]),
array([30.071877]),
array([50.206661,51.854298,53.735596]),
array([51.601864]),
array([45.115611,29.341551,29.892279,28.392036]),
array([38.545971,44.54973,42.193107,31.378903,31.740024,31.161487,27.274557,30.86246,41.028578,43.474949,43.620231,42.397959,45.555677]),
array([38.67504,41.309668,38.195577,38.882086]),
array([41.708182,46.08202,38.68763,36.951259,35.724369,30.868086]),
array([44.188102]),
array([33.882626,30.738545,25.467811,23.742904]),
array([38.712665,48.414681,38.721604]),
array([39.208673]),
array([40.936026,46.360186,54.05165,46.423148,39.731088,42.270115,42.918927,41.31122,46.858068,44.476079,44.690247,45.349799,38.086794]),
array([40.005682,46.024989,45.77413,39.270465,43.70466]),
array([49.791061]),
array([39.26463,45.78125]),
array([42.339309,37.853048,47.644372,42.025357,46.396615,53.274808,44.683552,43.929175,53.681096]),
array([44.355719]),
array([50.138537]),
array([47.317442,48.604396,52.178159]),
array([26.394702,23.918832]),
array([51.36285]),
array([44.276943,47.44277,44.724924,41.57119,46.245724]),
array([38.552248,38.85305]),
array([53.155192]),
array([44.115654,46.495416,47.444071,43.33043,39.939338,47.728519,49.179993,51.568419,53.684447,38.922039,40.602857,43.791275,40.717598,44.89652,46.87081,43.521507,42.750192,53.837529,39.961528]),
array([33.346352])
]


data_10=[array([27.82,24.230495,31.060735,26.32178,27.046614]),
array([32.744142,32.730941,47.832088]),
array([31.365264,30.248557,28.40447,46.277287,30.530199,29.634663]),
array([55.955461,54.901056,48.387949]),
array([34.31084]),
array([44.623119,49.806954,48.655765,39.261043,40.188197,40.906128,45.480077,43.031436,40.536879,39.10558,39.580647,49.040625,44.981188,38.013611,38.774517,48.134606,49.301509,48.360567,48.953309,38.065823]),
array([54.33574,53.372992,33.831405,27.710526]),
array([36.241776,51.427267,47.713885,48.553771,55.383451,38.364757,41.537556,40.266733,48.108524,49.304143,38.15368,39.518073,53.605305,52.765603]),
array([38.001259]),
array([45.600376,48.292532]),
array([43.024278]),
array([36.546306,40.596379,36.133522]),
array([34.765514]),
array([23.36038]),
array([50.559236]),
array([42.809394]),
array([32.426516,25.112262,45.905378,38.746554,30.714649,45.251095,44.405409,38.193316]),
array([44.877828]),
array([24.388361,45.334328,27.782292,24.923864,29.309931,27.613716,29.869651,28.877558,25.643566,23.628324,24.700178,24.644338,26.212688,27.797643,24.746082,30.537818,38.060939,30.152759,28.680812,29.098757,26.957148,28.13331,39.474942,31.166793,30.018116,30.821539]),
array([33.033971]),
array([50.075184,51.553019,48.096967]),
array([55.729768]),
array([37.989221,29.917793,32.215581,31.926964]),
array([45.525975,38.795903,39.400146,27.977846,30.24973,31.399472,25.050223,29.765492,45.171915,41.142784,45.384461,40.517975,45.682393]),
array([38.929222,47.235317,40.835802,40.744954]),
array([42.259765,44.873983,44.177443,36.005697,33.995653,35.044125]),
array([43.465455]),
array([30.012734,30.759955,26.729325,24.334567]),
array([40.94103,48.594731,40.86184]),
array([38.697302]),
array([46.318285,42.009033,49.892641,44.301223,46.804563,45.162044,37.899911,52.865435,52.317819,44.958625,39.58817,37.846315,38.447317]),
array([42.578826,42.243143,44.141296,42.379955,43.700703]),
array([48.382515]),
array([44.000492,42.403095]),
array([45.039382,42.329435,39.785223,46.12131,38.834251,47.63996,46.324789,47.290378,50.270926]),
array([40.277268]),
array([49.835217]),
array([47.585446,50.196655,51.961085]),
array([26.682798,26.494999]),
array([51.78291]),
array([41.436534,47.139812,47.246297,43.159908,39.702227]),
array([46.907106,46.627207]),
array([48.035179]),
array([39.857642,39.547614,46.647317,46.301453,38.162551,47.877799,40.421266,41.195427,48.826116,40.94754,44.51937,42.042292,44.169396,47.782924,38.30481,42.42088,44.224198,54.836443,39.270955]),
array([34.246133])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'insectivore_EOT_gen_occ_SALMA_smoothed_1',  'insectivore_EOT_gen_occ_SALMA_smoothed_2',  'insectivore_EOT_gen_occ_SALMA_smoothed_3',  'insectivore_EOT_gen_occ_SALMA_smoothed_4',  'insectivore_EOT_gen_occ_SALMA_smoothed_5',  'insectivore_EOT_gen_occ_SALMA_smoothed_6',  'insectivore_EOT_gen_occ_SALMA_smoothed_7',  'insectivore_EOT_gen_occ_SALMA_smoothed_8',  'insectivore_EOT_gen_occ_SALMA_smoothed_9',  'insectivore_EOT_gen_occ_SALMA_smoothed_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Archaeutatus','Astegotherium','Barrancatatus','Carodnia','Clenia','Didolodus','Eomicrobiotherium','Ernestokokenia','Eutrochodon','Florentinoameghinia','Greniodon','Groeberia','Kirutherium','Kuntinaru','Lamegoia','Lumbreratherium','Machlydotherium','Mazzoniphractus','Meteutatus','Microbiotherium','Mirandatherium','Palaeocladosictis','Parastegosimpsonia','Parutaetus','Paulogervaisia','Perulestes','Picunia','Pilchenia','Proectocion','Progarzonia','Prostegotherium','Pseudeutatus','Pseudhalmarhiphus','Pseudostegotherium','Pucatherium','Punatherium','Ricardocifellia','Riostegotherium','Salladolodus','Saltaodus','Stegosimpsonia','Trilobodon','Umayodus','Utaetus','Wirunodon']
def get_taxa_names(): return taxa_names