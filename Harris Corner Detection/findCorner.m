

% Function that finds the maxima in a window (1 units in each direction) so
% as to determine if there is a corner or not.
function [outputMatrix] = findCorner(inputMatrix, windowWidth, thresh)

% Multiplying with large number in order make easier to read
inputMatrix = inputMatrix.*1000000;

% Create waitbar.
h = waitbar(0,'Suppressing Redundant Points...');
set(h,'Name','Suppression Filter Progress');

% Size of array
[m, n] = size(inputMatrix);

outputMatrix = zeros(m, n);
% Region 1 (Corners)
if (((windowWidth + 1) > m) || ((windowWidth + 1) > n) || ((m - windowWidth) < 1 ) || ((n - windowWidth) < 1 ))
   error('windowWidth violation!');
end

currentPoint = inputMatrix(1,1);
if ((currentPoint > thresh) && (currentPoint > inputMatrix(1,1+windowWidth)) && (currentPoint > inputMatrix(1+windowWidth,1+windowWidth)) && (currentPoint > inputMatrix(1+windowWidth,1)) )
    outputMatrix(1,1) = 1;
    % disp(currentPoint);
end

currentPoint = inputMatrix(1,n);
if ((currentPoint > thresh) &&  (currentPoint > inputMatrix(1,n-windowWidth)) && (currentPoint > inputMatrix(1+windowWidth,n)) && (currentPoint > inputMatrix(2,n-windowWidth)) )
    outputMatrix(1,n) = 1;
    %disp(currentPoint);
end

currentPoint = inputMatrix(m,1);
if ((currentPoint > thresh) &&  (currentPoint > inputMatrix(m,1+windowWidth)) && (currentPoint > inputMatrix(m-windowWidth,1)) && (currentPoint > inputMatrix(m-windowWidth,1+windowWidth)) )
    outputMatrix(m,1) = 1;
    %disp(currentPoint);
end

currentPoint = inputMatrix(m,n);
if ( (currentPoint > thresh) && (currentPoint > inputMatrix(m,n-windowWidth)) && (currentPoint > inputMatrix(m-windowWidth,n)) && (currentPoint > inputMatrix(m-windowWidth,n-windowWidth)) )
    outputMatrix(m,n) = 1;
    %disp(currentPoint);
end

% Region 2 (Edges)
for j=2:n-1,
    currentPoint = inputMatrix(1,j);
    if( (j-windowWidth) < 1 )
        continue;
    elseif((j+windowWidth) > n)
        break;
    else
        if( (currentPoint > thresh) && (currentPoint > inputMatrix(1,j-windowWidth)) && (currentPoint > inputMatrix(1+windowWidth,j-windowWidth)) && (currentPoint > inputMatrix(1+windowWidth,j)) && (currentPoint > inputMatrix(1+windowWidth,j+windowWidth)) && (currentPoint > inputMatrix(1,j+windowWidth)) )
            outputMatrix(1,j) = 1;
            %disp(currentPoint);
        end
    end
end

for j=2:n-1,
    currentPoint = inputMatrix(m,j);
    if( (j-windowWidth) < 1 )
        continue;
    elseif((j+windowWidth) > n)
        break;
    else
        if( (currentPoint > thresh) && (currentPoint > inputMatrix(m,j-windowWidth)) && (currentPoint > inputMatrix(m-windowWidth,j-windowWidth)) && (currentPoint > inputMatrix(m-windowWidth,j)) && (currentPoint > inputMatrix(m-windowWidth,j+windowWidth)) && (currentPoint > inputMatrix(m,j+windowWidth)) )
            outputMatrix(m,j) = 1;
            %disp(currentPoint);
        end
    end
end

for i=2:m-1,
    currentPoint = inputMatrix(i,1);
     if( (i-windowWidth) < 1 )
        continue;
    elseif((i+windowWidth) > m)
        break;
    else
        if( (currentPoint > thresh) && (currentPoint > inputMatrix(i-windowWidth,1)) && (currentPoint > inputMatrix(i-windowWidth,1+windowWidth)) && (currentPoint > inputMatrix(i,1+windowWidth)) && (currentPoint > inputMatrix(i+windowWidth,1+windowWidth)) && (currentPoint > inputMatrix(i+windowWidth,1)) )
            %disp(currentPoint);
            outputMatrix(i,1) = 1;
        end
     end
end

for i=2:m-1,
    currentPoint = inputMatrix(i,n);
     if( (i-windowWidth) < 1 )
        continue;
    elseif((i+windowWidth) > m)
        break;
    else
        if( (currentPoint > thresh) && (currentPoint > inputMatrix(i-windowWidth,n)) && (currentPoint > inputMatrix(i-windowWidth,n-windowWidth)) && (currentPoint > inputMatrix(i,n-windowWidth)) && (currentPoint > inputMatrix(i+windowWidth,n-windowWidth)) && (currentPoint > inputMatrix(i+windowWidth,n)) )
            %disp(currentPoint);
            outputMatrix(i,n) = 1;
        end
     end
end

% Region 3 (Mid)
for i=2:m-1,
    for j=2:n-1,
        currentPoint = inputMatrix(i,j);
        if( ((i-windowWidth) < 1) || ((j-windowWidth) < 1))
            continue;
        elseif(((i+windowWidth) > m) || ((j+windowWidth) > n))
            break;
        else
            if( (currentPoint > thresh) && (currentPoint > inputMatrix(i-windowWidth,j-windowWidth)) && (currentPoint > inputMatrix(i-windowWidth,j)) && (currentPoint > inputMatrix(i-windowWidth,j+windowWidth)) && (currentPoint > inputMatrix(i,j+windowWidth)) && (currentPoint > inputMatrix(i+windowWidth,j+windowWidth)) && (currentPoint > inputMatrix(i+windowWidth,j)) && (currentPoint > inputMatrix(i+windowWidth,j-windowWidth)) && (currentPoint > inputMatrix(i,j-windowWidth)) )
            outputMatrix(i,j) = 1;
            %disp(currentPoint);
            end
        end
    end
    waitbar(i/m-1);
end
close(h);
return ;

