
function [p,B_new] = steepest_descent(~,delta_f,~, x,B,k)
    p = -delta_f(x(:,k));
    B_new = B(:,:,k);
end


