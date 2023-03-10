*----------------------------------------------------------------------*
***INCLUDE LS4D445_UII01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'CONTINUE'.
      IF gv_basic_data IS INITIAL OR gv_partner_data IS INITIAL
        OR gv_sales_data IS INITIAL OR gv_sales_partner_data IS INITIAL.

* JM 25.01.2022: Tax classification not required in collection 23.
*        or gv_tax_class is initial.
        MESSAGE i004(s4d445).
* Enter the names of all four staging tables
        LEAVE TO SCREEN 100.
        else.
          gv_rc = 0.
          set screen 0.
      ENDIF.

    WHEN 'CANCEL'.
      gv_rc = 4.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
