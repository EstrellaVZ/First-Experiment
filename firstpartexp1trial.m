%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Preference Task I                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Response Matrix of Preference Task I is call: respMat 



%function [results] = firstpartexp1trial (subject)

% Close screens and waits to start press
sca; % closes all screens

input ('start>>>','s'); % prints to command window



try
%----------------------------------------------------------------------
%                              Set Up Screens
%----------------------------------------------------------------------

    HideCursor;
    % Call defaults
    PsychDefaultSetup(1); % Executes the AssertOpenGL command & KbName('UnifyKeyNames')
    Screen('Preference', 'SkipSyncTests', 2); % DO NOT KEEP THIS IN EXPERIMENTAL SCRIPTS!
    
    % Setup screens
    getScreens   = Screen('Screens'); % Gets the screen numbers
    chosenScreen = max(getScreens);   % Chose which screen to display on (here we chose the external)
    rect         = [];                % Full screen
    
    % Get luminance values
    white = WhiteIndex(chosenScreen); % 255
    black = BlackIndex(chosenScreen); % 0
    grey  = white/2;
    
    % Open a psychtoolbox screen
    [w, scr_rect] = PsychImaging('OpenWindow',chosenScreen,grey,rect); % here scr_rect gives us the size of the screen in pixels
    [centerX, centerY] = RectCenter(scr_rect); % get the coordinates of the center of the screen
    [screenXpixels, screenYpixels] = Screen('WindowSize', w); %pixels of the screen
    
    % Get flip and refresh rates
    ifi = Screen('GetFlipInterval', w); % the inter-frame interval (minimum time between two frames)
    hertz = FrameRate(w); % check the refresh rate of the screen

    %----------------------------------------------------------------------
    %                       Timing Information
    %----------------------------------------------------------------------
    
    % Interstimulus interval time in seconds and frames
    isiTimeSecs = 1;
    isiTimeFrames = round(isiTimeSecs / ifi);
    
    % Numer of frames to wait before re-drawing
    waitframes = 1;

    %----------------------------------------------------------------------
    %                       Keyboard information
    %----------------------------------------------------------------------

    % Define the keyboard keys that are listened for. We will be using the 
    % number keys as response keys for the task 
    
    OneKey = KbName('1!');
    TwoKey = KbName('2@');
    ThreeKey = KbName('3#');
    FourKey = KbName('4$');
    FiveKey = KbName('5%');
    SixKey = KbName('6^');
    SevenKey = KbName('7&');
    EightKey = KbName('8*');



    %----------------------------------------------------------------------
    %                     Import data & randomisation
    %----------------------------------------------------------------------

    %%% Here I import all words for the preference task     
    Words = importdata('Preferencetaskwords.txt');
    %Words = string(Words); %%revisar si quitarlo

    % Returns a row vector containing a random permutation of the integers 
    % from 1 to n without repeating elements.
    number_of_items = length(Words);
    random_vector = randperm(number_of_items);

    %----------------------------------------------------------------------
    %                     Make a response matrix
    %----------------------------------------------------------------------
    
    % This is a four row matrix: first row will record the word we 
    % present, second row if they pressed the keyboard or not, third 
    % row the key they respond with and the final row the time they took 
    % to make there response.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %1.-Order of the presentation of the items
    %2.-Key pressed (1) or not (0)
    %3.-Rating from 1-8. 999 any other key.Nan when any key was pressed.
    %4.-Response time
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    respMat = nan(4, number_of_items);

    
    %%%%
    %% Randomization of fixation time
    seed = round(sum(10*clock)); % set a "random" seed for this experimental session
    rng(seed)
    fixation_time = rand(number_of_items,1)*(1-0.4) + 0.4; % random number between 0.4 and 1


    %----------------------------------------------------------------------
    %                       Experimental loop
    %----------------------------------------------------------------------

    %Here, we present all words in a random order, wait for the preference
    %rating of the subject and present the fixation point
    %I need to review this fixation point
    
    Screen('FillRect', w, white);
    Screen('TextSize', w, 80);
    Screen('TextFont', w, 'Courier');

    Screen('DrawDots', w, [centerX; centerY], 10, black, [], 2);
    vbl = Screen('Flip', w);
    %WaitSecs(2)
   

    %randompresentationofitems
    for i = 1:number_of_items
        WaitSecs(fixation_time(i))
        everyword = Words(random_vector(i));
        
     
        DrawFormattedText(w, char(everyword), 'center', 'center', black);   
        % Flip to the screen
        Screen('Flip', w); 
       

        % Cue to determine whether a response has been made
        %respToBeMade = true;
        
        % The participant introduces her/his preference rate, from 1 to 8.

        FlushEvents('keyDown');
        t1 = GetSecs;
        time = 0;

        while time < 2 %&& respToBeMade == true % maximum wait time: 3 s
       

        [keyIsDown,t2,keyCode] = KbCheck; % determine state of keyboard
        time = t2-t1;
        

            if (keyIsDown) % has a key been pressed?
                key = KbName(find(keyCode)); % find key's name
                respMat(2, i) = 1;

                if keyCode(OneKey)
                   PreferenceResponse = 1;
                   %respToBeMade = false;
   
                elseif keyCode(TwoKey)
                   PreferenceResponse = 2;
                   %respToBeMade = false;
   
                elseif keyCode(ThreeKey)
                   PreferenceResponse = 3;
                   %respToBeMade = false;
   
                elseif keyCode(FourKey)
                   PreferenceResponse = 4;
                   %respToBeMade = false;

                elseif keyCode(FiveKey)
                   PreferenceResponse = 5;
                   respToBeMade = false;

                elseif keyCode(SixKey)
                   PreferenceResponse = 6;
                   %respToBeMade = false;

                elseif keyCode(SevenKey)
                   PreferenceResponse = 7;
                   %respToBeMade = false;

                elseif keyCode(EightKey)
                   PreferenceResponse = 8;
                   %respToBeMade = false;

                else 
                   PreferenceResponse = 999;
                   %respToBeMade = false;
                    
                end
           
            respMat(3, i) = PreferenceResponse;
            respMat(4, i) = time;

            end     


        end



        %KbStrokeWait; I change that for the numeric key press

        % Flip again to sync us to the vertical retrace at the same time as
        % drawing our fixation point
        Screen('DrawDots', w, [centerX; centerY], 10, black, [], 2);
        vbl = Screen('Flip', w);

        % Now we present the isi interval with fixation point minus one frame
        % because we presented the fixation point once already when getting a
        % time stamp
        for frame = 1:isiTimeFrames - 1
    
            % Draw the fixation point
            Screen('DrawDots', w, [centerX; centerY], 10, black, [], 2);
    
            % Flip to the screen
            vbl = Screen('Flip', w, vbl + (waitframes - 0.5) * ifi);
        end

  
    end
    
    respMat(1, :) = random_vector; %first row, with the number of item 
                                    %presented, in case we need it.
    %Substitutes Nans in the second row(pressed -1- or not -0-) by 0
    row2=respMat(2,:);
    row2(isnan(row2))=0;
    respMat(2,:)=row2;
    
    
    
    %Just an ending to conclude %%%ELIMINATE THAT FOR THE FINAL VERSION

   
    Screen('FillRect', w, white);
    Screen('TextSize', w, 80);
    Screen('TextFont', w, 'Times');
    DrawFormattedText(w, 'That is the end :)', 'center', 'center', [0 0 255]);
    Screen('Flip', w);  

    KbStrokeWait;
    Screen('CloseAll') % close all screens

    
catch

    Screen('CloseAll')
    ShowCursor;
    psychrethrow(psychlasterror);

end


Finish= (" That's the end :) ");
disp(Finish)


tablerespMat = array2table(respMat', "VariableNames",["Item number" "Pressed (1) or not (0)" "Preference Rating" "Response Time"]);
disp(tablerespMat)
