%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOLVE THE MODEL AND SIMULATE THE DYNAMIC TRANSITION PATHS             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Short Recession, No consumption cap
clear
clc
fprintf('Setup Exogenous Processes and Parameters \n')
[Normal_Transition_Pre, Pandemic_Transition_Pre, wages, r, A, T, worldstate] = SetupExogenous_good();
[Transitions] = GenerateTransitionMatrices_good(Normal_Transition_Pre, Pandemic_Transition_Pre, T) ;
[parms] = SetupParameters();
fprintf('Solve Stationary End Point Problem\n')
tic
[b, Value_Function, k_choice_stat, c_choice_stat, grid_parms, initdist] = SolveStationaryProblem(parms,r(end), wages(end,:)*A(end), Transitions(:,:,end),worldstate(end));
fprintf('Stationary Problem has Converged in: %.5f seconds. \n',toc')
fprintf('Simulate Stationary Distribution\n')
tic
[ALPHA, ~, nn] = nonstochsim_stat(initdist,Transitions(:,:,end), k_choice_stat, grid_parms);
fprintf('Simulation of Stationary Distribution completed in: %.5f seconds. \n',toc')
initdist = reshape(ALPHA, size(initdist));
fprintf('Solve Dynamic Problem backwards \n')
tic
[ k_choice, c_choice] = SolveVFbackward(b,Value_Function,k_choice_stat,c_choice_stat, Transitions, wages, A, r, parms,grid_parms,worldstate);
fprintf('Dynamic Problem has Completed in: %.5f seconds. \n',toc')
fprintf('Simulate Forward \n')
tic
[OMEGA, aa,  nn] = nonstochsim(initdist,Transitions, k_choice, grid_parms);
fprintf('Simulation has Completed in: %.5f seconds. \n',toc')
    
[Share_Class,Share_HTM,Share_HTM_Class, Mean_K,  Mean_C, Mean_E, Mean_Y, Median_K,  Median_C, Median_E, Palma, Pareto, Quintile_Share, Percentiles, Percentiles_Class, Var_K, Var_C, Var_E,  GINI_K, GINI_C, GINI_E, GINI_Y, P10_K,P10_C, P10_E, P90_K,  P90_C, P90_E, Mean_K_Class, Mean_C_Class, Mean_E_Class, Mean_Y_Class,  Median_K_Class, Median_C_Class, Median_E_Class,Palma_Class, Pareto_Class,  Var_K_Class, Var_C_Class, Var_E_Class,  P10_K_Class, P10_C_Class, P10_E_Class, P90_K_Class, P90_C_Class, P90_E_Class, GINI_K_Class, GINI_C_Class, GINI_E_Class, GINI_Y_Class,Quintile_Share_Class] = SummaryStatistics(OMEGA, k_choice, c_choice, wages.*A', r, aa, nn);
save('Good_v2.mat')

%% Short Recession, Consumption cap
clear
clc
fprintf('Setup Exogenous Processes and Parameters \n')
[Normal_Transition_Pre, Pandemic_Transition_Pre, wages, r, A, T, worldstate] = SetupExogenous_good();
worldstate(1:2) =1;
[Transitions] = GenerateTransitionMatrices_good(Normal_Transition_Pre, Pandemic_Transition_Pre, T) ;
[parms] = SetupParameters();
fprintf('Solve Stationary End Point Problem\n')
tic
[b, Value_Function, k_choice_stat, c_choice_stat, grid_parms, initdist] = SolveStationaryProblem(parms,r(end), wages(end,:)*A(end), Transitions(:,:,end),worldstate(end));
fprintf('Stationary Problem has Converged in: %.5f seconds. \n',toc')
fprintf('Simulate Stationary Distribution\n')
tic
[ALPHA, ~, ~] = nonstochsim_stat(initdist,Transitions(:,:,end), k_choice_stat, grid_parms);
fprintf('Simulation of Stationary Distribution completed in: %.5f seconds. \n',toc')
initdist = reshape(ALPHA, size(initdist));
fprintf('Solve Dynamic Problem backwards \n')
tic
[ k_choice, c_choice] = SolveVFbackward(b,Value_Function,k_choice_stat,c_choice_stat, Transitions, wages, A, r, parms,grid_parms,worldstate);
fprintf('Dynamic Problem has Completed in: %.5f seconds. \n',toc')
fprintf('Simulate Forward \n')
tic
[OMEGA, aa,  nn] = nonstochsim(initdist,Transitions, k_choice, grid_parms);
fprintf('Simulation has Completed in: %.5f seconds. \n',toc')   
[Share_Class,Share_HTM,Share_HTM_Class, Mean_K,  Mean_C, Mean_E, Mean_Y, Median_K,  Median_C, Median_E, Palma, Pareto, Quintile_Share, Percentiles, Percentiles_Class, Var_K, Var_C, Var_E,  GINI_K, GINI_C, GINI_E, GINI_Y, P10_K,P10_C, P10_E, P90_K,  P90_C, P90_E, Mean_K_Class, Mean_C_Class, Mean_E_Class, Mean_Y_Class,  Median_K_Class, Median_C_Class, Median_E_Class,Palma_Class, Pareto_Class,  Var_K_Class, Var_C_Class, Var_E_Class,  P10_K_Class, P10_C_Class, P10_E_Class, P90_K_Class, P90_C_Class, P90_E_Class, GINI_K_Class, GINI_C_Class, GINI_E_Class, GINI_Y_Class,Quintile_Share_Class] = SummaryStatistics(OMEGA, k_choice, c_choice, wages.*A', r, aa, nn);
save('Good_Cap_v2.mat')

%% Long Recession, No consumption cap
clear
clc
fprintf('Setup Exogenous Processes and Parameters \n')
[Normal_Transition_Pre, Pandemic_Transition_Pre, wages, r, A, T, worldstate] = SetupExogenous_bad();
[Transitions] = GenerateTransitionMatrices_bad(Normal_Transition_Pre, Pandemic_Transition_Pre, T) ;
[parms] = SetupParameters();
fprintf('Solve Stationary End Point Problem\n')
tic

[b, Value_Function, k_choice_stat, c_choice_stat, grid_parms, initdist] = SolveStationaryProblem(parms,r(end), wages(end,:)*A(end), Transitions(:,:,end),worldstate(end));
fprintf('Stationary Problem has Converged in: %.5f seconds. \n',toc')
fprintf('Simulate Stationary Distribution\n')
tic
[ALPHA, ~, ~] = nonstochsim_stat(initdist,Transitions(:,:,end), k_choice_stat, grid_parms);
fprintf('Simulation of Stationary Distribution completed in: %.5f seconds. \n',toc')
initdist = reshape(ALPHA, size(initdist));
fprintf('Solve Dynamic Problem backwards \n')
tic
[ k_choice, c_choice] = SolveVFbackward(b,Value_Function,k_choice_stat,c_choice_stat, Transitions, wages, A, r, parms,grid_parms,worldstate);
fprintf('Dynamic Problem has Completed in: %.5f seconds. \n',toc')
fprintf('Simulate Forward \n')
tic
[OMEGA, aa,  nn] = nonstochsim(initdist,Transitions, k_choice, grid_parms);
fprintf('Simulation has Completed in: %.5f seconds. \n',toc') 
[Share_Class,Share_HTM,Share_HTM_Class, Mean_K,  Mean_C, Mean_E, Mean_Y, Median_K,  Median_C, Median_E, Palma, Pareto, Quintile_Share, Percentiles, Percentiles_Class, Var_K, Var_C, Var_E,  GINI_K, GINI_C, GINI_E, GINI_Y, P10_K,P10_C, P10_E, P90_K,  P90_C, P90_E, Mean_K_Class, Mean_C_Class, Mean_E_Class, Mean_Y_Class,  Median_K_Class, Median_C_Class, Median_E_Class,Palma_Class, Pareto_Class,  Var_K_Class, Var_C_Class, Var_E_Class,  P10_K_Class, P10_C_Class, P10_E_Class, P90_K_Class, P90_C_Class, P90_E_Class, GINI_K_Class, GINI_C_Class, GINI_E_Class, GINI_Y_Class,Quintile_Share_Class] = SummaryStatistics(OMEGA, k_choice, c_choice, wages.*A', r, aa, nn);
save('Bad_v2.mat')

%% Long Recession, Consumption cap
clear
clc
fprintf('Setup Exogenous Processes and Parameters \n')
[Normal_Transition_Pre, Pandemic_Transition_Pre, wages, r, A, T,  worldstate] = SetupExogenous_bad();
worldstate(1:2) =1;
[Transitions] = GenerateTransitionMatrices_bad(Normal_Transition_Pre, Pandemic_Transition_Pre, T) ;
[parms] = SetupParameters();
fprintf('Solve Stationary End Point Problem\n')
tic
[b, Value_Function, k_choice_stat, c_choice_stat, grid_parms, initdist] = SolveStationaryProblem(parms,r(end), wages(end,:)*A(end), Transitions(:,:,end),worldstate(end));
fprintf('Stationary Problem has Converged in: %.5f seconds. \n',toc')
fprintf('Simulate Stationary Distribution\n')
tic
[ALPHA, ~, ~] = nonstochsim_stat(initdist,Transitions(:,:,end), k_choice_stat, grid_parms);
fprintf('Simulation of Stationary Distribution completed in: %.5f seconds. \n',toc')
initdist = reshape(ALPHA, size(initdist));
fprintf('Solve Dynamic Problem backwards \n')
tic
[ k_choice, c_choice] = SolveVFbackward(b,Value_Function,k_choice_stat,c_choice_stat, Transitions, wages, A, r, parms,grid_parms,worldstate);
fprintf('Dynamic Problem has Completed in: %.5f seconds. \n',toc')
fprintf('Simulate Forward \n')
tic
[OMEGA, aa,  nn] = nonstochsim(initdist,Transitions, k_choice, grid_parms);
fprintf('Simulation has Completed in: %.5f seconds. \n',toc')  
[Share_Class,Share_HTM,Share_HTM_Class, Mean_K,  Mean_C, Mean_E, Mean_Y, Median_K,  Median_C, Median_E, Palma, Pareto, Quintile_Share, Percentiles, Percentiles_Class, Var_K, Var_C, Var_E,  GINI_K, GINI_C, GINI_E, GINI_Y, P10_K,P10_C, P10_E, P90_K,  P90_C, P90_E, Mean_K_Class, Mean_C_Class, Mean_E_Class, Mean_Y_Class,  Median_K_Class, Median_C_Class, Median_E_Class,Palma_Class, Pareto_Class,  Var_K_Class, Var_C_Class, Var_E_Class,  P10_K_Class, P10_C_Class, P10_E_Class, P90_K_Class, P90_C_Class, P90_E_Class, GINI_K_Class, GINI_C_Class, GINI_E_Class, GINI_Y_Class,Quintile_Share_Class] = SummaryStatistics(OMEGA, k_choice, c_choice, wages.*A', r, aa, nn);
save('Bad_Cap_v2.mat')

    
  


    


    


    
    


















    
  


    


    


    
    

















