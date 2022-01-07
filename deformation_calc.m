function plts = deformation_calc(x1, x2, x3, output_title, ... % mendatory
    X1_range, X2_range, X3_range, material_resolution, ... % optional
    t_range, t_resolution) % optional

    % ====================== input example ======================
    % deformation input
    % beta = 1;
    % k = 2;
    
    % syms X1 X2 X3 t
    
    % x1(X1, X2, X3, t) = beta * X2 ^ 2 * t^2 + X1;
    % x2(X1, X2, X3, t) = k * X2 * t + X2;
    % x3(X1, X2, X3, t) = X3;
    
    % X1_range = [-1 1];
    % X2_range = [-1 1];
    % X3_range = [-1 1];
    
    % t_range = [0 10];
    % t_resolution = 1;

    % ======================  example end  ======================
    
    if nargin == 4
        X1_range = [-1 1];
        X2_range = [-1 1];
        X3_range = [-1 1];
        material_resolution = 0.2;
        t_range = [0 10];
        t_resolution = 1;
    end    

    ranges = struct( ...
        'X1', X1_range, ...
        'X2', X2_range, ...
        'X3', X3_range, ...
        'material_resolution', material_resolution, ...
        't' , t_range, ...
        't_resolution', t_resolution ...
    );

    
    sizes = struct( ...
            'X1', size(ranges.X1(1) : ranges.material_resolution : ranges.X1(2), 2), ...
            'X2', size(ranges.X1(1) : ranges.material_resolution : ranges.X1(2), 2), ...
            'X3', size(ranges.X1(1) : ranges.material_resolution : ranges.X1(2), 2), ...
            't' , size(ranges.t(1) : ranges.t_resolution : ranges.t(2), 2) ...
    );


    % deformation
    % TODO: 이부분 vectorize
    plts = zeros(3, max([sizes.X1, sizes.X2, sizes.X3]), sizes.t);
    i = 1;
    for t = ranges.t(1) : ranges.t_resolution : ranges.t(2)
        fprintf("calculating for time = %f ( %d / %d )\n", t, i, sizes.t);
        j = 1;
        for X1 = ranges.X1(1) : ranges.material_resolution : ranges.X1(2)
            fprintf(" %f%% \n", 100 * j / (sizes.X1 * sizes.X2 * sizes.X3));
            for X2 = ranges.X2(1) : ranges.material_resolution : ranges.X2(2) 
                for X3 = ranges.X3(1) : ranges.material_resolution : ranges.X3(2)
                    
                    plts(1, j, i) = x1(X1, X2, X3, t); % x1
                    plts(2, j, i) = x2(X1, X2, X3, t); % x2
                    plts(3, j, i) = x3(X1, X2, X3, t); % x3
                    j = j + 1;

                end
            end
        end

        i = i + 1;
    end
    
    save(output_title, 'plts')
end
