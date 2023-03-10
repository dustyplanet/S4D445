*&---------------------------------------------------------------------*
*& Include          MS4D445_DATA_GENERATORC01
*&---------------------------------------------------------------------*
CLASS lcl_Event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS constructor IMPORTING  it_data       TYPE lcl_Controller=>tt_ex_status
                                   io_controller TYPE REF TO lcl_Controller
                        EXCEPTIONS no_controller_instance.
    METHODS on_button_click FOR EVENT button_click OF cl_gui_alv_Grid
      IMPORTING es_row_no es_col_id sender.
  PRIVATE SECTION.
    DATA: mt_status     TYPE lcl_Controller=>tt_ex_status,
          mo_controller TYPE REF TO lcl_Controller.

ENDCLASS.

CLASS lcl_Event_Handler IMPLEMENTATION.
  METHOD constructor.
    IF io_controller IS INITIAL.
      RAISE no_controller_instance.
    ENDIF.
    mo_controller = io_controller.
    mt_status = it_Data.

  ENDMETHOD.
  METHOD on_button_Click.

    DATA: lv_Answer      TYPE c LENGTH 1,
          lv_do_generate TYPE abap_bool VALUE abap_true,
          lv_progname type programm.

* Get the data
    DATA(ls_data) = gt_alv_data[ es_row_no-row_id ].
    CASE es_col_id-fieldname.
      WHEN 'GENERATE_DATA'.
        IF ls_Data-status = icon_led_green.
          CALL FUNCTION 'POPUP_TO_CONFIRM'
            EXPORTING
              titlebar      = 'S4D445 Data Generator'
*             DIAGNOSE_OBJECT             = ' '
              text_question = 'You have already generated data for this exercise. Do you want to continue?'
            IMPORTING
              answer        = lv_answer.

          IF lv_Answer = 2 OR lv_Answer = 'A'.
            lv_Do_generate = abap_false.
          ENDIF.
        ENDIF.

        IF lv_do_generate = abap_true.

          mo_controller->provide_data( ls_Data-exercise ).
*  CATCH cx_s4d445_download_error. " S4D445: Download Error in Data Generator
*  CATCH cx_s4d445_staging_error.  " S4D445: Error Filling Staging Table
        ENDIF.
        gt_alv_data[ es_row_no-row_id ]-status = icon_led_green.
        sender->refresh_table_Display( ).
      WHEN 'SHOW_CODE_1'.

          lv_progname = if_s4d445_types=>gc_code_snippet_prefix && ls_data-show_code_1.

            CALL FUNCTION 'S4D445_DISPLAY_CODE'
              EXPORTING
                iv_progname = lv_Progname
                iv_group = mo_controller->mv_group_number
*               NOT_A_PROGRAM       = 1
*               OTHERS      = 2
              .



          WHEN 'SHOW_CODE_2'.
            lv_progname = if_s4d445_types=>gc_code_snippet_prefix && ls_data-show_code_2.
              CALL FUNCTION 'S4D445_DISPLAY_CODE'
              EXPORTING
                iv_progname = lv_Progname
                iv_group = mo_controller->mv_group_number
*               NOT_A_PROGRAM       = 1
*               OTHERS      = 2
              .
        ENDCASE.
      ENDMETHOD.
ENDCLASS.
