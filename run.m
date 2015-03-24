%run
load('HB.mat');

h1=2;
h2=4855;
t1=2;
t2=53;
ds=1.5;
de=1.5;
sampleC=logical(rand(1,h2)>0.85);
sampleP=logical(rand(1,t2)>0.15);
opt_initeta;
opt_initscore;
opt;
