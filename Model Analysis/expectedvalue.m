%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - CALCULATE THE EXPECTED VALUE                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [EV] = expectedvalue(kapx,b,p)

%% Generate Polynominal Expansion of order p

    if p==1
        poly = [hx' kapx' hx'.*kapx'];
    elseif p==2
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2];
    elseif p==3
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3];
    elseif p==4
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4];
     elseif p==5
        poly = [kapx' kapx'.^2 kapx'.^3 kapx'.^4 kapx'.^5];
    elseif p==6
        poly = [kapx' kapx'.^2 kapx'.^3 kapx'.^4 kapx'.^5 kapx'.^6 ];    
    elseif p==7
        poly = [kapx' kapx'.^2 kapx'.^3 kapx'.^4 kapx'.^5 kapx'.^6 kapx'.^7];
    end
    EV = zeros(size(poly,1),size(b,2));
    for n=1:size(b,2)
      EV(:,n) = ([1 poly]*b(:,n));
    end
    
end
