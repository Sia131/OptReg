function alpha_k = step_length(f, delta_f, xk, alpha0, pk)
    alpha = alpha0;
    rho = 0.95;
    c = 1e-4;
    
    while f(xk + alpha*pk) > f(xk) + c*alpha*delta_f(xk)'*pk
        alpha = rho*alpha;
    end 
    
    alpha_k = alpha;
    
end