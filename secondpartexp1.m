%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Choice Task                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%This second task creates pairs of words with equal ratings and pairs of
%words with different ratings

%Variable "equalrandompairs" has 30 pairs of equal ratings
%Variable "matrix_fornotequalpairs" has 30 pairs of inequal ratings




% Close screens and waits to start press
sca; % closes all screens

input ('start>>>','s'); % prints to command window



try
    
%----------------------------------------------------------------------
%                              Set Up Screens
%----------------------------------------------------------------------
%% **That part need to be deleted when all the code is together

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
%% **That part need to be deleted when all the code is together
    
    % Interstimulus interval time in seconds and frames
    isiTimeSecs = 1;
    isiTimeFrames = round(isiTimeSecs / ifi);
    
    % Numer of frames to wait before re-drawing
    waitframes = 1;


%----------------------------------------------------------------------
%                                 Import data 
%----------------------------------------------------------------------
%% **This will be later just on the first task. 
%% **Delete when everything is together.

    %%% Here I import all words for the preference task     
    Words = importdata('randomwords.txt');




%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------
 
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
escapeKey = KbName('ESCAPE');


%----------------------------------------------------------------------
%                   Matrix of preferences & pairs creation
%----------------------------------------------------------------------

%% ** This is a "simulation" matrix to perform the second task. That should
%%  be substituted by the respMat generated in the Preference task I

 % This is a four row matrix: first row will record the word we 
 % present, second row if they pressed the keyboard or not, third 
 % row the key they respond with and the final row the time they took 
 % to make there response.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.-Order of the presentation of the items
%2.-Key pressed (1) or not (0)
%3.-Rating from 1-8. 999 any other key. Nan when any key was pressed.
%4.-Response time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%Generates a random Mat. Example of 160 items 
    
    number_of_items = 160;
    respMat = nan(4, number_of_items); %creates an empty matrix
    
    %first row
    
    
    random_vector_firstrow = randperm(number_of_items);
    respMat(1,:) = random_vector_firstrow;
    
    %second row
    
    onesrow= ones(1,number_of_items); %supposing the participant has responded 
                                      % to all 160 trials
    respMat(2,:) = onesrow;
    
    %third row
    
    random_thirdrow = randi(8,1,160);
    respMat(3,:) = random_thirdrow;
    
    %forth row
    
    random_forthrow = 0.5 + (3-0.5)*rand(1,160); %To generate random numbers N 
    % in the interval (a,b) with the formula r = a + (b-a).*rand(N,1). Here we
    % want to generate random numbers between 0.5-3, supposing response times
    % between that (instead of 0-3, supposing a minimim time to make the
    % response).
    respMat(4,:) = random_forthrow;
    
    %%QUITAR ESTO
    %%%KbStrokeWait;
    %sca; % close all screens
    
    %disp(respMat)

