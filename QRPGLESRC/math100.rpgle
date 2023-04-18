**free

ctl-opt 
  noMain
  option(*srcStmt : *noDebugIO)
  text('MODULE Arithmetic Operations')
;

/COPY 'qprotosrc/math100.rpgleinc'

dcl-proc math100_sum export;
  dcl-pi math100_sum packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return operand1 + operand2;

end-proc;

dcl-proc math100_dif export ;
  dcl-pi math100_dif packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return operand1 - operand2;

end-proc;

dcl-proc math100_mul export ;
  dcl-pi math100_mul packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return operand1 * operand2;

end-proc;

dcl-proc math100_div export ;
  dcl-pi math100_div packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return operand1 / operand2;

end-proc;
