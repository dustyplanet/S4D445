CLASS cl_s4d445_provider_base DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC

  GLOBAL FRIENDS cl_s4d445_provider_factory .

  PUBLIC SECTION.

    TYPES:
      tt_data         TYPE TABLE OF string .
    TYPES:
      tv_group_number TYPE c LENGTH 2 .

    METHODS constructor
      IMPORTING
        !iv_group_number    TYPE if_s4d445_types=>tv_group
        !iv_exercise_number TYPE if_s4d445_types=>tv_exercise
      RAISING
        cx_s4d445_wrong_user .
    METHODS provide_data
      ABSTRACT
      EXPORTING
        !et_data TYPE tt_data .
  PROTECTED SECTION.

    DATA mv_attempt TYPE d445_ex_attempts .
    DATA mv_group_number TYPE if_s4d445_types=>tv_group .
    DATA mv_exercise_number TYPE if_s4d445_types=>tv_exercise .

    METHODS write_status .
    METHODS file_download
      IMPORTING
        !iv_filename TYPE string
      CHANGING
        !ct_table    TYPE STANDARD TABLE .
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_S4D445_PROVIDER_BASE IMPLEMENTATION.


  METHOD constructor.

    TRY.
        DATA(l_test) = EXACT i( iv_Group_Number ).

      CATCH cx_root.
        RAISE EXCEPTION TYPE CX_s4D445_wrong_user.
    ENDTRY.

    mv_group_number = iv_group_Number.
    mv_Exercise_number = iv_exercise_Number.

    SELECT SINGLE FROM d445_ex_status FIELDS attempts WHERE exercise = @mv_exercise_number
    INTO @me->mv_attempt.

  ENDMETHOD.


  METHOD file_download.

    cl_gui_frontend_services=>gui_download(
      EXPORTING
        filename                  =  |C:\\Users\\train-{ mv_group_number }\\downloads\\{ iv_filename }.txt|                    " Name der Datei
      CHANGING
        data_tab                  =  ct_Table                    " Übergabetabelle
      EXCEPTIONS
        OTHERS                    = 1
    ).
    IF sy-subrc = 0.
      me->write_status( ).
    ENDIF.
  ENDMETHOD.


  METHOD write_status.

    DATA(ls_insert) = VALUE d445_ex_status( username = sy-uname exercise = mv_exercise_number ).
    INSERT d445_ex_status FROM ls_insert.
    UPDATE d445_ex_status SET attempts = attempts + 1 WHERE exercise = mv_Exercise_number AND username = sy-uname.


  ENDMETHOD.
ENDCLASS.
