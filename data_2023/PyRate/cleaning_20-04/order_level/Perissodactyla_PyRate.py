#!/usr/bin/env python
from numpy import * 


data_1=[array([0.287934,0.029603,0.026929,0.069408,0.732844,0.400863,0.026414,0.104103,0.137974,0.19408,0.05562,0.09418,0.730132,1.791281,0.423601,0.056685,0.803839,0.014341,0.618084,0.209692,0.0379,2.265524,1.659114,0.019127,0.153679,0.916645,1.298173,0.27452,0.063037,0.118917,0.279651,0.019567,0.202439,0.143166,0.095771,0.363449,0.099363,0.067019,0.052181,0.018497,0.940909,0.917539,0.832656,1.987063,2.383844,0.84676,1.209414,2.207934,2.169939,2.019518,2.090526,0.490382,0.775471,0.138325,1.298116,0.824471,2.492214,0.104427,0.084461,0.01816,0.05352,1.715423,0.165599,0.001565,0.140025,0.113704,0.153378,0.021727,0.021663,0.011808,0.063155,0.232331,0.173691,0.242489,0.294338,0.068289,0.005676,0.02262,0.121803,0.176421,0.113223,0.060888,0.043039,0.269875,0.123229,0.110187,0.13725,0.037059,1.503809,0.111919,0.021342,0]),
array([0.028221,2.106449,2.002151,2.100962,0.838549,0.247727,0.037228,0.02196,0.627267,0.251264,1.660285,1.881314,2.520461,0.056427,0.978439,0.102038,0.073994,0.033978,0.073583,0.102492,0.06398,0.082714,0.089305,0.115876,0.069723,0.064963,0.002808,0.124105,0.091539,0.048816,0.249935,0.0856,0.058449,0.092318,2.764916,1.943193,1.437507,1.304922,0.11006,0.030975,0.003183,0.109148,0.213432,1.682599,0.028227,0.062831,0.089328,0.154603,0.030725,0.02556,0.04115,0.049998,0.0024,0.11488,0.082401,0.107482,0.1201,1.481358,0.984728,2.618559,1.125589,1.205307,0.013363,2.856585,0.015843,2.088568,0.322048,0.897063,0.283444,0.010278,0.075582,0.068548,0.096005,0.120114,0.036142,0.076921,0.062226,0.074774,0.124306,0.09348,0.077373,0.022115,0.070958,0.075744,0.024079,0.101715]),
array([2.529056,0.164865,0.080369,2.09264,1.775571,0.083323,0.051015,0.068196,1.853496,0.118038,0.097524,0.034511,0.011657,0.009452,0.954135,0.00461,0.807122,0.018312,0.120391,1.154499,0.008684,0.835077,0.003608,0.006182,0.003654,0.036301,0.023224,1.743207,0.084714,0.036542,0.121963,0.073566,0.036444,1.209706,0.119943,0.024318,2.426209,0.016332,0.012272,0.008645,0])
]


