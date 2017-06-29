clear; close;
%qsh modified

%addpath [liblinear-1.91/windows/] % for hinge loss



dataset = 'cifar_10_gist';

% prepare_dataset(dataset);

%load(['C:\Users\qishuhan\Documents\GitHub\SHDH_1\testbed\',dataset]);
load(['E:\bakubuntu\SHDH_3\testbed\',dataset]);
traindata = double(traindata);
testdata = double(testdata);


if sum(traingnd == 0)
    traingnd = traingnd + 1;
    testgnd = testgnd + 1;
end


Ntrain = size(traindata,1);
% Use all the training data
%X = traindata;

label = double(traingnd);
% get anchors
n_anchors = 500;
% rand('seed',1);
anchor = traindata(randsample(Ntrain, n_anchors),:);


% % determin rbf width sigma
% Dis = EuDist2(X,anchor,0);
% % sigma = mean(mean(Dis)).^0.5;
% sigma = mean(min(Dis,[],2).^0.5);
% clear Dis
sigma = 0.4; % for normalized data
sample = randsample(Ntrain, 3000);
Train_label = label(sample,:);
Train_sample= traindata(sample,:);
[A] = HyGh2( Train_sample,sigma, 7 );
%A=[];
% PhiX = exp(-sqdist(traindata,anchor)/(2*sigma*sigma));
% PhiX = [PhiX, ones(Ntrain,1)];

Phi_testdata = exp(-sqdist(testdata,anchor)/(2*sigma*sigma)); 
%clear testdata
%Phi_testdata = [Phi_testdata, ones(size(Phi_testdata,1),1)];
Phi_traindata = exp(-sqdist(traindata,anchor)/(2*sigma*sigma)); 
%clear traindata;
%Phi_traindata = [Phi_traindata, ones(size(Phi_traindata,1),1)];
Phi_trainsample = exp(-sqdist(Train_sample,anchor)/(2*sigma*sigma));
%Phi_trainsample = [Phi_trainsample, ones(size(Phi_trainsample,1),1)];

Phi_trainsample=Train_sample;
Phi_traindata=traindata;
Phi_testdata=testdata;

% learn G and F
%betaarray=[0,0.0000005,0.000001,0.000005,0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01];
betaarray=[0,0.000005,0.00001,0.00005,0.0001,0.0005];
maxItr = 7;
gmap.lambda = 1; gmap.loss = 'L2';
Fmap.type = 'RBF';
Fmap.nu = 1e-5; %  penalty parm for F term
Fmap.lambda = 1e-2;
%Hmap.beta = 0.000;
Hmap.graph=A;
%% run algo
%nbitsarray=[32,48,64,96,128];
%nbitsarray=[48];
resultarray=[];
% for nl= 1:size(nbitsarray,2)
%   nbits= nbitsarray(nl)
%   result = [];
%   result = [result nbits];

for nl= 1:size(betaarray,2)
  beta= betaarray(nl)
  result = [];
  result = [result beta];
  Hmap.beta = beta;
  
  nbits = 64;

% Init Z
randn('seed',3);
Zinit=sign(randn(size(Phi_trainsample,1),nbits));
%  Zinit=schmidt(Zinit');
%  Zinit=Zinit';
%Zinit=sign(Zinit);

debug = 1;
%[~, F, H] = SDH(Phi_trainsample,Train_label,Zinit,gmap,Fmap,[],maxItr,debug);
[~, F, H] = SHDH(Phi_trainsample,Train_label,Zinit,gmap,Fmap,Hmap,[],maxItr,debug);



%% evaluation
display('Evaluation...');

AsymDist = 0; % Use asymmetric hashing or not

if AsymDist 
    H = H > 0; % directly use the learned bits for training data
else
    H = Phi_traindata*F.W > 0;
end

tH = Phi_testdata*F.W > 0;

hammRadius = 2;



B = compactbit(H);
tB = compactbit(tH);


hammTrainTest = hammingDist(tB, B)';
% hash lookup: precision and reall
Ret = (hammTrainTest <= hammRadius+0.00001);
[Pre, Rec] = evaluate_macro(cateTrainTest, Ret)

% hamming ranking: MAP
[~, HammingRank]=sort(hammTrainTest,1);
MAP = cat_apcal(traingnd,testgnd,HammingRank)
result = [result Pre Rec MAP];
resultarray=[resultarray;result];
end
a=1;















