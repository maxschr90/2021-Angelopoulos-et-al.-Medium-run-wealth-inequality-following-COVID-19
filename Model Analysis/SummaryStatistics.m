%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - CALCULATE SUMMARY STATISTICS                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Share_Class,Share_HTM, Share_HTM_Class, Mean_K,  Mean_C, Mean_E, Mean_Y, Median_K,  Median_C, Median_E, Palma, Pareto, Quintile_Share, Percentiles, Percentiles_Class, Var_K, Var_C, Var_E,  GINI_K, GINI_C, GINI_E, GINI_Y, P10_K,P10_C, P10_E, P90_K,  P90_C, P90_E, Mean_K_Class, Mean_C_Class, Mean_E_Class, Mean_Y_Class,  Median_K_Class, Median_C_Class, Median_E_Class,Palma_Class, Pareto_Class,  Var_K_Class, Var_C_Class, Var_E_Class,  P10_K_Class, P10_C_Class, P10_E_Class, P90_K_Class, P90_C_Class, P90_E_Class, GINI_K_Class, GINI_C_Class, GINI_E_Class, GINI_Y_Class,Quintile_Share_Class] = SummaryStatistics(OMEGA, k_choice, c_choice, wages, r, aa, nn)

        [T] = size(OMEGA,2);
        k_choice =reshape(k_choice,[],T);
        c_choice =reshape(c_choice,[],T);

        wages = [wages(end,:);wages(1:end-1,:)];
            
        class =       (nn<4)...
                      + 2*(nn>3 & nn<=6)+  ...
                      + 3*(nn>6 & nn<=9)+  ...
                      + 4*(nn>9 & nn<=12) ;
        Share_Class = [sum(OMEGA(class ==1,:)); sum(OMEGA(class ==2,:)); sum(OMEGA(class ==3,:)); sum(OMEGA(class ==4,:))];
        
        Mean_K = sum(OMEGA.*k_choice);
        Mean_C = sum(OMEGA.*c_choice);
        Mean_E = sum(wages(:,nn)'.*OMEGA);
        Mean_Y = sum(wages(:,nn)'.*OMEGA+r.*repmat(aa,1,T).*OMEGA);
        
        parfor t=1:T
            [~,~,GINI_K(t)] =  gini( k_choice(:,t),OMEGA(:,t));
            [~,~,GINI_E(t)] = gini( wages(t,nn)',OMEGA(:,t));
            [~,~,GINI_Y(t)] = gini((r(t)*aa'+wages(t,nn)'),OMEGA(:,t));
            [~,~,GINI_C(t)] =  gini( c_choice(:,t),OMEGA(:,t));
            
            Share_HTM(t) = sum(OMEGA(:,t).*(k_choice(:,t)<10^-6));
            Palma(t) = (sum(OMEGA(:,t).*k_choice(:,t).*(k_choice(:,t)>wprctile(k_choice(:,t),90,OMEGA(:,t),8)))/sum(OMEGA(:,t).*k_choice(:,t).*(k_choice(:,t)<=wprctile(k_choice(:,t),40,OMEGA(:,t),8))));           
            Pareto(t) = (sum(OMEGA(:,t).*k_choice(:,t).*(k_choice(:,t)>wprctile(k_choice(:,t),80,OMEGA(:,t),8)))/sum(OMEGA(:,t).*k_choice(:,t).*(k_choice(:,t)<=wprctile(k_choice(:,t),80,OMEGA(:,t),8))));            
            
            Quintile_Share(:,t) = [sum(OMEGA(:,t).*k_choice(:,t).*(k_choice(:,t)<=wprctile(k_choice(:,t),20,OMEGA(:,t),8)));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),20,OMEGA(:,t),8))&(k_choice(:,t)<=wprctile(k_choice(:,t),40,OMEGA(:,t),8))));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),40,OMEGA(:,t),8))&(k_choice(:,t)<=wprctile(k_choice(:,t),60,OMEGA(:,t),8))));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),60,OMEGA(:,t),8))&(k_choice(:,t)<=wprctile(k_choice(:,t),80,OMEGA(:,t),8))));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),80,OMEGA(:,t),8))))]/Mean_K(t);
            Median_K(t) = wprctile(k_choice(:,t),50,OMEGA(:,t),8);
            Median_C(t) = wprctile(c_choice(:,t),50,OMEGA(:,t),8);
            Median_E(t) = wprctile(wages(t,nn)',50,OMEGA(:,t),8);
            
            P10_K(t) = wprctile(k_choice(:,t),10,OMEGA(:,t),8);
            P10_C(t) = wprctile(c_choice(:,t),10,OMEGA(:,t),8);
            P10_E(t) = wprctile(wages(t,nn)',10,OMEGA(:,t),8);
            
            P90_K(t) = wprctile(k_choice(:,t),90,OMEGA(:,t),8);
            P90_C(t) = wprctile(c_choice(:,t),90,OMEGA(:,t),8);
            P90_E(t) = wprctile(wages(t,nn)',90,OMEGA(:,t),8);
            
            Var_K(t) = var(k_choice(:,t),OMEGA(:,t));
            Var_C(t) = var(c_choice(:,t),OMEGA(:,t));
            Var_E(t) = var(wages(t,nn)',OMEGA(:,t));
            
            Percentiles(:,t) = [wprctile(k_choice(:,t),10,OMEGA(:,t),8);wprctile(k_choice(:,t),20,OMEGA(:,t),8);wprctile(k_choice(:,t),30,OMEGA(:,t),8);wprctile(k_choice(:,t),40,OMEGA(:,t),8);wprctile(k_choice(:,t),50,OMEGA(:,t),8);wprctile(k_choice(:,t),60,OMEGA(:,t),8);wprctile(k_choice(:,t),70,OMEGA(:,t),8);wprctile(k_choice(:,t),80,OMEGA(:,t),8);wprctile(k_choice(:,t),90,OMEGA(:,t),8)];
            for n = 1:4
                Share_HTM_Class(n,t) = sum(OMEGA(class==n,t).*(k_choice(class==n,t)<10^-6))/ sum(OMEGA(class==n,t));

                Mean_K_Class(n,t) = k_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_C_Class(n,t) = c_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_E_Class(n,t) = wages(t,nn(class==n))*OMEGA((class==n),t)/sum(OMEGA(:,t).*(class==n));
                Mean_Y_Class(n,t) = wages(t,nn(class==n))*OMEGA((class==n),t)/sum(OMEGA(:,t).*(class==n)) + r(t)*aa(class==n)'*OMEGA((class==n),t)/sum(OMEGA(:,t).*(class==n));
                Palma_Class(n,t) = (sum(OMEGA(class==n,t).*k_choice(class==n,t).*((k_choice(class==n,t)>(wprctile(k_choice(class==n,t),90,OMEGA(class==n,t),8)))))/sum(OMEGA(class==n,t).*k_choice(class==n,t).*((k_choice(class==n,t)<=wprctile(k_choice(class==n,t),40,OMEGA(class==n,t),8)))));            
                Pareto_Class(n,t) = (sum(OMEGA(class==n,t).*k_choice(class==n,t).*((k_choice(class==n,t)>(wprctile(k_choice(class==n,t),80,OMEGA(class==n,t),8)))))/sum(OMEGA(class==n,t).*k_choice(class==n,t).*((k_choice(class==n,t)<=wprctile(k_choice(class==n,t),80,OMEGA(class==n,t),8)))));            

                Median_K_Class(n,t) = wprctile(k_choice(class==n,t),50, OMEGA(class==n,t),8);
                Median_C_Class(n,t) = wprctile(c_choice(class==n,t),50, OMEGA(class==n,t),8);
                Median_E_Class(n,t) = wprctile(wages(t,nn(class==n))',50, OMEGA(class==n,t),8);

                P10_K_Class(n,t) = wprctile(k_choice(class==n,t),10, OMEGA(class==n,t),8);
                P10_C_Class(n,t) = wprctile(c_choice(class==n,t),10, OMEGA(class==n,t),8);
                P10_E_Class(n,t) = wprctile(wages(t,nn(class==n))',10, OMEGA(class==n,t),8);

                P90_K_Class(n,t) = wprctile(k_choice(class==n,t),90, OMEGA(class==n,t),8);
                P90_C_Class(n,t) = wprctile(c_choice(class==n,t),90, OMEGA(class==n,t),8);
                P90_E_Class(n,t) = wprctile(wages(t,nn(class==n))',90, OMEGA(class==n,t),8);
                
                Percentiles_Class(:,t,n) = [wprctile(k_choice(class==n,t),10, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),20, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),30, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),40, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),50, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),60, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),70, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),80, OMEGA(class==n,t),8);wprctile(k_choice(class==n,t),90, OMEGA(class==n,t),8);];
                Quintile_Share_Class(:,t,n) = [sum(OMEGA(class==n,t).*k_choice(class==n,t).*((k_choice(class==n,t)<=wprctile(k_choice(class==n,t),20,OMEGA(class==n,t),8))));...
                                               sum(OMEGA(class==n,t).*k_choice(class==n,t).*(((k_choice(class==n,t)>wprctile(k_choice(class==n,t),20,OMEGA(class==n,t),8))&(k_choice(class==n,t)<=wprctile(k_choice(class==n,t),40,OMEGA(class==n,t),8)))));...
                                               sum(OMEGA(class==n,t).*k_choice(class==n,t).*(((k_choice(class==n,t)>wprctile(k_choice(class==n,t),40,OMEGA(class==n,t),8))&(k_choice(class==n,t)<=wprctile(k_choice(class==n,t),60,OMEGA(class==n,t),8)))));...
                                               sum(OMEGA(class==n,t).*k_choice(class==n,t).*(((k_choice(class==n,t)>wprctile(k_choice(class==n,t),60,OMEGA(class==n,t),8))&(k_choice(class==n,t)<=wprctile(k_choice(class==n,t),80,OMEGA(class==n,t),8)))));...
                                               sum(OMEGA(class==n,t).*k_choice(class==n,t).*(((k_choice(class==n,t)>wprctile(k_choice(class==n,t),80,OMEGA(class==n,t),8)))))]/(k_choice(class==n,t)'*OMEGA(class==n,t));
 

                Var_K_Class(n,t) = var(k_choice(class==n,t),OMEGA(class==n,t));
                Var_C_Class(n,t) = var(c_choice(class==n,t),OMEGA(class==n,t));
                Var_E_Class(n,t) = var(wages(t,nn(class==n))',OMEGA(class==n,t));
                
                [~,~, GINI_K_Class(n,t)] = gini( k_choice(class==n,t),OMEGA((class==n),t));
                [~,~, GINI_C_Class(n,t)] = gini( c_choice(class==n,t),OMEGA((class==n),t));
                [~,~, GINI_E_Class(n,t)] = gini( wages(t,nn(class==n))',OMEGA((class==n),t));
                [~,~, GINI_Y_Class(n,t)] = gini( (r(t)*aa(class==n)'+wages(t,nn(class==n))'),OMEGA((class==n),t));
            end
        end

    end
