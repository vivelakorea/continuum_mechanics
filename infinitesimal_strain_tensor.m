function E = infinitesimal_strain_tensor(X1, X2, X3, x1, x2, x3)
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
    E = 0.5 * (del_u + del_u.');
end