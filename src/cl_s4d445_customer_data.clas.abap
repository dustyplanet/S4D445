CLASS cl_s4d445_customer_data DEFINITION
  PUBLIC
  INHERITING FROM cl_s4d445_provider_base
  FINAL
  CREATE PUBLIC

  GLOBAL FRIENDS cl_s4d445_provider_factory .

  PUBLIC SECTION.

    METHODS provide_data
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_S4D445_CUSTOMER_DATA IMPLEMENTATION.


  METHOD provide_data.

    DATA: lv_basic         TYPE dd02l-tabname,
          lv_partner       TYPE dd02l-tabname,
          lv_Sales         TYPE dd02l-tabname,
          lv_sales_partner TYPE dd02l-tabname,
          lv_Tax_class     TYPE dd02l-tabname.

    CALL FUNCTION 'S4D445_GET_STAGING_TABLE_NAMES'
      EXPORTING
        iv_group         = me->mv_group_number
      IMPORTING
        ev_basic         = lv_basic
        ev_partner       = lv_partner
        ev_sales         = lv_sales
        ev_sales_partner = lv_sales_partner
        ev_tax_class     = lv_tax_class
      EXCEPTIONS
        action_cancelled = 1.





    CASE sy-subrc.
      WHEN 0.
        TRY.
            cl_S4d445_amdp=>create_customer_data(
              EXPORTING
                iv_tabname_p  = lv_basic
                iv_tabname_r  = lv_partner
                iv_tabname_sd = lv_Sales
                iv_tabname_sp = lv_sales_partner
                iv_tabname_tx = lv_tax_class
                iv_Attempt = me->mv_attempt
                iv_group      = me->mv_group_number
                iv_count      = 100
            ).

            DATA(first) = |5{ me->mv_group_number ALIGN = RIGHT WIDTH = 2 PAD = '0' }06{ me->mv_attempt ALIGN = RIGHT WIDTH = 2 PAD = '0' }001|.
            DATA(last) =             |5{ me->mv_group_number ALIGN = RIGHT WIDTH = 2 PAD = '0' }06{ me->mv_attempt ALIGN = RIGHT WIDTH = 2 PAD = '0' }100|.

            MESSAGE i008(s4d445) WITH first last.

            write_status( ).
          CATCH cx_root.
            MESSAGE i003(s4d445).
* An error occurred while filling the staging tables

        ENDTRY.
      WHEN 1.
        MESSAGE i005(s4d445).
* Operation Cancelled
    ENDCASE.


  ENDMETHOD.
ENDCLASS.
