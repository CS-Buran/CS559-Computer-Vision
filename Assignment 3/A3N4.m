%camera is recording 30fps
%vehicle on ruler for 5 frames/0.166667 seconds
%ruler is 125 cm or 100%

F1 = imread('Frame 1.png');% read in first frame 
F5 = imread('Frame 5.png');% read in fifth frame
var1 = 0; %number of blue pixels in image 1
var2 = 0; %number of blue pixels in image 2
for height = 1:size(F1,1)
    for width = 1:size(F1,2)
        if F1(height,width,1) > 160 || F1(height,width,2) > 160 || F1(height,width,3) < 190
            %RGB if red>160 or greewidth>160 or Blue <190
            F1(height,width,:) = [0 0 0]; 
            %replace the selected pixel with  black 
        else
            var1 = var1+1;
        end
 end
end
 
for height = 1:size(F5,1)
    for width = 1:size(F5,2)
        if F5(height,width,1) > 160 || F5(height,width,2) > 160 || F5(height,width,3) < 190
            %RGB if red>160 or greewidth>160 or Blue <190
            F5(height,width,:) = [0 0 0]; 
            %replace the selected pixel with  black 
        else
            var2 = var2+1;
        end
 end
end

%calculate percent of ruler left visible after 5th frame
k = ((var2 .* 100)./var1)./100;

%calculate amount of centemeters traveled on the ruler
traveled = (125 - (125.* k)) ./ 100;

tRound = round(traveled .* 100);
%lastly calculate the distance the car would travel in 1 second if this is
%the distance traveled in 5 frames i.e. 5/30th of a second
metersPerSecond = round(traveled ./ 0.166667);

%convert to miles per hour
mph = round(metersPerSecond  .* 2.2369);
imshow(F5)
disp (var1)
disp(var2)
fprintf('Distance traveled: %d centemeters\n', tRound);
fprintf ('Speed: %d miles per hour\n', mph);







