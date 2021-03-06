function [] = waveGraph()
    close all;
    global gui;
    gui.fig = figure(); %creates figure
    gui.p = plot(0,0); %creates empty plot
    ylim([-10 10]); %sets y axis limit for plot
    ylabel('Displacement(Meters)'); %adds y axis label
    title('Wave Graph') %adds title to plot
    gui.p.Parent.Position = [0.1 0.55 0.85 0.4]; %repositions plot
    
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0.1 0.4 0.8 0.1],'selectionchangedfcn',{@graphType}); %creates button group
    gui.distanceButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.05 0.35 0.4 0.3],'HandleVisibility','off','string','Distance(Meters)'); %adds buttons for x axis units
    gui.timeButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.55 0.35 0.4 0.3],'HandleVisibility','off','string','Time(MilliSeconds)');

    gui.waveLength = uicontrol('style','edit','units','normalized','position',[0.1 0.25 0.3 0.05],'callback',{@waveLength}); %creates edit box and label for wave length
    gui.waveLengthLabel = uicontrol('style','text','units','normalized','position',[0.1 0.3 0.3 0.05],'string','Wave Length(Meters)');
    gui.waveSpeed = uicontrol('style','edit','units','normalized','position',[0.5 0.25 0.3 0.05],'callback',{@waveSpeed}); %creates edit box and label for wave speed
    gui.waveSpeedLabel = uicontrol('style','text','units','normalized','position',[0.5 0.3 0.3 0.05],'string','Wave Speed(Meters/Second)');
    
    gui.frequency = uicontrol('style','text','units','normalized','position',[0.35 0.0 0.3 0.05],'string','Frequency:'); %creates text for frequency
    
    gui.amplitudeSliderLabel = uicontrol('style','text','units','normalized','position',[0.2 0.15 0.6 0.05],'string','Change Amplitute(Meters)'); %creates slider and label for amplitude
    gui.amplitudeSlider = uicontrol('style','slider','units','normalized','position',[0.2 0.1 0.6 0.05],'value',1,'min',0,'max',10,'sliderstep',[1/19 1/19],'callback',{@amplitudeSlider});
    
end

function [] = waveLength(~,~)
    global gui;
    waveSpeed = str2double(gui.waveSpeed.String); %changes variable to a number
    waveLength = str2double(gui.waveLength.String);
    if waveSpeed > 0 %checks if there is a value in waveSpeed
        type = gui.buttonGroup.SelectedObject.String; %determines what radiobutton is selected
        plotWave(type); %plots the values
    end
    if waveLength > 0
    else
        f = errordlg('Values entered must be numbers'); %prints error if incorrect values are entered
    end
end

function [] = waveSpeed(~,~)
    global gui;
    waveLength = str2double(gui.waveLength.String); %changes variable to a number
    waveSpeed = str2double(gui.waveSpeed.String);
    if waveLength > 0 %checks if there is a value in waveLength
        type = gui.buttonGroup.SelectedObject.String; %determines what radiobutton is selected
        plotWave(type); %plots the values
    end
    if waveSpeed > 0
    else
        f = errordlg('Values entered must be numbers'); %prints error if incorrect values are entered
    end
end

function [] = amplitudeSlider(~,~)
    global gui;
    gui.amplitudeSlider.Value = round(gui.amplitudeSlider.Value); %rounds slider values
    type = gui.buttonGroup.SelectedObject.String; %determines what radiobutton is selected
    plotWave(type); %plots the values
end

function [] = graphType(~,~)
    global gui;
    type = gui.buttonGroup.SelectedObject.String; %determines what radiobutton is selected
    plotWave(type); %plots the values
end

function [] = plotWave(type)
    global gui;
    amplitude = gui.amplitudeSlider.Value; %creates variable for amplitude
    waveLength = str2double(gui.waveLength.String); %converts string to number
    waveSpeed = str2double(gui.waveSpeed.String); %converts string to number
    frequency = waveSpeed/waveLength; %calculates frequency value
    gui.frequency.String = ['Frequency: ',num2str(frequency),'Hz']; %adds frequency values
    
    if strcmp(type,'Distance(Meters)') %determines what radiobutton is selected
        syms x; %creates a variable x
        f = amplitude*cos((2*pi/waveLength)*x); %calculates graph from equation of wave
        fplot(f); %plots the function
        ylim([-10 10]); %sets y axis limits
        ylabel('Displacement(Meters)'); %creates y axis label
        title('Wave Graph') %creates plot title
    else
        syms x; %creates a variable x
        f = amplitude*cos(2*pi*frequency*(x/1000)); %calculates graph from equation of wave and changes time to milliseconds
        fplot(f); %plots the function
        ylim([-10 10]); %sets y axis limits
        ylabel('Displacement(Meters)'); %creates y axis label
        title('Wave Graph') %creates plot title
    end
end