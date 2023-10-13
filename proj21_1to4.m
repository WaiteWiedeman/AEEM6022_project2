clc; clear; close all;

% normalized x and y coordinates of cities
x_cities = [0.1905, 0.4177, 1.1147, 0.1457, 1.0422, 0.6581, 0.2803, 0.6684, 0.414,...
    0.1785, 0.8779,1.1269, 0.7589, 1.2214, 0.9241, 0.5275, 0.8779, 0.5707,...
    0.7962, 0.8532, 0.2433, 0.4668, 0.2485,0.3945, 0.6758, 0.3435, 0.2286,...
    0.1173, 0.16, 0.1267, 0.3898, 1.3039, 1.2795, 0.5264, 0.7363,1.1704,...
    0.3625, 0.3522,0.9716, 0.8205, 0.5527, 0.7302, 0.6702, 0.7628, 0.9665,...
    1.2174, 0.9337, 0.3116, 0.7064, 1.2665];
y_cities = [0.9134, 0.5469,0.3922,0.8235,0.3171,0.3816,0.4898,0.6463,0.6797,...
    0.4984,0.2238,0.2551,0.6991,0.2435,0.4733,0.8308,0.5497,0.5678,...
    0.7792,0.4694,0.7943,0.5285,0.602,0.6541,0.0838,0.9133,0.8258,...
    0.4427,0.9619,0.3998,0.8001,0.5797,0.6221,0.5132,0.4893,0.3897,...
    0.4039,0.3532,0.4509,0.2963,0.6256,0.4359,0.3063,0.5108,0.3786,...
    0.5328,0.587,0.3012,0.2305,0.1948];
locations = [x_cities.' y_cities.'];

pop_size = 100;
num_iter = 1e4;
show_prog = 1;
show_res = 1;
varargout = cell(2,1);

figure;
load('usborder.mat','x','y','xx','yy');
plot(x,y,'Color','red'); hold on;
plot(x_cities,y_cities,'o')

for count1=1:length(x_cities)
    for count2=1:count1
        x1 = locations(count1,1);
        y1 = locations(count1,2);
        x2 = locations(count2,1);
        y2 = locations(count2,2);
        distances(count1,count2)=sqrt((x1-x2)^2+(y1-y2)^2);
        distances(count2,count1)=distances(count1,count2);
    end
end

[totalhulldistance, shortestPathLength] = tsp_nn(locations, distances);

fval = runga(locations, distances);

[varargout{:}] = tsp_ga(locations,distances,pop_size,num_iter,show_prog,show_res);

distance = TwoOpt_TSP(locations,distances);