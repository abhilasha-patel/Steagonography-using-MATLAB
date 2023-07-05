%% Checks for the image to be lighter or darker image

function [LighterAlgo, DarkerAlgo, lighter, darker] = Function_2_Lighter_or_Darker(OriginalImage)

lighter = 0;

darker = 0;

DarkerAlgo = 0;

LighterAlgo = 0;

height = size(OriginalImage,1);

width = size(OriginalImage,2);

for i = 1:height
    
    for j = 1:width
        
        if OriginalImage(i,j) > 127
            
%             disp('pixel is lighter');
            
            lighter = lighter + 1;
            
        else
            
%             disp('pixel is darker')
            
            darker = darker + 1;
            
        end
    end
end


if lighter > darker
    
    LighterAlgo = 1;
    
    fprintf('\n \n \n \n \t *****IMAGE IS LIGHTER*****\n\n\n\n');
    
else
    
    DarkerAlgo = 1;

    fprintf('\n \n \n \n \t *****IMAGE IS DARKER*****\n\n\n\n');
    
end



