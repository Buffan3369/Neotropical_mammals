################################################################################
################## Plotting RTT and LTT for EOT occurrences ####################
################################################################################

library(ggplot2)
library(deeptime)
library(cowplot)
library(dplyr)

## Set Cenozoic epochs dataset for plotting facilities -------------------------
cnz_epochs <- deeptime::epochs[5:6, ]

##### EPOCH-LEVEL Q SHIFT #####
time <- c(-23.19677155, -23.53207465,-23.867377749999996,-24.20268085,-24.537983949999997,-24.873287050000002,-25.20859015,-25.543893249999996,-25.87919635,-26.214499449999998,-26.549802549999995,-26.88510565,-27.220408749999997,-27.55571185,-27.89101495,-28.226318049999996,-28.56162115,-28.896924249999998,-29.232227349999995,-29.56753045,-29.902833549999997,-30.23813665,-30.57343975,-30.908742849999996,-31.24404595,-31.579349049999998,-31.914652149999995,-32.24995525,-32.58525835,-32.920561449999994,-33.25586455,-33.591167649999996,-33.92647075,-34.26177385,-34.59707695,-34.93238005,-35.267683149999996,-35.60298625,-35.93828935,-36.273592449999995,-36.60889555,-36.94419865,-37.279501749999994,-37.61480485,-37.950107949999996,-38.28541104999999,-38.62071415,-38.95601725,-39.29132035,-39.62662345,-39.96192655,-40.29722965,-40.632532749999996,-40.96783585,-41.30313895,-41.638442049999995,-41.97374515,-42.30904825,-42.644351349999994,-42.97965445,-43.31495755,-43.65026064999999,-43.98556375,-44.32086685,-44.65616995,-44.991473049999996,-45.32677615,-45.66207925,-45.997382349999995,-46.33268545,-46.66798855,-47.003291649999994,-47.33859475,-47.67389785,-48.00920094999999,-48.34450405,-48.67980715,-49.01511025,-49.35041335,-49.68571645,-50.02101955,-50.356322649999996,-50.69162575,-51.02692885,-51.362231949999995,-51.69753505,-52.03283815,-52.368141249999994,-52.70344435,-53.03874745,-53.37405055,-53.70935365,-54.04465675,-54.37995985,-54.715262949999996,-55.05056605,-55.38586915,-55.72117225,-56.05647535,-56.39177845)
time <- abs(time)
  #Origination rate
