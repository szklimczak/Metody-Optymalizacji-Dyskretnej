function varargout = GUI(varargin)
% jest to GUI dla porownania trzech metod, naiwna (bez/z filtracja) i 
% punktu idealnego trzeba ogarnąć tego luccio i będzie cacy


% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 01-Dec-2024 14:25:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Ustawienie domyślnych parametrów
set(handles.rozklad, 'Value', 1); % Domyślny rozkład: normalny
set(handles.param1, 'Enable', 'on');
set(handles.param2, 'Enable', 'on');
set(handles.param3, 'Enable', 'off');
set(handles.param4, 'Enable', 'off');
set(handles.param5, 'Enable', 'off');

% Initial table setup
set(handles.tabela_kryteria, 'Data', {'Kryterium 1', 'Min'; 'Kryterium 2', 'Max'});

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in dodaj_kryterium.
function dodaj_kryterium_Callback(hObject, eventdata, handles)
    dane_kryteria = get(handles.tabela_kryteria, 'Data');
    nowy_wiersz = {sprintf('Kryterium %d', size(dane_kryteria, 1) + 1), 'Min'};
    dane_kryteria = [dane_kryteria; nowy_wiersz];
    set(handles.tabela_kryteria, 'Data', dane_kryteria);
% hObject    handle to dodaj_kryterium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in usun_kryterium.
function usun_kryterium_Callback(hObject, eventdata, handles)
    dane = get(handles.tabela_kryteria, 'Data');
    if ~isempty(dane)
        dane(end, :) = [];
    end
    set(handles.tabela_kryteria, 'Data', dane);
% hObject    handle to usun_kryterium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in rozklad.
function rozklad_Callback(hObject, eventdata, handles)
wybor = get(hObject, 'Value');
if wybor == 1 % Normalny
    set(handles.param1, 'Enable', 'on');
    set(handles.param2, 'Enable', 'on');
    set(handles.param3, 'Enable', 'off');
    set(handles.param4, 'Enable', 'off');
    set(handles.param5, 'Enable', 'off');
elseif wybor == 2 % Jednostajny
    set(handles.param1, 'Enable', 'off');
    set(handles.param2, 'Enable', 'off');
    set(handles.param3, 'Enable', 'off');
    set(handles.param4, 'Enable', 'on');
    set(handles.param5, 'Enable', 'on');
elseif wybor == 3 % Poissona
    set(handles.param1, 'Enable', 'off');
    set(handles.param2, 'Enable', 'off');
    set(handles.param3, 'Enable', 'on');
    set(handles.param4, 'Enable', 'off');
    set(handles.param5, 'Enable', 'off');
end

% hObject    handle to rozklad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rozklad contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rozklad


% --- Executes during object creation, after setting all properties.
function rozklad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rozklad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param1_Callback(hObject, eventdata, handles)
% hObject    handle to param1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param1 as text
%        str2double(get(hObject,'String')) returns contents of param1 as a double


% --- Executes during object creation, after setting all properties.
function param1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param2_Callback(hObject, eventdata, handles)
% hObject    handle to param2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param2 as text
%        str2double(get(hObject,'String')) returns contents of param2 as a double


% --- Executes during object creation, after setting all properties.
function param2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param3_Callback(hObject, eventdata, handles)
% hObject    handle to param3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param3 as text
%        str2double(get(hObject,'String')) returns contents of param3 as a double


% --- Executes during object creation, after setting all properties.
function param3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param4_Callback(hObject, eventdata, handles)
% hObject    handle to param4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param4 as text
%        str2double(get(hObject,'String')) returns contents of param4 as a double


% --- Executes during object creation, after setting all properties.
function param4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param5_Callback(hObject, eventdata, handles)
% hObject    handle to param5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param5 as text
%        str2double(get(hObject,'String')) returns contents of param5 as a double


