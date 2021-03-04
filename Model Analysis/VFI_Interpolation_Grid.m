%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - SOLVES THE HH PROBLEM                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [BC, k_choice, c_choice, y, util, TV] = VFI_Interpolation_Grid(wage, r, b_lim, k_t, k_tt,  mu,beta, Transition,  b, orderpoly, worldstate);
    %% Calculate availabe resources
        if k_t <0
            r = 2*r;
        end
        y = wage+(1+r)*k_t;
        if worldstate ==1
            cap =  1.2024; %% this is the value of the 70th  pct in consumption for the stationary distribution
        else
            cap=Inf;
        end
    %% For each productivity State find optimal choices and the value of the VF        
        options = optimoptions(@fmincon,'Display','off','OptimalityTolerance', 1e-8, 'StepTolerance', 1e-8','SpecifyObjectiveGradient',false, 'DerivativeCheck', 'off','Algorithm','sqp');
            parfor n = 1:size(wage,2)
                [z(:,n),fval(n)] = fmincon(@(x)bellman(x(1),x(2), b,orderpoly,Transition(n,:),beta,mu), [k_tt(n), min(cap,y(n)-k_tt(n))]',[1,1],y(n),[],[],[b_lim,0]',[y(n)-b_lim,min(cap,y(n)-b_lim)]',[], options);%%
            end
    %% Collect Choices & VF        
    k_choice = z(1,:)';
    c_choice = z(2,:)';
    util = (((c_choice).^(1-mu)))./(1-mu);
    TV = -fval;
    BC = y' - c_choice - k_choice;
    
end