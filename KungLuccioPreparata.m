function [P, comparisons, coordComparisons] = kungLuccioPreparata(X)
    % Kung-Luccio-Preparata: Wyznaczanie punktów niezdominowanych
    % Input:
    %   X - macierz punktów
    % Output:
    %   P - punkty niezdominowane
    %   comparisons - liczba porównań punktów
    %   coordComparisons - liczba porównań współrzędnych

    % Sortowanie wstępne po pierwszym kryterium
    [X_sorted, sortComparisons] = sortPoints(X);

    % Rekurencyjne wyznaczanie punktów niezdominowanych
    [P, mergeComparisons, mergeCoordComparisons] = klpRecursive(X_sorted, 1, size(X_sorted, 1));

    % Zliczanie porównań
    comparisons = sortComparisons + mergeComparisons;
    coordComparisons = mergeCoordComparisons;
end

function [X_sorted, comparisons] = sortPoints(X)
    % Sortowanie punktów po pierwszym kryterium z liczeniem porównań
    comparisons = 0;

    % Implementacja sortowania bąbelkowego
    X_sorted = X;
    n = size(X_sorted, 1);
    for i = 1:n-1
        for j = 1:n-i
            comparisons = comparisons + 1; % Liczenie porównań punktów
            if X_sorted(j, 1) > X_sorted(j+1, 1)
                % Zamiana miejscami
                temp = X_sorted(j, :);
                X_sorted(j, :) = X_sorted(j+1, :);
                X_sorted(j+1, :) = temp;
            end
        end
    end
end

function [P, comparisons, coordComparisons] = klpRecursive(X, left, right)
    % Rekurencyjne wyznaczanie punktów niezdominowanych
    comparisons = 0;
    coordComparisons = 0;

    if left == right
        P = X(left, :);
        return;
    end

    % Dzielenie danych na części
    mid = floor((left + right) / 2);
    [P_left, leftComparisons, leftCoordComparisons] = klpRecursive(X, left, mid);
    [P_right, rightComparisons, rightCoordComparisons] = klpRecursive(X, mid + 1, right);

    % Scalanie wyników
    [P, mergeComparisons, mergeCoordComparisons] = mergeSets(P_left, P_right);

    % Sumowanie porównań
    comparisons = leftComparisons + rightComparisons + mergeComparisons;
    coordComparisons = leftCoordComparisons + rightCoordComparisons + mergeCoordComparisons;
end

function [P, comparisons, coordComparisons] = mergeSets(P_left, P_right)
    % Scalanie dwóch zbiorów punktów niezdominowanych
    P = P_left;
    comparisons = 0;
    coordComparisons = 0;

    for i = 1:size(P_right, 1)
        dominated = false;
        for j = 1:size(P_left, 1)
            comparisons = comparisons + 1; % Liczba porównań punktów
            coordComparisons = coordComparisons + size(P_left, 2); % Liczba porównań współrzędnych
            if all(P_left(j, :) <= P_right(i, :)) && any(P_left(j, :) < P_right(i, :))
                dominated = true;
                break;
            end
        end
        if ~dominated
            P = [P; P_right(i, :)];
        end
    end
end