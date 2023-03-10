FUNCTION S4D445_CREATE_CONNECTION.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IS_CONNECTION) TYPE  SPFLI
*"     REFERENCE(IV_SIMULATE) TYPE  ABAP_BOOL
*"  EXPORTING
*"     REFERENCE(ES_RETURN) TYPE  BAPIRET2
*"     REFERENCE(EV_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(EV_CONNID) TYPE  S_CONN_ID
*"----------------------------------------------------------------------

***********************************************************************
*This function module is used in training course S4D445 as an example *
*of a customer-developed routine to migrate data using the Migration  *
*Cockpit                                                              *
***********************************************************************


DATA lv_Error TYPE abap_bool.

CLEAR: ev_Carrid, ev_connid,  es_return.

* Check carrier
SELECT SINGLE 1 FROM scarr INTO @DATA(Check_Carrid) WHERE carrid = @is_connection-carrid.
  IF check_carrid IS INITIAL.
    es_return-type  = 'E'.
    es_Return-id = 'S4D445'.
    es_Return-number = '100'.
    es_return-message_v1 = is_connection-carrid.
lv_Error = abaP_true.
    ENDIF.

* Check departure city
    SELECT SINGLE 1 FROM sgeocity INTO @DATA(check_from) WHERE country = @is_Connection-countryfr AND city = @is_connection-cityfrom.
      IF check_from IS INITIAL.
        es_return-type = 'E'.
        es_return-id = 'S4D445'.
        es_return-number = '101'.
        es_return-message_V1 = is_Connection-cityfrom.
lv_Error = abaP_true.
        ENDIF.

* Check arrival city
    SELECT SINGLE 1 FROM sgeocity INTO @DATA(check_to) WHERE country = @is_Connection-countryto AND city = @is_connection-cityto.
      IF check_to IS INITIAL.
        es_return-type = 'E'.
        es_return-id = 'S4D445'.
        es_return-number = '101'.
        es_return-message_V1 = is_Connection-cityto.
lv_Error = abaP_true.
        ENDIF.

* Check that connection doesn't alreadey exist
SELECT SINGLE 1 FROM spfli INTO @DATA(Check_existence) WHERE carrid = @is_connection-carrid AND connid = @is_Connection-connid.
  IF check_existence = 1.
    es_Return-type = 'E'.
    es_Return-id = 'S4D445'.
    es_return-number = '102'.
    es_return-message_v1 = is_connection-carrid.
    es_return-message_v2 = is_connection-connid.
    lv_Error = abaP_true.
    ENDIF.

* Create entry if no errors.
IF lv_error = abap_false.
    INSERT spfli FROM is_connection.
    IF sy-subrc = 0.
      es_Return-type = 'S'.
      es_return-id = 'S4D445'.
      es_return-number = '103'.
      es_return-message_v1 = is_connection-carrid.
    es_return-message_v2 = is_connection-connid.

    ev_Carrid = is_connection-carrid.
    ev_connid = is_connection-connid.

    ENDIF.

  IF iv_simulate = abap_true.
    ROLLBACK WORK.
  ENDIF.

ENDIF.


ENDFUNCTION.
