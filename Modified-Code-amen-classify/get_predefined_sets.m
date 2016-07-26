function [features, givenA, givenB ] = get_predefined_sets()
    %first set is the positive label(C+), second class is the negative (C-)
    
%interesting case with random values
    features = [2 4 6 8 10 14];
    givenA = [0.00127479082935900	0.838219667025204	0.893236168836106	0.0383845292211468	0.555830554482422	0.143505800961349	0.841081561507408	0.900908724122759	0.438260924883848	0.0641980573793238	0.911090705134790	0.491333797043834	0.219718881762801	0.0341662327794491	0.882491646242846
0.392993493173714	0.0991837279543725	0.947072742747796	0.751007900443425	0.770767394782895	0.776895065568044	0.214351209945797	0.580432389828081	0.152905402225335	0.0421779755901158	0.205380112218692	0.340917170463213	0.870392508166418	0.700108222693186	0.460675963801908
0.805293423419518	0.601000624624119	0.372300962602568	0.841386884678187	0.982263919399073	0.933406501193143	0.922291610773846	0.963859507178217	0.588512796401041	0.712598449005940	0.0124659207164960	0.854852147388217	0.0356690436729946	0.622996348540461	0.516482424624236
0.784299542955876	0.144971459935934	0.685558901944066	0.640245630844003	0.517567329256162	0.483600496680169	0.110450808456472	0.117565269542779	0.851458568881437	0.231227027033966	0.431696762824632	0.731096127340809	0.627744586397170	0.489668050287370	0.443529208450578
0.155026909077117	0.0384232606147553	0.991283027478121	0.549664231003806	0.896093683343727	0.0229674386081332	0.632337613072164	0.840408446075281	0.444559289846061	0.763966334233685	0.471270054096622	0.195576413864449	0.449554345824802	0.0787490699908449	0.956623911019116
0.874427819856382	0.316054424822358	0.269780252908738	0.234733051426439	0.840702141611913	0.340043438577815	0.655538021095345	0.973909823178577	0.707934643569259	0.933304698162993	0.972349440967092	0.903925233772190	0.779678760251710	0.171580384382801	0.619601240271653
0.265221069117602	0.683238345615516	0.120041585006071	0.900081801553927	0.321482498992152	0.826612348732764	0.535619888107564	0.980451294515545	0.174151888310097	0.289066998466684	0.583126396694185	0.950072816671075	0.486622479943171	0.775294435285599	0.335701862289176
0.388662673720151	0.350585058073808	0.688031102407640	0.00203587122845583	0.0122766718701323	0.884586014252441	0.730923659490442	0.997928082055806	0.695494563177461	0.700111341043490	0.219643535777493	0.345573478264118	0.966486985575715	0.150568456017035	0.445860189990499
0.651793420808454	0.667029369258206	0.531894402805884	0.580498121676586	0.373581947327232	0.326827923454658	0.715123982480521	0.168124226510244	0.110989646352437	0.809718390427418	0.238171592271160	0.193392318486798	0.0270033389954193	0.998463283775074	0.745250170868637
0.957376908236414	0.250298709814932	0.232559074181939	0.301437914089005	0.332489447180526	0.440990166447044	0.437863053116261	0.140846068135687	0.0157524092652280	0.326911678514750	0.955025423937575	0.237267630948005	0.930838797835785	0.0807663687573947	0.553844960307913];

    givenB = [0.743795450774187	0.563251132097044	0.354459464585013	0.411706004158326	0.392815689626803	0.691002079820412	0.375846007262542	0.826789301372583	0.00106766015488724	0.627755992264285	0.381753723092201	0.901357919815180	0.967917674377931	0.573223433203540	0.895568512153639
0.630746774373078	0.00813495185330959	0.453022361358138	0.368453060089081	0.358644218995631	0.879211185102602	0.266494049147214	0.787333338538158	0.740191875708903	0.829708484323952	0.570114461538122	0.531910773794116	0.162241081997642	0.970614613369021	0.229670347328476
0.164434362827199	0.140151307567480	0.706962724689734	0.382653167971408	0.499222783310208	0.722316962815568	0.546972104436037	0.128939427170538	0.435108920026814	0.756893875874040	0.399971512323262	0.265805424727025	0.837338304375112	0.800078751936616	0.690022584199355
0.600895916650063	0.707811773197957	0.967002569799790	0.569565885347918	0.727702280067548	0.558613698440479	0.234465665873868	0.996995102920820	0.736245854223055	0.260649209819640	0.562183288437102	0.519504577283845	0.961162950017905	0.154210730080624	0.616170341687780
0.392184198487557	0.256975524893978	0.791175857023754	0.793261081163995	0.421518136241551	0.0739448083322165	0.969988388543870	0.414346922396498	0.569241294925111	0.867538512370825	0.510281764520807	0.943935701896645	0.745987062633419	0.855882680527957	0.371605270913859
0.592851972385633	0.723225000535238	0.450362684702098	0.0230638410606807	0.936876362649556	0.656166248286648	0.544148378623151	0.959694424111373	0.0215025040727876	0.747485779699645	0.0498487948588502	0.337376541865703	0.925609322681238	0.890714690641290	0.0218761886676723
0.141432594793761	0.559418914908943	0.852286770032085	0.337370738039493	0.661578511240761	0.0205922384472472	0.482183217955525	0.190847292036327	0.0506583121164715	0.896254833487207	0.288551528971997	0.878592014149489	0.00150633956299795	0.465056129665077	0.990380155314650
0.409838912922757	0.335350157451195	0.365455751603356	0.960850130310460	0.101625072543588	0.0670421545182084	0.0239251696153536	0.747543569215778	0.127880220679509	0.829689181424456	0.123709300465386	0.707142708338791	0.775568555043212	0.0296861772758918	0.0826069529452667
0.725767589174155	0.402924846330207	0.999023090802282	0.492587786234689	0.887949231319295	0.914283813798116	0.669310202280991	0.940302322551632	0.552609891591918	0.253177607467324	0.273230900917584	0.941358763918265	0.696380203995745	0.988468005349011	0.775217230627883
0.608831743431899	0.813983134256095	0.0837828487608321	0.0141997521559160	0.804776023904992	0.819759196429687	0.984975444597425	0.322118531940579	0.313812252423507	0.588200962045943	0.827836904340576	0.914984308806324	0.0953753232117682	0.000251024626523266	0.800214737538973];

