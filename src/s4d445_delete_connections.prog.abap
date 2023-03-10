*&---------------------------------------------------------------------*
*& Report S4D445_DELETE_CONNECTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT s4d445_delete_connections.

DATA: gv_Answer TYPE c LENGTH 1.

CALL FUNCTION 'POPUP_TO_CONFIRM'
  EXPORTING
    text_question = 'This program will delete the contents of database table SPFLI. Continue?'
  IMPORTING
    answer        = gv_Answer.

CASE gv_answer.
  WHEN '1'.
    DELETE FROM spfli.
    IF sy-subrc = 0.
      MESSAGE 'Table contents deleted' TYPE 'I'.
    ENDIF.
  WHEN '2' OR 'A'.
    MESSAGE 'Operation cancelled by user' TYPE 'S'.
ENDCASE.
