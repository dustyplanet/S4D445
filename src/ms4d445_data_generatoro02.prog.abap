*----------------------------------------------------------------------*
***INCLUDE MS4D445_DATA_GENERATORO02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module INITIALIZE_APP OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE initialize_app OUTPUT.
  IF go_application IS INITIAL.
    TRY.
        go_application = NEW #( ).
        gt_alv_data = go_application->get_status( ).
      CATCH cx_s4d445_wrong_user INTO DATA(user_exception).
        MESSAGE user_Exception TYPE 'A'.

    ENDTRY.
  ENDIF.
ENDMODULE.
