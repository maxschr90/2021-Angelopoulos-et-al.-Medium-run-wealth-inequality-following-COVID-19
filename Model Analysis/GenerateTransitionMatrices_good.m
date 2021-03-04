%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - SETUP TRANSITION MATRICES FOR THE MILD RECESSION SCENARIO  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Employment_Trans] = GenerateTransitionMatrices_good(Normal_Transition_Pre, Shock_Transition_Pre, T)

    Stat_Transition_combined = Normal_Transition_Pre;
    Shock_Transition_combined = Shock_Transition_Pre;
    
    %% Allow the Employment Transition Matrix to linearly go back after the shock in T_Employment Periods
    t_e = reshape([2/3,0],1,1,[]);
    Employment_Trans = Shock_Transition_combined+[t_e.*(Stat_Transition_combined-Shock_Transition_combined)];
    Employment_Trans(:,:,3:T) = repmat(Stat_Transition_combined,1,1,T-2);
    Employment_Trans(10:12,1:9,3:4) =  Employment_Trans(10:12,1:9,3:4)*1.5;
    temp = Employment_Trans(10:12,10:12,end)./sum(Employment_Trans(10:12,10:12,end),2);
    Employment_Trans(10:12,10:12,3:4) = temp.*(1-sum(Employment_Trans(10:12,1:9,3:4),2));

end
