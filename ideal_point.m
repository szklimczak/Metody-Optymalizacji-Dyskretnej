function [P, comparisons, coordComparisons] = ideal_point(X)
    % Metoda punktu idealnego
    % Input: X - macierz punktów, gdzie każdy wiersz to punkt w przestrzeni wielokryterialnej
    % Output: P - macierz punktów niezdominowanych
    %         comparisons - liczba porównań punktów
    %         coordComparisons - liczba porównań współrzędnych
    
    n = size(X, 1);   % Liczba punktów w zbiorze X
    comparisons = 0;  % Zmienna zliczająca porównania punktów
    coordComparisons = 0;   % Zmienna zliczająca porównania współrzędnych
    P = [];   % Inicjalizacja zbioru punktów niezdominowanych

    % Obliczanie odległości d(j) od punktu idealnego
    xmin = min(X);  % Punkt idealny (min każdej współrzędnej)
    d = [];   % Wektor odległości
    for j = 1:n
        d = [d, sum((xmin - X(j, :)).^2)];   % Odległość euklidesowa do punktu idealnego
    end

    % Sortowanie punktów według odległości (rosnąco)
    [~, J] = sort(d); 
    X = X(J, :); 
    
    while ~isempty(X) 
        Y = X(1, :);   % Wybranie aktualnie analizowanego punktu
        X(1, :) = [];  % Usunięcie aktualnie rozważanego punktu
        P = [P; Y];    % Dodanie bieżącego punktu do listy punktów, które nie są zdominowane
        new_X = [];    % Wektor tymczasowy
        
        % Sprawdzenie, które punkty są niezdominowane
        for i = 1:size(X, 1)
            A = X(i, :); % Punkt analizowany
            B = Y;       % Punkt odniesienia
            
            % Określenie które punkty są niezdominowane
            isDominated = true; % Flaga określająca, czy punkt jest zdominowany
            all_ge = true; % Flag określająca wszystkie współrzędne A >= B
            any_g = false; % Flaga określająca czy którakolwiek współrzędna A > B
            for k = 1:length(A)
                coordComparisons = coordComparisons + 1; % Liczymy porównania współrzędnych
                if A(k) < B(k)
                    all_ge = false;
                elseif A(k) > B(k)
                    any_g = true;
                end
            end
            isDominated = all_ge && any_g;

            if ~isDominated
                comparisons = comparisons + 1;  % Liczymy porównania punktów
                new_X = [new_X; A];
            end
        end
        X = new_X;
    end
end
