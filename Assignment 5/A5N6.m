
function [J, J2, J3]=A5N6(~,x,y,reg_maxdist, x2,y2,reg_maxdist2, x3,y3,reg_maxdist3)

I = im2double(imread('I.jpg'));

if(exist('reg_maxdist','var')==0), reg_maxdist=0.1; end
if(exist('y','var')==0), figure, imshow(I,[]); [y,x]=getpts; y=round(y(1)); x=round(x(1)); end

if(exist('reg_maxdist2','var')==0), reg_maxdist2=0.1; end
if(exist('y2','var')==0), figure, imshow(I,[]); [y2,x2]=getpts; y2=round(y2(1)); x2=round(x2(1)); end

if(exist('reg_maxdist3','var')==0), reg_maxdist3=0.1; end
if(exist('y3','var')==0), figure, imshow(I,[]); [y3,x3]=getpts; y3=round(y3(1)); x3=round(x3(1)); end


J = zeros(size(I)); % Output 
J2 = zeros(size(I));
J3 = zeros(size(I));

Isizes = size(I); % Dimensions of input image

reg_mean = I(x,y); % The mean of the segmented region
reg_mean2 = I(x2,y2);
reg_mean3 = I(x3,y3);


reg_size = 1; % Number of pixels in region
reg_size2 = 1;
reg_size3 = 1;

% Free memory to store neighbours of the (segmented) region
neg_free = 10000; neg_pos=0;
neg_list = zeros(neg_free,3); 

neg_free2 = 10000; neg_pos2=0;
neg_list2 = zeros(neg_free2,3);

neg_free3 = 10000; neg_pos3=0;
neg_list3 = zeros(neg_free3,3);

pixdist=0; % Distance of the region newest pixel to the regio mean
pixdist2=0;
pixdist3=0;



% Neighbor locations (footprint)
neigb=[-1 0; 1 0; 0 -1;0 1];
neigb2=[-1 0; 1 0; 0 -1;0 1];
neigb3=[-1 0; 1 0; 0 -1;0 1];

% Start regiogrowing until distance between regio and posible new pixels become
% higher than a certain treshold
while(pixdist<reg_maxdist&&reg_size<numel(I))
    % Add new neighbors pixels
    for j=1:4
        % Calculate the neighbour coordinate
        xn = x +neigb(j,1); yn = y +neigb(j,2);
        
        % Check if neighbour is inside or outside the image
        ins=(xn>=1)&&(yn>=1)&&(xn<=Isizes(1))&&(yn<=Isizes(2));
        
        % Add neighbor if inside and not already part of the segmented area
        if(ins&&(J(xn,yn)==0)) 
                neg_pos = neg_pos+1;
                neg_list(neg_pos,:) = [xn yn I(xn,yn)]; J(xn,yn)=1;
        end
    end
    % Add a new block of free memory
    if(neg_pos+10>neg_free), neg_free=neg_free+10000; neg_list((neg_pos+1):neg_free,:)=0; end
    
    % Add pixel with intensity nearest to the mean of the region, to the region
    dist = abs(neg_list(1:neg_pos,3)-reg_mean);
    [pixdist, index] = min(dist);
    J(x,y)=2; reg_size=reg_size+1;
    
    % Calculate the new mean of the region
    reg_mean= (reg_mean*reg_size + neg_list(index,3))/(reg_size+1);
    
    % Save the x and y coordinates of the pixel (for the neighbour add proccess)
    x = neg_list(index,1); y = neg_list(index,2);
    
    % Remove the pixel from the neighbour (check) list
    neg_list(index,:)=neg_list(neg_pos,:); neg_pos=neg_pos-1;
end

while(pixdist2<reg_maxdist2&&reg_size2<numel(I))
    % Add new neighbors pixels
    for j=1:4
        % Calculate the neighbour coordinate
        xn = x2 +neigb2(j,1); yn = y2 +neigb2(j,2);
        
        % Check if neighbour is inside or outside the image
        ins=(xn>=1)&&(yn>=1)&&(xn<=Isizes(1))&&(yn<=Isizes(2));
        
        % Add neighbor if inside and not already part of the segmented area
        if(ins&&(J2(xn,yn)==0)) 
                neg_pos2 = neg_pos2+1;
                neg_list2(neg_pos2,:) = [xn yn I(xn,yn)]; J(xn,yn)=1;
        end
    end
    % Add a new block of free memory
    if(neg_pos2+10>neg_free2), neg_free2=neg_free2+10000; neg_list2((neg_pos2+1):neg_free2,:)=0; end
    
    % Add pixel with intensity nearest to the mean of the region, to the region
    dist = abs(neg_list2(1:neg_pos2,3)-reg_mean);
    [pixdist2, index] = min(dist);
    J2(x2,y2)=2; reg_size2=reg_size2+1;
    
    % Calculate the new mean of the region
    reg_mean2= (reg_mean2*reg_size2 + neg_list2(index,3))/(reg_size2+1);
    
    % Save the x and y coordinates of the pixel (for the neighbour add proccess)
    x2 = neg_list2(index,1); y2 = neg_list2(index,2);
    
    % Remove the pixel from the neighbour (check) list
    neg_list2(index,:)=neg_list2(neg_pos2,:); neg_pos2=neg_pos2-1;
end


while(pixdist3<reg_maxdist3&&reg_size3<numel(I))
    % Add new neighbors pixels
    for j=1:4
        % Calculate the neighbour coordinate
        xn = x3 +neigb3(j,1); yn = y3 +neigb3(j,2);
        
        % Check if neighbour is inside or outside the image
        ins=(xn>=1)&&(yn>=1)&&(xn<=Isizes(1))&&(yn<=Isizes(2));
        
        % Add neighbor if inside and not already part of the segmented area
        if(ins&&(J3(xn,yn)==0)) 
                neg_pos3 = neg_pos3+1;
                neg_list3(neg_pos3,:) = [xn yn I(xn,yn)]; J(xn,yn)=1;
        end
    end
    % Add a new block of free memory
    if(neg_pos3+10>neg_free3), neg_free3=neg_free3+10000; neg_list3((neg_pos3+1):neg_free3,:)=0; end
    
    % Add pixel with intensity nearest to the mean of the region, to the region
    dist = abs(neg_list3(1:neg_pos3,3)-reg_mean3);
    [pixdist3, index] = min(dist);
    J3(x3,y3)=2; reg_size3=reg_size3+1;
    
    % Calculate the new mean of the region
    reg_mean3= (reg_mean3*reg_size3 + neg_list3(index,3))/(reg_size3+1);
    
    % Save the x and y coordinates of the pixel (for the neighbour add proccess)
    x3 = neg_list3(index,1); y3 = neg_list3(index,2);
    
    % Remove the pixel from the neighbour (check) list
    neg_list3(index,:)=neg_list3(neg_pos3,:); neg_pos3=neg_pos3-1;
end


% Return the segmented area as logical matrix
J=J>1;
J2=J2>1;
J3=J3>1;

figure, imshow(I+J+J2+J3);


