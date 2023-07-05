function [textString] = My_Lighter_Extracting_New(StegoImage)
%StegoImage = imread('C:\Users\RaaJ\Desktop\FINAL v1.1\Output.png');

k = 1;

[height, width, RGB] = size(StegoImage);

%% LENGTH EXTRACTION

msg_Count = 32;

for i = 1 : height
    
    for j= 1 : width
        
        if (k <= msg_Count)
            
            R_pixel = StegoImage(i,j,1);
            G_pixel = StegoImage(i,j,2);
            B_pixel = StegoImage(i,j,3);
            B_BIN = dec2bin(B_pixel,8);
            
            R_MSB = bitget(R_pixel,8);
            G_MSB = bitget(G_pixel,8);
            B_MSB = bitget(B_pixel,8);
            
            MSB_value = (R_MSB*4 + G_MSB*2 + B_MSB ) + 1;
            
            LSB = bitget(B_pixel,1);
            %%
            
           if(((R_MSB==1) && (G_MSB==1) && (B_MSB==1)) || ((R_MSB==0) && (G_MSB==1)&&(B_MSB==1)) ||((R_MSB==1) && (G_MSB==0) && (B_MSB==1)) || ((R_MSB==1) && (G_MSB==1) && (B_MSB==0)))
               
               
                fprintf('\n\nloop no: %d\n',k);
                fprintf('MSB Value: %d\n', MSB_value);
                fprintf('BLUE Binary: %s\n', B_BIN);
                fprintf('Blue Decimal bit: %d\n', bitget(B_pixel,MSB_value));
                fprintf('LSB Value: %d\n', LSB);
               
                
                if(LSB == 1)
                    disp('<strong>extract Decimal bit directly.</strong> :-)');
                    Scan_Length_Of_Message(k) = bitget(B_pixel,MSB_value);
                    fprintf('Value Extracted: %d\n\n ',bitget(B_pixel,MSB_value));
                    k=k+1;
                    
%                    jupdated = j;
%                    iupdated = i;

                    
                else
                    
                    disp('<strong>extract Inverted Blue Decimal Bit</strong>');

                    
                    if(LSB == 0)
                    
                    temp = bitget(B_pixel, MSB_value);
                                        
                    if (temp == 1)
                        
                        Scan_Length_Of_Message(k)=0;
                        fprintf('Value Extracted: 0\n\n');
                        
                                                 
                    else
                        
                        if (temp == 0)
                        
                        Scan_Length_Of_Message(k)= 1;
                        fprintf('Value Extracted: 1\n\n');
                     
                        end
                        
                    end
                    
                     k = k + 1;
                    
                    end
                    
                    
                    
                end
                
            else
                
                fprintf('PIXEL SKIPPED: %d,%d\n\n',i,j);
                
                
            end
        end
        
        if(k > msg_Count)
            
            break;
            
        end

        
    end
    
        if(k > msg_Count)
            
            break;
            
        end

    
    
end

%%
binaryVector = double(Scan_Length_Of_Message);

binaryString = transpose(binaryVector);

binaryVector = binaryString(:);

if mod(length(binaryVector),8) ~= 0
    
    error('Length of binary vector must be a multiple of 8.');
    
end

k = msg_Count;
format longG
n = 0;
for i1 = k:-1:1
    
    binValues(k) = 2^(n) ;
    k = k - 1;
    n = n + 1;
    
end

Length = binValues*binaryVector;

%% MESSAGE EXTRACTION STARTS FROM HERE

k = 1;

%% CHECK IF J OR JUPDATED (BOTH ARE SAME) POINTS AT WIDTH PIXEL

if (j == width)
    
    j = 1;
    
else
    
    j = j + 1 ;
    
end

%% CURRENT VALUE OF I AND J

iupdate = i;
jupdate = j;



%%
if (Length~=0)

c = mod(Length,8);

else
    
    fprintf('ERROR: <strong> Length cannot be zero! </strong>\n        Something went wrong while Extracting \n        the number of message bits!\n\n\n');
    
    c = 1;
end

%%

if (c == 0)

for i = iupdate : height
    
    if (j == width)
    
    jupdate = 1;
    
    end
    
    for j = jupdate : width
        
        if (k <= Length)
            
            R_pixel = StegoImage(i,j,1);
            G_pixel = StegoImage(i,j,2);
            B_pixel = StegoImage(i,j,3);
            B_BIN = dec2bin(B_pixel,8);
            
            R_MSB = bitget(R_pixel,8);
            G_MSB = bitget(G_pixel,8);
            B_MSB = bitget(B_pixel,8);
            
            MSB_value = (R_MSB*4 + G_MSB*2 + B_MSB ) + 1;
            
            LSB = bitget(B_pixel,1);
            %%
            if(((R_MSB==1) && (G_MSB==1) && (B_MSB==1)) || ((R_MSB==0) && (G_MSB==1)&&(B_MSB==1)) ||((R_MSB==1) && (G_MSB==0) && (B_MSB==1)) || ((R_MSB==1) && (G_MSB==1) && (B_MSB==0)))
%%
                  fprintf('\n\nloop no: %d\n',k);
                 fprintf('Pixel no: %d,%d\n',i,j)
                fprintf('Decimal Value: %d\n', MSB_value);
                fprintf('BLUE Binary: %s\n', B_BIN);
                fprintf('Blue Decimal bit: %d\n', bitget(B_pixel,MSB_value));
                fprintf('LSB Value: %d\n', LSB);
               
%%
                if(LSB == 1)
                    disp('<strong>Extract Blue Decimal bit..</strong>');
                    Stego_message(k) = bitget(B_pixel,MSB_value);
                    fprintf('Extracted Value is: %d\n', bitget(B_pixel, MSB_value));
                    
                    
                    k=k+1;
                    
                else
                    
                    if(LSB == 0)
                        disp('<strong>Invert the Blue Decimal bit..</strong>');
                        temp = bitget(B_pixel, MSB_value);
                        
                        if (temp == 1)
                            
                            Stego_message(k)=0;
                            fprintf('Extracted Value is: 0\n');
                            
                            k=k+1;
                        else
                            
                            Stego_message(k)= 1;
                            fprintf('Extracted Value is: 1\n');
                            
                            k=k+1;
                            
                        end
                    end
                end
            else
                fprintf('\n\nPIXEL SKIPPED: %d,%d\n',i,j);
            end
        end
        
        if(k > Length)
            
            break;
            
        end
    end
    if(k > Length)
        
        break;
        
    end
    
    
end
%% STEGO STRING

binaryVector = double(Stego_message);

% binaryVector = double(str2num(message));

binValues = [ 128 64 32 16 8 4 2 1];

binaryString = transpose(binaryVector);

binaryVector = binaryString(:);

if mod(length(binaryVector),8) ~= 0
    
    disp('ERROR: <strong>Length of binary vector must be a multiple of 8.</strong>');
    textString = '';
    
else

binMatrix = reshape(binaryVector,8,(k-1)/8);

textString = char(binValues*binMatrix);

%% Print text

fprintf('decoded o/p is:\n%s\n',textString);

end

else
    fprintf('ERROR: <strong> Length must be multiple of 8! </strong>\n\n');
    textString = '';
    
end
%end
