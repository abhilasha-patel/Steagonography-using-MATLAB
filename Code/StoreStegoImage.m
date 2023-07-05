function [StegoPath] = StoreStegoImage(StegoImage)


%global StegoPath;


 %StegoImage=imnoise(StegoImage,'speckle',0.04);
 
[FileName, PathName] = uiputfile('*.*', 'Save As','Output.png');
StegoPath = fullfile(PathName,FileName);  
imwrite(StegoImage, StegoPath);
