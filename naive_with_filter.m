function [P, comparisons, coordComparisons] = naive_with_filter(X)
    % Algorytm z filtracją punktów zdominowanych zgodny z pseudokodem
    % Input: X - macierz punktów
    % Output: P - macierz punktów niezdominowanych
    %         comparisons - liczba porównań punktów
    %         coordComparisons - liczba porównań współrzędnych

    P = []; % Inicjalizacja zbioru punktów niezdominowanych
    comparisons = 0; % Liczba porównań punktów
    coordComparisons = 0; % Liczba porównań współrzędnych

    while size(X, 1) > 1 % Dopóki w X jest więcej niż jeden punkt
        Y = X(1, :); % Wybierz pierwszy punkt
        X(1, :) = []; % Usuń go z listy X

        i = 1;
        while i <= size(X, 1)
            comparisons = comparisons + 1; % Liczba porównań punktów
            coordComparisons = coordComparisons + 2 * size(X, 2); % Porównania współrzędnych

            % Porównaj punkt Y z X(i,:)
            if all(Y <= X(i, :)) && any(Y < X(i, :)) % Y ≤ X(i)
                X(i, :) = []; % Usuń punkt X(i), bo jest zdominowany przez Y
            elseif all(X(i, :) <= Y) && any(X(i, :) < Y) % X(i) ≤ Y
                Y = X(i, :); % Zastąp Y punktem X(i)
                X(i, :) = []; % Usuń punkt X(i)
            else
                i = i + 1; % Przejdź do następnego punktu
            end
        end

        % Dodaj Y do zbioru niezdominowanego
        P = [P; Y];

        % Usuń z X wszystkie punkty zdominowane przez Y
        dominatedIndices = all(bsxfun(@le, Y, X), 2) & any(bsxfun(@lt, Y, X), 2);
        X(dominatedIndices, :) = [];
    end

    % Jeśli w X pozostał tylko jeden punkt, dodaj go do P
    if size(X, 1) == 1
        P = [P; X];
    end
end