function [optSeamMask, seamEnergy] = findOptSeam(energy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Following paper by Avidan and Shamir `07
% Finds optimal seam by the given energy of an image
% Returns mask with 0 mean a pixel is in the seam
% You only need to implement vertical seam. For
% horizontal case, just using the same function by 
% giving energy for the transpose image I'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Find M for vertical seams
    % Add one element of padding in vertical dimension 
    % to avoid handling border elements
    M = padarray(energy, [0 1], realmax('double'));

    sz = size(M);
    
    % For all rows starting from second row, fill in the minimum 
    % energy for all possible seam for each (i,j) in M, which
    % M[i, j] = e[i, j] + min(M[i - 1, j - 1], M[i - 1, j], M[i - 1, j + 1]).     
    
    %%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE:
    %%%%%%%%%%%%%%%%%% 
    for i = 2 : sz(1)
        for j = 2 : (sz(2) - 1)
            neighbors = [M(i - 1, j - 1) M(i - 1, j) M(i - 1, j + 1)];
            M(i, j) = M(i, j) + min(neighbors);
        end
    end
    %%%%%%%%%%%%%%%%%%
    % END OF YOUR CODE
    %%%%%%%%%%%%%%%%%%
    

    % Find the minimum element in the last raw of M
    [val, indJ] = min(M(sz(1), :));
    seamEnergy = val;
    fprintf('Min Energy: %.2f\n', seamEnergy);
    
    % Initial for optimal seam mask
    optSeamMask = zeros(size(energy), 'uint8');
    
    % Traverse back the path of seam with minimum energy
    % and update optimal seam mask, which (i,j) value of 
    % a seam should be set to 1 here
    % (Aware the size of mask and the M is different)
    
    %%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE:
    %%%%%%%%%%%%%%%%%%
    for i = sz(1) : -1 : 2
        optSeamMask(i, indJ - 1) = 1; % -1 because of padding on 1 element from left
        neighbors = [M(i - 1, indJ - 1) M(i - 1, indJ) M(i - 1, indJ + 1)];
        [val, indIncr] = min(neighbors);

        seamEnergy = seamEnergy + val;

        indJ = indJ + (indIncr - 2); % (x - 2): [1,2]->[-1,1]]
    end
    optSeamMask(1, indJ - 1) = 1; % -1 because of padding on 1 element from left
    %%%%%%%%%%%%%%%%%%
    % END OF YOUR CODE
    %%%%%%%%%%%%%%%%%%
  
    % convert the mask to logical
    optSeamMask = ~optSeamMask; 
    
 
end
