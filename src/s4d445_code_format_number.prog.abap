*&---------------------------------------------------------------------*
*& Report S4D445_CODE_FORMAT_NUMBER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT S4D445_CODE_FORMAT_NUMBER.

"#GroupNumber

*DATA: lv_number TYPE n LENGTH 10.
*
*
*
*lv_number = |{ i_num ALIGN = RIGHT }|.
*OVERLAY lv_Number WITH '0000000000'.
*REPLACE SECTION OFFSET 0 LENGTH 5 OF lv_number WITH '5##10'.
*
*e_num = lv_Number.
