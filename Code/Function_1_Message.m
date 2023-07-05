function [ message, Length_of_Message] = Function_1_Message(GetMessage)


message = strtrim(GetMessage);  %trim extra 0's

AsciiCode = uint8(message);

message = transpose(dec2bin(AsciiCode,8));

message = transpose(message(:));

Length_of_Message = length(message);
