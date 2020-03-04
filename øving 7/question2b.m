

K_1 = 1;
K_2 = 1;
K_3 = 1;
T = 0.1;
x_0 = [5 1]';
x_0_hat = [6 0]';

Ad = [1 T; -K_2*T 1-K_1*T];
bd = [0 K_3*T]';
cd = [1 0];

desired_observer_poles = 0.5 + 0.03j*[1; -1];

Kf = place(Ad', cd',desired_observer_poles);

%simulation
time_steps = 50;
x = nan(2,time_steps + 1);
u = nan(1,time_steps+1);
y = nan(1,time_steps);
x_hat = nan(2,time_steps + 1);
y_hat = nan(1,time_steps);
x(:,1) = x_0;
x_hat(:,1) = x_0_hat;

for t = 1:time_steps
   u(:,t) = -K*x(:,t);
   y(:,t) = cd*x(:,t);
   x(:,t+1) = Ad*x(:,t) + bd*u(:,t);
   
   
   %simulate the observer
   y_hat(:,t) = cd*x_hat(:,t);
   x_hat(:,t+1) = Ad*x_hat(:,t) + bd*u(:,t) + Kf'*y(:,t) - Kf'*y_hat(:,t);
end

%plot
t = 0:time_steps;

subplot(2,1,1)
plot(t, x, 'r--','linewidth', 2);
hold on
plot(t,x_hat,'bl-')
hold off
hleg = legend('$x_1(t)$', '$x_2(t)$', '$\hat{x}_1(t)$', '$\hat{x}_2(t)$');
set(hleg, 'Interpreter', 'Latex');
grid('on');
ylabel('states and estimates');

subplot(2,1,2);
plot(t,u);
ylabel('u');
grid('on');


