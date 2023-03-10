class CL_S4D445_CUSTOMER_DATA_2 definition
  public
  inheriting from CL_S4D445_PROVIDER_BASE
  final
  create public

  global friends CL_S4D445_PROVIDER_FACTORY .

public section.

  methods PROVIDE_DATA
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS CL_S4D445_CUSTOMER_DATA_2 IMPLEMENTATION.


  METHOD provide_data.

    DATA: lv_basic         TYPE dd02l-tabname,
          lv_partner       TYPE dd02l-tabname,
          lv_Sales         TYPE dd02l-tabname,
          lv_sales_partner TYPE dd02l-tabname,
          lv_Tax_class     type dd02l-tabname.

    CALL FUNCTION 'S4D445_GET_STAGING_TABLE_NAMES'
      EXPORTING
        iv_group         = me->mv_group_number
      IMPORTING
        ev_basic         = lv_basic
        ev_partner       = lv_partner
        ev_sales         = lv_sales
        ev_sales_partner = lv_sales_partner
        ev_tax_class = lv_tax_class
      EXCEPTIONS
        action_cancelled = 1.





    CASE sy-subrc.
      WHEN 0.
        TRY.
            cl_S4d445_amdp=>create_customer_data_2(
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
            MESSAGE i007(s4d445).
write_status( ).
          CATCH cx_root.
        MESSAGE i003(s4d445).
* An error occurred while filling the staging tables

        ENDTRY.
      WHEN 1.


      WHEN 2.
        MESSAGE i005(s4d445).
* Operation Cancelled
    ENDCASE.


  ENDMETHOD.
ENDCLASS.
