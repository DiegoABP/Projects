function val = softmax2(x)

  val=exp(x);
  # nor=sum(val) + ones(1,columns(val)); ## the ones 'cause exp(0) for k
  nor=sum(val,2); ## the ones 'cause exp(0) for k
  val = val ./ nor;

endfunction
