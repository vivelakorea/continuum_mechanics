function deformation_draw(plts, X1_range, X2_range, X3_range)
    
    % draw
    for t = 1 : size(plts, 3)

        plot3(plts(1, :, t), plts(2, :, t), plts(3, :, t), 'ko');
        
        if nargin == 4
            axis([X1_range(1) X1_range(2) ...
                  X2_range(1) X2_range(2) ...
                  X3_range(1) X3_range(2)])
        end
        
        drawnow;
        pause(0.2);
        hold off

    end

end