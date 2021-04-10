% ENSC180-Assignment3

% Student Name 1: Sepehr Borji

% Student 1 #: 301372450

% Student 1 userid (email): Sepehr_borji@sfu.ca

% Student Name 2: Akash Mallhi

% Student 2 #: 301393341

% Student 2 userid (email): asm19@sfu.ca

% Below, edit to list any people who helped you with the assignment, 
%      or put ‘none’ if nobody helped (the two of) you.

% Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__

% Instructions:
% * Put your name(s), student number(s), userid(s) in the above section.
% * Edit the "Helpers" line.  
% * Your group name should be "A3_<userid1>_<userid2>" (eg. A3_stu1_stu2)
% * Form a group 
%   as described at:  https://courses.cs.sfu.ca/docs/students
% * You will submit THIS file (assignment3_2017.m),    
%   and your video file (assignment3.avi or possibly similar).
% Craig Scratchley, Spring 2021

function frameArray = assignment3_2017
% Since depth was decreased, to make up for the quality of the images, we
% have increased resolution so we don't have a pixelated effect
% the nature of the way we are zooming and flipping and how sporadic it is,
% we will increase the duration so that frames per second is less and it
% isn't as intense. However, if you want to feel like you're tripping, i
% recommend 12 seconds duration, very dubstep
MAX_FRAMES = 256; % you can change this and consider increasing it.
RESOLUTION = 712; % you can change this and consider increasing it.
DURATION = 15; % Duration of video -- you can change this if you want.

% Colors
MAX_DEPTH = 123; % you will probably need to increase this.
DURATION = 20; % Duration of video -- you can change this if you want.

% Colors
% Although increasing the max depth seems to cause sharper images or red
% and blue, we wanted some more variety in the colour, so by decreasing to
% 25, we have some yellow/green in the visuals now
MAX_DEPTH = 25; % you will probably need to increase this.
CMAP=colormap(flipud(jet(MAX_DEPTH))); %change the colormap as you want.


WRITE_VIDEO_TO_FILE = false; % change this as you like (true/false)
DO_IN_PARALLEL = true; % true; %change this as you like (true/false)

if DO_IN_PARALLEL
    startClusterIfNeeded
end

if WRITE_VIDEO_TO_FILE
    vidObj = [];
    openVideoFile
end

if DO_IN_PARALLEL || ~WRITE_VIDEO_TO_FILE 
    %preallocate struct array
    %frameArray=struct('cdata',cell(1,MAX_FRAMES),'colormap',cell(1,MAX_FRAMES));
end

% the path "around" the mandelbrot set, associating centres of frames
%     with zoom (magnification) levels.  

%           index  centre      number of times to zoom in by 2
PATH_POINTS =[0,   -0.5,            0; 
              50,   0.5,            1;
              100, -1.861,          2;
              300, -1.861+0.01i,    8.2; 
              400, -1.9-0.002i,     4; 
              450, -1.9-0.0002i,    2; 
              500, -1.9-0.0002i,    0];

SIZE_0 = 1.5; % the "size" from the centre of a frame with no zooming.

% scale indexes to number of frames.
scaledIndexArray = PATH_POINTS(:, 1).*((MAX_FRAMES-1)/PATH_POINTS(end, 1));

% interpolate centres and zoom levels.
interpArray = interp1(scaledIndexArray, PATH_POINTS(:, 2:end), 0:(MAX_FRAMES-1), 'pchip');

zoomArray = interpArray(:,2); % zoom level of each frame

% ***** modify the below line to consider zoom levels.
% code below causes a gradual zooming out/in 
sizeArray = [];
% we created this for loop so that every alternating value in sizeArray is
% a column vector with a value for every frame which is the value index
% multiplied by the "size" from the centre of a frame with no zooming
% (SIZE_0). Additionally, to cause some sporadic zooming just for
% craziness, every odd index of the matrix will be negative. We did this
% because if it is not negative for every odd index, then it is
% incompatible with the centreFactor variable we have defined later, and
% will cause the fractal to jump around, so making every index odd causes a
% bit more coherence
% this began as "for k = 1:MAX_FRAMES" so this would only zoom out, but we
% have changed it to try zooming in as well

% Its cool that we are zooming out, but we will now try zooming in after a
% while. After testing a lot of iterations, its become clear that since the
% numbers in the size array are switching immediately, not following any
% sort of continuous mathematical function, the frames are very sporadic
% but this seems pretty dubstep so we'll keep it. In fact this is now
% making it so exciting and long we will extend the number of frames
% because of this. The only issue at this point is that we want to centre
% the fractal now to the frame. Update: fixed the issue by lowering
% centerfactor to a magnitude less than 1

