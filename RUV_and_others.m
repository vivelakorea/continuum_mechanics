

dimension = 2;
syms t x1 x2
node1_u1_dot = 0.2;
node1_u2_dot = 0.1;
node2_u1_dot = -0.1;
node2_u2_dot = -0.2;
node3_u1_dot = -0.2;
node3_u2_dot = -0.1;
node4_u1_dot = 0.1;
node4_u2_dot = 0.2;

%      initial position         u
node1_x1 =       1           +   node1_u1_dot * t;
node1_x2 =       1           +   node1_u2_dot * t;
node2_x1 =      -1           +   node2_u1_dot * t;
node2_x2 =       1           +   node2_u2_dot * t;
node3_x1 =      -1           +   node3_u1_dot * t;
node3_x2 =      -1           +   node3_u2_dot * t;
node4_x1 =       1           +   node4_u1_dot * t;
node4_x2 =      -1           +   node4_u2_dot * t;
          
h1 = 0.25 * (1 + x1) * (1 + x2);
h2 = 0.25 * (1 - x1) * (1 + x2);
h3 = 0.25 * (1 - x1) * (1 - x2);
h4 = 0.25 * (1 + x1) * (1 - x2);

x1_at_t = h1 * node1_x1 + h2 * node2_x1 + h3 * node3_x1 + h4 * node4_x1;
x2_at_t = h1 * node1_x2 + h2 * node2_x2 + h3 * node3_x2 + h4 * node4_x2;

% X = [1 0.1*t;0 1];

syms X [2 2]
X(1,1) = diff(x1_at_t, x1);
X(1,2) = diff(x1_at_t, x2);
X(2,1) = diff(x2_at_t, x1);
X(2,2) = diff(x2_at_t, x2);

C = X.'*X;
[R_L, gamma2] = eig(C);
gamma = sqrt(gamma2); % pure stretch diagonal matrix
U = R_L * gamma * R_L.';
R = X/U;
R_E = R_L * R;
eta = R_L*(0.5*(gamma2-eye(dimension)))*R_L.'; % Green-Lagrange strain tensor

L = diff(X, t);
D = 0.5 * (L + L.');
W = 0.5 * (L - L.');
D_E = R_E.' * D * R_E;
W_E = R_E.' * W * R_E;
eta_dot = X.' * D * X;

