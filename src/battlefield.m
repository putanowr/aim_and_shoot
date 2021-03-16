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
  t1 = move_tank(t1, [3,2]);
  
  draw_tank(gca, t1);
  draw_tank(gca, t2);
      
  stepNorth=[0,1];
  stepEast=[1,0];
  stepWest=[-1,0];
  stepSouth=[0,-1];
  while true
    k = kbhit(1);
    if (isempty(double(k)))
      continue
    elseif double(k) == 27
      break
    else
      switch k
        case 'w'
          t1 = move_tank(t1, stepNorth);
        case 'd'
          t1 = move_tank(t1, stepEast);
        case 's'
          t1 = move_tank(t1, stepSouth);
        case 'a'
          t1 = move_tank(t1, stepWest);
      endswitch
      cla;    
      draw_tank(gca, t1);
      draw_tank(gca, t2);  
    end 
  end % main even loop
  clf
  close(gcf, 'force')
end

function draw_tank(ax, tank)
  tank.gh = patch(ax, tank.xy(1,:), tank.xy(2,:), tank.color);
end  
  
function tank = move_tank(tank, displacement)
  tank.xy(1,:) += displacement(1);
  tank.xy(2,:) += displacement(2);
end
  
function tank = create_tank(w, h, color)
  tank.xy = [0, 1, 2, 1, 0, 0;
         -0.5,-0.5,0, 0.5, 0.5, -0.5];
  tank.xy(1,:) *= w;
  tank.xy(2,:) *= h;
  tank.color = color;
end   