data_2=[array([0.069697,0.033249,0.030897,0.111093,0.296187,1.774119,0.075048,0.024897,0.20966,0.076822,0.087831,0.107304,2.573675,1.133675,0.71682,0.268496,1.136729,0.042537,0.80279,0.266141,0.189576,1.875362,0.233133,0.107792,0.176482,0.887577,0.407109,0.128729,0.052602,0.020322,0.199771,0.023882,0.281907,0.201089,0.0137,1.850087,0.083704,0.083829,0.115678,0.087388,0.903346,1.257622,1.307277,0.550449,2.060367,1.247917,0.132885,0.497881,2.536814,0.802104,1.82249,2.55641,2.364529,0.54372,0.920974,0.899616,1.046999,0.048974,0.096482,0.088471,0.098658,0.838498,0.08375,0.011174,0.093149,0.242861,0.118178,0.082641,0.107645,0.094778,0.021531,2.400933,0.142889,0.183028,0.256158,0.075597,0.032816,0.065287,0.167512,0.126949,0.027793,0.215037,0.036556,0.119759,0.055481,0.08069,0.180287,0.104218,1.124312,0.041829,0.025132,0]),
array([0.037012,1.775597,2.233394,1.442389,0.842385,0.535148,0.121869,0.028869,0.131681,0.853587,1.968868,1.74352,1.367733,0.111432,0.792771,0.040684,0.111208,0.04865,0.083213,0.014292,0.121285,0.063486,0.125525,0.109061,0.112304,0.096542,0.007339,0.062377,0.33323,0.068257,0.300221,0.086512,0.109464,0.013015,2.885043,1.328893,1.465959,1.372067,0.084404,0.067347,0.010746,0.010327,0.100249,1.64063,0.104849,0.027424,0.091527,0.237428,0.072541,0.049916,0.11082,0.041996,0.002009,0.084211,0.082728,0.120198,0.090481,2.504256,0.802811,2.848057,0.901919,1.39568,0.013201,3.223167,0.034749,1.069907,0.327941,0.940241,0.236106,0.0105,0.24764,0.022803,0.041244,0.117259,0.110235,0.068874,0.095659,0.060474,0.107597,0.016904,0.105069,0.044523,0.120876,0.01585,0.02237,0.044832]),
array([2.443773,0.271754,0.093584,1.729318,0.901897,0.058961,0.185493,0.036194,1.779864,0.043369,0.012934,0.12153,0.099858,0.005188,2.396926,0.010828,2.216405,0.015955,0.118862,0.935869,0.041824,0.994936,0.001557,0.00929,0.003103,0.163252,0.066154,0.802179,0.072422,0.12252,0.116418,0.094265,0.092927,2.214924,0.123092,0.03425,0.126271,0.019036,0.012976,0.004279,0])
]


data_3=[array([0.131121,0.044208,0.03626,0.066176,0.278907,1.270748,0.044099,0.07955,0.180287,0.208911,0.153358,0.053431,1.522274,2.07276,1.856859,0.103176,1.081232,0.093891,0.551758,0.109901,0.230177,0.947194,0.239468,0.012476,0.17495,0.311372,0.631051,0.193983,0.064868,0.082319,0.023523,0.05346,0.178794,0.022733,0.095707,0.685434,0.047956,0.065815,0.101999,0.097314,0.900682,2.281486,0.800626,0.344681,1.499427,0.564911,1.580436,0.483501,1.407742,0.656351,2.423811,1.436175,1.681572,2.296034,2.175371,0.856686,2.525008,0.09065,0.043193,0.018586,0.088423,0.913746,0.164787,0.009993,0.203285,0.091962,0.158354,0.149916,0.0264,0.048738,0.073722,2.335615,0.175363,0.176288,0.204181,0.099268,0.030094,0.02441,0.127412,0.189872,0.239987,0.185691,0.077723,0.115443,0.010783,0.123308,0.127487,0.083306,0.445873,0.111245,0.088657,0]),
array([0.05297,1.427631,0.476989,2.064679,0.937447,0.416845,0.028189,0.033121,0.294173,2.475015,0.167863,0.998917,2.524039,0.01559,0.797303,0.050226,0.036427,0.080422,0.056223,0.041312,0.073238,0.094957,0.092385,0.008765,0.073387,0.081133,0.006331,0.103742,2.097011,0.099188,0.115369,0.053683,0.02028,0.10866,1.623835,0.651371,1.226017,0.674103,0.119053,0.092531,0.005699,0.040145,0.242137,0.570395,0.109167,0.042965,0.08137,0.09092,0.030941,0.105314,0.014835,0.095607,0.0023,0.051463,0.043986,0.03825,0.116397,1.569936,0.992215,2.859172,0.90673,2.413321,0.013821,3.026743,0.092332,0.640664,0.363963,0.994719,0.269698,0.011252,0.26735,0.091578,0.017372,0.121993,0.038163,0.081833,0.077756,0.051797,0.092491,0.074281,0.122724,0.013516,0.113234,0.041427,0.098843,0.012032]),
array([0.791834,0.092989,0.065995,1.357487,0.614939,0.038771,0.247025,0.073966,1.273916,0.092535,0.10424,0.115382,0.019997,0.000558,0.582435,0.00678,1.543934,0.039878,0.12087,0.847546,0.01703,0.915219,0.001301,0.003298,0.005099,0.01445,0.183461,1.538728,0.075822,0.093355,0.121008,0.052154,0.02512,1.684402,0.123629,0.016448,1.783321,0.014797,0.012714,0.003295,0])
]


