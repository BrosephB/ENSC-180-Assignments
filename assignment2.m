%can-you-fall-faster-than-the-speed-of-sound/?redirectURL=https%3A%2F%2Fwww.wired.com%2F2012%2F02%2Fstratos-spa…
%redbull.com/ca-en/red-bull-stratos-release-mission-data
%wired.com/2012/07/how-do-you-measure-the-stratos-space-jump
%wired.com/2012/07/analysis-of-a-red-bull-stratos-practice-jump
%% ENSC180-Assignment2

% Student Name 1: Sepehr Borji

% Student 1 #: 123456781

% Student 1 userid (email): stu1 (stu1@sfu.ca)

% Student Name 2: Akashroop Malhi

% Student 2 #: 301393341
% Student 2 userid (email): stu2 (asm19@sfu.ca)

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__

%% Instructions:
% * Put your name(s), student number(s), userid(s) in the above section.
% * Edit the "Helpers" line.  
% * Your group name should be "A2_<userid1>_<userid2>" (eg. A2_stu1_stu2)
% * Form a group 
%   as described at:  https://courses.cs.sfu.ca/docs/students
% * Replace "% <place your work here>" below, or similar, with your own answers and work.
% * Nagvigate to the "PUBLISH" tab (located on top of the editor)
%   * Click on the "Publish" dropdown and choose pdf as 
%     "Output file format" under "Edit Publishing Options..."
%   * Click "Publish" button. Ensure a report is automatically generated
% * You will submit THIS file (assignment2.m),    
%   and the PDF report (assignment2.pdf).
% Craig Scratchley, Spring 2021

%% main

function main

clf

% constants -- you can put constants for the program here
%MY_CONST = 123;'

g = -9.8;



% variables -- you can put variables for the program here
%myVar = 456;

% prepare the data
% <place your work here>
    Table = readtable('./data/data_clean_more_fixed_simplest.xlsx');
    data = table2array(Table);

% ... = xlsread()/csvread()/readtable()
% ...
% myVector(isnan(myVector))=[];

% <put here any conversions that are necessary>

%% Part 1
% Answer some questions here in these comments...
% How accurate is the model for the first portion of the minute? 
% The height vs the height measured is quite similar, in fact they are
% almost identical to eachother for the first portion of the minute. We can
% also state the same for velocity, as they are almost identical again.
% However, the measured acceleration changes quite frequently but remains
% similar to the modelled acceleration. Therfore, all of models are quite
% similar to eachother for the first portion of the minute.

% How accurate is the model for the last portion of that first minute? 
% The three models seems to differ at the start of the last portion of the
% first minute. This is where the values no longer overlap with eachother
% and you can see a difference between the modelled and measured values.

% Comment on the acceleration calculated from the measured data. 
% Is there any way to smooth the acceleration calculated from the data?
% The function smoothdata() helps smooth the acceleration calculated from
% the data.

part = 1;
% model Felix Baumgartner’s altitude, velocity, and acceleration for the 
%     first minute after he jumped from 38,969.4 meters above sea level
[T,M] = ode45(@fall, [0,60], [38959,0]);


% <call here your function to create your plots>
plotComparisons(60, 'Part1 - Freefall', T, M)  

%% Part 2
% Answer some questions here in these comments...
% Estimate your uncertainty in the mass that you have chosen (at the 
%     beginning of the jump). 
% After research, the combined mass that we found was 118kg. The mass
% included felix + pressure suit + helmet with Oxygen + parachute.

% How sensitive is the velocity and altitude reached after 60 seconds to 
%    changes in the chosen mass?
% If we changed the mass to 116kg or 120kg in order to consider the chances
% of calculation error, we noticed that changing mass values leads to
% change in terminal velocity. (Shift up or down)

part = 2;
[T,M] = ode45(@fall, [0,60], [38959,0]);

% <call here your function to create your plots>
plotComparisons(60, 'Part2 - Simple Air Resistance', T, M)

