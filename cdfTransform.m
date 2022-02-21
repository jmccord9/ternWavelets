function Itrans = cdfTransform(I,keepratio)

A3 = size(I,3);
if A3 == 3
    I = I/255;
    X(:,:,1) = 0.299*I(:,:,1) + 0.587*I(:,:,2) + 0.114*I(:,:,3);
    X(:,:,2) = -0.168736*I(:,:,1) + -0.331264*I(:,:,2) + 0.5*I(:,:,3);
    X(:,:,3) = 0.5*I(:,:,1) + -0.418688*I(:,:,2) + -0.081312*I(:,:,3);
    I = min(max(X,-1),1);
end

level = wmaxlev(min(size(I,[1,2])),'bior4.4');

X = waveletcdf97(I,level);
keepnum = floor(keepratio*numel(X));
[~,vvv] = sort(abs(X(:)));
X(vvv(1:end-keepnum)) = 0;
Itrans = waveletcdf97(X,-level);

if A3 == 3
    Itrans = min(max(Itrans,-1),1);
    X0recover(:,:,1) = 1*Itrans(:,:,1) + -0.000001218894189*Itrans(:,:,2) +  1.401999588657340*Itrans(:,:,3);  
    X0recover(:,:,2) = 1*Itrans(:,:,1) + -0.344135678165337*Itrans(:,:,2) + -0.714136155581812*Itrans(:,:,3);  
    X0recover(:,:,3) = 1*Itrans(:,:,1) +  1.772000066073816*Itrans(:,:,2) +  0.000000406298063*Itrans(:,:,3);  
    Itrans = 255*min(max(X0recover,0),1);
end