sp_rate <- c(0.06847612389361388, 0.06853290218320782,0.06857854320003809,0.0687177760446482,0.06901706641562898,0.06998366121253022,0.07058956868587885,0.0706986585417604,0.07190064098586049,0.09969913939883038,0.3825854543803266,0.4366652314804419,0.4577343970917241,0.4878447529866985,0.49022856607960097,0.4543470335299088,0.1743284316445691,0.13818970348296894,0.13473943438235503,0.1345845627872846,0.1345156069133415,0.1345156069133415,0.13453758018591488,0.13455383688262595,0.13453758018591488,0.13452633825089616,0.1345156069133415,0.13456563458424148,0.13456243633787834,0.13456243633787834,0.13456563458424148,0.1345729933833919,0.1345845627872846,0.1345845627872846,0.13459317686015107,0.1345729933833919,0.1345845627872846,0.13460482013512418,0.1346154341149609,0.13461854731388118,0.13460482013512418,0.13456563458424148,0.13415611731137295,0.13384075753975083,0.133174816046998,0.13242770081823046,0.1317610256497878,0.13115557032404962,0.13048135461260288,0.1299839743346701,0.12985368465856922,0.12967710181841924,0.129595849482206,0.12951050728362953,0.1293735738209673,0.12925855021582816,0.1288728029803079,0.12837899969151761,0.12592225415620503,0.12423169005132804,0.12410062015201756,0.12396085760547146,0.12392216646553297,0.12395808916362416,0.12397302257837367,0.12408291033279303,0.12433633624958451,0.12459445919300222,0.12545559567960132,0.12665764984342648,0.13114930702683109,0.13277125938135537,0.1342694900737068,0.13509076021260236,0.13546232541709147,0.13568651145029426,0.13582799348983995,0.13585615402342685,0.13596046726117825,0.136064365012085,0.1362102281158211,0.13629173837048109,0.13642024768547412,0.13652598075140565,0.13662222232478832,0.1367573390699338,0.1368310716803643,0.13700811721922135,0.1373208154143496,0.1375331687020639,0.1378664071354761,0.13842970696995172,0.13881150859119107,0.13917368827911708,0.13936229669871286,0.1400664013503995,0.14392286258555,0.15980324791510925,1.2924853579154787,2.191761682421728)
sp_minHPD <- c(0.01696187499581104, 0.017192385811136145,0.017192385811136145,0.017192385811136145,0.017066256415473675,0.01696187499581104,0.01723934089791573,0.01696187499581104,0.00925718681356886,0.024424295942016144,0.026517048654179354,0.05252582530031485,0.06840559306513316,0.21906594579314387,0.27127663208401215,0.11263960165115683,0.10432550427408101,0.105513226720995,0.10681943669725856,0.10563869208986648,0.10943123752581632,0.11069939469208678,0.11036125353208394,0.11069939469208678,0.11016910145924225,0.11036125353208394,0.11016910145924225,0.11069939469208678,0.11069939469208678,0.11036125353208394,0.11036125353208394,0.11069939469208678,0.10943123752581632,0.10943123752581632,0.11069939469208678,0.11069939469208678,0.10943123752581632,0.10670700567192436,0.10572943368997506,0.10572943368997506,0.105513226720995,0.105513226720995,0.1064211324176953,0.10542928721159503,0.10054074470912748,0.07714200356695401,0.06943834875956648,0.06961214905792411,0.06632026179717286,0.062340589206798594,0.062340589206798594,0.062340589206798594,0.060707231333122745,0.060707231333122745,0.06080722787267023,0.05938874263021872,0.05886595967434699,0.049832446515263966,0.018227650735732914,0.010503227330264747,0.010503227330264747,0.010240819803191829,0.010240819803191829,0.009293424882721798,0.009293424882721798,0.009293424882721798,0.009293424882721798,0.009235783763944462,0.008724720191728553,0.0037367315807010845,0.05144331430038239,0.06414017054636358,0.08501763472774818,0.10092238031225234,0.10344224570807181,0.10417204175238129,0.10542928721159503,0.105513226720995,0.10542928721159503,0.10581068612255162,0.10581068612255162,0.1054551440439058,0.10608570843277826,0.10608570843277826,0.10581350747778817,0.105513226720995,0.1054551440439058,0.10615889593698871,0.1054551440439058,0.1054551440439058,0.10023634044676222,0.10366958943472426,0.09546451714994716,0.09900604836888696,0.09676964995847515,0.08812119353128448,0.08812119353128448,0.08812119353128448,0.10107792192616978,0.11386770421146619)
sp_maxHPD <- c(0.1267523292598287, 0.1267523292598287,0.1267523292598287,0.1267523292598287,0.12777953883810575,0.13029050401463269,0.1337432515625233,0.1357173495860273,0.15410577661871755,0.5123975613273396,0.6469261486750205,0.713978260289822,0.7459318287132654,0.8846962794619638,0.8512891281836867,0.7377290453091476,0.6393986717292546,0.46500272419167343,0.19002535342181373,0.18018074556170854,0.18250575032913466,0.18235173591596862,0.18150120470299883,0.18150120470299883,0.1809391200984809,0.1809391200984809,0.1809391200984809,0.18150120470299883,0.18165870084008603,0.18150120470299883,0.18165870084008603,0.1821325304902467,0.1809391200984809,0.1809391200984809,0.18235173591596862,0.18250575032913466,0.18250575032913466,0.1809391200984809,0.1809391200984809,0.18150120470299883,0.18150120470299883,0.18165870084008603,0.18467823079398216,0.18662209109613312,0.19086391246025922,0.1756917468943377,0.16697654428441075,0.16497865837050438,0.1610197822594138,0.15625665353962706,0.15620830425168705,0.15625665353962706,0.1549685232497697,0.1549685232497697,0.15625665353962706,0.15620830425168705,0.15950593715392306,0.15764112403830888,0.15323699928701057,0.1495239625632721,0.14967491401594865,0.14947411819998943,0.14967491401594865,0.14883771431927767,0.14887751744747393,0.1489698021802054,0.1495239625632721,0.15105475994889161,0.1538868038094971,0.15886243848490222,0.21158197833430234,0.20667066695591033,0.2133945715028764,0.21690733076676613,0.21379676114585403,0.2134711989265009,0.21370014841940232,0.2134711989265009,0.21228541131930526,0.2123991750701131,0.21244927234972907,0.21244927234972907,0.2134711989265009,0.21379676114585403,0.21379676114585403,0.21379676114585403,0.2142087970913019,0.21632209374171893,0.21772987278218334,0.22128213233141075,0.219574294984172,0.23155202534473973,0.23995653619662358,0.26479218720739645,0.2865984603694171,0.40444554306116465,1.1077105725472767,1.7076040156607246,3.9532357913581513,4.555435049649047)
sp_ribbon <- data.frame(time = time,
                        min = sp_minHPD,
                        max = sp_maxHPD)
  #Extinction rate
