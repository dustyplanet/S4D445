class CL_S4D445_BANK_DATA_ERROR definition
  public
  inheriting from CL_S4D445_PROVIDER_BASE
  final
  create private

  global friends CL_S4D445_PROVIDER_FACTORY .

public section.

  methods PROVIDE_DATA
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS CL_S4D445_BANK_DATA_ERROR IMPLEMENTATION.


  METHOD provide_data.

* This method provides incorrect bank data
* It contains the following errors:
* 1. Missing mandatory field (entries 1 - 5 )
* 2. Duplicate entries (every fifth entrty)
* 3. Country values that do not match Customizing ( Entries 8 and 12 ).
* 4. Bank key that is too short ( Entry 14 ).
* The format of the bank key is 40ggeenn where gg is the group number, ee the exercise number and nn a counter.


    DATA: ls_Bank        TYPE string,
          lv_country_Key TYPE c LENGTH 3.


    DO 15 TIMES.
      IF sy-index < 5.
        CLEAR lv_country_key.
      ELSEIF sy-index = 8 OR sy-index = 12.
        lv_country_key = 'GER'.
      ELSE.
        lv_Country_key = 'DE'.
      ENDIF.
      if sy-index = 14.
        ls_bank = |{ lv_Country_key };400{ mv_group_number }{ mv_Exercise_Number }{ sy-index WIDTH = 2 PAD = '0' ALIGN = RIGHT };| &&
      |Bank of Group { mv_group_number };;High Street { sy-index };Anytown|.
        else.
           ls_bank = |{ lv_Country_key };4{ mv_group_number }{ mv_Exercise_Number }{ sy-index WIDTH = 2 PAD = '0' ALIGN = RIGHT };| &&
      |Bank of Group { mv_group_number };;High Street { sy-index };Anytown|.
      ls_bank = |{ lv_Country_key };40{ mv_group_number }{ mv_Exercise_Number }{ sy-index WIDTH = 2 PAD = '0' ALIGN = RIGHT };| &&
      |Bank of Group { mv_group_number };;High Street { sy-index };Anytown|.
          endif.
      APPEND ls_bank TO et_Data.
* Every fifth entry should be duplicated
      IF sy-index MOD 5 = 0.
        APPEND ls_bank TO et_Data.
      ENDIF.
    ENDDO.

me->file_download(
  EXPORTING
    iv_filename = 'bank_error'
  CHANGING
    ct_table    = et_Data
).
me->write_status( ).

  ENDMETHOD.
ENDCLASS.
