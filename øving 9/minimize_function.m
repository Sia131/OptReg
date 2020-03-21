%% minimize rosebrock

function [x_opt, fval, alpha, iter] = minimize_function(f, delta_f, J,dirfunction,stepfunction, x0)
    maxiter = 1000;
    grad_tol = 1e-3;
    
    %delcare variables
    Nx = size(x0,1);
    x = nan(Nx,maxiter);
    p = nan(Nx, maxiter);
    alpha = nan(1, maxiter);
    fval = nan(1, maxiter);
    B  = nan(Nx,Nx,maxiter);
    
    k = 1;
    x(:,k) = x0;
    alpha_0 = 1;
    
    while (k < maxiter) && (norm(delta_f(x(:,k))) > grad_tol)
        fval(k) = f(x(:,k));
        [p(:,k),B(:,:,k)] = dirfunction(f,delta_f, J, x,B,k);
        alpha(k) = stepfunction(f, delta_f, x(:,k), alpha_0,p(:,k));
        x(:,k+1) = x(:,k) + alpha(k)*p(:,k);
        
        k = k + 1;
    end
    fval(k) = f(x(:,k));
    
    iter = k;
    fval = fval(1:k);
    alpha = alpha(1:k);
    x_opt = x(:,1:k);
    
    
    
    
        