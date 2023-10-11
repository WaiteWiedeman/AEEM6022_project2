clc; clear;
% map is an array of distances between nodes
% each row is the distance between the row number node 
% and the column number node
% if there is no path between nodes the value is "inf"
% if the column number is the node number, the value is zero
%      1   2   3   4   5   6   7   8   9   10
map = [inf 16  10  25  inf inf inf inf inf inf
       16  inf 20  3   15  inf inf inf inf inf
       10  20  inf 40  inf 6   inf inf inf inf
       25  3   40  inf 11  32  23  inf inf inf
       inf 15  inf 11  inf 22  27  19  inf inf
       inf inf 6   32  22  inf 16  inf 28  inf
       inf inf inf 23  27  16  inf 30  10  inf
       inf inf inf inf 19  inf 30  inf 25  14
       inf inf inf inf inf 28  10  25  inf 9
       inf inf inf inf inf inf inf 14  9   inf];
V = [2 3 4 5 6 7 8 9 10];
U = [1];
while isempty(V) == 0
    u = U(end);
    for i = 1:length(map(u,:))        
        [v,j] = min(map(u,:));        
    end
    map(:,j) = inf;
    U(end+1) = j;
    V(V == j) = [];
    if U(end) == 10
        disp(U)
        disp(map)
        return
    end
end
