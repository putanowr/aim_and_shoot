function battlefield()
  L=20;  % size of the battlefied
  f = figure('position', [0,0,800,800]);
  axis([-L,L, -L, L])
  axis('square')
  title('Keep focus in command window')
  xlabel('W=North, A=West, S=South D=East, Esc=Quit')
  hold on;

  t1 = create_tank(1,1, 'blue');
  t2 = create_tank(1,1, 'red');
  t1 = move_tank(t1, 2);
  redraw_tank(t1);
  
  bullets_table = [];
  

  tankStep = 1; % length of displacement
  tankRot = 5;  % degrees of unit rotation
  pause(3);
  while true
    k = kbhit(1);
    bullets_table = update_bullets(bullets_table);
    if (isempty(double(k)))
      continue
    elseif double(k) == 27
      break
    else
      switch k
        case 'w'
          t1 = move_tank(t1, tankStep);
        case 's'
          t1 = move_tank(t1, -tankStep);        
        case 'a'
          t1 = rotate_tank(t1, tankRot);
        case 'd'
          t1 = rotate_tank(t1, -tankRot);
        case 'f'
          h = scatter(gca, t1.pos(1), t1.pos(2), 'o', 'fill', 'markerfacecolor', 'yellow')
          set(h, 'userdata', t1.dir);
          bullets_table = [bullets_table, h];
      endswitch    
      redraw_tank(t1);
      redraw_tank(t2);
    end
  end % main even loop
  clf
  close(gcf, 'force')
end

function k=wait_for_key()
   k=[];
   for i=1:100
     k = kbhit(1);
   endfor
end

function bullets = update_bullets(bullets)
  for i = 1:numel(bullets)
    h = bullets(i);
    x = get(h, 'xdata');
    y = get(h, 'ydata');
    if abs(x) > 20 || abs(y) > 20
      bullets(i) = [];
      continue
    endif
    dir = get(h, 'userdata')
    set(h, 'xdata', x + dir(1)*0.1);
    set(h, 'ydata', y + dir(2)*0.1);
  endfor
end

function redraw_tank(tank)
  set(tank.gh, 'xdata',  tank.xy(1,:));
  set(tank.gh, 'ydata',  tank.xy(2,:));
end  
  
function tank = move_tank(tank, displacement)  
  tank.xy += displacement*tank.dir;
  tank.pos += displacement*tank.dir;
end


function tank = rotate_tank(tank, angle)
  angle = deg2rad(angle);
  c = cos(angle);
  s = sin(angle);
  M = [c, -s; s, c];
  tank.dir =  M * tank.dir;
  for i=1:size(tank.xy,2)
    tank.xy(:,i) = M * (tank.xy(:,i)-tank.pos) + tank.pos;
  endfor
end
  
function tank = create_tank(w, h, color)
  tank.xy = [0, 1, 2, 1, 0, 0;
         -0.5,-0.5,0, 0.5, 0.5, -0.5];
  tank.xy(1,:) *= w;
  tank.xy(2,:) *= h;
  tank.dir = [1;0];
  tank.pos = [1;0];
  tank.color = color;
  tank.gh = patch(gca, tank.xy(1,:), tank.xy(2,:), tank.color);
end   