ex_rate <- c(4.639089514412941, 0.19172043080634882,0.18000776486563846,0.17948957393437065,0.17889802141630406,0.177381922276252,0.17701915873499033,0.1770755042517444,0.17723752577173918,0.17765725279225408,0.17822671310533875,0.18023000809782636,0.18302555218138444,0.184301958383643,0.1855030757555656,0.18595761811250777,0.18600684585357713,0.18581337031860878,0.18575647407467896,0.18558604830668712,0.18548760810565496,0.18547133950082473,0.1855030757555656,0.18543610409290087,0.18543385890974662,0.18543385890974662,0.18548760810565496,0.18555356381515709,0.18559687398471247,0.18580211485201864,0.18597299493815103,0.18625594353004965,0.18663532833455132,0.18706283019908915,0.18718109380726775,0.1872253220970001,0.18714953412245677,0.18719393762791653,0.18723429343841974,0.18723429343841974,0.18738422053841408,0.1874776420096657,0.18839607183244944,0.18896259961754308,0.1889567376655174,0.18613911204800565,0.16704466261839582,0.07432830631261725,0.07176577997093747,0.07097971753889837,0.07061546956708686,0.0705092955124938,0.07047958828041281,0.07048098258922798,0.07047728969819166,0.0705092955124938,0.07058045717437639,0.07062590460527385,0.07064635917828307,0.0707311153417943,0.0707748147509977,0.0708412824340886,0.07089248903141307,0.07104673998243552,0.07122837963286935,0.07147790032713663,0.07174884944879267,0.07199945506516756,0.07215627778606497,0.07221681589553816,0.07232251400626886,0.07239378006872826,0.0724861747144831,0.07252679946779819,0.0725487372438825,0.0725965792963933,0.0725965792963933,0.07264165269437997,0.07269234837582955,0.07269470214527737,0.07269777796469234,0.07271274765155632,0.07271678054113363,0.07271274765155632,0.07271678054113363,0.07271678054113363,0.07270250579034121,0.07264165269437997,0.07253700492907397,0.0724861747144831,0.072479507020906,0.07241123990687098,0.0723802776474464,0.07237221346930883,0.07237221346930883,0.07237221346930883,0.07237789812616688,0.0723802776474464,0.07238156677339805,0.07247850997751906)
ex_minHPD <- c(0.04259302225610466, 0.05669497340542536,0.00024644670969622127,0.00024644670969622127,0.0072872679174527935,0.027202422510577546,0.030671148711464806,0.030671148711464806,0.030758231421805622,0.035930485238446525,0.03642673881405525,0.05549214122054566,0.09323739893228263,0.13201582353617689,0.14274622279108554,0.1434461070699394,0.14568292210973258,0.14542331646479226,0.14590072817667216,0.1471308138603301,0.1471308138603301,0.14709104126789588,0.1482148798058258,0.1471308138603301,0.1471308138603301,0.14709104126789588,0.14867106638921243,0.14894058343161556,0.149484213456441,0.14996261220347637,0.15101683696934018,0.1509724637080998,0.1520265083037775,0.1509724637080998,0.1506293145044483,0.1506293145044483,0.1519477516738751,0.1509724637080998,0.1519477516738751,0.1509724637080998,0.149484213456441,0.14788421390490794,0.146895873765321,0.14581842868868938,0.14581842868868938,0.057006121526857856,0.0495957893799478,0.04168091404433366,0.03134339258769256,0.022553204605144116,0.03517602040726783,0.0382356866165411,0.04046511610371386,0.04056132808429231,0.04110302159723086,0.04278558079629327,0.04335019054711841,0.04417996572445776,0.04426572466681089,0.046043852876549066,0.046043852876549066,0.04615406093330073,0.046043852876549066,0.04623755476357,0.04743631797090535,0.04925931910722254,0.052006569846283796,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052062831536813514,0.052250237896340715,0.052250237896340715,0.0523879598435007,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.0523879598435007,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.052250237896340715,0.05244209437942353,0.05312745262681809,0.05324907831600392,0.052659008726579686,0.052250237896340715,0.052250237896340715,0.052062831536813514,0.052062831536813514,0.052495907932877256,0.05244209437942353,0.052250237896340715,0.04918706410682189)
ex_maxHPD <- c(76.7661814599657, 4.4156296032411975,0.40999612509477007,0.3137063535789505,0.22360719427969702,0.22238637407662354,0.22345450983411777,0.22303837890330214,0.2209168469873924,0.2229678393987799,0.22246503872917228,0.2237976879490289,0.22905473088527578,0.23261754842448232,0.22820244081350727,0.22729298441467205,0.22820244081350727,0.2247679236892135,0.2247679236892135,0.2247679236892135,0.2237976879490289,0.223845037337209,0.2247679236892135,0.22377216589914975,0.2237976879490289,0.2237976879490289,0.2247679236892135,0.2247584915413328,0.2247679236892135,0.2247679236892135,0.22608072657566686,0.22608072657566686,0.22744928983655607,0.22716319001556187,0.22754911555554755,0.22754911555554755,0.22804082656505628,0.22716319001556187,0.22804082656505628,0.22744928983655607,0.22716319001556187,0.22716319001556187,0.23985753991483819,0.264017716532307,0.2976736134128116,0.24948492371634134,0.22503576596651395,0.20610259360531227,0.1831818827510526,0.095545806351732,0.09368979866262156,0.09379951227036507,0.0944389129228623,0.09379951227036507,0.09379951227036507,0.09508480034523817,0.09464686922622327,0.09499418653603077,0.0944389129228623,0.09508480034523817,0.09464686922622327,0.09464686922622327,0.09379951227036507,0.09379951227036507,0.0944389129228623,0.09475752100024744,0.09589039610098475,0.09524777849710993,0.0948294937457502,0.0948294937457502,0.0944389129228623,0.0948294937457502,0.09510530039172747,0.09513683305967947,0.09510530039172747,0.09513683305967947,0.09513683305967947,0.09524777849710993,0.09589039610098475,0.09587409861390087,0.09603345137927108,0.0967550491570783,0.0967550491570783,0.09683960084706865,0.09683960084706865,0.09683960084706865,0.09693169515077737,0.09693169515077737,0.09742034712287675,0.0985677978522812,0.09878530908800601,0.0985677978522812,0.0985677978522812,0.09875417901375015,0.09878530908800601,0.09878530908800601,0.10030267589417106,0.10048217525650398,0.10110321064087599,0.10142128701223456)
ex_ribbon <- data.frame(time = time,
                        min = ex_minHPD,
                        max = ex_maxHPD)
  #Rates dataframe
