function [P, comparisons, coordComparisons] = naive_no_filter(X)
    % Algorytm bez filtracji zgodny z pseudokodem
    % Input: X - macierz punktów
    % Output: P - macierz punktów niezdominowanych
    %         comparisons - liczba porównań punktów
    %         coordComparisons - liczba porównań współrzędnych

    n = size(X, 1); % Liczba punktów w zbiorze X
    P = []; % Inicjalizacja zbioru punktów niezdominowanych
    comparisons = 0; % Liczba porównań punktów
    coordComparisons = 0; % Liczba porównań współrzędnych

    for i = 1:n
        Y = X(i, :); % Rozważany punkt
        fl = 0; % Flaga określająca, czy punkt Y został zastąpiony

        for j = i+1:n
            comparisons = comparisons + 1; % Liczymy porównania punktów
            coordComparisons = coordComparisons + 2 * size(X, 2); % Porównania współrzędnych

            % Sprawdzamy dominację
            if all(Y <= X(j, :)) && any(Y < X(j, :)) % Y ≤ X(j)
                % Punkt X(j) jest zdominowany, usuwamy go
                X(j, :) = inf; % Usunięcie X(j) przez oznaczenie jako punkt "nieskończony"
            elseif all(X(j, :) <= Y) && any(X(j, :) < Y) % X(j) ≤ Y
                % Punkt Y jest zdominowany, zastępujemy go przez X(j)
                Y = X(j, :);
                X(j, :) = inf; % Usunięcie X(j)
                fl = 1;
            end
        end

        % Dodanie punktu Y do listy niezdominowanych
        P = [P; Y];

        % Usunięcie Y z listy X, jeśli fl=0 (czyli Y = X(i))
        if fl == 0
            X(i, :) = inf;
        end
    end
end