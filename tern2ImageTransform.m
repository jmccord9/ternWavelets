function [X] = tern2ImageTransform(u,data,dir)

N = size(data,2);
boundType = mod(N,3);

%---------------------------------------------
%          Wavelet Transform
%---------------------------------------------

if dir == 1 % forward transform
    
    if boundType == 0

        X  = zeros(size(data));      Xtemp = X;
        a  = 0:3:N-3;a(1)=1;         b     = 2:3:N-1;             c = 4:3:N+1;c(end)=N;
        d1 = 3:3:N;                  e1    = 4:3:N+1;e1(end)=N;
        d2 = 0:3:N;d2(1)=1;          e2    = 1:3:N+1;e2(end)=N;
        end1 = -2:3:N-5;end1(1)=3;   end2 = 2:3:N-1;              end3 = 6:3:N+3;end3(end)=N-2;
        
        Xtemp(:,end1,:)    = u{3}(1,1)*data(:,a,:)   + u{3}(2,1)*data(:,b,:)    + u{3}(3,1)*data(:,c,:);
        Xtemp(:,end2,:)    = u{3}(1,2)*data(:,a,:)   + u{3}(2,2)*data(:,b,:)    + u{3}(3,2)*data(:,c,:);
        Xtemp(:,end3,:)    = u{3}(1,3)*data(:,a,:)   + u{3}(2,3)*data(:,b,:)    + u{3}(3,3)*data(:,c,:);
        X(:,end1,:)        = u{2}(1,1)*Xtemp(:,a,:)  + u{2}(2,1)*Xtemp(:,b,:)   + u{2}(3,1)*Xtemp(:,c,:);
        X(:,end2,:)        = u{2}(1,2)*Xtemp(:,a,:)  + u{2}(2,2)*Xtemp(:,b,:)   + u{2}(3,2)*Xtemp(:,c,:);
        X(:,end3,:)        = u{2}(1,3)*Xtemp(:,a,:)  + u{2}(2,3)*Xtemp(:,b,:)   + u{2}(3,3)*Xtemp(:,c,:);
        Xtemp(:,1:3:N-2,:) = u{1}(1,1)*X(:,a,:)      + u{1}(2,1)*X(:,b,:)       + u{1}(3,1)*X(:,c,:);
        Xtemp(:,2:3:N-1,:) = u{1}(1,2)*X(:,a,:)      + u{1}(2,2)*X(:,b,:)       + u{1}(3,2)*X(:,c,:);
        Xtemp(:,3:3:N,:)   = u{1}(1,3)*X(:,a,:)      + u{1}(2,3)*X(:,b,:)       + u{1}(3,3)*X(:,c,:);
        Bminus             = u{4}(1,1)*Xtemp(:,d1,:) + u{4}(2,1)*Xtemp(:,e1,:);
        Bplus              = u{4}(1,2)*Xtemp(:,d2,:) + u{4}(2,2)*Xtemp(:,e2,:);
        Bminus(:,end,:)    = Bplus(:,end,:);
        X                  = [Bplus(:,1:1:end-1,:) Xtemp(:,2:3:N-1,:) Bminus];
        
    elseif boundType == 1
        
        X  = zeros(size(data));    Xtemp = X;
        a0 = 2:3:N-2;              b0    = 4:3:N;     c0 = 6:3:N+2;c0(end)=N-2;
        a1 = -1:3:N-2;a1(1)=3;     b1    = 1:3:N;     c1 = 3:3:N+2;c1(end)=N-2;
        a2 = -1:3:N-5;a2(1)=3;     b2    = 1:3:N-3;   c2 = 3:3:N-1;
        d  = 2:3:N-2;              e     = 3:3:N-1;
        end1 = 0:3:N-4;end1(1)=2;  end2  = 1:3:N;     end3 = 5:3:N+1;end3(end)=N-1;
        
        Xtemp(:,end1,:)    = u{3}(1,1)*data(:,a0,:)  + u{3}(2,1)*data(:,b0,:)   + u{3}(3,1)*data(:,c0,:);
        Xtemp(:,end2,:)    = u{3}(1,2)*data(:,a1,:)  + u{3}(2,2)*data(:,b1,:)   + u{3}(3,2)*data(:,c1,:);
        Xtemp(:,end3,:)    = u{3}(1,3)*data(:,a2,:)  + u{3}(2,3)*data(:,b2,:)   + u{3}(3,3)*data(:,c2,:);
        X(:,end1,:)        = u{2}(1,1)*Xtemp(:,a0,:) + u{2}(2,1)*Xtemp(:,b0,:)  + u{2}(3,1)*Xtemp(:,c0,:);
        X(:,end2,:)        = u{2}(1,2)*Xtemp(:,a1,:) + u{2}(2,2)*Xtemp(:,b1,:)  + u{2}(3,2)*Xtemp(:,c1,:);
        X(:,end3,:)        = u{2}(1,3)*Xtemp(:,a2,:) + u{2}(2,3)*Xtemp(:,b2,:)  + u{2}(3,3)*Xtemp(:,c2,:);
        Xtemp(:,3:3:N-1,:) = u{1}(1,1)*X(:,a0,:)     + u{1}(2,1)*X(:,b0,:)      + u{1}(3,1)*X(:,c0,:);
        Xtemp(:,1:3:N,:)   = u{1}(1,2)*X(:,a1,:)     + u{1}(2,2)*X(:,b1,:)      + u{1}(3,2)*X(:,c1,:);
        Xtemp(:,2:3:N-2,:) = u{1}(1,3)*X(:,a2,:)     + u{1}(2,3)*X(:,b2,:)      + u{1}(3,3)*X(:,c2,:);
        Bminus             = u{4}(1,1)*Xtemp(:,d,:)  + u{4}(2,1)*Xtemp(:,e,:);
        Bplus              = u{4}(1,2)*Xtemp(:,d,:)  + u{4}(2,2)*Xtemp(:,e,:);
        X                  = [Bplus Xtemp(:,1:3:N,:) Bminus];
        
    elseif boundType == 2
        
        X    = zeros(size(data));   Xtemp = X;
        a0   = 2:3:N-3;             b0    = 4:3:N-1;            c0   = 6:3:N+1;c0(end)=N;
        a    = -1:3:N-3;a(1)=3;     b     = 1:3:N-1;            c    = 3:3:N+1;c(end)=N;
        d    = 2:3:N;               e     = 3:3:N+1;e(end)=N;
        end1 = 0:3:N-5;end1(1)=2;   end2  = 1:3:N-1;            end3 = 5:3:N+3;end3(end)=N-2;
        
        Xtemp(:,end1,:)    = u{3}(1,1)*data(:,a0,:)  + u{3}(2,1)*data(:,b0,:)  + u{3}(3,1)*data(:,c0,:);
        Xtemp(:,end2,:)    = u{3}(1,2)*data(:,a,:)   + u{3}(2,2)*data(:,b,:)   + u{3}(3,2)*data(:,c,:);
        Xtemp(:,end3,:)    = u{3}(1,3)*data(:,a,:)   + u{3}(2,3)*data(:,b,:)   + u{3}(3,3)*data(:,c,:);
        X(:,end1,:)        = u{2}(1,1)*Xtemp(:,a0,:) + u{2}(2,1)*Xtemp(:,b0,:) + u{2}(3,1)*Xtemp(:,c0,:);
        X(:,end2,:)        = u{2}(1,2)*Xtemp(:,a,:)  + u{2}(2,2)*Xtemp(:,b,:)  + u{2}(3,2)*Xtemp(:,c,:);
        X(:,end3,:)        = u{2}(1,3)*Xtemp(:,a,:)  + u{2}(2,3)*Xtemp(:,b,:)  + u{2}(3,3)*Xtemp(:,c,:);
        Xtemp(:,3:3:N-2,:) = u{1}(1,1)*X(:,a0,:)     + u{1}(2,1)*X(:,b0,:)     + u{1}(3,1)*X(:,c0,:);
        Xtemp(:,1:3:N-1,:) = u{1}(1,2)*X(:,a,:)      + u{1}(2,2)*X(:,b,:)      + u{1}(3,2)*X(:,c,:);
        Xtemp(:,2:3:N,:)   = u{1}(1,3)*X(:,a,:)      + u{1}(2,3)*X(:,b,:)      + u{1}(3,3)*X(:,c,:);
        Bminus             = u{4}(1,1)*Xtemp(:,d,:)  + u{4}(2,1)*Xtemp(:,e,:);
        Bplus              = u{4}(1,2)*Xtemp(:,d,:)  + u{4}(2,2)*Xtemp(:,e,:);
        Bminus(:,end,:)    = Bplus(:,end,:);
        X                  = [Bplus(:,1:1:end-1,:) Xtemp(:,1:3:N-1,:) Bminus];
        
    end
    
