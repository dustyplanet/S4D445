class CL_S4D445_BANK_DATA_CORRECT definition
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



CLASS CL_S4D445_BANK_DATA_CORRECT IMPLEMENTATION.


  METHOD provide_data.

    DATA ls_Bank TYPE string.

    DO 50 TIMES.
      ls_bank = |DE;40{ mv_group_number }{ mv_Exercise_Number }{ sy-index WIDTH = 2 PAD = '0' ALIGN = RIGHT };| &&
      |Bank of Group { mv_group_number };;High Street { sy-index };Anytown|.
      APPEND ls_bank TO et_Data.

    ENDDO.

me->file_download(
  EXPORTING
    iv_filename = 'bank_correct'
  CHANGING
    ct_table    = et_data
).

me->write_status( ).
  ENDMETHOD.
ENDCLASS.
