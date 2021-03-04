%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - SOLVES THE STATIONARY PROBLEM                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [b, Value_Function,  k_choice, c_choice, grid_parms, initdist] = SolveStationaryProblem(parms, r, wages, Transition,worldstate)

    %% Algorithm Control
        Convergence_Criterion = 10^-8; % for VF Convergence
        orderpoly = 7; %Degree of polynominal for VF approximation (up to 3 (not recommended))
%% PARAMETERS
        mu = parms.mu; % CRRA Coefficient
        beta = parms.beta; % Discount Rate
        b_lim =parms.blim;
    %% Building Grids for Endogenous Variables
        nkap = 500;
        kap = (b_lim+(20-b_lim)*linspace(0,1,nkap).^4);

        indexsize = nkap; % Total Number of Gridpoints
   %% Add Grids together & Vectorize
        kapx = 1:nkap;        
        exog = size(Transition,1); % Number of idiosyncratic productivity states x health states
        grid_parms = struct('nkap', nkap, 'kap', kap, 'b_lim',b_lim);
        initdist = ones(nkap,exog).*(1/(nkap*exog));


      %% Preallocation
        TV = zeros(indexsize, exog);
   
%% VALUE FUNCTION ITERATION
        
    %% Make Initial Guess for Value Function assuming all income is consumed
        parfor i = 1:indexsize
            Value_Function(i,:) = (([(wages + (1+r)*kap(kapx(i)))].^(1-mu)))/(1-mu);
        end
    %% Make Initial Guess for Policy Function assuming all income is consumed
        k_policy = ones(indexsize,exog)*min(kap);
        k_choice = k_policy;

        
    %% Get Coefficients for VF Approximation    
       b = interpV(Value_Function,kap(kapx),orderpoly);
       
    %% Begin VFI Loop
        vfi_iter = 1; % Initialize Iteration Counter
        vficrit =1;

            while vficrit > Convergence_Criterion

                %% Howards Improvement Loop
                if vfi_iter > 2
                    howard_crit = 1;
                    t = 0;
                    while howard_crit > Convergence_Criterion*10^-2 && t<min(50, round(10*vfi_iter))   

                        %% Perform Howard Step

                            parfor i = 1:indexsize
                                EV_how(i,:) = beta*[sum(Transition(1,:).*expectedvalue(k_choice(i,1),b,orderpoly),2)      sum(Transition(2,:).*expectedvalue(k_choice(i,2),b,orderpoly),2)      sum(Transition(3,:).*expectedvalue(k_choice(i,3),b,orderpoly),2)      sum(Transition(4,:).*expectedvalue(k_choice(i,4),b,orderpoly),2)      sum(Transition(5,:).*expectedvalue(k_choice(i,5),b,orderpoly),2)      ...
                                                    sum(Transition(6,:).*expectedvalue(k_choice(i,6),b,orderpoly),2)      sum(Transition(7,:).*expectedvalue(k_choice(i,7),b,orderpoly),2)      sum(Transition(8,:).*expectedvalue(k_choice(i,8),b,orderpoly),2)      sum(Transition(9,:).*expectedvalue(k_choice(i,9),b,orderpoly),2)      sum(Transition(10,:).*expectedvalue(k_choice(i,10),b,orderpoly),2)   ...
                                                    sum(Transition(11,:).*expectedvalue(k_choice(i,11),b,orderpoly),2)   sum(Transition(12,:).*expectedvalue(k_choice(i,12),b,orderpoly),2)   ];
                            end
                        
                        
                        V_how = util + EV_how; 
                        howard_crit = max(max(abs(V_how-Value_Function)));
                        
                        %% Update Value Function
                        Value_Function = V_how;
                        t = t+1;
                    
                        %% Interpolate Value Function    
                    	b = interpV(Value_Function,kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                 
                    end
                else
                 %% Interpolate Value Function   
                 b = interpV(Value_Function,kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                end

                %% Perform VFI with Interpolation
                % Calculate VF + Choices at every Gridpoint
                parfor i = 1:indexsize
                        [BC(i,:), k_choice(i,:), c_choice(i,:), income(i,:), util(i,:), TV(i,:)] = VFI_Interpolation_Grid( wages, r, b_lim, kap(kapx(i)), k_policy(i,:),  mu,  beta, Transition, b, orderpoly,worldstate);
                end
                
                vficrit = norm(Value_Function-TV,inf);
                Value_Function = TV;    % Update VF

                k_policy = k_choice; % Update Policy
                
                b = interpV(Value_Function,kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                
                vfi_iter = vfi_iter+1; % increase counter

 
            end

       


end
