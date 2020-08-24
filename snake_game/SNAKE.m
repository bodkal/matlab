%-------------------------%
%team 95                  %
%yaacov livne 308372879   %
%elad newman  302727508   %
%-------------------------%

%clear all the data and start the program
clc;
clear all;
mainprogram;
%the mainprogram function
%output/input-none
%call the game option functions according to the user choice
function mainprogram
global userchoice;                                                          %define the global variable userchoice so it could be use in this function
userchoice.option='f';                                                      %put an initial value to the userchoice.option cell
mainmenu;                                                                   %call mainmenu (menu pops and activated)
%wait for the user to choose an option
while (userchoice.option=='f')
    pause(0.1);
end
%call the game option functions accordint to user's choice
switch userchoice.option
    case 'e'
    case 's'
        simulation
    case 'g'
        newgame;
end
end
%the simulation fuction
%output/input-none
%runs a game simulation
function simulation
global key_preace;                                                          %difine global variable key_preace so it could be use in this function
global userchoice;                                                          %difine global variable userchoice so it could be use in this function
%runs the function until the break condition
top_score=0;
back=1;
while(back==1)
    %initialize the variables
    key_preace='0';
    score=0;
    playing=1;
    game_matrix=zeros(100)+50;
    snake = struct('y',{1},'x',{1});
    index_x=randi(100);
    index_y=randi(100);
    food=struct('y',{randi(100)},'x',{randi(100)});
    game_matrix(food.y,food.x)=0 ;
    for index = 1:8                                                        %determine the snake size
        snake(index) = struct('y',{index_y},'x',{index_x});
    end
    game_matrix(snake(end).y,snake(end).x)=255;
    %create the game figure, define it's design and text
    boord = figure('Name','SNAKE','NumberTitle','off','pos',[400 55 670 670],'WindowStyle','modal','Units','centimeters','WindowKeyPressFcn',@key_callback);
    if(~isempty(get(groot,'CurrentFigure')))
        text=annotation('textbox',[.37 .18 0.8 0.8],'String',strcat('corrent score : ',int2str(score)," top score : ",int2str(top_score)),'FitBoxToText','on');
        temp_text=annotation('textbox',[0.35 0.5 0.1 0.1],'String',('Press any key to start the simulation'));
        %create the board of the game
        image_reff(game_matrix);
        %waiting for user to press a key for starting simulation
        
    else
        back=0;
        key_preace='1';
    end
    while(key_preace=='0')
        pause(0.1);
    end
    delete(temp_text);                                                      %remove text annotation
    %run the simulation until the break condition
    while(playing==1)
        pause((0.7/(size(snake,2)))^(1.2^userchoice.speed));                %determine the speed of action
        %check which diraction to move for get closer to the food
        moove=snake(end).x-food.x;
        if(moove>0)
            %if not fail go to the left else move to a safe spot
            if(~check_fail(index_x-1,index_y,game_matrix))
                index_x=index_x-1;
                [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
            else
                [back,playing,index_y,index_x]= move_non_fail(index_y,index_x,game_matrix);
                [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
            end
        elseif(moove<0)
            %if not fail go to the right else move to a safe spot
            if(~check_fail(index_x+1,index_y,game_matrix))
                index_x=index_x+1;
                [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
            else
                [back,playing,index_y,index_x]= move_non_fail(index_y,index_x,game_matrix);
                [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
            end
        else
            moove=snake(end).y-food.y;
            if(moove>0)
                %if not fail go up else move to a safe spot
                if(~check_fail(index_x,index_y-1,game_matrix))
                    index_y=index_y-1;
                    [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
                else
                    [back,playing,index_y,index_x]= move_non_fail(index_y,index_x,game_matrix);
                    [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
                end
            elseif(moove<0)
                %if not fail go down else move to a safe spot
                if(~check_fail(index_x,index_y+1,game_matrix))
                    index_y=index_y+1;
                    [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
                else
                    [back,playing,index_y,index_x]= move_non_fail(index_y,index_x,game_matrix);
                    [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x);
                end
            end
        end
        %check if the snake have eaten the food and then increace it's size
        %draw the movment by refreshing the picture
        if(~isempty(get(groot,'CurrentFigure')))
            [top_score,score,text,snake,game_matrix,food]= if_eat(game_matrix,snake,text,score,top_score,food);
            game_matrix(snake(1).y,snake(1).x)=50 ;
            game_matrix(snake(end).y,snake(end).x)=255;
            image_reff(game_matrix);
             else
        back=0;
        key_preace='1';
        end
    end
    close(boord)
end
mainprogram;                                                                %return to menu
end
%the new game fuction
%output/input-none
%runs the player game
function newgame
%define the variables and initialize
choise=1;
global userchoice;
global key_preace;
top_score=0;
food=struct('y',{1},'x',{1});
%run the function until the break condition
while(choise~=2)
    %create the game figure and determine it's design
    boord = figure('Name','SNAKE','NumberTitle','off','pos',[400 55 670 670],'WindowStyle','modal','Units','centimeters','WindowKeyPressFcn',@key_callback);
    if(~isempty(get(groot,'CurrentFigure')))
        score=0;
        text=annotation('textbox',[.37 .18 0.8 0.8],'String',strcat('corrent score : ',int2str(score)," top score : ",int2str(top_score)),'FitBoxToText','on');
        %define and initialize variables
        game_matrix=zeros(100)+50;
        key_preace='0';
        old_key='0';
        exit_game='0';
        snake = struct('y',{1},'x',{1});
        index_x=randi(100);
        index_y=randi(100);
        up=0;
        right=0;
    else
        exit_game='1';
        choise=2;
    end
    for index = 1:8                                                         %determine the snake size
        snake(index) = struct('y',{index_y},'x',{index_x});
    end
    %create the board of the game
    game_matrix(randi(100),randi(100))=0 ;
    game_matrix(snake(end).y,snake(end).x)=255;
    if(~isempty(get(groot,'CurrentFigure')))
        image_reff(game_matrix);
    else
        exit_game='1';
        choise=2;
    end
    %tell the user to press a key and wait for his respond
    temp_text=annotation('textbox',[0.35 0.5 0.1 0.1],'String',('Press w,a,d or x to start moving'));
    while(key_preace=='0')
        pause(0.1);
        if(key_preace == 'w'||key_preace=='d'||key_preace == 'x'||key_preace=='a')
            break;
        else
            key_preace='0';
        end
    end
    delete(temp_text);
    %run the game until the break condition
    while(exit_game~='1')
        pause((0.7/(size(snake,2)))^(1.2^userchoice.speed));                %determine the speed acording to user choice and snake size
        [index_y,index_x,key_preace,old_key,right,up]=x_y(index_y,index_x,key_preace,old_key,right,up);         %determine the snake movment according to the key pressing
        %finish the game if the player fails
        if(check_fail(index_x,index_y,game_matrix))
            gmae_over=annotation('textbox',[.3 .5 0.1 0.1],'String','Game Over! Press B to back to the menu or R to restart','FitBoxToText','on');
            ander_game='0';
            key_preace='0';
            while(ander_game~='r')
                pause(0.1);
                ander_game=key_preace;
                if(ander_game=='b')
                    choise=2;
                    ander_game='r';
                    close(gcf);
                    mainprogram;
                end
            end
            close(gcf);
            break
        end
        %check if the snake have eaten the food and then increace it's size
        %draw the movment by refreshing the picture
        if(~isempty(get(groot,'CurrentFigure')))
            snake(end+1)=struct('y',{index_y},'x',{index_x});
            [top_score,score,text,snake,game_matrix,food]= if_eat(game_matrix,snake,text,score,top_score,food);
            game_matrix(snake(end).y,snake(end).x)=255;
            game_matrix(snake(1).y,snake(1).x)=50;
            snake(1)=[];
            image_reff(game_matrix)
        else
            exit_game='1';
            choise=2;
        end
    end
end
end
%the eating case fuction
%input-figure board,snake vector,the top text, the game score, top score, food location
%output-figure board,snake vector,the top text, the game score, top score, food location
%dealing with eating case
function [top_score,score,text,snake,boord,food] = if_eat(temp_boord,snake,text,score,top_score,food)
%if the sanke has eatten create a new food, increase snake size
if(temp_boord((snake(end).y),(snake(end).x))==0)
    good_plise=0;
    while(good_plise==0)
        %create and draw a new food with taking account of the non-avliable
        %spots
        food=struct('y',{randi(100)},'x',{randi(100)});
        if(temp_boord(food.y,food.x)~=255)
            temp_boord(food.y,food.x)=0;
            good_plise=1;
        end
    end
    %increase the snake size
    for i =1:2
        snake(end+1)=struct('y',{snake(end).y},'x',{snake(end).x});
    end
    %increase score and update the top score if needed
    score=score+1;
    if(top_score<score)
        top_score=score;
    end
    if(~isempty(get(groot,'CurrentFigure')))
        text.String= (strcat('corrent score : ',int2str(score)," top score : ",int2str(top_score)));    %update the data text
    end
end
boord=temp_boord;
end
%the check fail function
%input-x and y coordination of the snake head and the map matrix
%output-boolean variable which tell if fail is occur
%check if the move is causing a failure
function [bool]=check_fail(x,y,map)
if ((x>length(map))||(x<1)||(y<1)||(y>length(map))||(map(y,x)==255))
    bool=true;
else
    bool=false;
end
end
%the key callback function
%input-system definiton
%output-none
%recieving the keyboard input
function key_callback(src,event)
global key_preace;
key_preace=event.Character;
if(isempty(key_preace))
    key_preace='0';                                                         %in case of not compitable pressing put '0' in the key_preace variable
end
end
%the key to movment function
%input-x and y coordinates of the snake head, pressed value, the previous pressed value,previous movment details
%output-the new x,y coordinte of the head snake, the current press, the current movment
%convert the a key press to a movment
function [index_y,index_x,key_preace,old_key,right,up]=x_y(index_y,index_x,key_preace,old_key,right,up)
switch key_preace
    %dealing with 'q' pressing- update coordinates and variables
    case 'q'
        if(old_key=='a' ||old_key=='d')
            old_key='w';
            index_y=index_y-1;
            up=-1;
            right=0;
            key_preace='w';
        elseif(old_key=='w' || old_key=='x')
            old_key='a';
            index_x=index_x-1;
            up=0;
            right=-1;
            key_preace='a';
        end
        %dealing with 'w' pressing- update coordinates and variables
    case 'w'
        if(old_key~='x')
            index_y=index_y-1;
            old_key=key_preace;
            up=-1;
            right=0;
        else
            index_y=index_y+1;
            old_key='x';
        end
        %dealing with 'e' pressing- update coordinates and variables
    case 'e'
        if(old_key=='a' ||old_key=='d')
            old_key='w';
            index_y=index_y-1;
            up=-1;
            right=0;
            key_preace='w';
        elseif(old_key=='w' ||old_key=='x')
            old_key='d';
            index_x=index_x+1;
            up=0;
            right=1;
            key_preace='d';
        end
        %dealing with 'd' pressing- update coordinates and variables
    case 'd'
        if(old_key~='a')
            index_x=index_x+1;
            old_key=key_preace;
            up=0;
            right=1;
        else
            index_x=index_x-1;
            old_key='a';
        end
        %dealing with 'c' pressing- update coordinates and variables
    case 'c'
        if(old_key=='a' ||old_key=='d')
            old_key='x';
            index_y=index_y+1;
            up=1;
            right=0;
            key_preace='x';
        elseif(old_key=='w' ||old_key=='x')
            old_key='d';
            index_x=index_x+1;
            up=0;
            right=1;
            key_preace='d';
        end
        %dealing with 'x' pressing- update coordinates and variables
    case 'x'
        if(old_key~='w')
            index_y=index_y+1;
            old_key=key_preace;
            up=1;
            right=0;
        else
            index_y=index_y-1;
            old_key='w';
        end
        %dealing with 'z' pressing- update coordinates and variables
    case 'z'
        if(old_key=='a' || old_key=='d')
            old_key='x';
            index_y=index_y+1;
            up=1;
            right=0;
            key_preace='x';
        elseif(old_key=='w' ||old_key=='x')
            old_key='a';
            index_x=index_x-1;
            up=0;
            right=-1;
            key_preace='a';
        end
        %dealing with 'a' pressing- update coordinates and variables
    case 'a'
        if(old_key~='d')
            index_x=index_x-1;
            old_key=key_preace;
            up=0;
            right=-1;
        else
            index_x=index_x+1;
            old_key='d';
        end
        %in case of not pressing the movment keys keep moving in the
        %current diraction
    otherwise
        index_x=index_x+right;
        index_y=index_y+up;
end
end
%the mainmenu function
%output/input-none
%the function creates a popup menu and store the user choices
function mainmenu

global userchoice;                                                          %difined a global struct which would store the user choices
userchoice.speed=1;                                                         %determine defult speed choice

%create a figure which includs the menu and define it's design
fmenu = figure('name','MAIN MENU','NumberTitle','off','WindowStyle',...
    'modal','pos',[520 190 350 400],'color',[0.55 0.5 0.3]);
headline=annotation('textbox',[.28 .75 .2 .2],'string',...
    '~~S~N~A~K~E~~','FitBoxToText','on');
headline.FontSize=12;

% Create a push button for starting new game
startbutton = uicontrol('Style', 'pushbutton', 'String',...                 %button design, location and fuction link
    'START NEW GAME','Position', [120 280 120 50],'Callback', @startgame);

% Create a push button for starting simulation
simulationbutton = uicontrol('Style', 'pushbutton', 'String',...            %button design, location and fuction link
    'SIMULATION','Position', [120 220 120 50],'Callback', @simulationgame);

% Create a multiply scrolled option menu
speedoption = uicontrol('Style', 'popup',...                                %scrolled menu design, location and fuction link
    'String', {'1-noob','2-beginner','3-average','4-pro','5-superman'},...
    'Position', [120 160 120 50],'Callback', @speedset);

% Create an exit button
exitbutton = uicontrol('Style', 'pushbutton', 'String', 'EXIT',...          %button design, location and fuction link
    'Position', [120 40 120 50],'Callback', @exitgame);

%when user push the start button- put 'g' to userchoice.option
    function startgame(source,event)
        userchoice.option='g';
        close(gcf);                                                         %close figure
    end

%when user choose speed- update the userchoice.speed value
    function speedset(source,event)
        userchoice.speed=source.Value;
    end

%when user push the simulation button- put 's' to userchoice.option
    function simulationgame(source,event)
        userchoice.option='s';
        close(gcf);                                                         %close figure
    end
    function exitgame(source,event)
        userchoice.option='e';
        close(gcf);                                                         %close figure
    end
end
%the image refreshing function
%input-map matrix
%output-none
%draw the map ofter the updates
function  image_reff(game_matrix)
image(game_matrix);
set(gca,'xtick',[],'ytick',[])
colormap(flag)
drawnow()
end
%the snake movment function
%input-map matrix,snake vector, x and y coordinates of the snake head
%output-map matrix,snake vector
%update the new location of the snake
function [game_matrix,snake] =snake_moove(game_matrix,snake,index_y,index_x)
snake(end+1)=struct('y',{index_y},'x',{index_x});
snake(1)=[];
end
%the safe move locating function
%input-map matrix, x and y coordinates of the snake head
%output-x and y coordinates of the snake head, faliure status values
%check for safe place spot to move
function [back,playing,index_y,index_x]= move_non_fail(index_y,index_x,game_matrix)
%define varaibles and initializing
global key_preace;
playing=1;
back=1;
%check which of the next optional move is safe and choose the first move
%which is safe
if(~check_fail(index_x,index_y+1,game_matrix))
    index_y=index_y+1;
elseif(~check_fail(index_x+1,index_y,game_matrix))
    index_x=index_x+1;
elseif(~check_fail(index_x,index_y-1,game_matrix))
    index_y=index_y-1;
elseif(~check_fail(index_x-1,index_y,game_matrix))
    index_x=index_x-1;
else
    %in case of no safe move pop a messege and recieve user key input for
    %a new simulation or back to the menu
    key_preace='0';
    gmae_over=annotation('textbox',[.3 .5 0.1 0.1],'String','Game Over! Press B to back to the menu or R to restart','FitBoxToText','on');
    while(key_preace~='r')
        pause(0.1)
        playing=0;
        if(key_preace=='b')
            back=0;
            delete(gmae_over);
            break;
        end
    end
    delete(gmae_over);
end
end