%% Part 3
% Answer some questions here in these comments...
% Felix was wearing a pressure suit and carrying oxygen. Why? 
%     What can we say about the density of air in the stratosphere?
%     How is the density of air different at around 39,000 meters than it 
%     is on the ground?
% The density of air near the top of the strtosphere is nearly zero. Here
% is our source: http://www.ccpo.odu.edu/SEES/ozone/class/Chap_6/6_2.htm#:~:text=The%20density%20of%20air%20near,with%20altitude%20and%20then%20increases.
% The density of air compared to the ground it close to 1.2
% Felix needs to wear his own helmet with oxyge and pressure suit since
% there is a lack of atomosphere pressure and air which will allow him to
% die.
% There was a higher velocity at the higher stratosphere point, therefore
% Felix has a lower drag froce at 39000m. Therefore, we can conclude that
% the lower the altitude, the higher the density of air.


% What are the factors involved in calculating the density of air? 
%     How do those factors change when we end up at the ground but start 
%     at the stratosphere?  Please explain how calculating air density up 
%     to the stratosphere is more complicated than say just in the troposphere.
% <put your answer here in these comments>

% What method(s) can we employ to estimate [the ACd] product? 
% <put your answer here in these comments>

% What is your estimated [ACd] product?
% <put your answer here in these comments>
%
% [Given what we are told in the textbook about the simple drag constant, b,] 
%   does the estimate for ACd seem reasonable?
% <put your answer here in these comments>

part = 3;
[T,M] = ode45(@fall, [0,270], [39000,0]);


% <call here your function to create your plots>
plotComparisons(270, 'Part3: Drag', T, M);
%% Part 4
% Answer some questions here in these comments...
% What is the actual gravitational field strength around 39,000 meters? 
%   (See Tipler Volume 1 6e page 369.) 

% How sensitive is the altitude reached after 4.5 minutes to simpler and 
%   more complicated ways of modelling the gravitational field strength? 
% <put your answer here in these comments>

% What other changes could we make to our model? Refer to, or at least 
%   attempt to explain, the physics behind any changes that you propose. 
% <put your answer here in these comments>

% What is a change that we could make to our model that would result in 
%   insignificant changes to the altitude reached after 4.5 minutes? 
% <put your answer here in these comments>

% How can we decide what change is significant and what change is 
%   insignificant?
% <put your answer here in these comments>