data_4=[array([0.245987,0.064714,0.013391,0.030751,0.214965,2.347018,0.076907,0.090756,0.096316,0.099418,0.183558,0.080546,1.97417,1.817973,0.122098,0.235135,0.970045,0.039978,0.840922,0.221469,0.080617,1.815107,1.465842,0.090295,0.170216,0.081029,0.896238,0.282209,0.081042,0.086495,0.022134,0.159902,0.059498,0.11842,0.028077,2.515801,0.040973,0.057302,0.072966,0.103317,0.955026,2.505926,2.199302,1.058709,0.042971,0.08936,1.910556,0.875394,2.353537,2.200983,0.90965,0.774369,1.305811,1.812546,0.42475,0.836744,2.337296,0.089303,0.125638,0.095674,0.116302,2.346078,0.178628,0.00495,0.193024,0.230628,0.132104,0.224594,0.067592,0.077927,0.077717,1.985557,0.1764,0.130097,0.171639,0.046166,0.011678,0.120838,0.254452,0.275939,0.140356,0.239247,0.112381,0.035559,0.051531,0.100956,0.034291,0.032167,0.334614,0.061729,0.041429,0]),
array([0.060083,1.047189,2.163457,0.209668,0.946768,0.623742,0.067024,0.084484,0.762108,0.848245,0.845572,2.301002,1.584397,0.071257,1.13944,0.08431,0.044085,0.070176,0.117372,0.104926,0.121753,0.096077,0.109736,0.083773,0.085298,0.124352,0.002028,0.070993,1.559547,0.120082,0.179956,0.016496,0.123097,0.035357,1.037746,1.669603,1.328719,1.035152,0.017977,0.104102,0.003635,0.027791,0.047414,1.766011,0.055221,0.103916,0.101161,0.186791,0.121731,0.116599,0.095468,0.123885,0.009967,0.108284,0.107602,0.099393,0.034738,2.365437,0.995087,2.697921,1.091909,2.334497,0.014918,3.146025,0.026523,2.53985,0.394596,0.822106,0.240679,0.010365,0.097889,0.044623,0.062535,0.118067,0.084413,0.072154,0.07962,0.047617,0.028583,0.109352,0.125636,0.048948,0.107521,0.012904,0.028874,0.059286]),
array([2.426407,0.231517,0.017424,0.3079,1.919498,0.090795,0.257402,0.020248,1.208659,0.08073,0.069327,0.068578,0.082773,8.2e-05,2.066153,0.006454,2.117389,0.084982,0.116483,1.173716,0.089005,0.817818,0.010738,0.009458,0.007125,0.168431,0.080017,2.474909,0.215583,0.074858,0.119107,0.096103,0.03344,1.318516,0.116938,0.035873,1.997772,0.018031,0.012126,0.010178,0])
]


