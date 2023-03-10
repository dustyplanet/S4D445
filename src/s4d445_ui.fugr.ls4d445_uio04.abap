*----------------------------------------------------------------------*
***INCLUDE LS4D445_UIO04.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module CREATE_EDITOR OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_editor OUTPUT.
  IF go_custom IS INITIAL.
    CREATE OBJECT  go_Custom EXPORTING container_name = 'CUSTOM200'.
    CREATE OBJECT go_text
      EXPORTING
*       max_number_chars           =                          " maximum number of characters insertable into editor control
*       style  = 0                        " control style, if initial a defined value is choosen
*       wordwrap_mode              = wordwrap_at_windowborder " 0: OFF; 1: wrap a window border; 2: wrap at fixed position
*       wordwrap_position          = -1                       " position of wordwrap, only makes sense with wordwrap_mode=2
*       wordwrap_to_linebreak_mode = false                    " eq 1: change wordwrap to linebreak; 0: preserve wordwraps
*       filedrop_mode              = dropfile_event_off       " event mode to handle drop of files on control
        parent = go_custom                         " Parent Container
*       lifetime                   =                          " for life time management
*       name   =                          " name for the control
*  EXCEPTIONS
*       error_cntl_create          = 1                        " Error while performing creation of TextEdit control!
*       error_cntl_init            = 2                        " Error while initializing TextEdit control!
*       error_cntl_link            = 3                        " Error while linking TextEdit control!
*       error_dp_create            = 4                        " Error while creating DataProvider control!
*       gui_type_not_supported     = 5                        " This type of GUI is not supported!
*       others = 6
      .
  ENDIF.
  go_text->set_text_as_r3table(
    EXPORTING
      table           =   gt_code               " table with text
*  EXCEPTIONS
*    error_dp        = 1                " Error while sending R/3 table to TextEdit control!
*    error_dp_create = 2                " ERROR_DP_CREATE
*    others          = 3
  ).
  go_text->set_readonly_mode( 1 ). "read only
  go_text->set_toolbar_mode( 0 ). "toolbar off
ENDMODULE.
