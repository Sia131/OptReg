%% Function 
f = @(x) 100* (x(2) - x(1)^2)^2 + (1 - x(1))^2;
delta_f = @(x)    [400*x(1)^3 - 400*x(1)*x(2) + 2*x(1) - 2;
            200*(x(2) - x(1)^2)                       ];
J = @(x)        [1200*x(1)^2 - 400*x(2) + 2, -400*x(1);
                -400*x(1),                  200        ];

 
%f = @(x) x(1)^2 + x(2)^2 + 15;
%delta_f = @(x) [2*x(1);
%                2*x(2)];
%J = @(x)       [2, 0;
%                0, 2];
            
%%
x0 = [-1.2 , 1]';
[x_n, f_n, alpha_n,k_n] = minimize_function(f, delta_f, J,@newton,@step_length, x0);
[x_s, f_s, alpha_s,k_s] = minimize_function(f, delta_f, J,@steepest_descent,@step_length, x0);
[x_b, f_b, alpha_b,k_b] = minimize_function(f, delta_f, J,@BFGS,@step_length, x0);



%t = linspace(0,iter, iter);
t = 1:k_n;
subplot(3,1,1)
plot(t,f_n)
title("newton")
grid("on")


t = 1:k_s;
subplot(3,1,2)
plot(t,f_s)
title("steepest descent ")
grid("on")


t = 1:k_b;
subplot(3,1,3)
plot(t,f_b)
title("BFGS ")
grid("on")



sgtitle("x0 = [-1.2 1]'")