data_5=[array([0.16868,0.056928,0.042101,0.04447,0.399673,2.083603,0.097285,0.092761,0.186081,0.091702,0.172693,0.086061,0.458407,0.409738,0.036044,0.018911,1.100633,0.016059,0.489757,0.186851,0.04655,0.08438,2.561608,0.095583,0.025281,0.306853,0.698785,0.202466,0.086508,0.059626,0.048921,0.024744,0.251181,0.073929,0.066494,0.320555,0.072743,0.012773,0.119509,0.027474,0.882507,0.026055,1.843765,1.960364,0.409908,1.631545,0.743371,0.468759,2.352281,2.494276,1.98093,2.393052,0.681551,2.470086,2.106163,0.843669,2.185939,0.108922,0.035015,0.09256,0.042345,1.56721,0.125352,0.010419,0.031226,0.232764,0.030576,0.135481,0.111627,0.068057,0.040838,0.28303,0.246903,0.040551,0.103544,0.050161,0.017716,0.108033,0.133541,0.281335,0.264293,0.293026,0.066642,0.248133,0.111286,0.056218,0.144661,0.079201,2.534274,0.115892,0.02495,0]),
array([0.056031,1.954843,1.636924,2.53633,0.799494,0.374344,0.085864,0.046584,0.17502,1.976918,2.556382,1.495526,2.26932,0.01683,0.887677,0.100616,0.07461,0.012617,0.109529,0.107729,0.053125,0.050317,0.041789,0.125954,0.087746,0.119793,0.005047,0.029741,0.70001,0.060486,0.395688,0.121055,0.031606,0.016679,2.859834,1.377997,1.067139,0.074939,0.098115,0.080773,0.004358,0.066445,0.079125,2.287213,0.018822,0.054498,0.024748,0.123892,0.101319,0.08074,0.023556,0.092202,0.003158,0.053497,0.11812,0.042191,0.015369,2.484939,0.861345,2.614108,1.130612,1.037418,0.014945,3.118264,0.014664,0.176347,0.330801,1.040155,0.027557,0.010669,0.087115,0.066633,0.012097,0.119422,0.094348,0.066674,0.091718,0.076326,0.105076,0.07222,0.099829,0.03761,0.039462,0.079091,0.108459,0.038739]),
array([1.256735,0.026604,0.041494,1.2354,1.662354,0.049481,0.15104,0.016926,2.900141,0.038795,0.094988,0.04977,0.070132,0.003583,2.244557,0.001039,2.020251,0.016652,0.116431,1.196085,0.037649,0.990721,0.000277,0.010488,0.005118,0.017157,0.036597,2.15259,0.027092,0.086938,0.119644,0.031653,0.076061,1.692416,0.118113,0.034985,1.675831,0.015521,0.01206,0.004496,0])
]


data_6=[array([0.093349,0.033047,0.116551,0.087941,0.765907,0.268857,0.094289,0.117987,0.130675,0.257317,0.137186,0.019045,1.334486,1.254116,1.007486,0.100252,1.169169,0.096929,0.660406,0.111187,0.196996,1.207283,1.352997,0.06534,0.200282,2.192245,1.233265,0.259595,0.039841,0.011885,0.105322,0.291491,0.055979,0.278351,0.089866,0.121067,0.062247,0.105605,0.038652,0.083644,0.932048,2.252138,0.672381,0.675038,0.514517,2.137787,2.132775,2.076596,2.567907,1.602226,1.750438,0.361614,1.544632,1.816257,0.920989,0.988577,0.846115,0.08168,0.120976,0.026152,0.045992,0.919661,0.242046,0.007669,0.092467,0.032682,0.107456,0.03267,0.07322,0.093204,0.096177,2.263323,0.102397,0.014764,0.232639,0.026529,0.0303,0.106625,0.084605,0.191726,0.230602,0.105648,0.122168,0.274116,0.028617,0.123747,0.224935,0.084721,1.278607,0.072594,0.117605,0]),
array([0.08085,1.119503,1.104126,0.073723,0.978415,0.651,0.112922,0.080821,0.644352,1.404446,1.953485,1.055426,1.059879,0.05189,0.981168,0.10868,0.094445,0.051875,0.02872,0.028984,0.040119,0.060185,0.056196,0.01271,0.017993,0.031022,0.005974,0.117246,1.651007,0.048953,0.758072,0.053418,0.026316,0.017968,1.586163,2.039807,0.233262,2.519304,0.082563,0.063716,0.008666,0.11797,0.1136,1.075216,0.081163,0.046099,0.120926,0.226137,0.125656,0.08499,0.069018,0.02777,0.009175,0.029914,0.095125,0.061251,0.082113,0.921122,0.866602,2.845154,1.120522,2.1253,0.012932,3.13707,0.03031,0.444566,0.325143,0.82736,0.04787,0.010872,0.117672,0.055145,0.10756,0.124491,0.071742,0.068868,0.078695,0.091567,0.040572,0.099533,0.124116,0.125523,0.022401,0.068448,0.111258,0.019259]),
array([1.540926,0.129745,0.093336,2.479098,0.708554,0.019607,0.22753,0.017001,0.937914,0.032545,0.115984,0.012358,0.085445,0.008779,0.475389,0.002688,2.101996,0.041301,0.101549,1.178454,0.011402,1.008213,0.010831,0.002557,0.001754,0.154106,0.148305,1.68374,0.0382,0.085388,0.125421,0.121595,0.043757,0.113029,0.117622,0.018506,0.517178,0.018597,0.012706,0.009305,0])
]


