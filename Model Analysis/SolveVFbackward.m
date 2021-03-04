%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - SOLVES THE HH PROBLEM                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ k_choice, c_choice] = SolveVFbackward(b_stat,VF_stat,k_choice_stat, c_choice_stat, Transitions, wages, A, r, parms, grid_parms, worldstate)
%% PARAMETERS

        mu = parms.mu; % CRRA Coefficient
        beta = parms.beta; % Discount Rate

    %% Building Grids for Endogenous Variables
        nkap = grid_parms.nkap;
        kap = grid_parms.kap; % Capital  
        b_lim = grid_parms.b_lim;
        indexsize = nkap; % Total Number of Gridpoints
   %% Add Grids together & Vectorize
        kapx = repmat(1:size(kap,2),1, (indexsize/nkap));
                 
T=size(Transitions,3);
indexsize = size(kapx,2);
b = NaN(size(b_stat,1),size(b_stat,2),T);
k_choice = NaN(indexsize, size(b,2),T);
c_choice = NaN(indexsize, size(b,2),T);

Value_Function = NaN(size(VF_stat,1),size(VF_stat,2),T);

for t =T-80:T %% for the last decades the value and policy functions are the same as in the stationary world
    b(:,:,t)= b_stat;
    Value_Function(:,:,t)= VF_stat;
    k_choice(:,:,t) = k_choice_stat;
    c_choice(:,:,t) = c_choice_stat;
end

orderpoly =7;

for t=81:T-1
        parfor i = 1:indexsize
              [~,k_temp(i,:)  , c_temp(i,:), ~,~, V_temp(i,:)] = VFI_Interpolation_Grid(wages(T-t,:)*A(T-t), r(T-t),b_lim, kap(kapx(i)), k_choice(i,:,T-t+1), mu,  beta, Transitions(:,:,T-t), b(:,:,T-t+1), orderpoly,worldstate(T-t));
        end
        

        k_choice(:,:,T-t) =k_temp;
        c_choice(:,:,T-t) =c_temp;
        Value_Function(:,:,T-t) =V_temp;
        b(:,:,T-t)=  interpV(Value_Function(:,:,T-t),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    


end
k_choice =cat(3,k_choice_stat, k_choice(:,:,1:T-1));
c_choice =cat(3,c_choice_stat, c_choice(:,:,1:T-1));
end
