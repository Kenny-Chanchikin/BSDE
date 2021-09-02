%%Backward Stochastic Differential Equation
%-dYt = f(t,Yt,Zt)dt - ZtdWt
n = 1000;   %iteration
T = 1;   %terminal time
dt = 1/n;   %step size
sqrt_dt = sqrt(dt);

%## Generate Brownian Motion 
B = BrownianMotion(n);

%## Terminal values of Y 
for i = 1:n+1
    Y(n+1,i) = xi(B(n+1,i));
end

%## Explicit solution of Y and Z 
for i = n:-1:1
    for j = 1:i
        Z(i,j) = (Y(i+1,j)-Y(i+1,j+1))/(2*sqrt_dt);
        Expectation_Y = (Y(i+1,j) + Y(i+1,j+1))/2;
        Y(i,j) = Expectation_Y + g(i*dt,Expectation_Y,Z(i,j))*dt;
    end
end

Y(1,1)

%%## Show the figure
path1 = ones(n,1);
path2 = ones(n,1);
pathy1 = zeros(n,1);
pathy2 = zeros(n,1);
pathz1 = zeros(n,1);
pathz2 = zeros(n,1);
epsilon1 = sign(rand(n,1)-0.5);
epsilon2 = sign(rand(n,1)-0.5);
for i = 2:n+1
    path1(i) = path1(i-1)- epsilon1(i-1)/2 + 1/2;
    path2(i) = path2(i-1)- epsilon2(i-1)/2 + 1/2;
end
for i = 1:n+1
    pathy1(i)=Y(i,path1(i));
    pathy2(i)=Y(i,path2(i));
end
for i = 1:n
    pathz1(i)=Z(i,path1(i));
    pathz2(i)=Z(i,path2(i));
end

figure
plot([0:dt:1],[pathy1])
hold on
plot([0:dt:1],[pathy2])
xlabel('t')
ylabel('y')
title('Simulation result of y(t)')

figure 
plot([0:dt:1-dt],[pathz1])
hold on
plot([0:dt:1-dt],[pathz2])
xlabel('t')
ylabel('z')
title('Simulation result of z(t)')