%----------------------------------------------------------------------
%                          Creation of pairs
%----------------------------------------------------------------------

    %Separates in different matrices all the differente responses for
    %preferences 
    
    LogicalOne = respMat(3,:) == 1;
    MatAnswerOne = respMat(:,LogicalOne);
    
    LogicalTwo = respMat(3,:) == 2;
    MatAnswerTwo = respMat(:,LogicalTwo);
    
    LogicalThree = respMat(3,:) == 3;
    MatAnswerThree = respMat(:,LogicalThree);
    
    LogicalFour = respMat(3,:) == 4;
    MatAnswerFour = respMat(:,LogicalFour);
    
    LogicalFive = respMat(3,:) == 5;
    MatAnswerFive = respMat(:,LogicalFive);
    
    LogicalSix = respMat(3,:) == 6;
    MatAnswerSix = respMat(:,LogicalSix);
    
    LogicalSeven = respMat(3,:) == 7;
    MatAnswerSeven = respMat(:,LogicalSeven);
    
    LogicalEight = respMat(3,:) == 8;
    MatAnswerEight = respMat(:,LogicalEight);
    
    
    %%Creates pairs of equal ratings for each value and stores them
    
    
    %Answer "1"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerOne = respMat(1,LogicalOne);%list of items with answer 1
    shuffledOne = ListofItems_AnswerOne(randperm(length(ListofItems_AnswerOne)));
    
    
    if rem(length(shuffledOne),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledOne(end) = [];
    end
    
    reshapeshuffledOne = reshape(shuffledOne,[],2);
    
    
    
    %Answer "2"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerTwo = respMat(1,LogicalTwo);%list of items with answer 2
    shuffledTwo = ListofItems_AnswerTwo(randperm(length(ListofItems_AnswerTwo)));
    
    
    if rem(length(shuffledTwo),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledTwo(end) = [];
    end
    
    reshapeshuffledTwo = reshape(shuffledTwo,[],2);
    
    
    %Answer "3"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerThree = respMat(1,LogicalThree);%list of items with answer 3
    shuffledThree = ListofItems_AnswerThree(randperm(length(ListofItems_AnswerThree)));
    
    
    if rem(length(shuffledThree),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledThree(end) = [];
    end
    
    reshapeshuffledThree = reshape(shuffledThree,[],2);
    
    
    %Answer "4"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerFour = respMat(1,LogicalFour);%list of items with answer 4
    shuffledFour = ListofItems_AnswerFour(randperm(length(ListofItems_AnswerFour)));
    
    
    if rem(length(shuffledFour),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledFour(end) = [];
    end
    
    reshapeshuffledFour = reshape(shuffledFour,[],2);
    
    
    %Answer "5"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerFive = respMat(1,LogicalFive);%list of items with answer 5
    shuffledFive = ListofItems_AnswerFive(randperm(length(ListofItems_AnswerFive)));
    
    
    if rem(length(shuffledFive),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledFive(end) = [];
    end
    
    reshapeshuffledFive = reshape(shuffledFive,[],2);
    
    
    
    %Answer "6"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerSix = respMat(1,LogicalSix);%list of items with answer 6
    shuffledSix = ListofItems_AnswerSix(randperm(length(ListofItems_AnswerSix)));
    
    
    if rem(length(shuffledSix),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledSix(end) = [];
    end
    
    reshapeshuffledSix = reshape(shuffledSix,[],2);
    
    
    
    %Answer "7"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerSeven = respMat(1,LogicalSeven);%list of items with answer 7
    shuffledSeven = ListofItems_AnswerSeven(randperm(length(ListofItems_AnswerSeven)));
    
    
    if rem(length(shuffledSeven),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledSeven(end) = [];
    end
    
    reshapeshuffledSeven = reshape(shuffledSeven,[],2);
    
    
    %Answer "8"
    
    %Extracts items & shuffle them %if its odd, it eliminates the last one
    
    ListofItems_AnswerEight = respMat(1,LogicalEight);%list of items with answer 8
    shuffledEight = ListofItems_AnswerEight(randperm(length(ListofItems_AnswerEight)));
    
    
    if rem(length(shuffledEight),2) == 1 %%If the list of numbers is odd,     
                                % it eliminates the last number
    shuffledEight(end) = [];
    end
    
    reshapeshuffledEight = reshape(shuffledEight,[],2);
    
    
    %All matrices together
    
    Allmatrices_equalpairs = [reshapeshuffledOne; reshapeshuffledTwo; 
        reshapeshuffledThree; reshapeshuffledFour; reshapeshuffledFive; 
        reshapeshuffledSix; reshapeshuffledSeven; reshapeshuffledEight];
    
    %Allmatrices is a 78x2 matrix. We need to extract 30 equal pairs
    
    
    randomrowsforAllmatrices = randperm(length(Allmatrices_equalpairs));
    equalrandompairs = Allmatrices_equalpairs(randomrowsforAllmatrices(1:30),:);
    
    %*It would be great if I can check how many pairs I get of each punctuation
    
    
    %It makes a list of a single row from the matrix
    Allmatrices_equalpairs_inanarray = reshape(Allmatrices_equalpairs, 1, []);
    equalrandompairs_inanarray = reshape(equalrandompairs, 1, []);
    
    %Gets a logical array of those items that are already used for the equal
    %pairs, so they can not be used later for the different pairs.
    
    Logical_Already_used = ismember(Allmatrices_equalpairs_inanarray, equalrandompairs_inanarray);
    %Logical Array of those items that are still not used, so we can use them
    %to create pairs 
    Logical_Still_not_used = ~Logical_Already_used;
    
    
    %%Still_not_used is a list of those that we need to make the rest of the
    %%pairs
    %Already_used = Allmatrices_equalpairs_inanarray(:,Logical_Already_used);
    Still_not_used = Allmatrices_equalpairs_inanarray(:,Logical_Still_not_used);
    
    
    %Ordering first matrix and Still_not_used
    Table_respMat = array2table(respMat',"VariableNames",["Stimuli" "Pressed or not" "Rating" "RT"]);
    Table_respMat = sortrows(Table_respMat);
    
    NOTUSED_Table_respMat=Table_respMat(Still_not_used,:);
    
    
    %
    
    
    NonEqualMat = table2array(NOTUSED_Table_respMat)';
    %emptymatrix_fornotequalpairs = nan(30, 2);
    idx=randperm(length(NonEqualMat)); %random vector to 
    
    NonEqualMat2dot0 = NonEqualMat(:,idx);
     
    % 
    % for ii = 1:length(NonEqualMat2dot0)
    %    
    %    %% while emptymatrix_fornotequalpairs < 30
    % 
    %     if NonEqualMat2dot0(3,1) ~= NonEqualMat2dot0(3,2) && (NonEqualMat2dot0(3,1) >= (NonEqualMat2dot0(3,2)+3) || NonEqualMat2dot0(3,1) <= (NonEqualMat2dot0(3,2)-3))
    %         emptymatrix_fornotequalpairs(ii,1) = [NonEqualMat2dot0(1,1)];
    %         emptymatrix_fornotequalpairs(ii,2) = [NonEqualMat2dot0(1,2)];
    %         NonEqualMat2dot0(:,1) = [];
    %         NonEqualMat2dot0(:,2) = [];
    %     else 
    %         NonEqualMat2dot0(:,1) = [];
    %     end
    %     
    %     
    % end 
    
    
    
    matrix_fornotequalpairs = zeros(30,2);
    
    ii=1;
    jj=1;
    
    while matrix_fornotequalpairs(30,2) == 0
    
       
    
        %for ii = 1:length(NonEqualMat2dot0)
    
            if NonEqualMat2dot0(3,jj) ~= NonEqualMat2dot0(3,(jj+1)) && (NonEqualMat2dot0(3,jj) >= (NonEqualMat2dot0(3,(jj+1))+3) || NonEqualMat2dot0(3,jj) <= (NonEqualMat2dot0(3,(jj+1))-3))
                matrix_fornotequalpairs(ii,1) = [NonEqualMat2dot0(1,jj)];
                matrix_fornotequalpairs(ii,2) = [NonEqualMat2dot0(1,jj+1)];
                NonEqualMat2dot0(:,jj+1) = [];
                NonEqualMat2dot0(:,jj) = [];
                ii= ii+1;
            elseif NonEqualMat2dot0(3,jj) ~= NonEqualMat2dot0(3,(jj+2)) && (NonEqualMat2dot0(3,jj) >= (NonEqualMat2dot0(3,(jj+2))+3) || NonEqualMat2dot0(3,jj) <= (NonEqualMat2dot0(3,(jj+2))-3))
                matrix_fornotequalpairs(ii,1) = [NonEqualMat2dot0(1,jj)];
                matrix_fornotequalpairs(ii,2) = [NonEqualMat2dot0(1,jj+2)];
                NonEqualMat2dot0(:,jj+2) = [];
                NonEqualMat2dot0(:,jj) = [];
                ii= ii+1;
            elseif NonEqualMat2dot0(3,jj) ~= NonEqualMat2dot0(3,(jj+3)) && (NonEqualMat2dot0(3,jj) >= (NonEqualMat2dot0(3,(jj+3))+3) || NonEqualMat2dot0(3,jj) <= (NonEqualMat2dot0(3,(jj+3))-3))
                matrix_fornotequalpairs(ii,1) = [NonEqualMat2dot0(1,jj)];
                matrix_fornotequalpairs(ii,2) = [NonEqualMat2dot0(1,jj+3)];
                NonEqualMat2dot0(:,jj+3) = [];
                NonEqualMat2dot0(:,jj) = [];
                ii= ii+1; 
            else    
                NonEqualMat2dot0(:,jj) = [];
            end
    
        %end  
        
    end 

%----------------------------------------------------------------------
%                     Randomisazion & response matrix
%----------------------------------------------------------------------

    %Matrix with all the pairs to present. ("equalrandompairs" has 
    % 30 pairs of equal ratings %Variable "matrix_fornotequalpairs" has 
    % 30 pairs of different ratings
    
    fullpairsmatrix = [equalrandompairs; matrix_fornotequalpairs];
    number_of_pairs = length(fullpairsmatrix);
    
    %for the random presentation
    random_vector_pairs = randperm(number_of_pairs); 


    %Make a response matrix

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %1.-Number of item presented.
    %2.-Key pressed (1) or not (0).
    %3.-Choice: selected (1) or rejected (0). 999 any other key. 
                %Nan when any key was pressed.
    %4.-Response time.
    %5. Equal (in preference ratings) pair (1) or not (0).
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %1.- Item on the left
    %2.- Item on the right
    %3.-Key pressed (1) or not (0).
    %4.-Choice: izq (1) or dcha (2). 999 any other key. 
                %Nan when any key was pressed.
    %5.-Response time.
    %6. Equal (in preference ratings) pair (1) or not (0). ¿¿¿???
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Choice_respMat = nan(5, number_of_pairs);
  
    %% Randomization of fixation time
    seed = round(sum(10*clock)); % set a "random" seed for this experimental session
    rng(seed)
    fixation_time = rand(number_of_pairs,1)*(1-0.4) + 0.4; % random number between 0.4 and 1

  %----------------------------------------------------------------------
  %                       Experimental loop
  %----------------------------------------------------------------------

    %I need to review this fixation point
    
    Screen('FillRect', w, white);
    Screen('TextSize', w, 80);
    Screen('TextFont', w, 'Courier');
    
    Screen('DrawDots', w, [centerX; centerY], 10, black, [], 2);
    vbl = Screen('Flip', w);
    

    for i = 1:number_of_pairs
        WaitSecs(fixation_time(i))
 
        %Left side 
        everypairleft = Words(fullpairsmatrix(random_vector_pairs(i),1));
        %de prueba (quitar for loop) %DrawFormattedText2('izquierda', 'win', w, 'sx', centerX-(screenXpixels/6),'sy', 'center', 'xalign', 'center', 'yalign', 'center','xlayout', 'center');
        DrawFormattedText2(char(everypairleft), 'win', w, 'sx', centerX-(screenXpixels/6),'sy', 'center', 'xalign', 'center', 'yalign', 'center','xlayout', 'center');
        
        %Right side 
        everypairright = Words(fullpairsmatrix(random_vector_pairs(i),2));
        %de prueba (quitar for loop)%% DrawFormattedText2('derecha', 'win', w, 'sx', centerX+(screenXpixels/6),'sy', 'center', 'xalign', 'center', 'yalign', 'center','xlayout', 'center');
        DrawFormattedText2(char(everypairright), 'win', w, 'sx', centerX+(screenXpixels/6),'sy', 'center', 'xalign', 'center', 'yalign', 'center','xlayout', 'center');
        
        %We keep in the Choice response matrix both items
        Choice_respMat(1, i) = fullpairsmatrix(random_vector_pairs(i),1); %left
        Choice_respMat(2, i) = fullpairsmatrix(random_vector_pairs(i),2); %right

        % Flip to the screen
        Screen('Flip', w); 
       

       %WaitSecs(2) %This was to try whitout the while. Delete later
        
        %Now, participants make a choice between 2 options.
        FlushEvents('keyDown');
        t1 = GetSecs;
        time = 0;
 
 
       
        while time<2 %later 5 s per decision

        [keyIsDown,t2,keyCode] = KbCheck; % determine state of keyboard
        time = t2-t1;
    

            if (keyIsDown) % has a key been pressed?
                key = KbName(find(keyCode)); % find key's name
                Choice_respMat(3, i) = 1;

                if keyCode(leftKey)
                   ChoiceResponse = 1;

                elseif keyCode(rightKey)
                   ChoiceResponse = 2;

                elseif keyCode(escapeKey)
                  ShowCursor;
                  sca;
                  return
                else 
                   ChoiceResponse = 999;
                 
                end
                
            
                %We add this to the Choice response matrix
                Choice_respMat(4, i) = ChoiceResponse;
                Choice_respMat(5, i) = time;
                
            end
        end
     
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
            %WaitSecs (fixation_time(i))

            end              
       
    end

    %Substitutes Nans in the second row(pressed -1- or not -0-) by 0
    row3=Choice_respMat(3,:);
    row3(isnan(row3))=0;
    Choice_respMat(3,:)=row3;
    

    %Just an ending to conclude %%%ELIMINATE THAT FOR THE FINAL VERSION

   
    Screen('FillRect', w, white);
    Screen('TextSize', w, 80);
    Screen('TextFont', w, 'Times');
    DrawFormattedText(w, 'That is the end :)', 'center', 'center', [0 0 255]);
    Screen('Flip', w); 

    KbStrokeWait;
    sca; % close all screens

catch

    sca;
    ShowCursor;
    psychrethrow(psychlasterror);

end


tableChoice_respMat = array2table(Choice_respMat', "VariableNames",["Left Item" "Right Item" "Pressed (1) or not (0)" "Choice: Left(1)-Right(2)" "Response Time"]);
disp(tableChoice_respMat)
