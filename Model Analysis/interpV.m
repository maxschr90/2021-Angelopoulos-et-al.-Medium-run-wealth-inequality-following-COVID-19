%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FUNCTION - INTERPOLATE THE VALUE FUNCTION                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function b = interpV(Value_Function, kapx, n)

%% Generate Polynominal of order n    
    if n==1
        poly = [hx' kapx' hx'.*kapx'];
    elseif n==2
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2];
    elseif n==3
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3];
    elseif n==4
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4];
    elseif n==5
        poly = [kapx' kapx'.^2 kapx'.^3 kapx'.^4 kapx'.^5];
    elseif n==6
        poly = [kapx' kapx'.^2 kapx'.^3 kapx'.^4 kapx'.^5 kapx'.^6 ];    
    elseif n==7
        poly = [kapx' kapx'.^2 kapx'.^3 kapx'.^4 kapx'.^5 kapx'.^6 kapx'.^7];
    
	end
    s = var(poly).^0.5;
    m = mean(poly);
    poly = ((poly - m)./s); % standardize
%% Use Regression to find Coefficients
    b = NaN(size(poly,2)+1,size(Value_Function,2));
    b = [ones(size(kapx,2),1) poly]\Value_Function;
    b(1,:) = b(1,:)-(m./s)*b(2:end,:);
    b(2:end,:) = b(2:end,:)./s';
end
