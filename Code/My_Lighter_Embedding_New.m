function [StegoImage] = My_Lighter_Embedding_New(OriginalImage,message,Length_of_Message,lighter)
%% Declare Variables

StegoImage = OriginalImage;

counter = 1;

[height, width, RGB] = size(OriginalImage);

bin_Value_Of_Length_Of_Message = num2str(dec2bin(Length_of_Message,32));

Msg_To_Be_Embedded=strcat(bin_Value_Of_Length_Of_Message,message);

Length_of_Message_To_Be_Embedded = length(Msg_To_Be_Embedded)
%%
Length_of_message = Length_of_Message_To_Be_Embedded - 24

capacity_of_image = (lighter)

number_of_characters = lighter/8 

if (Length_of_Message_To_Be_Embedded >= capacity_of_image)
    
   fprintf('ERROR: <strong>PLEASE SHORTEN THE MESSAGE OR CHOOSE AN IMAGE OF BIGGER SIZE </strong>\n\n\n')
   fprintf('You can only Embedd %d number of characters for this Image.\n',number_of_charachters);
   StegoImage = 0;
else

for i = 1 : height
    
    for j = 1 : width
        
        %% RGB pixels
        
        if (counter <= Length_of_Message_To_Be_Embedded )
            
            
            R = OriginalImage(i,j,1);
            G = OriginalImage(i,j,2);
            B = OriginalImage(i,j,3);
            B_BIN = dec2bin(B,8);
            
            
            
            %% MSBs of RGB
            
            R_MSB = bitget(R,8);
            G_MSB = bitget(G,8);
            B_MSB = bitget(B,8);
           
            MSB_dec = (R_MSB*4 + G_MSB*2 + B_MSB ) + 1;
           
             
            %% Checks for the conditions and embedds the data
            
            
            if(((R_MSB==1) && (G_MSB==1) && (B_MSB==1)) || ((R_MSB==0) && (G_MSB==1)&&(B_MSB==1)) ||((R_MSB==1) && (G_MSB==0) && (B_MSB==1)) || ((R_MSB==1) && (G_MSB==1) && (B_MSB==0)))
               
                  fprintf('pixel no: %d,%d\n',i,j);
                B_DEC_Bit = num2str(bitget(B,MSB_dec));
                
                Message_bit = num2str(Msg_To_Be_Embedded(counter));

                fprintf('loop no: %d\n',counter);
                fprintf('Decimal Value: %d\n',MSB_dec);
                disp(['Blue Value: ', B_BIN]);
                disp(['Blue Decimal bit is: ',B_DEC_Bit]);
                disp(['msgbit is: ',Message_bit]);
                   
                if(B_DEC_Bit == Message_bit)
                    
                    fprintf('<strong>Make LSB 1</strong>\n');
                    
                    StegoImage(i,j,3) = bitset(OriginalImage(i,j,3),1);
                    
                    fprintf('final: %s\n\n\n',dec2bin(StegoImage(i,j,3),8))
                    
                else
                    
                    fprintf('<strong>Make LSB 0</strong>\n');
                   
                    StegoImage(i,j,3) = bitset(OriginalImage(i,j,3),1,0);
                    
                    fprintf('final: %s\n\n\n',dec2bin(StegoImage(i,j,3),8))
                                   
                end
                
                counter = counter + 1;
                
            else
                
                fprintf('PIXEL SKIPPED: %d,%d\n\n',i,j);
                
            end
            
        end
        
        if(counter > Length_of_Message_To_Be_Embedded)
            
            break;
            
        end
    end
    
    if(counter > Length_of_Message_To_Be_Embedded)
        
        break;
        
    end
    
end
end