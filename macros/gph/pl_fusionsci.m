function [fH]=pl_fusionsci(C,S)
	% _pl_fusionsci	merge two increasing sequences.
	%		_pl_fusionsci(C,S) gives the resulting indices fH where each slope supports the epigraph. 
	%		All in all, it amounts to finding the first indice i such that C(i-1)<=S(j)<C(i)
	%
	% 		This function uses scilab syntax to speed up computation, see _pl_fusion for a more classical
	%		programming of the same function
	% 
	% Input parameters:
	%  C,S - Increasing column vectors. We want to know the conjugate at
	%	S(j). C gives the slope of planar input points.
	%  
	% Output parameter:
	%  fH - Index at which the slope support the epigraph. Column vector.
	%
	% Example:
	%  X=[-5:0.5:5]'
	%  Y=X.^2
	%  C=(Y(2:size(Y,1))-Y(1:size(Y,1)-1))./(X(2:size(X,1))-X(1:size(X,1)-1))
	%  S=C-0.25*ones(size(C, 1))
	%  [fH]=_pl_fusionsci(C,S)

	% The BUILT-IN sort function is faster than looking at each slope with a for loop
	[Z I]=sort([C;S]);
	I=find(I>size(C,1));
	J=I(2:size(I,1))-I(1:size(I,1)-1);
	if (size(J,1) == 0) 

	  K=[];
	  L=[];
      if (size(I,1) > 1)
          H=[I(1)];
      else
          H = [];
      end
	else
	  K=J-1;
	  L= cumsum(K)+1;
	  H=[I(1) L'+I(1)-1]';
	end;

	fS=S;
    fH=H;
	% This (maybe) obscure computation ONLY aims at using Scilab syntax
	% to do exactly the same as _pl_fusion whose programming sticks to the
	% LLT as written in ["Faster than the Fast Legendre Transform, the
	% Linear-time Legendre Transform", Y. Lucet]
end