data_7=[array([0.143344,0.021149,0.032275,0.077372,0.533523,0.434727,0.058334,0.108936,0.11251,0.112345,0.068543,0.119333,0.422486,2.10408,0.559815,0.017661,1.187756,0.071363,0.117805,0.086361,0.271723,0.180469,2.038489,0.023106,0.292907,2.021552,2.503553,0.035719,0.117641,0.012587,0.158797,0.06334,0.042248,0.195504,0.123975,1.558688,0.041354,0.124512,0.100592,0.074961,0.971157,1.669343,1.455566,1.441171,0.430837,2.481344,2.447939,0.715819,2.058522,2.064769,2.249422,0.144313,0.74154,0.164518,2.269562,0.86639,1.287753,0.103355,0.073196,0.11476,0.064752,2.506956,0.073764,0.006016,0.152798,0.127866,0.178383,0.024327,0.047401,0.057377,0.099567,2.104877,0.126768,0.086014,0.023957,0.028375,0.082145,0.030965,0.24074,0.036652,0.06668,0.08382,0.040592,0.166901,0.060938,0.01387,0.220634,0.103615,1.763477,0.098439,0.06328,0]),
array([0.073912,0.938212,0.820874,0.560737,0.980028,0.344067,0.093925,0.089616,0.282948,2.163745,0.011815,1.646882,1.99083,0.121181,0.987665,0.044368,0.111071,0.023279,0.093001,0.10669,0.013224,0.087151,0.025015,0.074338,0.094407,0.036516,0.001553,0.036175,1.407371,0.100173,0.141051,0.019258,0.0823,0.042621,2.527844,2.353471,1.725569,1.493987,0.014163,0.038752,0.003838,0.05907,0.113238,2.277333,0.016314,0.032505,0.081184,0.149282,0.05396,0.069207,0.07542,0.036032,0.011533,0.118027,0.101237,0.038807,0.104706,1.431714,0.860324,2.790884,0.983735,1.490451,0.014959,2.951489,0.046033,1.92572,0.358183,0.853147,0.103354,0.010818,0.012188,0.015147,0.031405,0.124124,0.036222,0.090174,0.077063,0.094738,0.087564,0.073215,0.036533,0.059367,0.059459,0.102898,0.115078,0.109301]),
array([0.974726,0.076753,0.050332,1.07271,0.72881,0.068834,0.166972,0.08973,3.286544,0.034644,0.080632,0.104099,0.043922,0.001443,0.272832,0.007518,1.65989,0.065346,0.11437,1.142818,0.070657,0.818148,0.006869,0.010281,0.006774,0.045988,0.180806,0.255504,0.295242,0.027616,0.116397,0.045223,0.065723,1.814927,0.121908,0.039614,1.261806,0.016777,0.012337,0.004408,0])
]


