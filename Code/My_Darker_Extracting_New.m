function [textString] = My_Darker_Extracting_New(StegoImageReceived)

%StegoImage=imread('C:\Users\RaaJ\Desktop\stego.png');
%%
k = 1;

[height, width, RGB] = size(StegoImageReceived);

%% LENGTH EXTRACTION

msg_Count = 32;

for i = 1 : height
    
    for j = 1 : width
        %         fprintf('%d, %d\n\n\n',j,jupdated)
        if (k <= msg_Count)
            
            R_pixel = StegoImageReceived(i,j,1);
            G_pixel = StegoImageReceived(i,j,2);
            B_pixel = StegoImageReceived(i,j,3);
            B_BIN = dec2bin(B_pixel,8);
            
            R_MSB = bitget(R_pixel,8);
            G_MSB = bitget(G_pixel,8);
            B_MSB = bitget(B_pixel,8);
            
            MSB_value = (R_MSB*4 + G_MSB*2 + B_MSB ) + 1;
            
            LSB = bitget(B_pixel,1);
            %%

            if ((R_MSB==0) && (G_MSB==0) && (B_MSB==0))
            
                fprintf('\n\n\nloop no: %d\n',k);
                fprintf('Decimal Value is: %d\n',MSB_value);
                fprintf('Blue value is: %s\n',B_BIN);
                fprintf('LSB Value is: %d\n',LSB);
                fprintf('<strong>Extract LSB Directly..</strong>\n');
                
                Scan_Length_Of_Message(k) = bitget(B_pixel,1);
                
                k = k + 1;
                
                fprintf('Extracted bit is: %d\n',bitget(B_pixel,1));
                
            else
                             
                if((R_MSB==0 && G_MSB==0 && B_MSB == 1) || (R_MSB==0 && G_MSB==1 && B_MSB==0)|| (R_MSB==1 && G_MSB==0 && B_MSB==0))
                    
                    fprintf('\n\nloop no: %d\n',k);
                    fprintf('Decimal Value: %d\n',MSB_value);
                    fprintf('Blue value is: %s\n',B_BIN);
                    fprintf('Blue decimal bit is: %d\n',bitget(B_pixel,MSB_value));
                    fprintf('LSB is: %d\n',LSB);
                    
                    if(LSB == 1)
                                                
                        Scan_Length_Of_Message(k) = bitget(B_pixel,MSB_value);
                        fprintf('<strong>Extract Decimal bit Directly..</strong>\n');
                        fprintf('Extracted bit is: %d\n',bitget(B_pixel,MSB_value));
   
                    else

                        if (LSB == 0)
                            
                            disp('<strong>Extract the Inverted Blue Decimal Bit</strong>');
                            
                            temp = num2str(bitget(B_pixel, MSB_value));

                            
                            if (temp == '1')

                                Scan_Length_Of_Message(k)=0;
                                disp('Value Extracted: 0');

                            else

                                Scan_Length_Of_Message(k)= 1;
                                disp('Value Extracted: 1');
                                
                               
                            end
                            
                        end
                        
                    end
                    
                   k = k + 1; 
                   
                else
                    
                    fprintf('PIXEL SKIPPED: %d,%d\n\n',i,j);

                end

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
% Stego_message=0;

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
if (Length ~= 0)

c = mod(Length,8);

else
    
    fprintf('ERROR: <strong> Length cannot be zero! </strong>\n        Something went wrong while Extracting \n        the number of message bits!\n\n\n');
    
    c = 1;
    
end

%%

if c == 0
    
for i= iupdate : height
    
    if (j == width)
        
        jupdate = 1;
        
    end
    
    for j = jupdate : width

        if (k <= Length)

            R_pixel = StegoImageReceived(i,j,1);
            G_pixel = StegoImageReceived(i,j,2);
            B_pixel = StegoImageReceived(i,j,3);
            
            R_MSB = bitget(R_pixel,8);
            G_MSB = bitget(G_pixel,8);
            B_MSB = bitget(B_pixel,8);
            
            MSB_value = (R_MSB*4 + G_MSB*2 + B_MSB ) + 1;
            
            LSB = bitget(B_pixel,1);
            %%
            
            if (MSB_value==1)
                
                Stego_message(k) = bitget(B_pixel,1);
                
                k = k + 1;
                
            else
                
                if((R_MSB==0 && G_MSB==0 && B_MSB == 1) || (R_MSB==0 && G_MSB==1 && B_MSB==0)|| (R_MSB==1 && G_MSB==0 && B_MSB==0))
                    
                    if(LSB == 1)
                        
                        %disp('lsb==1')
                        
                        Stego_message(k) = bitget(B_pixel,MSB_value);
                        
                        k=k+1;
                        
                    else
                        
                        %disp('lsb=0')
                        
                        if(LSB == 0)
                            
                            temp = bitget(B_pixel, MSB_value);
                            
                            if (temp == 1)
                                
                                %disp('pth bit= 1 and a =0');
                                
                                Stego_message(k)=0;
                                
                                k=k+1;
                            else
                                
                                %disp('pth bit= 0 and a =1');
                                
                                Stego_message(k)= 1;
                                
                                k=k+1;
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
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

%%

binaryVector = double(Stego_message);

binaryString = transpose(binaryVector);

binaryVector = binaryString(:);

if mod(length(binaryVector),8) ~= 0
    
    error('Length of binary vector must be a multiple of 8.');
    
end

binMatrix = reshape(binaryVector,8,(k-1)/8);

binValues=[128 64 32 16 8 4 2 1];

textString = char(binValues * binMatrix);

%% Print text

fprintf('decoded o/p is:\n%s\n',textString);

else
    fprintf('\n\nERROR:\nLength must be a multiple of 8.\n\n');
    textString = '';
end
end

