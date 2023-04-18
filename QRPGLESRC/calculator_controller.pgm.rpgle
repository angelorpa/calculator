**free

ctl-opt 
  dftActGrp(*no)
  actGrp(*new)
  option(*srcStmt : *noDebugIO : *noUnref)
  text('PGM Calculator Controller')
  bnddir('CALCDIR')
;


/copy 'QPROTOSRC/calculator_view.rpgleinc'
/copy 'QPROTOSRC/calculator_model.rpgleinc'

dcl-s indScreen ind;
dcl-s done ind inz(*off);
dcl-s operand1 packed(15 : 2) inz(0);
dcl-s operand2 packed(15 : 2) inz(0);
dcl-s result   packed(15 : 2) inz(0);
dcl-s function varchar(3) inz(*blanks);

if not calculatorView_loadScreen();
  *InLR = *On;
  return;
endIf;

dow not done;

  if calculatorView_readInput(operand1 : operand2 : function);
    if calculator_isFunctionAllowed(function);
      
      calculator_doOperation(operand1 : operand2 : function : result);

      calculatorView_displayResult(result);

      calculatorView_displayMessage(
        'Calc: ' +
        function + '(' +
        %char(operand1) + ' , ' + 
        %char(operand2) + ') : ' + %char(result)
      );

    else;
      calculatorView_displayMessage('Operation Not allowed');
    endIf;
  else;
    done = *on;
  endIf;

endDo;

// Terminate Program
 *InLR = *On;

 return;

