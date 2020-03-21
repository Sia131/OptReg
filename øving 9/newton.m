function [p, B_new] = newton(~,delta_f, J, x,B , k)
    p = -J(x(:,k))\delta_f(x(:,k));
    B_new = B(:,:,k);
end


