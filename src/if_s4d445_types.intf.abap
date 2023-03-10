interface IF_S4D445_TYPES
  public .


  types TV_ATTEMPT type I .
  types:
    tv_group TYPE n LENGTH 2 .
  types:
    tv_exercise type n length 2 .
  types:
    BEGIN OF ts_staging_table,
           table_use  TYPE string,
           table_name TYPE dd02l-tabname,
         END OF ts_staging_Table .
  types:
    tt_staging_tables TYPE STANDARD TABLE OF ts_staging_table .

  constants GC_CODE_SNIPPET_PREFIX type PROGRAMM value 'S4D445_CODE_' ##NO_TEXT.
endinterface.
