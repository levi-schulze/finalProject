function [] = waveGraph()
    close all;
    global gui;
    gui.fig = figure();
    gui.p = plot(0,0);
    ylim([-10 10]);
    ylabel('Displacement(Meters)');
    title('Wave Graph')
    gui.p.Parent.Position = [0.1 0.55 0.85 0.4]; 
    
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0.1 0.4 0.8 0.1],'selectionchangedfcn',{@graphType});
    gui.distanceButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.05 0.35 0.4 0.3],'HandleVisibility','off','string','Distance(Meters)');
    gui.timeButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.55 0.35 0.4 0.3],'HandleVisibility','off','string','Time(MilliSeconds)');

    gui.waveLength = uicontrol('style','edit','units','normalized','position',[0.1 0.25 0.3 0.05],'callback',{@waveLength});
    gui.waveLengthLabel = uicontrol('style','text','units','normalized','position',[0.1 0.3 0.3 0.05],'string','Wave Length(Meters)');
    gui.waveSpeed = uicontrol('style','edit','units','normalized','position',[0.5 0.25 0.3 0.05],'callback',{@waveSpeed});
    gui.waveSpeedLabel = uicontrol('style','text','units','normalized','position',[0.5 0.3 0.3 0.05],'string','Wave Speed(Meters/Second)');
    
    gui.frequency = uicontrol('style','text','units','normalized','position',[0.35 0.0 0.3 0.05],'string','Frequency:','callback',{@frequency});
    
    gui.amplitudeSliderLabel = uicontrol('style','text','units','normalized','position',[0.2 0.15 0.6 0.05],'string','Change Amplitute(Meters)');
    gui.amplitudeSlider = uicontrol('style','slider','units','normalized','position',[0.2 0.1 0.6 0.05],'value',1,'min',0,'max',10,'sliderstep',[1/19 1/19],'callback',{@amplitudeSlider});
    
end

function [] = waveLength(~,~)
    global gui;
    waveSpeed = str2double(gui.waveSpeed.String);
    if waveSpeed > 0
        type = gui.buttonGroup.SelectedObject.String;
        plotWave(type);
    end
end

function [] = waveSpeed(~,~)
    global gui;
    waveLength = str2double(gui.waveLength.String);
    if waveLength > 0
        type = gui.buttonGroup.SelectedObject.String;
        plotWave(type);
    end
end

function [] = frequency(~,~)
    global gui;
    waveLength = str2double(gui.waveLength.String);
    waveSpeed = str2double(gui.waveSpeed.String);
    if waveSpeed > 0 && waveLength > 0
        type = gui.buttonGroup.SelectedObject.String;
        plotWave(type);
    end
end
function [] = amplitudeSlider(~,~)
    global gui;
    gui.amplitudeSlider.Value = round(gui.amplitudeSlider.Value);
    type = gui.buttonGroup.SelectedObject.String;
    plotWave(type);
end

function [] = graphType(~,~)
    global gui;
    type = gui.buttonGroup.SelectedObject.String;
    plotWave(type);
end

function [] = plotWave(type)
    global gui;
    amplitude = gui.amplitudeSlider.Value;
    waveLength = str2double(gui.waveLength.String);
    waveSpeed = str2double(gui.waveSpeed.String);
    frequency = waveSpeed/waveLength;
    gui.frequency.String = ['Frequency: ',num2str(frequency),'Hz'];
    
    if strcmp(type,'Distance(Meters)')
        syms x;
        f = amplitude*cos((2*pi/waveLength)*x);
        fplot(f);
        ylim([-10 10]);
        ylabel('Displacement(Meters)');
        title('Wave Graph')
    else
        syms x;
        f = amplitude*cos(2*pi*frequency*(x/1000));
        fplot(f);
        ylim([-10 10]);
        ylabel('Displacement(Meters)');
        title('Wave Graph')
    end
end