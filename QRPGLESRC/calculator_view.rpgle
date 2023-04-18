**free
// dftActGrp(*NO)
ctl-opt
  noMain
  option(*srcStmt : *noDebugIO : *noUnref)
  text('MODULE Calculator View')
;

// ----------------------------------------------------------- File Declarations

dcl-f CALCSCREEN workstn prefix(sc_) indDs(dspFunc) infDs(dspInfo);


// ---------- Constants, Data Structure & Prototypes declatartion from copybooks

/copy 'QPROTOSRC/calculator_view.rpgleinc'

// ------------------------------------------------ Other Constant Declatartions 


// AID code (AidByte in the above code) is a hexadecimal field that corresponds 
// to the key that the user pressed to return the control to the program
// Constant definitions with HEX value of keypresses
// Function keys 
 dcl-c KEY_F01 const(x'31');
 dcl-c KEY_F02 const(x'32');
 dcl-c KEY_F03 const(x'33');
 dcl-c KEY_F04 const(x'34');
 dcl-c KEY_F05 const(x'35');
 dcl-c KEY_F06 const(x'36');
 dcl-c KEY_F07 const(x'37');
 dcl-c KEY_F08 const(x'38');
 dcl-c KEY_F09 const(x'39');
 dcl-c KEY_F10 const(x'3A');
 dcl-c KEY_F11 const(x'3B');
 dcl-c KEY_F12 const(x'3C');
 dcl-c KEY_F13 const(x'B1');
 dcl-c KEY_F14 const(x'B2');
 dcl-c KEY_F15 const(x'B3');
 dcl-c KEY_F16 const(x'B4');
 dcl-c KEY_F17 const(x'B5');
 dcl-c KEY_F18 const(x'B6');
 dcl-c KEY_F19 const(x'B7');
 dcl-c KEY_F20 const(x'B8');
 dcl-c KEY_F21 const(x'B9');
 dcl-c KEY_F22 const(x'BA');
 dcl-c KEY_F23 const(x'BB');
 dcl-c KEY_F24 const(x'BC');
 // Other attention keys 
 dcl-c KEY_CLEAR const(x'BD');
 dcl-c KEY_ENTER const(x'F1');
 dcl-c KEY_HELP const(x'F3');
 dcl-c KEY_UP const(x'F4');
 dcl-c KEY_DOWN const(x'F5');
 dcl-c KEY_PRINT const(x'F6');
 dcl-c KEY_AUTO_ENTER const(x'50');
 dcl-c KEY_LIGHT_PEN_ENTER const(x'3f');

 dcl-c TRUE 1;
 dcl-c FALSE 0;

// ------------------------------------------------ Data Structure Declatartions

// File information display Data structure for Display file 
dcl-ds dspInfo qualified;
  pressedKey char(1) pos(369);
end-ds;

// Indicator Data structure for Display file
dcl-ds dspFunc qualified;
  F03_exit ind pos(3);
  F04_calcualte ind pos(4);
  F05_refresh ind pos(5);
  F12_cancel ind pos(12);
  
  pageDown ind pos(26);
  pageUp ind pos(27);

  errorInds char(10) pos(31);
  enableDelete ind pos(41);

  SFLInds char(3) pos(51);
  SFLDsp ind pos(51);
  SFLDspCtl ind pos(52);
  SFLClr ind pos(53);
  SFLNxtChg ind pos(54);
  SFLPageDown ind pos(55);
  SFLPageUp ind pos(56);
  SFLProtect ind pos(57);
  enableMsgSFL ind pos(91) inz(*on);
end-ds;



// ------------------------------------------------------ Procedure Declatarions

dcl-proc calculatorView_show export;
  dcl-pi calculatorView_show ind;
  end-pi;

  dcl-s messageText varchar(70);
  
  sc_errMsg = 'Basic Calculator';
  
  sc_operand1 = 0;
  sc_operand2 = 0;
  sc_result = ' ';

  write HEADER;
  write FOOTER;
  //write DETAIL; 
  
  dow not dspFunc.F03_exit;
    exfmt DETAIL;
    select;
      when dspFunc.F03_exit;
        // Exit
        return *off;

      when dspFunc.F05_refresh;
        messageText = 'Calculating...' + 
        %char(sc_operand1) + ' ' + 
        sc_function + ' ' + 
        %char(sc_operand2) ;

        calculatorView_displayMessage(messageText);

      when dspFunc.F12_cancel;
        // Cancel
      other;
    endSl; 
  endDo;

  return *on;
end-proc;

dcl-proc calculatorView_loadScreen export;
  dcl-pi calculatorView_loadScreen ind;
  end-pi;

  write HEADER;
  write FOOTER;
  write DETAIL; 

  return *on;

end-proc;

dcl-proc calculatorView_cleanScreen export;
  dcl-pi calculatorView_cleanScreen ind;
  end-pi;

  sc_operand1 = 0;
  sc_operand2 = 0;
  sc_function = *blanks;
  sc_result = ' ';
  sc_errMsg = *blanks;

  if calculatorView_loadScreen();
    return *on;
  else;
    return *off;
  endIf;

end-proc;

dcl-proc calculatorView_displayMessage export;
  dcl-pi calculatorView_displayMessage ind;
    msgText varchar(70) const;
  end-pi;

  sc_errMsg = msgText;
  write FOOTER;

  return *on;

end-proc;

dcl-proc calculatorView_displayResult export;
  dcl-pi calculatorView_displayResult ind;
    result packed(15 : 2) const;
  end-pi;

  sc_result = %char(result);
  write DETAIL;
  
  return *on;

end-proc;

dcl-proc calculatorView_readInput export;
  dcl-pi calculatorView_readInput ind;
    operand1 packed(15 : 2);
    operand2 packed(15 : 2);
    function varchar(3);
  end-pi;

  dow not dspFunc.F03_exit;
    read DETAIL; 
    select;
      when dspFunc.F04_calcualte or dspInfo.pressedKey = KEY_ENTER;
        operand1 = sc_operand1;
        operand2 = sc_operand2;
        function = sc_function;
        return *on;
      when dspFunc.F12_cancel;
        calculatorView_cleanScreen();
      when dspFunc.F03_exit;
        return *off;
    endSl;
  endDo;

  return *off;
end-proc;
