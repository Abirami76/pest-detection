load('trainedNetwork_1.mat')
I = imread("C:\Users\hp\OneDrive\Desktop\pest\test\0\00112.jpg");
I = imresize(I,[227 227]);
[YPred,probs] = classify(trainedNetwork_1,I);
imshow(I);
label = YPred;
title(string(label) + "," + num2str(100*max(probs),3) + "%");