% --- Executes during object creation, after setting all properties.
function param5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generuj.
function generuj_Callback(hObject, eventdata, handles)
    % Pobierz wybrany rozkład
    rozklad = get(handles.rozklad, 'Value');
    
    % Pobierz liczbę obiektów
    liczba_obiektow = str2double(get(handles.liczba_obiektow, 'String'));
    
    % Pobierz dane z tabeli kryteriów (nazwy i kierunki)
    kryteria = get(handles.tabela_kryteria, 'Data'); % Zakładając, że 'tabela_kryteriow' zawiera nazwy i kierunki
    
    % Pobierz liczbę kryteriów (liczba kolumn w tabeli kryteriów)
    num_kryteriow = size(kryteria, 1);
    
    % Inicjalizacja tabeli danych
    dane = zeros(liczba_obiektow, num_kryteriow);
    
    % Generowanie danych w zależności od wybranego rozkładu
    for i = 1:num_kryteriow
        if rozklad == 1 % Normalny
            % Pobierz parametry dla rozkładu normalnego
            % Załóżmy, że są wpisane w odpowiednich polach: średnia i odchylenie standardowe
            srednia = str2double(get(handles.param1, 'String'));
            odchylenie = str2double(get(handles.param2, 'String'));
            tic;
            dane(:, i) = srednia + odchylenie * randn(liczba_obiektow, 1);
            time1 = toc;
            if i == 1
                fprintf('Czas generowania dla rozkładu normalnego Time = %.4f s\n', time1);
            end
        elseif rozklad == 2 % Jednostajny
            % Pobierz parametry dla rozkładu jednostajnego
            % Załóżmy, że są wpisane w odpowiednich polach: dolna i górna granica
            dolna = str2double(get(handles.param4, 'String'));
            gorna = str2double(get(handles.param5, 'String'));
            tic;
            dane(:, i) = dolna + (gorna - dolna) * rand(liczba_obiektow, 1);
            time2 = toc;
            if i == 1
                fprintf('Czas generowania dla rozkładu jednostajnego Time = %.4f s\n', time2);
            end
        elseif rozklad == 3 % Poissona
            % Pobierz parametr lambda dla rozkładu Poissona
            lambda = str2double(get(handles.param3, 'String'));
            tic;
            dane(:, i) = poissrnd(lambda, liczba_obiektow, 1);
            time3 = toc;
            if i == 1
                fprintf('Czas generowania dla rozkładu Poissona Time = %.4f s\n', time3);
            end
        end
    end
    
    % Zaktualizowanie tabeli danych
    set(handles.tabela_wartosci, 'Data', dane);
    
    % Zaktualizowanie nazw kolumn w tabeli
    nazwy_kolumn = cell(1, num_kryteriow);
    for i = 1:num_kryteriow
        nazwy_kolumn{i} = sprintf('Kryterium %d', i);
    end
    set(handles.tabela_wartosci, 'ColumnName', nazwy_kolumn);

set(handles.tabela_wartosci, 'Data', dane);
% hObject    handle to generuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sortuj.
function sortuj_Callback(hObject, eventdata, handles)
% hObject    handle to sortuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function liczba_obiektow_Callback(hObject, eventdata, handles)
% hObject    handle to liczba_obiektow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of liczba_obiektow as text
%        str2double(get(hObject,'String')) returns contents of liczba_obiektow as a double


% --- Executes during object creation, after setting all properties.
function liczba_obiektow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liczba_obiektow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sortuj_kolumna_Callback(hObject, eventdata, handles)
    kolumna = str2double(get(handles.sortuj_kolumna, 'String'));
    dane = get(handles.tabela_wartosci, 'Data');
    if ~isempty(dane) && kolumna > 0 && kolumna <= size(dane, 2)
        dane = sortrows(dane, kolumna);
        set(handles.tabela_wartosci, 'Data', dane);
    end
% hObject    handle to sortuj_kolumna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sortuj_kolumna as text
%        str2double(get(hObject,'String')) returns contents of sortuj_kolumna as a double


