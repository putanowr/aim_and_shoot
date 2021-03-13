## First attempt at creating GUI controls for aim_and_shoot game.
## The code is based on code found at:
## https://wiki.octave.org/Uicontrols

close all
clear h

graphics_toolkit qt

h.ax = axes ("position", [0.05 0.5 0.9 0.48]);

function update_plot (obj, init = false)
  ## gcbo holds the handle of the control
  h = guidata (obj);
  replot = false;
  recalc = false;
  switch (gcbo)
    case {h.fire_pushbutton}
      disp('fire')
    case {h.angle_slider}
      recalc = true;
    case {h.velocity_slider}
      recalc = true;
  endswitch

  if (recalc || init)
    angle = get (h.angle_slider, "value");
    angle *= 90;
    set (h.angle_label, "string", sprintf ("Angle: %2.0f degrees", angle));
    fprintf('Set angle to %f\n', angle);
    vel = get(h.velocity_slider, "value");
    vel *= 20;
    set (h.velocity_label, "string", sprintf ("Velocity: %4.1f m/s", vel));
  endif
 
endfunction

## print figure
sliderHeight=0.04
h.fire_pushbutton = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Fire",
                                "backgroundcolor", [0.9, 0.1, 0.1], 
                                "callback", @update_plot,
                                "position", [0.05 0.01 0.35 0.09]);

h.angle_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Angle:",
                           "backgroundcolor", [0.9, 0.8, 0.9], 
                           "horizontalalignment", "left",
                           "position", [0.05 0.35 0.35 0.08]);

h.angle_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "backgroundcolor", [0.9, 0.3, 0.9],
                            "callback", @update_plot,
                            "value", 0.5,
                            "position", [0.05 0.30 0.90 sliderHeight]);
                            
 h.velocity_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Velocity:",
                           "backgroundcolor", [0.9, 0.8, 0.9], 
                           "horizontalalignment", "left",
                           "position", [0.05 0.2 0.35 0.08]);

h.velocity_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", 0.5,
                            "position", [0.05 0.15 0.90 sliderHeight]);                           

set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (gcf, h)
update_plot (gcf, true);