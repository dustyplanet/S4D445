FUNCTION s4d445_display_code.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_PROGNAME) TYPE  PROGRAMM
*"     REFERENCE(IV_GROUP) TYPE  IF_S4D445_TYPES=>TV_GROUP
*"  EXCEPTIONS
*"      NOT_A_PROGRAM
*"----------------------------------------------------------------------


  DATA: lt_Code     TYPE TABLE OF string,
        lv_codeline TYPE string,
        lv_replace  TYPE abap_bool.

  READ REPORT iv_progname INTO lt_Code.
  IF sy-subrc <> 0.
    RAISE not_a_program.
  ENDIF.

* Shift each line left to take out commment symbols.
  LOOP AT lt_Code ASSIGNING FIELD-SYMBOL(<line>).

* If the code contains this comment, it also contains pound signs
* that must be replaced with the group number
    IF <line> = '"#GroupNumber'.
      lv_replace = abap_true.
    ENDIF.
    SHIFT <line> LEFT BY 1 PLACES.
  ENDLOOP.

* Delete all lines before Data devlarations.
  LOOP AT lt_Code INTO lv_codeline.
    IF strlen( lv_Codeline ) >= 4.
      IF lv_codeline(4) = 'DATA'.

        EXIT.
      ELSE.
        DELETE lt_code INDEX sy-tabix.
      ENDIF.
    ELSE.
      DELETE lt_Code INDEX sy-tabix.
    ENDIF.
  ENDLOOP.

* If code contains group numbers, insert them in place of pound signs
  IF lv_Replace = abap_true.
    REPLACE ALL OCCURRENCES OF '##' IN TABLE lt_code WITH iv_Group.
  ENDIF.
  gt_code = lt_code.
  CALL SCREEN 200 STARTING AT 12 12.

ENDFUNCTION.