rates <- data.frame(time = time,
                    sp_rate = sp_rate,
                    ex_rate = ex_rate)
  #Restrict rates and ribbons values < 1.4
rates$sp_rate[which(rates$sp_rate > 1.4)] <- 1.4
sp_ribbon$max[which(sp_ribbon$max > 1.4)] <- 1.4
rates$ex_rate[which(rates$ex_rate > 1.4)] <- 1.4
ex_ribbon$max[which(ex_ribbon$max > 1.4)] <- 1.4
  #Plot
sp_ex <- ggplot(data = rates, aes(x = time, y = sp_rate)) +
  scale_x_reverse(breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 56)) +
  scale_y_continuous(breaks = seq(from = 0, to = 1.4, by = 0.2),
                     limits = c(0, 1.5)) +
  geom_ribbon(data = sp_ribbon, aes(x = time, ymin = min, ymax = max),
              fill = "#4c4cec",
              alpha = 0.2) +
  geom_ribbon(data = ex_ribbon, aes(x = time, ymin = min, ymax = max),
              fill = "#e34a33",
              alpha = 0.2) +
  geom_line(aes(x = time, y = sp_rate),
            linewidth = 1, colour = "#4c4cec",) +
  geom_line(aes(x = time, y = ex_rate),
            linewidth = 1, colour = "#e34a33") +
  labs(x = "Time (Ma)",
       y = "Rate (event/lineage/Myr)") +
  theme(axis.title.x = element_text(size = 22),
        axis.title.y = element_text(size = 22),
        axis.text = element_text(size = 18),
        legend.text = element_text(size = 10),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(dat = cnz_epochs, abbrv = FALSE, size = 5)

  #Net Diversification Rate
net_rate <- c(-15.687417909589547, -0.9314074814639837,-0.11699948231635995,-0.11039294027106519,-0.10169804645935247,-0.08697504701013141,-0.08263806518717222,-0.08180933563175245,-0.07482681087296945,0.038376578724988224,0.16854095699915472,0.24339292350049338,0.2699933364642538,0.31959643988376324,0.31634579169873955,0.2530451018481053,0.10234000794294251,0.0033940413986220763,-0.04531780843580163,-0.04737603007021334,-0.046345488868840046,-0.04649525738554328,-0.04654083946070382,-0.04611471447129284,-0.04580786060687104,-0.04583585260681785,-0.04597195694265075,-0.046058435244284164,-0.04633636168504515,-0.046909290440243064,-0.04741937085278976,-0.04805410169597407,-0.048747286229535426,-0.05125735520187679,-0.05137044758079927,-0.05136311526247454,-0.0496629227999503,-0.04902295000738373,-0.048557312738530346,-0.04837547657883751,-0.048695940590974075,-0.049083703362078256,-0.05559023341293378,-0.06097959415036872,-0.06331469452262092,-0.0536480959578615,-0.009649996109781785,0.03282327515242895,0.04727494701473232,0.05160813545266407,0.05376748529676376,0.05404624457477872,0.054183700946284774,0.05399542045605782,0.05363704934408298,0.053087625757907965,0.051942621255504924,0.049803641724822705,0.04026579699990934,0.03392738882681822,0.033332542609158,0.032751140554845605,0.03241837837482681,0.0322497637978692,0.03178004462644364,0.03140783281589368,0.03132985784814787,0.03196794036378785,0.03450764865117376,0.03861823025019943,0.055215560526173955,0.06163208493087383,0.06734608040125206,0.06940727779878203,0.0704409304925373,0.07085969963174087,0.0710707639351886,0.07114233588703409,0.07109415772523595,0.07115457175364659,0.0713746463849221,0.07159390126448277,0.07222132934441572,0.07254151523316064,0.07287955428500398,0.07320936881922252,0.07368587635059475,0.0747304063443361,0.07609735239047456,0.07732918826699048,0.07850495337554564,0.0824391233377123,0.08742337975010601,0.09049709055307081,0.09442066024564502,0.11004783778470832,0.1911435751158248,0.35417420050781084,1.4567114407500825,2.2245186953464837)
net_minHPD <- c(-76.72135056713702, -4.342880056505673,-0.35859313058396974,-0.2504912024880534,-0.18189512826465956,-0.17179120755715224,-0.16772176878096823,-0.16785784950557903,-0.1744147851051165,-0.16147976851430748,-0.14634079863989718,-0.12804874438556396,-0.12350199342379667,0.009309930591908044,0.06466982801695542,-0.08797952401040393,-0.1026271445447939,-0.10911346170538105,-0.10462511250739889,-0.10275736048633226,-0.09318684307869737,-0.09287764859267955,-0.09981632471685561,-0.09981632471685561,-0.1026271445447939,-0.1026271445447939,-0.09981632471685561,-0.09733621561250494,-0.09705922882437656,-0.10085440032453064,-0.10085440032453064,-0.10145827623163228,-0.10275736048633226,-0.1040630812419521,-0.10516481491213206,-0.10516481491213206,-0.10516481491213206,-0.10303665391288766,-0.10721878775535118,-0.10670570148574873,-0.10762846160527126,-0.10935757487627874,-0.11673044253511847,-0.14575816188576027,-0.15991963217673738,-0.13812661701911044,-0.11673044253511847,-0.08185857438174611,-0.05799597737013579,-0.01874184022191676,-0.011165532551609167,-0.007609812256248447,-0.008631806919363855,-0.007609812256248447,-0.007609812256248447,-0.010811443713916014,-0.013427060663713845,-0.019261806398472872,-0.05865106607037335,-0.06459410580663745,-0.0661220334400335,-0.0660708792214858,-0.06640149252920291,-0.06459410580663745,-0.0640668775846652,-0.0640668775846652,-0.0640668775846652,-0.0640668775846652,-0.0640668775846652,-0.0640668775846652,-0.02406584636931968,-0.005512898643107694,0.006064920192594692,0.011680627534207316,0.01785028591494789,0.019380589089597264,0.01942982889716756,0.01895603920108381,0.019380589089597264,0.021761110188817906,0.022485539214588943,0.019380589089597264,0.0187413817856686,0.01785028591494789,0.018309037209458506,0.018113361101103315,0.018309037209458506,0.018113361101103315,0.02338635960065269,0.02325754228118554,0.02198746286490995,0.0187413817856686,0.00837906477387497,0.009669577004398008,0.005080807602997631,-0.0002203906541582007,-0.011200674211429673,-0.005064762612616708,0.009194290302308922,0.02581025946714567)
net_maxHPD <- c(0.0491133042573646, -0.000801244685167124,0.10050664661208468,0.11190190141519729,0.07945607031437696,0.050702220164317816,0.05137115209529344,0.053059962587655746,0.06601576215803479,0.3461539288629234,0.4936571538312108,0.5687317441328101,0.58260630662855,0.681971330855518,0.6740251485522316,0.565861334514298,0.5245117963558645,0.31078038671474295,0.0263368355724288,0.012531964816061003,0.017793851332992994,0.01698450994978254,0.0095663793439352,0.009321413499674858,0.007156309493208196,0.007156309493208196,0.009321413499674858,0.010714635855473137,0.010714635855473137,0.0067221444967789645,0.00683588675701885,0.0067221444967789645,0.00703007791166016,0.007156309493208196,0.007156309493208196,0.007333538864049083,0.007156309493208196,0.010675001721566074,0.008488462680031034,0.010675001721566074,0.010675001721566074,0.010675001721566074,0.018785799877354625,0.01995770052918841,0.02871409269290237,0.08377531568443068,0.09837780748672895,0.10742914338000145,0.10501302528437144,0.112020617465304,0.10501302528437144,0.10501302528437144,0.10237138453834141,0.10237138453834141,0.10426516614825565,0.10237138453834141,0.10237138453834141,0.10426516614825565,0.09258829803183474,0.09033717375325412,0.0878894893177064,0.0878894893177064,0.08713146146604826,0.08822919187700376,0.08707461352412432,0.08474780842101126,0.083413681254812,0.08402568620674482,0.08725978454324837,0.09736173754387525,0.1375679138032298,0.1375679138032298,0.13793833847181763,0.13793833847181763,0.1402077532504558,0.14115809492675754,0.14099303927093948,0.1402077532504558,0.14070843670238964,0.14258706985030573,0.14399732498789936,0.14248301174906866,0.14258706985030573,0.14258706985030573,0.14399732498789936,0.14414759170550162,0.14399732498789936,0.14414759170550162,0.15185111023424444,0.15399832219154289,0.1560723856319426,0.16472049848147907,0.17391309979461772,0.19410942331989178,0.21921519362599715,0.34319270408749797,1.0478273081521623,1.6357100760278163,3.8842939086489485,4.45424875357217)

net_rate_df <- data.frame(time = time,
                          net_rate = net_rate)
net_ribbon <- data.frame(time = time,
                         min = net_minHPD,
                         max = net_maxHPD)
#restrict rate and ribbon
net_rate_df$net_rate[which(net_rate_df$net_rate > 1.4)] <- 1.4
net_rate_df$net_rate[which(net_rate_df$net_rate < -1.4)] <- 1.4
net_ribbon$max[which(net_ribbon$max > 1.4)] <- 1.4
net_ribbon$min[which(net_ribbon$max < -1.4)] <- -1.4
  #Plot
net_plot <- ggplot(data = net_rate_df, aes(x = time, y = net_rate))+
  scale_x_reverse(breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 56)) +
  scale_y_continuous(breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                     labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                     limits = c(-1.5, 1.5)) +
  geom_ribbon(data = net_ribbon, aes(x = time, ymin = min, ymax = max),
              fill = "#504A4B",
              alpha = 0.2) +
  geom_line(aes(x = time, y = net_rate),
            linewidth = 1, colour = "#504A4B") +
  geom_hline(yintercept = 0,
             linetype = "dashed", colour = "red") +
  labs(x = "Time (Ma)",
       y = "Rate (event/lineage/Myr)") +
  theme(axis.title.x = element_text(size = 22),
        axis.title.y = element_text(size = 22),
        axis.text = element_text(size = 18),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(dat = cnz_epochs, abbrv = FALSE, size = 5)


# LTT from all replicates
dir <- "../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE/LTT/q_epochs/per_replicate/"
files <- Sys.glob(paste0(dir, "*_ltt.txt"))

ltt <- read.table(files[1], header = TRUE)
ltt$time <- unlist(lapply(X = ltt$time, FUN = round, digits = 1))
ltt <- ltt[-which(ltt$time > 66.0), c("time", "diversity")]
ltt <- ltt %>% rename(diversity_1 = "diversity")

i = 2
for(file in files[2:length(files)]){
  f <- read.table(file, header = TRUE)
  if(length(which(ltt$time > 66.0)) > 0){
    f <- f[-which(f$time > 66.0), c("time", "diversity")]
  }
  else{
    f <- f[, c("time", "diversity")]
  }
  f$time <- unlist(lapply(X = f$time, FUN = round, digits = 1))
  colnames(f) <- c("time", paste0("diversity_", i))
  ltt <- merge(ltt, f, by = "time", all = T)
  i <- i+1
}

LTT <- data.frame(Age = ltt$time,
                  Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                    MARGIN = 1,
                                    FUN = mean,
                                    na.rm = TRUE),
                  min_Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                        MARGIN = 1,
                                        FUN = min,
                                        na.rm = TRUE),
                  max_Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                        MARGIN = 1,
                                        FUN = max,
                                        na.rm = TRUE))