data_8=[array([0.265671,0.103113,0.039643,0.120367,0.376592,1.188797,0.097821,0.111986,0.163029,0.065323,0.014771,0.061162,0.624584,0.66751,1.479949,0.180157,0.907292,0.094281,0.155658,0.241321,0.01224,2.368125,1.536142,0.015647,0.276546,2.504321,0.763488,0.083612,0.070959,0.030289,0.083362,0.234326,0.291661,0.070234,0.071099,0.367768,0.068677,0.107224,0.044629,0.033617,0.976988,1.503646,1.851702,1.358277,2.199111,0.855963,1.061606,0.24402,0.736806,2.155061,0.680857,1.008092,1.149118,0.1505,0.49764,0.858409,2.195816,0.102161,0.018432,0.047974,0.109958,1.889856,0.22405,0.001654,0.273268,0.055017,0.165858,0.19909,0.038347,0.106154,0.072016,2.058052,0.276945,0.107065,0.295474,0.035425,0.000157,0.076051,0.215684,0.040571,0.107356,0.237843,0.08588,0.094261,0.075908,0.061281,0.266233,0.026067,2.478767,0.047554,0.124444,0]),
array([0.113418,1.386108,0.357194,1.078239,0.799115,0.617874,0.098542,0.114759,0.217043,0.182704,1.604349,1.220001,1.089773,0.07215,0.871853,0.076645,0.044061,0.028629,0.093068,0.121068,0.022583,0.104338,0.113489,0.10118,0.026326,0.090525,0.005734,0.030174,0.279997,0.074574,0.390607,0.042723,0.077438,0.016768,1.15198,0.919862,0.332146,0.993395,0.04926,0.063984,0.010233,0.068173,0.043324,0.163883,0.04283,0.071999,0.071335,0.192531,0.121603,0.124772,0.028211,0.1248,0.011083,0.046751,0.049319,0.043964,0.022085,1.416958,0.88704,2.757001,0.969724,2.262892,0.012985,3.385788,0.116847,1.240398,0.389959,0.890389,0.024134,0.011188,0.27012,0.097372,0.061008,0.121609,0.05309,0.09663,0.096038,0.109882,0.119853,0.013895,0.07411,0.036572,0.11457,0.028153,0.112726,0.113899]),
array([2.38266,0.069263,0.073226,1.806832,2.46409,0.123189,0.250042,0.081735,1.794462,0.03489,0.096371,0.028321,0.098563,0.00581,1.37898,0.003699,2.538872,0.107584,0.109087,0.794673,0.074339,0.903052,0.010742,0.002626,0.006828,0.089262,0.038924,0.817547,0.278873,0.110914,0.119244,0.120852,0.096108,2.014276,0.124289,0.037002,2.298495,0.014532,0.012061,0.009109,0])
]


data_9=[array([0.231224,0.082896,0.059843,0.094541,0.918546,2.292024,0.018995,0.040794,0.273769,0.216387,0.209847,0.07926,0.771214,0.594641,0.260137,0.114318,0.811071,0.07442,0.519252,0.105891,0.174942,2.236811,0.879664,0.125125,0.087174,0.015295,0.431538,0.257677,0.025875,0.045306,0.162711,0.252844,0.071879,0.192047,0.08253,1.012197,0.096215,0.087898,0.076284,0.065018,0.853518,1.146061,1.434994,1.056739,0.128831,0.802407,1.229547,1.398229,1.334444,0.744563,0.03128,2.248894,2.492202,1.097275,0.575617,0.95661,0.877175,0.053981,0.087113,0.039173,0.114754,1.982949,0.168161,0.010121,0.205004,0.15378,0.121074,0.126257,0.104183,0.096309,0.031283,2.253079,0.229708,0.215484,0.254251,0.108885,0.061997,0.019122,0.035599,0.196442,0.290956,0.147489,0.092462,0.120592,0.122806,0.021652,0.189076,0.107554,0.843403,0.050784,0.078883,0]),
array([0.032991,0.407204,1.392031,1.649458,0.975556,0.361214,0.091344,0.03254,0.129254,1.45637,2.336506,2.461513,2.376181,0.065948,0.805698,0.104838,0.066145,0.044601,0.049584,0.072272,0.040827,0.021478,0.118757,0.029743,0.101336,0.034487,0.007013,0.051072,0.94227,0.062172,0.544891,0.07098,0.105472,0.10168,1.646754,2.183279,2.441195,1.921481,0.055888,0.101583,0.008987,0.003109,0.172656,0.502193,0.03463,0.111981,0.078695,0.149234,0.107813,0.022338,0.037785,0.024606,0.000887,0.082188,0.060136,0.016236,0.070581,1.679438,1.024555,2.742495,1.121637,1.415358,0.014928,3.099114,0.019408,2.533297,0.362294,0.832997,0.227871,0.010348,0.036905,0.07803,0.071018,0.116351,0.093898,0.072849,0.070144,0.081069,0.024391,0.085065,0.10166,0.035629,0.039474,0.04796,0.072651,0.065833]),
array([1.550635,0.207325,0.054134,0.320414,2.345697,0.051689,0.058485,0.045652,1.231811,0.047951,0.045558,0.031213,0.072752,1.9e-05,1.515174,0.009428,1.673622,0.013318,0.115939,0.978299,0.079253,1.006444,0.004764,0.003108,0.000701,0.179899,0.234119,0.947137,0.265846,0.054792,0.116777,0.068678,0.088892,1.702104,0.11927,0.021496,1.997329,0.012855,0.012016,0.005653,0])
]


