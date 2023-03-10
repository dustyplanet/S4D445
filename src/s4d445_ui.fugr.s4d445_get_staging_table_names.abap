FUNCTION s4d445_get_staging_table_names.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_GROUP) TYPE  IF_S4D445_TYPES=>TV_GROUP
*"  EXPORTING
*"     REFERENCE(EV_BASIC) TYPE  DD02L-TABNAME
*"     REFERENCE(EV_PARTNER) TYPE  DD02L-TABNAME
*"     REFERENCE(EV_SALES) TYPE  DD02L-TABNAME
*"     REFERENCE(EV_SALES_PARTNER) TYPE  DD02L-TABNAME
*"     REFERENCE(EV_TAX_CLASS) TYPE  DD02L-TABNAME
*"  EXCEPTIONS
*"      STAGING_TABLE_ERROR
*"      ACTION_CANCELLED
*"----------------------------------------------------------------------

  CALL SCREEN 100 STARTING AT 12 5.

  IF gv_Rc = 0.
    ev_basic = gv_basic_data.
    ev_partner = gv_partner_data.
    ev_sales = gv_sales_data.
    ev_sales_partner = gv_sales_partner_data.
    ev_Tax_class = gv_Tax_class.
  ELSEIF gv_Rc = 4.
    RAISE action_cancelled.
  ENDIF.


ENDFUNCTION.