#cut ages under 23.03 or over 56
LTT <- LTT[-which((LTT$Age < 23.03) | (LTT$Age > 56)), ]

ltt_plot <- ggplot(data = LTT, aes(x = Age, y = Diversity)) +
  scale_x_reverse(breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 56)) +
  scale_y_continuous(breaks = seq(from = 0, to = 120, by = 20),
                     labels = seq(from = 0, to = 120, by = 20),
                     limits = c(0, 130)) +
  geom_ribbon(aes(x = Age, ymin = min_Diversity, ymax = max_Diversity), 
              fill = "#a1d99b",
              alpha = 0.8) +
  geom_line(linewidth = 1, colour = "#329507") +
  xlab("Time (Ma)") +
  ylab("Diversity (nb. lineages)") +
  theme(axis.title.x = element_text(size = 22),
        axis.title.y = element_text(size = 22),
        axis.text = element_text(size = 18),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(dat = cnz_epochs, abbrv = FALSE, size = 5)

#Combine
top_row <- cowplot::plot_grid(sp_ex, net_plot,
                              ncol = 2,
                              rel_widths = c(1/2, 1/2))
bottom_row <- cowplot::plot_grid(NULL, ltt_plot, NULL,
                                 ncol = 3,
                                 rel_widths = c(1, 2.5, 1))
p <- cowplot::plot_grid(top_row, bottom_row, nrow = 2)

#Save
ggsave("./figures/EOT_RTT_LTT_q_epochs.png",
       plot = p,
       height = 300,
       width = 400,
       units = "mm",
       dpi = 600)


## Frequency of rate shifts plot
png("./figures/freq_rate_shifts_EOT_q_epochs.png", height = 500, width = 1000)
par(mfrow = c(1,2))
bf2 <- 0.029509288326512895
bf6 <- 0.1834573756453758
  #Origination
mids <- c(-0.28565368686868686, -0.8569610606060606,-1.4282684343434342,-1.9995758080808081,-2.5708831818181817,-3.1421905555555556,-3.7134979292929295,-4.284805303030303,-4.856112676767676,-5.42742005050505,-5.998727424242424,-6.5700347979797975,-7.141342171717171,-7.712649545454545,-8.283956919191919,-8.855264292929293,-9.426571666666668,-9.99787904040404,-10.569186414141415,-11.140493787878787,-11.711801161616162,-12.283108535353536,-12.854415909090909,-13.425723282828283,-13.997030656565657,-14.56833803030303,-15.139645404040404,-15.710952777777779,-16.28226015151515,-16.853567525252522,-17.4248748989899,-17.99618227272727,-18.567489646464644,-19.13879702020202,-19.710104393939393,-20.281411767676765,-20.85271914141414,-21.424026515151514,-21.995333888888887,-22.56664126262626,-23.137948636363635,-23.709256010101008,-24.28056338383838,-24.851870757575757,-25.42317813131313,-25.994485505050502,-26.565792878787878,-27.13710025252525,-27.708407626262623,-28.279715,-28.851022373737372,-29.422329747474745,-29.99363712121212,-30.564944494949494,-31.136251868686866,-31.707559242424242,-32.278866616161615,-32.85017398989899,-33.42148136363637,-33.992788737373736,-34.56409611111111,-35.13540348484849,-35.70671085858586,-36.278018232323234,-36.84932560606061,-37.42063297979798,-37.991940353535355,-38.56324772727273,-39.1345551010101,-39.70586247474748,-40.27716984848485,-40.84847722222222,-41.4197845959596,-41.991091969696974,-42.56239934343434,-43.13370671717172,-43.705014090909096,-44.276321464646465,-44.84762883838384,-45.41893621212121,-45.990243585858586,-46.56155095959596,-47.13285833333333,-47.70416570707071,-48.275473080808084,-48.84678045454545,-49.41808782828283,-49.989395202020205,-50.560702575757574,-51.13200994949495,-51.703317323232326,-52.274624696969695,-52.84593207070707,-53.41723944444445,-53.98854681818182,-54.55985419191919,-55.13116156565657,-55.70246893939394,-56.273776313131314)
counts <- c(0.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.001358695652173913,0.004076086956521739,0.011141304347826087,0.013858695652173913,0.029076086956521738,0.5105978260869565,0.27418478260869567,0.16141304347826088,0.15108695652173912,0.55,0.3138586956521739,0.008152173913043478,0.0038043478260869567,0.0024456521739130437,0.001358695652173913,0.002717391304347826,0.0010869565217391304,0.0008152173913043478,0.0010869565217391304,0.0008152173913043478,0.003532608695652174,0.005163043478260869,0.005163043478260869,0.0019021739130434783,0.014130434782608696,0.02826086956521739,0.051358695652173915,0.035054347826086955,0.03016304347826087,0.00842391304347826,0.008695652173913044,0.007336956521739131,0.014130434782608696,0.06059782608695652,0.09375,0.009510869565217392,0.002989130434782609,0.002989130434782609,0.007608695652173913,0.014402173913043478,0.07907608695652174,0.13695652173913042,0.06576086956521739,0.016304347826086956,0.006793478260869565,0.005434782608695652,0.004891304347826087,0.007065217391304348,0.007336956521739131,0.004347826086956522,0.005978260869565218,0.011141304347826087,0.012228260869565218,0.017119565217391303,0.02418478260869565,0.02418478260869565,0.11739130434782609,0.6690217391304348,0.13641304347826086)
plot(mids,counts,type = 'h', main = "Origination", xlim = c(-56.55943,-23.02912), ylim=c(0,0.6690217391304348), ylab = 'Frequency of rate shift', xlab = 'Time',lwd=5,col='#4c4cec')
abline(h=bf2, lty=2)
abline(h=bf6, lty=2)
  #Extinction
mids <- c(-0.28565368686868686, -0.8569610606060606,-1.4282684343434342,-1.9995758080808081,-2.5708831818181817,-3.1421905555555556,-3.7134979292929295,-4.284805303030303,-4.856112676767676,-5.42742005050505,-5.998727424242424,-6.5700347979797975,-7.141342171717171,-7.712649545454545,-8.283956919191919,-8.855264292929293,-9.426571666666668,-9.99787904040404,-10.569186414141415,-11.140493787878787,-11.711801161616162,-12.283108535353536,-12.854415909090909,-13.425723282828283,-13.997030656565657,-14.56833803030303,-15.139645404040404,-15.710952777777779,-16.28226015151515,-16.853567525252522,-17.4248748989899,-17.99618227272727,-18.567489646464644,-19.13879702020202,-19.710104393939393,-20.281411767676765,-20.85271914141414,-21.424026515151514,-21.995333888888887,-22.56664126262626,-23.137948636363635,-23.709256010101008,-24.28056338383838,-24.851870757575757,-25.42317813131313,-25.994485505050502,-26.565792878787878,-27.13710025252525,-27.708407626262623,-28.279715,-28.851022373737372,-29.422329747474745,-29.99363712121212,-30.564944494949494,-31.136251868686866,-31.707559242424242,-32.278866616161615,-32.85017398989899,-33.42148136363637,-33.992788737373736,-34.56409611111111,-35.13540348484849,-35.70671085858586,-36.278018232323234,-36.84932560606061,-37.42063297979798,-37.991940353535355,-38.56324772727273,-39.1345551010101,-39.70586247474748,-40.27716984848485,-40.84847722222222,-41.4197845959596,-41.991091969696974,-42.56239934343434,-43.13370671717172,-43.705014090909096,-44.276321464646465,-44.84762883838384,-45.41893621212121,-45.990243585858586,-46.56155095959596,-47.13285833333333,-47.70416570707071,-48.275473080808084,-48.84678045454545,-49.41808782828283,-49.989395202020205,-50.560702575757574,-51.13200994949495,-51.703317323232326,-52.274624696969695,-52.84593207070707,-53.41723944444445,-53.98854681818182,-54.55985419191919,-55.13116156565657,-55.70246893939394,-56.273776313131314)
counts <- c(0.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5755434782608696,0.21195652173913043,0.057065217391304345,0.013043478260869565,0.007880434782608695,0.01956521739130435,0.07173913043478261,0.08369565217391305,0.03831521739130435,0.005706521739130435,0.010597826086956521,0.011956521739130435,0.0016304347826086956,0.005978260869565218,0.0024456521739130437,0.005706521739130435,0.00842391304347826,0.009510869565217392,0.013858695652173913,0.0125,0.002717391304347826,0.007065217391304348,0.002717391304347826,0.005978260869565218,0.024728260869565217,0.02690217391304348,0.23668478260869566,0.5755434782608696,0.1388586956521739,0.035597826086956524,0.011141304347826087,0.004076086956521739,0.005163043478260869,0.004076086956521739,0.004347826086956522,0.005163043478260869,0.005434782608695652,0.014130434782608696,0.02010869565217391,0.01548913043478261,0.007065217391304348,0.00625,0.005163043478260869,0.004347826086956522,0.002717391304347826,0.004347826086956522,0.0016304347826086956,0.002989130434782609,0.0010869565217391304,0.001358695652173913,0.0024456521739130437,0.00842391304347826,0.003260869565217391,0.0038043478260869567,0.002173913043478261,0.001358695652173913,0.002989130434782609,0.0038043478260869567,0.04157608695652174)
plot(mids,counts,type = 'h', main = "Extinction", xlim = c(-56.55943,-23.02912), ylim=c(0,0.5755434782608696), ylab = 'Frequency of rate shift', xlab = 'Time',lwd=5,col='#e34a33')
abline(h=bf2, lty=2)
abline(h=bf6, lty=2)

dev.off()