k1 = 1;
k2 = 1;
k3 = 1;
T = 0.1;

% Continuous time:
Ac = [  0    1 
      -k1  -k2 ];
Bc = [0  k3]';
Cc = [1  0;0 1];

% Discrete time:
A = eye(2) + Ac*T;
B = Bc*T;
C = [1  1];

Qt = diag([4 4]);
Rt = 1;

[K,S,e] = dlqr(Ac,Bc,Qt,Rt,[]);



