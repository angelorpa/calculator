**free
///
/// Model component from the MVC patter
///

ctl-opt 
  noMain
  datFmt(*iso)
  timFmt(*iso)
  option(*srcStmt : *noDebugIO : *noUnref)
  text('MODULE Calculator Model')
;

// ----------------------------------------------------------- File Declarations

// --------------------------------------- Constants & Prototypes from copybooks

/copy 'qprotosrc/math100.rpgleinc'
/copy 'qprotosrc/calculator_model.rpgleinc'
/copy 'qprotosrc/validation_functions.rpgleinc'

// ------------------------------------------ Prototypes for "internal routines" 


// ------------------------------------- Global Standalone variable declatarions 

dcl-s initialized ind inz(*OFF);
dcl-s lastErrId int(10);
dcl-s lastErrMsg varchar(70);

// ------------------------------------------------------ Procedure declarations

dcl-proc calculator_findSum export;
  dcl-pi calculator_findSum packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return math100_sum(operand1:operand2);
end-proc;

dcl-proc calculator_findDifference export;
  dcl-pi calculator_findDifference packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return math100_dif(operand1:operand2);
end-proc;

dcl-proc calculator_findProduct export;
  dcl-pi calculator_findProduct packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  return math100_mul(operand1:operand2);
end-proc;

dcl-proc calculator_findQuotient export;
  dcl-pi calculator_findQuotient packed(15 : 2);
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
  end-pi;

  if (operand2 = 0);
    setError(CALCULATOR_ERR_DIV_BY_CERO:'Error: Division by Cero.');
  else;
    return math100_div(operand1:operand2);
  endIf;

end-proc;

dcl-proc calculator_doOperation export;
  dcl-pi calculator_doOperation ind;
    operand1 packed(15 : 2) const;
    operand2 packed(15 : 2) const;
    operation varchar(3) const;
    result packed(15 : 2);
  end-pi;

  select;
    when (operation = CALCULATOR_OPERATION_SUM);
      result = calculator_findSum(operand1:operand2);

    when (operation = CALCULATOR_OPERATION_DIF);
      result = calculator_findDifference(operand1:operand2);

    when (operation = CALCULATOR_OPERATION_MUL);
      result = calculator_findProduct(operand1:operand2);

    when (operation = CALCULATOR_OPERATION_DIV);
      result = calculator_findQuotient(operand1:operand2);

    other;
      // handle other conditions
      setError(CALCULATOR_ERR_OPERATION_NOT_VALID:'Operación No Valida.');
      return *off;
  endsl;

  return *on;
end-proc;

dcl-proc calculator_error export;
  dcl-pi calculator_error varchar(70);
    errorId int(10) options(*nopass : *omit);
  end-pi;

  if %parms >= 1 and %addr(ErrorId) <> *null;
    ErrorId = lastErrId;
  endif;

  return lastErrMsg;
end-proc;

dcl-proc setError;
  dcl-pi setError;
    errId int(10) const;
    errMsg varchar(70) const;
  end-pi;

  lastErrId = errId;
  lastErrMsg=errMsg;
end-proc;

dcl-proc calculator_isFunctionAllowed export;
  dcl-pi calculator_isFunctionAllowed ind;
    function varchar(3) const;
  end-pi;

  select;
    when function = CALCULATOR_OPERATION_DIF;
      return *on;
    when function = CALCULATOR_OPERATION_DIV;
      return *on;
    when function = CALCULATOR_OPERATION_MUL;
      return *on;
    when function = CALCULATOR_OPERATION_SUM;
      return *on;
    other;
      return *off;
  endSl;
end-proc;
