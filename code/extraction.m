f1 = "R1-1-";  
% R1-1- R1-2- R2-1- R2-2- R3-1- R3-2- r4a1- r4a2- r4b1- r4b2- r5a1- 

addpath('../data/images/R1/i1');
% R1/i2 R1/i1 R2/i2 R4/a1 ...

%use first im for selection
im = imread(strcat(f1, num2str(1), ".jpg")); 
%% Let user select the heart pixel
disp("select the heart pixels");
heart = selectRegion(im);

%% Let user select the nonheart pixel (4 times)
nonheart = zeros(100, 100);
disp("select the nonheart pixels");
for i = 1:4
    disp([i "of 4 times"]);
    temp = selectRegion(im);
    nonheart = or(nonheart, temp);
end

%% mask values of all 1024 frames
% Preparing training data and all data for train and fit
disp("Preparing Data");

valHeart = [];
valNonheart = [];
allData = [];

% change t to select different num of frames
t = 30;
for i=1:t
    im = imread(strcat(f1, num2str(i), ".jpg"));
    % mask heart and nonheart values
    valHeart = [valHeart im(heart)];
    valNonheart = [valNonheart im(nonheart)];
    
    % store all data
%     im = reshape(im.', [], 1);
%     allData = [allData im];
end

% append 1s and 0s / labels
valHeart = [valHeart ones(sum(heart(:) == 1), 1)];
valNonheart = [valNonheart zeros(sum(nonheart(:) == 1), 1)];
trainingData = [valHeart; valNonheart];


writematrix(trainingData,strcat('../data/labeled_', num2str(t), "frame.csv")); 
% writematrix(allData,'data_r1_130.csv'); 

% rgbImage = cat(3, im, im, im);
