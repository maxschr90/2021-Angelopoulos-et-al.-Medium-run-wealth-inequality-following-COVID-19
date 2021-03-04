%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - SETUP TRANSITION MATRICES FOR THE SEVERE RECESSION SCENARIO%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Transitions] = GenerateTransitionMatrices_bad(Normal_Transition_Pre, Shock_Transition_Pre, T)

    Stat_Transition_combined = Normal_Transition_Pre;
    Shock_Transition_combined = Shock_Transition_Pre;
    %% Allow the Employment Transition Matrix to linearly go back after the shock in T_Employment Periods
   t_e = reshape([ 0.8333,0, 1 1 1 1 1 ],1,1,[]);

    Employment_Trans = Shock_Transition_combined+[t_e.*(Stat_Transition_combined-Shock_Transition_combined)];
    Employment_Trans(:,:,8:T) = repmat(Stat_Transition_combined,1,1,T-7);

    %% Combine Both Transition Matrices to form the combined Exogenous Process
    for t =1:T
        Transitions(:,:,t) = Employment_Trans(:,:,t);
    end

end
