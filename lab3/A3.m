%load data
load lab3_3_cat1.mat
load lab3_3_cat2.mat
load lab3_3_cat3.mat

h=1;

%points
u = [0.5 1 0];
v = [0.31 1.51 -0.5];
w = [-1.7 -1.7 -1.7];

%probs
pu1 = parzen_prob(u,x_w1,h);
pu2 = parzen_prob(u,x_w2,h);
pu3 = parzen_prob(u,x_w3,h);

pv1 = parzen_prob(v,x_w1,h);
pv2 = parzen_prob(v,x_w2,h);
pv3 = parzen_prob(v,x_w3,h);

pw1 = parzen_prob(w,x_w1,h);
pw2 = parzen_prob(w,x_w2,h);
pw3 = parzen_prob(w,x_w3,h);

%posterior probs
ppu1 = pu1*(1/3)
ppu2 = pu2*(1/3)
ppu3 = pu3*(1/3)
ppv1 = pv1*(1/3)
ppv2 = pv2*(1/3)
ppv3 = pv3*(1/3)
ppw1 = pw1*(1/3)
ppw2 = pw2*(1/3)
ppw3 = pw3*(1/3)


%nearest neigbour classification results
%function classLabel = KNN(POINT, K, DATA, CLASS_LABELS)

KNN(w,5,[x_w1;x_w2;x_w3], [repmat(1,1,10) repmat(2,1,10) repmat(2,1,10)] )


