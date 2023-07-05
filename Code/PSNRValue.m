
function [MSE, PSNR_Value, AAD, SNR]= PSNRValue()

%% Read the Original Image

[Path]=InputImage();
OriginalImage = imread(Path);
Original = double(OriginalImage);

%% Read the Stego Image

[Path]=InputImage();
StegoImage = imread(Path);
stego = double(StegoImage);

%% Variable Declaration

%MSE_temp = 0;

AAD_temp = 0;

Num = 0;

Den = 0;
%% Mean Square Error

rows= size(Original,1);
columns= size(Original,2);

%
% for i = 1: m
%
%     for j = 1:n
%
%         MSE_temp = MSE_temp + (double(original(i,j)) - double(stego(i,j)))^2;
%
%     end
%
% end
%
% MSE = double(MSE_temp/(m*n))
%
% fprintf('\n The Mean Square Error value is %0.4f\n\n',MSE );
%
% %% Peak Signal to Noise Ratio
%
% PSNRValue =PSNR_Value(original,stego);



% mse = mean(mean((im2double(c) - im2double(s)).^2, 1), 2)
% psnr = 10 * log10(1 ./ mean(mse,3));



% Calculate mean square error of R, G, B.

mseRImage = (double(OriginalImage(:,:,1)) - double(StegoImage(:,:,1))) .^ 2;
mseGImage = (double(OriginalImage(:,:,2)) - double(StegoImage(:,:,2))) .^ 2;
mseBImage = (double(OriginalImage(:,:,3)) - double(StegoImage(:,:,3))) .^ 2;

mseR = sum(sum(mseRImage)) / (rows * columns);
mseG = sum(sum(mseGImage)) / (rows * columns);
mseB = sum(sum(mseBImage)) / (rows * columns);

% Average mean square error of R, G, B.

MSE = (mseR + mseG + mseB)/3;

%% Calculate PSNR (Peak Signal to noise ratio).

PSNR_Value = 10*log10( (235^2) / MSE);

%fprintf('\n The Peak-SNR value is %0.4f\n\n',PSNR_Value );

%% Average Absolute Difference

for i = 1:rows
    
    for j = 1:columns
        
        AAD_temp = AAD_temp + abs(Original(i,j,3)-stego(i,j,3));
        
    end
    
end

AAD = AAD_temp/(rows*columns);

%fprintf('\n The Approx Average Absolute Difference value is %0.4f\n\n',AAD );

%% Signal to Noise Ratio

for i = 1:rows
    
    for j = 1:columns
        
        Num = Num + (Original(i,j,3))^2 ;
        
    end
    
end

for i = 1:rows
    
    for j = 1:columns
        
        Den = Den + ((Original(i,j,3))-(stego(i,j,3)))^2 ;
        
    end
    
end

SNR = Num/Den;

%fprintf('\n The Approx Signal to Noise Ratio value is %0.4f \n\n',SNR );
