function [Itrans] = mainImageTern(I,keepratio)

A = size(I,1,2);
A3 = size(I,3);

%---------------------------------------------
%     Use YCbCr colorspace for processing
%---------------------------------------------

if A3 == 3
    I = I/255;
    X(:,:,1) = 0.299*I(:,:,1) + 0.587*I(:,:,2) + 0.114*I(:,:,3);
    X(:,:,2) = -0.168736*I(:,:,1) + -0.331264*I(:,:,2) + 0.5*I(:,:,3);
    X(:,:,3) = 0.5*I(:,:,1) + -0.418688*I(:,:,2) + -0.081312*I(:,:,3);
    I = min(max(X,-1),1);
end

%---------------------------------------------
%             Rotation Angles
%---------------------------------------------

theta = [0.072130476 0.847695078 -0.576099009 -0.591746629 0.673886987 0.529449713];

%---------------------------------------------
%     Define Wavelet Transform Gates
%---------------------------------------------

u = {};
for i=1:6
    u{i} = 0.5*[cos(theta(i))+1, sqrt(2)*sin(theta(i)), cos(theta(i))-1;
        -sqrt(2)*sin(theta(i)), 2*cos(theta(i)), -sqrt(2)*sin(theta(i));
        cos(theta(i))-1, sqrt(2)*sin(theta(i)), cos(theta(i))+1];
end
u{7} = (sqrt(2)/2)*[1, 1; -1, 1];


%-----------------------------------------
%           Transform Sizes
%-----------------------------------------

M = size(I,1,2);
while 1 > 0
    if M(end,:) < 10
        break
    else
        boundType = mod(M(end,:),3);
        M = [M; 0 0];
        if boundType(1) == 0
            M(end,1) = M(end-1,1)/3;
        elseif boundType(1) == 1
            M(end,1) = (M(end-1,1)+2)/3;
        elseif boundType(1) == 2
            M(end,1) = (M(end-1,1)+1)/3;
        end
        if boundType(2) == 0
            M(end,2) = M(end-1,2)/3;
        elseif boundType(2) == 1
            M(end,2) = (M(end-1,2)+2)/3;
        elseif boundType(2) == 2
            M(end,2) = (M(end-1,2)+1)/3;
        end
    end
end

%-----------------------------------------
%           Forward Transform
%-----------------------------------------

Itrans = zeros(size(I));
for i=1:size(M,1)
    I = ternImageTransform(u,I,1);
    I = permute(ternImageTransform(u,permute(I,[2 1 3]),1), [2 1 3]);
    Itrans(1:M(i,1),1:M(i,2),:) = I;
    if i == size(M,1)
        break
    else
        I = Itrans(1:M(i+1,1),1:M(i+1,2),:);
    end
end

%-----------------------------------------
%              Truncation
%-----------------------------------------

Imid1 = Itrans;
keepnum = floor(keepratio*numel(Itrans));
[~,vvv] = sort(abs(Itrans(:)));
Itrans(vvv(1:end-keepnum)) = 0;
Imid2 = Itrans;

showImage = 10*abs(Itrans(:,:,1));
imshow(showImage)

% %-----------------------------------------
%          Backward Transform
%-----------------------------------------

for i = size(M,1):-1:1
    I = Itrans(1:M(i,1),1:M(i,2),:);
    I = permute(ternImageTransform(u,permute(I,[2 1 3]),-1),[2 1 3]);
    I = ternImageTransform(u,I,-1);
    Itrans(1:M(i,1),1:M(i,2),:) = I;
end

%-----------------------------------------
%     Switch back to RGB colorspace 
%-----------------------------------------

if A3 == 3
    Itrans = min(max(Itrans,-1),1);
    X0recover(:,:,1) = 1*Itrans(:,:,1) + -0.000001218894189*Itrans(:,:,2) +  1.401999588657340*Itrans(:,:,3);  
    X0recover(:,:,2) = 1*Itrans(:,:,1) + -0.344135678165337*Itrans(:,:,2) + -0.714136155581812*Itrans(:,:,3);  
    X0recover(:,:,3) = 1*Itrans(:,:,1) +  1.772000066073816*Itrans(:,:,2) +  0.000000406298063*Itrans(:,:,3);  
    Itrans = 255*min(max(X0recover,0),1);
end

%-----------------------------------------