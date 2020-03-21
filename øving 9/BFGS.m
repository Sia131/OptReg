function [p,B_new] = BFGS(~,delta_f,~, x,B,k)
    if k == 1
       B_new = eye(2);
       p = -delta_f(x(:,k));
    else
       y = delta_f(x(:,k)) - delta_f(x(:,k-1));
       s = x(:,k) - x(:,k-1);
       
       if s'*y > 0
           rho = 1/(y'*s);
           B_new = (eye(2) - rho*y*s')*B(:,:,k -1)*(eye(2) - rho*s*y') + rho*(y)*y';
           p = -1*B_new\delta_f(x(:,k));
           
       else
           B_new = eye(2);
           p = -delta_f(x(:,k));
       end
    end
           
end 