elseif dir == -1 % backward transform
    
    
    if boundType == 0
        
        n    = N/3;
        X    = zeros(size(data));   Xtemp = X;
        d    = 2*n+1:1:N-1;         e     = 2:1:n;
        a    = -2:3:N-5;a(1)=3;     b     = 2:3:N-1;   c    = 6:3:N+3;c(end)=N-2;
        end1 = 0:3:N-2;end1(1)=1;   end2  = 2:3:N-1;   end3 = 4:3:N+1;end3(end)=N;
        
        Xtemp(:,2:3:N-1,:) = data(:,n+1:1:2*n,:);
        Xtemp(:,3:3:N-3,:) = u{4}(1,1)*data(:,d,:)        + u{4}(1,2)*data(:,e,:);
        Xtemp(:,4:3:N-2,:) = u{4}(2,1)*data(:,d,:)        + u{4}(2,2)*data(:,e,:);
        Xtemp(:,[1 N],:)   = u{4}(2,2)*data(:,[1 N],:);
        X(:,end1,:)        = u{1}(1,1)*Xtemp(:,1:3:N-2,:) + u{1}(1,2)*Xtemp(:,2:3:N-1,:) + u{1}(1,3)*Xtemp(:,3:3:N,:);
        X(:,end2,:)        = u{1}(2,1)*Xtemp(:,1:3:N-2,:) + u{1}(2,2)*Xtemp(:,2:3:N-1,:) + u{1}(2,3)*Xtemp(:,3:3:N,:);
        X(:,end3,:)        = u{1}(3,1)*Xtemp(:,1:3:N-2,:) + u{1}(3,2)*Xtemp(:,2:3:N-1,:) + u{1}(3,3)*Xtemp(:,3:3:N,:);
        Xtemp(:,end1,:)    = u{2}(1,1)*X(:,a,:)           + u{2}(1,2)*X(:,b,:)           + u{2}(1,3)*X(:,c,:);
        Xtemp(:,end2,:)    = u{2}(2,1)*X(:,a,:)           + u{2}(2,2)*X(:,b,:)           + u{2}(2,3)*X(:,c,:);
        Xtemp(:,end3,:)    = u{2}(3,1)*X(:,a,:)           + u{2}(3,2)*X(:,b,:)           + u{2}(3,3)*X(:,c,:);
        X(:,end1,:)        = u{3}(1,1)*Xtemp(:,a,:)       + u{3}(1,2)*Xtemp(:,b,:)       + u{3}(1,3)*Xtemp(:,c,:);
        X(:,end2,:)        = u{3}(2,1)*Xtemp(:,a,:)       + u{3}(2,2)*Xtemp(:,b,:)       + u{3}(2,3)*Xtemp(:,c,:);
        X(:,end3,:)        = u{3}(3,1)*Xtemp(:,a,:)       + u{3}(3,2)*Xtemp(:,b,:)       + u{3}(3,3)*Xtemp(:,c,:);
        
    elseif boundType == 1
        
        n    = (N-1)/3;
        X    = zeros(size(data));          Xtemp = X;
        d    = 2*(n+1):1:N;                e     = 1:1:n;
        a0   = 3:3:N-1;                    b0    = 4:3:N;    c0   = 5:3:N+1;c0(end)=N-1;
        a1   = 0:3:N-1;a1(1)=2;            b1    = 1:3:N;    c1   = 2:3:N+1;c1(end)=N-1;
        a2   = 0:3:N-4;a2(1)=2;            b2    = 1:3:N-3;  c2   = 2:3:N-2;
        a3   = 0:3:N-4;a3(1)=2;            b3    = 4:3:N;    c3   = 8:3:N+4;c3(end-1)=N-1;c3(end)=N-4;
        a4   = -3:3:N-4;a4(1)=5;a4(2)=2;   b4    = 1:3:N;    c4   = 5:3:N+4;c4(end-1)=N-1;c4(end)=N-4;      
        a5   = -3:3:N-7;a5(1)=5;a5(2)=2;   b5    = 1:3:N-3;  c5   = 5:3:N+1;c5(end)=N-1;
        end1 = 2:3:N-2;                    end2  = 1:3:N;    end3 = 3:3:N-1;
        
        Xtemp(:,1:3:N,:)   = data(:,n+1:1:2*n+1,:);
        Xtemp(:,2:3:N-2,:) = u{4}(1,1)*data(:,d,:)   + u{4}(1,2)*data(:,e,:);
        Xtemp(:,3:3:N-1,:) = u{4}(2,1)*data(:,d,:)   + u{4}(2,2)*data(:,e,:);
        X(:,end1,:)        = u{1}(1,1)*Xtemp(:,a0,:) + u{1}(1,2)*Xtemp(:,b0,:) + u{1}(1,3)*Xtemp(:,c0,:);
        X(:,end2,:)        = u{1}(2,1)*Xtemp(:,a1,:) + u{1}(2,2)*Xtemp(:,b1,:) + u{1}(2,3)*Xtemp(:,c1,:);
        X(:,end3,:)        = u{1}(3,1)*Xtemp(:,a2,:) + u{1}(3,2)*Xtemp(:,b2,:) + u{1}(3,3)*Xtemp(:,c2,:);
        Xtemp(:,end1,:)    = u{2}(1,1)*X(:,a3,:)     + u{2}(1,2)*X(:,b3,:)     + u{2}(1,3)*X(:,c3,:);
        Xtemp(:,end2,:)    = u{2}(2,1)*X(:,a4,:)     + u{2}(2,2)*X(:,b4,:)     + u{2}(2,3)*X(:,c4,:);
        Xtemp(:,end3,:)    = u{2}(3,1)*X(:,a5,:)     + u{2}(3,2)*X(:,b5,:)     + u{2}(3,3)*X(:,c5,:);
        X(:,end1,:)        = u{3}(1,1)*Xtemp(:,a3,:) + u{3}(1,2)*Xtemp(:,b3,:) + u{3}(1,3)*Xtemp(:,c3,:);
        X(:,end2,:)        = u{3}(2,1)*Xtemp(:,a4,:) + u{3}(2,2)*Xtemp(:,b4,:) + u{3}(2,3)*Xtemp(:,c4,:);
        X(:,end3,:)        = u{3}(3,1)*Xtemp(:,a5,:) + u{3}(3,2)*Xtemp(:,b5,:) + u{3}(3,3)*Xtemp(:,c5,:);
        
    elseif boundType == 2
        
        n    = (N-2)/3;
        X    = zeros(size(data));        Xtemp = X;
        d    = 2*(n+1):1:N-1;            e     = 1:1:n;
        a0   = 3:3:N-2;                  b0    = 4:3:N-1;   c0   = 5:3:N;
        a    = 0:3:N-2;a(1)=2;           b     = 1:3:N-1;   c    = 2:3:N;
        a1 = 0:3:N-5;a1(1)=2;            b1 = 4:3:N-1;      c1 = 8:3:N+3;c1(end)=N-2;
        a2 = -3:3:N-5;a2(1)=5;a2(2)=2;   b2 = 1:3:N-1;      c2 = 5:3:N+3;c2(end)=N-2;
        end1 = 2:3:N-3;                  end2  = 1:3:N-1;   end3 = 3:3:N+1;end3(end)=N;
        
        Xtemp(:,1:3:N-1,:) = data(:,n+1:1:2*n+1,:);
        Xtemp(:,2:3:N-3,:) = u{4}(1,1)*data(:,d,:)   + u{4}(1,2)*data(:,e,:);
        Xtemp(:,3:3:N-2,:) = u{4}(2,1)*data(:,d,:)   + u{4}(2,2)*data(:,e,:);
        Xtemp(:,N,:)       = u{4}(2,2)*data(:,N,:);
        X(:,end1,:)        = u{1}(1,1)*Xtemp(:,a0,:) + u{1}(1,2)*Xtemp(:,b0,:) + u{1}(1,3)*Xtemp(:,c0,:);
        X(:,end2,:)        = u{1}(2,1)*Xtemp(:,a,:)  + u{1}(2,2)*Xtemp(:,b,:)  + u{1}(2,3)*Xtemp(:,c,:);
        X(:,end3,:)        = u{1}(3,1)*Xtemp(:,a,:)  + u{1}(3,2)*Xtemp(:,b,:)  + u{1}(3,3)*Xtemp(:,c,:);
        Xtemp(:,end1,:)    = u{2}(1,1)*X(:,a1,:)     + u{2}(1,2)*X(:,b1,:)     + u{2}(1,3)*X(:,c1,:);
        Xtemp(:,end2,:)    = u{2}(2,1)*X(:,a2,:)     + u{2}(2,2)*X(:,b2,:)     + u{2}(2,3)*X(:,c2,:);
        Xtemp(:,end3,:)    = u{2}(3,1)*X(:,a2,:)     + u{2}(3,2)*X(:,b2,:)     + u{2}(3,3)*X(:,c2,:);
        X(:,end1,:)        = u{3}(1,1)*Xtemp(:,a1,:) + u{3}(1,2)*Xtemp(:,b1,:) + u{3}(1,3)*Xtemp(:,c1,:);
        X(:,end2,:)        = u{3}(2,1)*Xtemp(:,a2,:) + u{3}(2,2)*Xtemp(:,b2,:) + u{3}(2,3)*Xtemp(:,c2,:);
        X(:,end3,:)        = u{3}(3,1)*Xtemp(:,a2,:) + u{3}(3,2)*Xtemp(:,b2,:) + u{3}(3,3)*Xtemp(:,c2,:);
        
    end
    
end

%---------------------------------------------