% we noticed after some playing around with our custom defined variable
% centreFactor that we no longer need the magnitude of the factor to
% greater than 1 or it will also try zooming in! For this reason, we've
% kept centre factor magnitude less than 1
for k = 1:MAX_FRAMES
    if k < MAX_FRAMES/4
        sizeArray(k,1) = SIZE_0 * ((-1)^k)*k;
    elseif k < MAX_FRAMES/2 && k >= MAX_FRAMES/4
        sizeArray(k,1) = SIZE_0 * k;
    elseif k < 3*MAX_FRAMES/4 && k >= MAX_FRAMES/2
        sizeArray(k,1) = SIZE_0 * k^-1;
    else
        sizeArray(k,1) = SIZE_0 * sin(k);
    end
end
%sizeArray = SIZE_0 * ones(MAX_FRAMES,1); % size from centre of each frame.

centreArray = interpArray(:,1);  % centre of each frame

iterateHandle = @iterate;

tic % begin timing
if DO_IN_PARALLEL
    parfor frameNum = 1:MAX_FRAMES
        %evaluate function iterate with handle iterateHandle
        frameArray(frameNum) = feval(iterateHandle, frameNum);
    end
else
    for frameNum = 1:MAX_FRAMES
        if WRITE_VIDEO_TO_FILE
            %frame has already been written in this case
            iterate(frameNum);
        else
            frameArray(frameNum) = iterate(frameNum);
        end
    end
end

if WRITE_VIDEO_TO_FILE
    if DO_IN_PARALLEL
        open(vidObj)
        writeVideo(vidObj, frameArray);
    end
    close(vidObj);
    toc %end timing
else
    toc %end timing
    %clf;
    set(gcf, 'Position', [100, 100, RESOLUTION + 10, RESOLUTION + 10]);
    axis off;
    shg; % bring the figure to the top to be seen.
    movie(gcf, frameArray, 1, MAX_FRAMES/DURATION, [5, 5, 0, 0]);
end

    function frame = iterate (frameNum)
        % I added a whole new variable called centreFactor for the purpose
        % of "flipping" the image for every odd value frame and to
        % essentially pan the image left or right based on the magnitude of
        % centreFactor. For example, if centerfactor is 1 or -1, then the
        % fractal flips but stays in the same place in the frame, but when
        % you increase the magnitude of centreFactor, the fractal looks
        % like it is floating left and right when zooming out.
        if mod(frameNum,2) == 0
            centreFactor = 0.04;
        else
            centreFactor = -0.04;
        end
        centreX = real(centreFactor*centreArray(frameNum)); 
        centreY = imag(centreFactor*centreArray(frameNum)); 
        size = sizeArray(frameNum); 
        x = linspace(centreX - size, centreX + size, RESOLUTION);
        %you can modify the aspect ratio if you want.
        y = linspace(centreY - size, centreY + size, RESOLUTION);
        
        % the below might work okay unless you want to further optimize
        % Create the two-dimensional complex grid using meshgrid
        [X,Y] = meshgrid(x,y);
        z0 = X + 1i*Y;
        
        % Initialize the iterates and counts arrays.
        z = z0;
        
        % needed for mex, assumedly to make z elements separate
        %in memory from z0 elements.
        z(1,1) = z0(1,1); 
        
        % make c of type uint16 (unsigned 16-bit integer)
        c = zeros(RESOLUTION, RESOLUTION, 'uint16');
        
        % Here is the Mandelbrot iteration.
        c(abs(z) < 2) = 1;
        
        % below line turns warning off for MATLAB R2015b and similar
        %   releases of MATLAB.  Those releases have a bug causing a 
        %   warning for mex invocations like ours.  
        % warning( 'off', 'MATLAB:lang:badlyScopedReturnValue' );

        depth = MAX_DEPTH; % you can make depth dynamic if you want.
        
        for k = 2:depth
            [z,c] = mandelbrot_step(z,c,z0,k);
            % mandelbrot_step is a c-mex file that does one step of:
              %z = z.^2 + z0;
              %c(abs(z) < 2) = k;
        end
        
        % create an image from c and then convert to frame.  Use CMAP
        frame = im2frame(ind2rgb(c, CMAP));
        if WRITE_VIDEO_TO_FILE && ~DO_IN_PARALLEL
            writeVideo(vidObj, frame);
        end
        
        disp(['frame=' num2str(frameNum)]);
    end

    function startClusterIfNeeded
        myCluster = parcluster('local');
        if isempty(myCluster.Jobs) || ~strcmp(myCluster.Jobs(1).State, 'running')
            PHYSICAL_CORES = feature('numCores');
            
            % "hyperthreads" per physical core
            LOGICAL_PER_PHYSICAL = 2; %valid for the i7 on Craig's desktop
            
            % you can change the NUM_WORKERS calculation below if you want.
            NUM_WORKERS = (LOGICAL_PER_PHYSICAL + 1) * PHYSICAL_CORES;
            myCluster.NumWorkers = NUM_WORKERS;
            saveProfile(myCluster);
            disp('This may take a while when needed!')
            parpool(NUM_WORKERS);
        end
    end

    function openVideoFile
        % create video object
        vidObj = VideoWriter('assignment3');
        %vidObj.Quality = 100; % or consider changing
        vidObj.FrameRate = MAX_FRAMES/DURATION;
        open(vidObj);
    end

    
end

