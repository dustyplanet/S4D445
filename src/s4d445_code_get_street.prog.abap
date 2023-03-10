*&---------------------------------------------------------------------*
*& Report S4D445_CODE_GET_STREET
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT S4D445_CODE_GET_STREET.


** Copy all of the code below this line.
** Paste it into the ABAP Editor of your migration rule
** Remove the asterisks at the beginning of each line



*DATA: lt_words TYPE TABLE OF string,
*      lv_lines TYPE i.
*
*
*SPLIT i_street AT space INTO TABLE lt_words.
*lv_lines = lines( lt_words ).
*
*IF lt_words[ 1 ] CO '0123456789'.
*  DELETE lt_Words INDEX 1.
*  e_street = concat_lines_of( table = lt_words sep = ` ` ).
*
*ELSEIF lt_words[ lv_lines ] CO '0123456789'.
*  DELETE lt_words INDEX lv_lines.
*  e_street = concat_lines_Of( table = lt_words sep = ` ` ).
*
*  ELSE.
*  allog_msg 'W' 'S4D445' '100' 'Could not identify house number'
*  '' '' '' ''.
*  ENDIF.
