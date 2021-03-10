% Simpe game based on projectile motion in 2D
clear all
clf
animationDelay = 0.1 % in seconds
movie_file = 'aim_and_shoot.gif'
movie_size = '-S400,400'
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

target.x = 8;
target.y = 6;
target.dx = 0.5;
target.dy = 0.5;
target.xcoords = [-1,1,1,-1,-1]*target.dx + target.x;
target.ycoords = [-1,-1,1,1,-1]*target.dy + target.y;

% Initialize array for stroing velocity and position components
xt(1) = x;
yt(1) = y;
vxt(1) = vx;
vyt(1) = vy;

% Iterate over time steps
plot(target.xcoords, target.ycoords, '-r');
grid
axis([-1, 12, -1, 7])
axis equal
frame_data(:,:,:,1) = print("-RGBImage", "-dpng", movie_size);
frame_data(:,:,:,2) = print("-RGBImage", "-dpng", movie_size);
imwrite(frame_data,movie_file,'gif','writemode','overwrite',...
        'LoopCount',inf,'DelayTime',0);
hold on
for i = 2 : 200
    vxt(i) = vxt(i-1);
    vyt(i) = vyt(i-1) - g*dt;
    xt(i) = xt(i-1) + vxt(i-1)*dt;
    yt(i) = yt(i-1) + vyt(i-1)*dt; 
	  line([xt(i-1),xt(i)], [yt(i-1), yt(i)], 'Color', 'green')
    pause(animationDelay);
    frame_data = print("-RGBImage", "-dpng", movie_size);
    imwrite(frame_data,movie_file,'gif','writemode','append','DelayTime',0)
    if (yt(i)< 0)
      break;
    end
end

% Visualise projectile trajectory
        
plot(xt, yt, '*b');
last_frame = print("-RGBImage", "-dpng", movie_size);
imwrite(last_frame,movie_file,'gif','writemode','append','DelayTime',0.5)
hold on

