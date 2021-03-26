%% ENSC180-Assignment2

% Student Name 1: student1

% Student 1 #: 123456781

% Student 1 userid (email): stu1 (stu1@sfu.ca)

% Student Name 2: student2

% Student 2 #: 123456782

% Student 2 userid (email): stu2 (stu2@sfu.ca)

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
%MY_CONST = 123;

% variables -- you can put variables for the program here
%myVar = 456;

% prepare the data
% <place your work here>
Table = readtable('./data/data_clean_more_fixed.xlsx');
data = table2array(Table);

% ... = xlsread()/csvread()/readtable()
% ...
% myVector(isnan(myVector))=[];

% <put here any conversions that are necessary>

%% Part 1
% Answer some questions here in these comments...
% How accurate is the model for the first portion of the minute? 
% <put your answer here in these comments>

% How accurate is the model for the last portion of that first minute? 
% <put your answer here in these comments>

% Comment on the acceleration calculated from the measured data. 
% Is there any way to smooth the acceleration calculated from the data?
% <put your answer here in these comments>

part = 1;
% model Felix Baumgartner’s altitude, velocity, and acceleration for the 
%     first minute after he jumped from 38,969.4 meters above sea level
[T,M] = ode45(@fall, [0,60], [4000,0])


% <call here your function to create your plots>
plotComparison(60, 'Part1 - Freefall', T, M)  

%% Part 2
% Answer some questions here in these comments...
% Estimate your uncertainty in the mass that you have chosen (at the 
%     beginning of the jump). 
% <put your answer here in these comments>

% How sensitive is the velocity and altitude reached after 60 seconds to 
%    changes in the chosen mass?
% <put your answer here in these comments>

part = 2;
%[T,M] = ode45(@fall, % <...>) 

% <call here your function to create your plots>
%plotComparisons(<...>, 'Part2 - Simple Air Resistance', T, M <, ...>) 

%% Part 3
% Answer some questions here in these comments...
% Felix was wearing a pressure suit and carrying oxygen. Why? 
%     What can we say about the density of air in the stratosphere?
%     How is the density of air different at around 39,000 meters than it 
%     is on the ground?
% <put your answer here in these comments>

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

% <place your work here>

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

% <place your work here>

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

    % if part <= % fill in
        grav = g_SEA;
    % else
        %...
    % end
end

function res = mass(t, v)
    % mass in kg of Felix and all his equipment
    %res = ...;  
end

function res = drag(t, y, v, m)
% <insert description of function here>

    if part == 2
        res = 0.2;
    else
        % air resistance drag = 1/2*rho*c_d*a = 1/2*rho*CdA
        %%%%%%%%%%% input your code here %%%%%%%%%%%%%%%%
        %CdA = ...

    end
end

%% Additional nested functions
% Nest any other functions below.  
%Do not put functions in other files when you submit, except you can use
%    the stdatmo function in file stdatmo.m which has been provided to you.
function res = plotComparison(x, mytitle, T, M)
    % time indexes for max time = x
    for k = 1:length(T)
        if T(k) == x
            t = 1:k; % indexes only from the start of the fall until x seconds
            break
        end
    end
    % position/velocity indexes for max time = x using first column entries of M
    y = []
    v = []
    for k = 1:length(t)
        y = [y M(k,1)]
        v = [v M(k,2)]
    end
    % subplot for model of position
    subplot(3,2,1);
    plot(t,y)
    title(mytitle,'modeled altitude')
    % subplot for experimental data of position 
    subplot(3,2,2);
    %FILL IN COMMANDS
    title(mytitle,'Measured altitude')
    a = (data(:,2));
    plot(a)
    % subplot for model of velocity
    subplot(3,2,3);
    plot(t,v)
    title(mytitle,'Modeled Velocity')
    % subplot for experimental data of velocity
    subplot(3,2,4);
 
    % FILL IN COMMANDS
    title(mytitle,'Measured Velocity')
    b = (data(:,3));
    plot(b)
    % subplot for model of acceleration
    subplot(3,2,5);
    % FILL IN COMMANDS 
    title(mytitle,'Modeled Acceleration')
    % subplot for measured acceleration
    subplot(3,2,6);
    % FILL IN COMMANDS
    title(mytitle,'Measured Acceleration')
    syms x
    f = b
    plot(diff(f))
end       
    
% end of nested functions
end % closes function main.  