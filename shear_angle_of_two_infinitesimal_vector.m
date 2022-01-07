function gamma = shear_angle_of_two_infinitesimal_vector(X1, X2, X3, x1, x2, x3, dX1, dX2)
    if size(dX1, 2) == 3
        dX1 = dX1.';
    end
    if size(dX2, 2) == 3
        dX2 = dX2.';
    end

    F = sym('f', [3 3]);
    F(1,1) = diff(x1, X1);
    F(1,2) = diff(x1, X2);
    F(1,3) = diff(x1, X3);
    F(2,1) = diff(x2, X1);
    F(2,2) = diff(x2, X2);
    F(2,3) = diff(x2, X3);
    F(3,1) = diff(x3, X1);
    F(3,2) = diff(x3, X2);
    F(3,3) = diff(x3, X3);
    del_u = F - eye(3);
    E_star = 0.5 * (del_u + del_u.' + del_u.'*del_u);

    n1 = dX1/norm(dX1);
    n2 = dX2/norm(dX2);
    disp(n1.')
    s1_S1 = sqrt(1 + n1.'*E_star*n1);
    s2_S2 = sqrt(1 + n2.'*E_star*n2);
    
    gamma = asin((1/(s1_S1 * s2_S2)) * n1.'*(F.'*F)*n2);
end