% [What changes did you try out to improve the model?  (Show us your changes
%   even if they didn't make the improvement you hoped for.)]
% <put your answer here in these comments>

part = 4;
[T,M] = ode45(@fall, [0,270], [39000,0]);
plotComparisons(270, 'Part4: Drag', T, M);

%% Part 5
% Answer some questions here in these comments...
% At what altitude does Felix pull the ripcord to deploy his parachute? 
% <put your answer here in these comments>

% Recalculate the CdA product with the parachute open, and modify your 
%   code so that you use one CdA product before and one after this altitude. 
%   According to this version of the model, what is the maximum magnitude 
%   of acceleration that Felix experiences? 
% <put your answer here in these comments>

%   How safe or unsafe would such an acceleration be for Felix?
% <put your answer here in these comments>

part = 5;

%Make a single acceleration-plot figure that includes, for each of the 
%model and the acceleration calculated from measurements, the moment when 
%the parachute opens and the following 10 or so seconds. If you have 
%trouble solving this version of the model, just plot the acceleration 
%calculated from measurements. 
% <place your work here>

%% Part 6 
% Answer some questions here in these comments...
% How long does it take for Felix’s parachute to open?
% <put your answer here in these comments>

part = 6;

%Redraw the acceleration figure from the previous Part but using the new 
%   model. Also, using your plotting function from Part 1, plot the 
%   measured/calculated data and the model for the entire jump from 
%   stratosphere to ground.
% <place your work here>

%% nested functions  
% nested functions below are required for the assignment.  
% see Appendix B of Physical Modeling in MATLAB for discussion of nested functions

function res = fall(t, X)
    %FALL <Summary of this function goes here>
    %   <Detailed explanation goes here>

    % do not modify this function unless required by you for some reason! 

    y = X(1); % the first element is position
    v = X(2); % the second element is velocity

    dydt = v; % velocity: the derivative of position w.r.t. time
    dvdt = acceleration(t, y, v); % acceleration: the derivative of velocity w.r.t. time

    res = [dydt; dvdt]; % pack the results in a column vector
end    

function res = acceleration(t, y, v)
    % <insert description of function here>
    % input...
    %   t: time
    %   y: altitude
    %   v: velocity
    % output...
    %   res: acceleration

    % do not modify this function unless required by you for some reason! 

    grav = gravityEst(y); 

    if part == 1 % variable part is from workspace of function main.
        res = -grav;
    else
        m = mass(t, v);
        b = drag(t, y, v, m);

        f_drag = -b * v^2 * sign(v);
        a_drag = f_drag / m;
        res = -grav + a_drag;
    end
end

% Please paste in or type in code into the below functions as may be needed.

function grav = gravityEst(y)
    % estimate the acceleration due to gravity as a function of altitude, y
    g_SEA = 9.807;  % gravity at sea level in m/s^2
    
     if part <= 3;
        grav = g_SEA;
     else
        r_earth = 6371000;
        grav = g_SEA*(r_earth^2)./(r_earth+y).^2;
     end
end

function res = mass(t, v)
  
    res = 73 + 27 + 3.628 + 14;  %felix + pressure suit + helmet with Oxygen + parachute
end

function res = drag(t, y, v, m)
% <insert description of function here>

    if part == 2
        res = 0.2;
    else
        % air resistance drag = 1/2*rho*c_d*a = 1/2*rho*CdA
        %%%%%%%%%%% input your code here %%%%%%%%%%%%%%%%
        CdA = finding_ACd(m);
        rho = stdatmo(y);
        res = 1/2*rho*CdA;

    end
end

function res = ACd_Calculator(h, v_terminal, m)
    rho = stdatmo(h);
    g = gravityEst(h);
    res = 2*(g).*m./rho*v_terminal.^2;
    
end

function res = finding_ACd(m)
        h = 27833;
        v_terminal = 1357.6;
        before_Parachute = ACd_Calculator(h, v_terminal, m);
        res = 0;
end
        


  

%% Additional nested functions
% Nest any other functions below.  
%Do not put functions in other files when you submit, except you can use
%    the stdatmo function in file stdatmo.m which has been provided to you.
function res = plotComparisons(x, mytitle, T, M)
    % time indexes for max time = x
    for k = 1:length(T)
        if T(k) == x
            t = 1:k; % indexes only from the start of the fall until x seconds
            break
        end
    end
    % position/velocity indexes for max time = x using first column entries of M
    y = [];
    v = [];
    %time_index=find(t_data >= time);
    %plot(t_data(1:time_index_min)
    %alt_data(1:time_index_min), 'b-');
    %plot(T,M(:,1),'r-');
    %hold on;
    %% Preprocessing - fill missing data using simple linear interpolation

 

%idx = 1:length(data)-1;

%[t_data, ~] = fillmissing(t_data,'linear','SamplePoints',idx);

%[alt_data, ~] = fillmissing(alt_data,'linear','SamplePoints',idx);

%[vel_data, ~] = fillmissing(vel_data,'linear','SamplePoints',idx);

    for k = 1:length(t)
        y = [y M(k,1)];
        v = [v M(k,2)];
    end
    % subplot for model of position
    figure;
    subplot(3,1,1);
   
    xlabel('s');
    ylabel('m');
    hold on
    title(mytitle,'Altitude')
    plot(t,y,'r-')
    % subplot for experimental data of position 
    a = (data(:,2));
    plot(a,'b-')
    legend('Actual', 'Modeled')
    hold off
    

    % subplot for model of velocity
    subplot(3,1,2);
    hold on
    xlabel('s');
    ylabel('m/s');
    plot(t,v,'r-')
    title(mytitle,'Velocity')
    % subplot for experimental data of velocity
    b = smoothdata((data(:,3)));
    plot(b,'b-')
    legend('Actual', 'Modeled')
    hold off
    

    % subplot for model of acceleration
    subplot(3,1,3);
    
    xlabel('s');
    ylabel('m/s^2');
    legend('Actual', 'Modeled')
    hold on 
    plot(diff(v)./diff(t))
    % FILL IN COMMANDS 
    title(mytitle,'Acceleration')
    % subplot for measured acceleration
    syms x
    plot(diff(b)./diff(t))
    legend('Actual', 'Modeled')
    hold off
   
   
    
    
    

end       
    
% end of nested functions
end % closes function main.  