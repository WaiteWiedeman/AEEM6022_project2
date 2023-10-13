
% @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
% @@@@ @@@@
% @@@@ PREPARED BY ANOOP SATHYAN @@@@
% @@@@ @@@@
% @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function distance = TwoOpt_TSP(locations,distances)
%n = 100; %Set the number of cities
n = length(locations);
%xy = 10*rand(n,2); %Randomise the positions of cities
xy = locations;
num_iter = 100; % Number of iterations
a = meshgrid(1:n);
%dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),n,n); %Distance Matrix
dmat = distances;
opt_rte = [1:1:n];
newopt = opt_rte; %Initial Tour
newopt(n+1) = opt_rte(1); %Should return to the starting position.
plot(xy(:,1),xy(:,2),'r.');
pfig = figure('Name','Current Best Solution','Numbertitle','off');

for iter = 1:num_iter,
    for i = 1:n-2,
        for j = i+2:n,
            d1 = dmat(newopt(i),newopt(i+1)) + dmat(newopt(j),newopt(j+1));
            d2 = dmat(newopt(i),newopt(j)) + dmat(newopt(i+1),newopt(j+1));
            if d1 > d2 %Compare the distances
                [newopt(j),newopt(i+1)] = deal(newopt(i+1),newopt(j)); %Swap move.
            else
            end
            if i == 1,
                newopt(n+1) = newopt(1);
            elseif (i == n)||(j == n)
                newopt(1) = newopt(n+1);
            end
        end
    end
end
optresult = newopt(1:n);
xy_opt = xy(optresult,:);
xy_opt(n+1,:) = xy(optresult(1),:);
distance = 0;
for ii = 1:n-1,
    distance = distance + dmat(optresult(ii),optresult(ii+1));
end
total_distance = distance + dmat(optresult(1),optresult(n));
figure(pfig)
plot(xy_opt(:,1),xy_opt(:,2),'r.-')
title(sprintf('Distance = %f',total_distance))
