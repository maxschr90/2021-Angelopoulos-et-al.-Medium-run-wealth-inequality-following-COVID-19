%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - BELLMAN EQUATION                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V] = bellman(k_tt,c,b,orderpoly,Transition,beta,mu)

    V = -(((((c).^(1-mu)))./(1-mu))+beta*expectedvalue(k_tt,b,orderpoly)*Transition') ;
    % We use the negative of V so it can be passed to fmincon

end


            