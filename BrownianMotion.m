function H = BrownianMotion(n)
T = 1;
dt = T/n;
H(1,1)=0;
for i = 2:n+1
    H(i,1) = H(i-1,1)+ sqrt(dt);
    for j = 2:i
        H(i,j) = H(i,j-1)- 2*sqrt(dt);
    end
end

