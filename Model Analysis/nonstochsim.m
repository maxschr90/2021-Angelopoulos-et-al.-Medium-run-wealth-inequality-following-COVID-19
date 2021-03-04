%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - NONSTOCHASTIC SIMULATION FOR THE DYNAMIC ECONOMY           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [OMEGA, aa, nn] = nonstochsim(initdist,Transitions,  k_choice, grid_parms)

nkap = grid_parms.nkap;
kap = grid_parms.kap; % Capital 

%% let us simulate the model economy 
T = size(Transitions,3);
N=size(Transitions,2);
amin=min(kap);
amax=max(kap);
OMEGA=[];


Omegat=initdist;
Omegatp=zeros(nkap,N);

       

aa=repmat(kap',N,1);
nn = repelem((1:1:N),nkap,1);

for t=1:T
    PI=squeeze(Transitions(:,:,t)); %amend here appropiately to make it time varying 
    K_grid = reshape(k_choice(:,:,t),nkap, N);
    K_grid=amin.*(K_grid<amin)+amax.*(K_grid>amax)+K_grid.*(K_grid>=amin & K_grid<=amax);
       
 for j=1:N
        % Linear interpolation of probabilities
   for ai = 1:nkap     
            for jp=1:N
                I = find(K_grid(ai,j)>=kap,1,'last');
                I = min(I,nkap-1);

           
                rhok = (K_grid(ai,j)-kap(I+1))./(kap(I)-kap(I+1));
                Omegatp(I,jp)   = Omegatp(I,jp)+Omegat(ai,j)*PI(j,jp)*rhok;
                Omegatp(I+1,jp) = Omegatp(I+1,jp)+Omegat(ai,j)*PI(j,jp)*(1-rhok);

               
            end
        
   end
end

   OMEGA=[OMEGA Omegat(:)];
  
    Omegat=Omegatp;
    Omegatp=zeros(nkap,N);
end

aa = aa(:);
nn = nn(:);
end
