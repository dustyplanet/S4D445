FUNCTION-POOL s4d445_ui.                    "MESSAGE-ID ..

* INCLUDE LS4D445_UID...                     " Local class definition

TYPES: BEGIN OF ts_code ,
         line TYPE c LENGTH 80,
       END OF ts_code,
       tt_code TYPE TABLE OF ts_code.

DATA: gv_basic_Data         TYPE dd02l-tabname,
      gv_partner_data       TYPE dd02l-tabname,
      gv_sales_data         TYPE dd02l-tabname,
      gv_sales_partner_data TYPE dd02l-tabname,
      gv_tax_class          TYPE dd02l-tabname,
      ok_code               TYPE syucomm,
      gv_Rc                 TYPE sysubrc,

      go_custom             TYPE REF TO cl_gui_Custom_Container,
      go_text               TYPE REF TO cl_gui_textedit,
      gt_code               TYPE Tt_Code.