%random values made by hand
%for 2, the methods outperform brute ???
% features = [2 3 4];
%     givenA = [0.90 0.94 0.20 0.34
%               0.87 0.80 0.23 0.25
%               0.75 0.67 0.30 0.23
%               0.68 0.78 0.20 0.36
%               0.90 0.94 0.15 0.20
%               0.96 0.86 0.30 0.23
%               0.87 0.70 0.24 0.05
%               0.79 0.99 0.12 0.15
%               0.92 0.85 0.20 0.30
%               0.97 0.81 0.15 0.40];
% 
%     givenB = [0.20 0.34 0.90 0.94
%               0.23 0.25 0.87 0.80
%               0.30 0.23 0.75 0.67
%               0.20 0.36 0.75 0.67
%               0.15 0.20 0.90 0.95
%               0.30 0.23 0.97 0.81
%               0.40 0.10 0.79 0.99
%               0.24 0.05 0.92 0.85
%               0.12 0.15 0.87 0.70
%               0.15 0.40 0.70 0.90];

%both classes get either only high values or low values for one node from the
%class 
% features = [2 3 4 5 8 10 15];
% givenA = [];
% givenB = [];
% for i=1:10
%     a = 0.55;
%     b = 1;
%     c = 0;
%     d = 0.45;
%     
%     boolRandom = round(rand);
%     if(boolRandom == 1)
%         x = b;
%         y = a;
%         z = d;
%         k = c;
%     else 
%         x = d;
%         y = c;
%         z = b;
%         k = a;
%     end
%           
%     randVectorA = (x-y).*rand(15,1) + y;
%     givenA = [givenA; randVectorA'];
%     randVectorB = (z-k).*rand(15,1) + k;
%     givenB = [givenB; randVectorB'];
% end

% %random values with low/high values for classes(only one class can have a
% %high value for a feature)
% features = [2 3 4 5 8 10 15];
% givenA = [];
% givenB = [];
% for i=1:15
%     a = 0.55;
%     b = 1;
%     c = 0;
%     d = 0.45;
%     
%     boolRandom = round(rand);
%     if(boolRandom == 1)
%         x = b;
%         y = a;
%         z = d;
%         k = c;
%     else 
%         x = d;
%         y = c;
%         z = b;
%         k = a;
%     end
%           
%     randVectorA = (x-y).*rand(10,1) + y;
%     givenA = [givenA, randVectorA];
%     randVectorB = (z-k).*rand(10,1) + k;
%     givenB = [givenB, randVectorB];
% end

% %random values between 0.55 and 100
% features = [2 3 4 5 8 10 15];
% givenA = [];
% givenB = [];
% for i=1:10
%     a = 0.55;
%     b = 1;
%     randVectorA = (b-a).*rand(15,1) + a;
%     givenA = [givenA; randVectorA'];
%     randVectorB = (b-a).*rand(15,1) + a;
%     givenB = [givenB; randVectorB'];
% end

end