data_10=[array([0.124998,0.03482,0.079047,0.052553,0.166363,0.875862,0.098488,0.036217,0.144767,0.27621,0.246003,0.027972,1.566114,1.415353,2.09638,0.033542,0.897076,0.030768,0.823023,0.194573,0.103818,0.35019,0.190018,0.124161,0.2675,0.111301,2.41103,0.206072,0.042121,0.03862,0.09097,0.285126,0.171613,0.113946,0.068092,1.384453,0.040783,0.078348,0.02682,0.116225,0.887406,2.554005,1.41621,1.087949,2.173596,2.366325,1.946504,1.689933,2.30901,0.836581,0.426606,1.763776,1.739649,1.776329,1.088449,0.96811,1.786184,0.065954,0.025798,0.11014,0.014361,2.539304,0.04625,0.000715,0.168605,0.17695,0.275732,0.264246,0.042758,0.037426,0.089991,0.14363,0.033303,0.114245,0.227679,0.018268,0.075395,0.04141,0.114444,0.288207,0.120204,0.112877,0.08291,0.129587,0.117164,0.09146,0.156037,0.039302,0.908484,0.063906,0.082709,0]),
array([0.046664,1.125193,0.732908,2.324505,0.924315,0.518139,0.03299,0.104874,0.644952,1.411387,0.088916,1.297845,2.377088,0.123265,0.874211,0.099127,0.073662,0.116466,0.109944,0.040976,0.110302,0.058043,0.104961,0.093906,0.050905,0.057207,0.00357,0.030024,1.746594,0.090833,0.334243,0.116768,0.084557,0.078394,0.909449,0.067439,2.333134,1.460651,0.113475,0.043398,0.003813,0.051366,0.031043,0.013218,0.072143,0.025358,0.051781,0.251516,0.114491,0.076707,0.022314,0.077637,0.00855,0.040683,0.022349,0.030793,0.06713,0.509975,0.799033,2.764801,1.017672,2.417354,0.012935,2.714045,0.06275,0.465007,0.382756,0.852091,0.299577,0.010652,0.08876,0.124261,0.090447,0.125022,0.093966,0.082037,0.096762,0.124665,0.097084,0.061276,0.121328,0.024596,0.088624,0.063618,0.037168,0.114513]),
array([2.348829,0.088596,0.05021,2.522437,1.60753,0.047467,0.12398,0.075014,1.652229,0.10882,0.097593,0.064729,0.095732,0.006274,0.308655,0.008214,2.257759,0.083667,0.123219,0.896059,0.057116,0.920793,0.006493,0.008968,0.011533,0.044582,0.075928,1.85308,0.153419,0.083252,0.121834,0.098499,0.062177,1.937977,0.120714,0.0371,1.690468,0.01833,0.0124,0.006916,0])
]

d=[ data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10]
names=[  'Perissodactyla_1',  'Perissodactyla_2',  'Perissodactyla_3',  'Perissodactyla_4',  'Perissodactyla_5',  'Perissodactyla_6',  'Perissodactyla_7',  'Perissodactyla_8',  'Perissodactyla_9',  'Perissodactyla_10',]
def get_data(i): return d[i]
def get_out_name(i): return  names[i]
taxa_names=['Equus','Hippidion','Tapirus']
def get_taxa_names(): return taxa_names