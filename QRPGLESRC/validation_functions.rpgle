**free

ctl-opt 
  noMain 
  option(*srcStmt : *noDebugIO : *noUnref)
  text('MODULE Validation functions')
;

// Procedure prototypes & constants --------------------------------------------

/copy 'qprotosrc/validation_functions.rpgleinc'

// procedure definitions -------------------------------------------------------

///
// non-digits characters check
// 
// this procedure take a string value and check for the presence of non-digits
// characters. The returned value is false (*off) if no non-digit character in 
// the string is found, or true (*on) if one exists.
//
// @param The string that will be checked for.
// @param The postion to start loking for.
// @return An indicator, false (*off) if no non-digit character in the string 
// is found otherwise true (*on).
//
///
dcl-Proc valfuncs_nonDigits export;
  // Procedure interface (must match the prototype)
  dcl-pi valfuncs_nonDigits ind;
    string varchar(100) value;
    position packed(3 : 0);
  end-pi;
  
  position = %check('0123456789' : string : 1);
  if position = 0;
    return *off;
  else;
    return *on;
  endIf;
end-proc;
