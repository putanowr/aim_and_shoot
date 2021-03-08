% Simpe game based on projectile motion in 2D
clear all

% Initial condition
v = 10;
alpha = 40;
x = 0; 
y = 0;

dt = 0.05;
g = 9.81;

% Map alha from radians to degree
alpha = alpha * pi/180;

% Calculate velocity components

vx = v * cos(alpha);
vy = v * sin(alpha);

% Initialize array for stroing velocity and position components
xt(1) = x;
yt(1) = y;
vxt(1) = vx;
vyt(1) = vy;

% Iterate over time steps
for i = 2 : 200
    vxt(i) = vxt(i-1);
    vyt(i) = vyt(i-1) - g*dt;
    xt(i) = xt(i-1) + vxt(i-1)*dt;
    yt(i) = yt(i-1) + vyt(i-1)*dt; 
    if (yt(i)< 0)
      break;
    end
end

% Visualise projectile trajectory
plot(xt, yt, '*-b');    