% --- Executes during object creation, after setting all properties.
function sortuj_kolumna_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sortuj_kolumna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in algorytm.
function algorytm_Callback(hObject, eventdata, handles)
% hObject    handle to algorytm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns algorytm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from algorytm


% --- Executes during object creation, after setting all properties.
function algorytm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algorytm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in renderuj_animacje.
function renderuj_animacje_Callback(hObject, eventdata, handles)
% hObject    handle to renderuj_animacje (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in przerwij.
function przerwij_Callback(hObject, eventdata, handles)
% hObject    handle to przerwij (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in benchmark.
function benchmark_Callback(hObject, eventdata, handles)
    X = get(handles.tabela_wartosci, 'Data');
    % Benchmark dla naive_no_filter
    tic;
    [P1, comp1, coordComp1] = naive_no_filter(X);
    time1 = toc;

    % Benchmark dla naive_with_filter
    tic;
    [P2, comp2, coordComp2] = naive_with_filter(X);
    time2 = toc;

    % Benchmark dla Punktu Idealnego
    tic;
    [P3, comp3, coordComp3] = ideal_point(X);
    time3 = toc;

    % Benchmark dla Luccio-Prepala - naprawić funkcję i można dodać :DD
    tic;
    [P4, comp4, coordComp4] = KungLuccioPreparata(X);
    time4 = toc;

    % Wyświetlenie wyników
    fprintf('Benchmark Results:\n');
    fprintf('Naive (No Filter): Time = %.4f s, Point Comparisons = %d, Coord Comparisons = %d\n', time1, comp1, coordComp1);
    fprintf('Naive (With Filter): Time = %.4f s, Point Comparisons = %d, Coord Comparisons = %d\n', time2, comp2, coordComp2);
    fprintf('Ideal Point: Time = %.4f s, Point Comparisons = %d, Coord Comparisons = %d\n', time3, comp3, coordComp3);
    fprintf('Kung Luccio Preparata: Time = %.4f s, Point Comparisons = %d, Coord Comparisons = %d\n', time4, comp4, coordComp4);

    % Wykres dla czasu wykonania
    figure;
    bar([time1, time2, time3, time4]);
    set(gca, 'XTickLabel', {'No Filter', 'With Filter', 'Ideal Point', 'Kung-Luccio-Preparata'});
    ylabel('Execution Time (s)');
    title('Benchmark: Execution Time');
    grid on;

    % Wykres dla liczby porównań punktów i współrzędnych
    figure;
    bar([comp1, coordComp1; comp2, coordComp2; comp3, coordComp3; comp4, coordComp4]');
    set(gca, 'XTickLabel', {'Number of Points Comparisons', 'Number of Coordinates Comparisons'});
    title('Benchmark: Point And Coordinates Comparisons');
    legend('No Filter', 'With Filter', 'Ideal Point', 'Kung-Luccio-Preparata', Location='northwest')
    grid on;

    % Oblicz punkt idealny
    [idealPoint, ~, ~] = ideal_point(X);

    % Obliczanie różnic względem punktu idealnego (dla każdego algorytmu)
    diff1 = sqrt(sum((P1(1) - idealPoint).^2, 2));
    diff2 = sqrt(sum((P2(1) - idealPoint).^2, 2));
    diff4 = sqrt(sum((P4(1) - idealPoint).^2, 2));

    % Obliczanie średniej i odchylenia standardowego dla różnic
    meanDiff1 = mean(diff1);
    stdDiff1 = std(diff1);

    meanDiff2 = mean(diff2);
    stdDiff2 = std(diff2);

    meanDiff4 = mean(diff4);
    stdDiff4 = std(diff4);

    % Wykresy dla odległości do punktu idealnego z odchyleniem standardowym
    figure;
    % Wykres dla odległości do punktu idealnego
    barWithError([meanDiff1, meanDiff2, meanDiff4], [stdDiff1, stdDiff2, stdDiff4], 'Distance to Ideal');

function barWithError(means, stdDevs, ylabelText)
    % Funkcja pomocnicza do rysowania słupków z błędami (średnia + odchylenie standardowe)
    bar(means);
    hold on;
    % Rysowanie błędów jako linie
    errorbar(1:length(means), means, stdDevs, 'k', 'linestyle', 'none', 'LineWidth', 2);
    hold off;
    set(gca, 'XTickLabel', {'No Filter', 'With Filter', 'Kung-Luccio-Preparata'});
    ylabel(ylabelText);
    title([ylabelText ' with Standard Deviation']);
    grid on;

% --- Executes on button press in rozwiaz.
function rozwiaz_Callback(hObject, eventdata, handles)  
    % Pobierz dane z tabeli wartości
    dane = get(handles.tabela_wartosci, 'Data');
    % Pobierz wybrany algorytm
    algorytm = get(handles.algorytm, 'Value');
    % Wykonaj algorytm
    if algorytm == 1 % Naiwny bez filtracji
        wynik = naive_no_filter(dane);
    elseif algorytm == 2 % Naiwny z filtracją
        wynik = naive_with_filter(dane);
    elseif algorytm == 3 %Punkt idealny
       wynik = ideal_point(dane);
    elseif algorytm == 4 %Kunga, Luccio & Preparaty
       wynik = KungLuccioPreparata(dane);
    end
    disp('Punkty niezdominowane:');
    disp(wynik);
    % Generowanie wykresu
    [n, m] = size(dane);  % n - liczba punktów, m - liczba wymiarów
    if m == 2
        % Wykres 2D dla 2 wymiarów (2 kryteria)
        figure;
        scatter(dane(:,1), dane(:,2), 'b');  % Wykres wszystkich punktów
        hold on;
        scatter(wynik(:,1), wynik(:,2), 'r', 'filled');  % Wykres punktów niezdominowanych
        xlabel('Kryterium 1');
        ylabel('Kryterium 2');
        title('Rozwiązanie problemu');
        legend('Zdominowane', 'Niezdominowane');
    elseif m == 3
        % Wykres 3D dla 3 wymiarów (3 kryteria)
        figure;
        scatter3(dane(:,1), dane(:,2), dane(:,3), 'b');  % Wykres wszystkich punktów
        hold on;
        scatter3(wynik(:,1), wynik(:,2), wynik(:,3), 'r', 'filled');  % Wykres punktów niezdominowanych
        xlabel('Kryterium 1');
        ylabel('Kryterium 2');
        zlabel('Kryterium 3');
        title('Rozwiązanie problemu');
        legend('Zdominowane', 'Niezdominowane');
    elseif m == 4
        % Wykres 4D dla 4 wymiarów (4 kryteria)
        figure;
        c = dane(:,4);  % Czwarty wymiar (czwarte kryterium)
        
        ksztalty = ones(n, 1);
        ksztalty(1:length(wynik), :) = 2;
        
        % Rozdzielenie punktów zdominowanych i niezdominowanych
        niezdominowane_idx = (ksztalty == 1);
        zdominowane_idx = (ksztalty == 2);
        
        % Scatter plot z różnymi kształtami i kolorami
        scatter3(dane(niezdominowane_idx, 1), dane(niezdominowane_idx, 2), dane(niezdominowane_idx, 3), ...
                 100, c(niezdominowane_idx), 'square', 'filled');
        hold on;
        scatter3(dane(zdominowane_idx, 1), dane(zdominowane_idx, 2), dane(zdominowane_idx, 3), ...
                 100, c(zdominowane_idx), 'o', 'filled');
        colormap(hot), colorbar;  % Dodanie colorbar dla czwartego kryterium
        xlabel('Kryterium 1');
        ylabel('Kryterium 2');
        zlabel('Kryterium 3');
        ylabel(colorbar, 'Kryterium 4', rotation=0);
        title('Rozwiązanie problemu');
        legend('Niezdominowane', 'Zdominowane');
    elseif m > 4 % Dla więcej niż 4 kryteriów brak wykresu
    end
% hObject    handle to rozwiaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


