class CL_S4D445_BANK_DATA_RULES definition
  public
  inheriting from CL_S4D445_PROVIDER_BASE
  final
  create public .

public section.

  methods PROVIDE_DATA
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS CL_S4D445_BANK_DATA_RULES IMPLEMENTATION.


  METHOD provide_data.

    DATA ls_Bank TYPE string.
    DATA: lt_Address TYPE tt_Data,
          lv_Address TYPE string.
*Bank country key
*Bank key
*Name of bank
*House number and street
*City
*Bank branch
*SWIFT code for international payments
*Post Office Bank Current Account
*Bank number
*Bank group (bank network)
*Bank Country
*Bank Key
*Street
*Postcode
*City
*Country

    DO 5 TIMES.
      ls_bank = |GER;40{ mv_group_number }{ mv_Exercise_Number }{ sy-index WIDTH = 2 PAD = '0' ALIGN = RIGHT };| &&
      |Bank of Group { mv_group_number };Dietmar-Hopp-Allee { sy-index };Walldorf|.
      APPEND ls_bank TO et_Data.
      lv_address = |GER;40{ mv_group_number }{ mv_Exercise_Number }{ sy-index WIDTH = 2 PAD = '0' ALIGN = RIGHT };| &&
      |Dietmar-Hopp-Allee { sy-index };69190;Walldorf;GER|.
      APPEND lv_address TO lt_Address.
    ENDDO.
    DO 5 TIMES.
      ls_bank = |GBR;4{ mv_group_number }{ mv_exercise_number }{ sy-index  }; | &&
      |Bank of Group { mv_group_number };{ sy-index } Kingsdown Parade;Bristol|.
      APPEND ls_Bank TO et_Data.
      lv_address = |GBR;4{ mv_group_number }{ mv_exercise_number }{ sy-index  }; | &&
           |{ sy-index } Kingsdown Parade;BS2;Bristol;GBR|.
      append lv_Address to lt_Address.
    ENDDO.

ls_bank = |GBR;4{ mv_group_number }{ mv_exercise_number }{ sy-index  }; | &&
      |Bank of Group { mv_group_number };78a Kingsdown Parade;Bristol|.
      APPEND ls_Bank TO et_Data.

lv_address = |GBR;4{ mv_group_number }{ mv_exercise_number }{ sy-index }; | &&
           |78a Kingsdown Parade;BS2;Bristol;GBR|.
      append lv_Address to lt_Address.

    me->file_download(
      EXPORTING
        iv_filename = 'bank_mapping_main'
      CHANGING
        ct_table    = et_data
    ).
    me->file_download(
      EXPORTING
        iv_filename = 'bank_mapping_address'
      CHANGING
        ct_table    = lt_Address
    ).

    me->write_status( ).
  ENDMETHOD.
ENDCLASS.
