*&---------------------------------------------------------------------*
*& Report S4D445_CODE_GET_NUMBER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT S4D445_CODE_GET_NUMBER.


** Copy all of the code below this line.
** Paste it into the ABAP Editor of your migration rule
** Remove the asterisks at the beginning of each line


*DATA: lt_words TYPE TABLE OF string,
*      lv_lines TYPE i.
*
*SPLIT i_street AT space INTO TABLE lt_Words.
*
*lv_Lines = lines( lt_words ).
*
*IF lt_words[ 1 ] CO '0123456789'.
*  e_number = lt_words[ 1 ].
*ELSEIF lt_words[ lv_lines ] CO '0123456789'.
*  e_number = lt_words[ lv_lines ].
*  ELSE.
* allog_msg 'W' 'S4D445' '100'
* 'Unable to identify house number' '' '' '' ''.
* ENDIF.
