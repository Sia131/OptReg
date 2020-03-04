

A = [0 0 0; 0 0 1; 0.1 -0.79 1.78];
B = [1 0 0.1]';
C = [0 0 1]; 

Qt = [ 0 0 0; 0 0 0; 0 0 2];
Rt = 2;
N = 30;

x0 = [0 0 1]';

%Number of states and inputs
nx = size(A,2);
nu = size(B,2);

%cost function
I_N = eye(N);
Q = kron(I_N, Qt);
R = kron(I_N, Rt);
G = blkdiag(Q,R);


% Equality constraint
Aeq_c1 = eye(N*nx);                         % Component 1 of A_eq
Aeq_c2 = kron(diag(ones(N-1,1),-1), -A);    % Component 2 of A_eq
Aeq_c3 = kron(I_N, -B);                     % Component 3 of A_eq
Aeq = [Aeq_c1 + Aeq_c2, Aeq_c3];

beq = [A*x0; zeros((N-1)*nx,1)];

% Inequality constraints
x_lb = -Inf(N*nx,1);    % Lower bound on x
x_ub =  Inf(N*nx,1);    % Upper bound on x
u_lb = -ones(N*nu,1);   % Lower bound on u
u_ub =  ones(N*nu,1);   % Upper bound on u
lb = [x_lb; u_lb];      % Lower bound on z
ub = [x_ub; u_ub];      % Upper bound on z

% Solving the equality- and inequality-constrained QP with quadprog
opt = optimset('Display','notify', 'Diagnostics','off', 'LargeScale','off');
[z,fval,exitflag,output,lambda] = quadprog(G,[],[],[],Aeq,beq,lb,ub,[],opt);

% Extracting variables
y = [x0(3); z(nx:nx:N*nx)] % y = x3
u = z(N*nx+1:N*nx+N*nu);    % Control
% Time vector
t = 1:N;

% Plot optimal trajectory
figure(4);
subplot(2,1,1);
plot([0,t],y,'-ko'); % Plot on 0 to N
grid('on');
ylabel('y_t')
subplot(2,1,2);
plot(t-1,u,'-ko'); % Plot on 0 to N-1
grid('on');
xlabel('t');
ylabel('u_t');

