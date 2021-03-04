%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - NONSTOCHASTIC SIMULATION FOR THE STATIONARY ECONOMY        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [OMEGA, aa,  nn] = nonstochsim_stat(initdist,Transitions, k_choice, grid_parms)

nkap = grid_parms.nkap;
kap = grid_parms.kap; % Capital 

%% let us simulate the model economy 
N=size(Transitions,2);
amin=min(kap);
amax=max(kap);
OMEGA=[];


Omegat=initdist;
Omegatp=zeros(nkap,N);
hist_crit = 1;
K_grid = reshape(k_choice,nkap, N);
K_grid=amin.*(K_grid<amin)+amax.*(K_grid>amax)+K_grid.*(K_grid>=amin & K_grid<=amax);
       
 
% Look-up index.

aa=repmat(kap',N,1);
nn = repelem((1:1:N),nkap,1);


Im       = zeros(size(aa));

for j=1:N
        % Linear interpolation of probabilities
   parfor ai = 1:nkap     
                Im(ai,j) = find(K_grid(ai,j)>=kap,1,'last');
                Im(ai,j) = min(Im(ai,j),nkap-1);
   end
end

while hist_crit >10^-10    

    PI=squeeze(Transitions); %amend here appropiately to make it time varying 
 for j=1:N
        % Linear interpolation of probabilities
   for ai = 1:nkap     
            for jp=1:N
                I =Im(ai,j);
                
                rhok = (K_grid(ai,j)-kap(I+1))./(kap(I)-kap(I+1));
                Omegatp(I,jp)   = Omegatp(I,jp)+Omegat(ai,j)*PI(j,jp)*rhok;
                Omegatp(I+1,jp) = Omegatp(I+1,jp)+Omegat(ai,j)*PI(j,jp)*(1-rhok);
       
               
            end
         
   end
end

   OMEGA=[OMEGA Omegat(:)];
  
    hist_crit = norm(Omegat(:)-Omegatp(:),inf);
    Omegat=Omegatp;
    Omegatp=zeros(nkap,N);
end

aa = aa(:);
nn = nn(:);
OMEGA=OMEGA(:,end);
end
