*----------------------------------------------------------------------*
***INCLUDE MS4D445_DATA_GENERATORO04.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module CREATE_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv OUTPUT.

  IF go_alv IS INITIAL.
    go_alv = NEW #( i_parent = NEW cl_gui_Custom_container( container_Name = 'CUSTOM100' ) ).

    DATA(layout) = VALUE lvc_s_layo( no_toolbar = 'X' stylefname = 'STYLE_TABLE' ).

    go_handler = NEW #( io_controller = go_application it_data = gt_alv_data ).

    SET HANDLER go_handler->on_button_click FOR go_alv.

    LOOP AT gt_alv_data ASSIGNING FIELD-SYMBOL(<line>).
      IF <line>-generate_data IS NOT INITIAL.
        <line>-style_table = VALUE #( BASE <line>-style_table ( fieldname = 'GENERATE_DATA' style = cl_gui_alv_grid=>mc_style_button ) ).
      ENDIF.
      IF <line>-show_code_1 IS NOT INITIAL.
        <line>-style_table = VALUE #( BASE <line>-style_table ( fieldname = 'SHOW_CODE_1' style = cl_gui_alv_grid=>mc_style_button ) ).
      ENDIF.
      IF <line>-show_code_2 IS NOT INITIAL.
        <line>-style_table = VALUE #( BASE <line>-style_table ( fieldname = 'SHOW_CODE_2' style = cl_gui_alv_grid=>mc_style_button ) ).
      ENDIF.

    ENDLOOP.

    go_alv->set_table_for_first_display(
      EXPORTING
        i_structure_name              = 'D445_EXERCISE_ALV'                 " Internal Output Table Structure Name
       is_layout = layout
      CHANGING
        it_outtab                     =   gt_alv_data ).              " Output Table
  ELSE.
    go_alv->refresh_table_display( ).
  ENDIF.

ENDMODULE.
