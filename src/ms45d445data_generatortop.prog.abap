*&---------------------------------------------------------------------*
*& Include MS45D445DATA_GENERATORTOP                - Module Pool      SAPMS4D445_DATA_GENERATOR
*&---------------------------------------------------------------------*
PROGRAM sapms4d445_data_generator.



CLASS lcl_Controller DEFINITION.
  PUBLIC SECTION.
    TYPES tv_ex_number TYPE c LENGTH 2.
    TYPES tt_ex_status TYPE STANDARD TABLE OF d445_exercise_alv WITH NON-UNIQUE DEFAULT KEY.
    METHODS: constructor RAISING cx_s4d445_wrong_user,
      get_status RETURNING VALUE(rt_status) TYPE tt_ex_status,
      provide_data IMPORTING iv_Exercise TYPE if_s4d445_types=>tv_group RAISING cx_s4d445_download_error cx_s4D445_staging_error.
    DATA: mv_Group_Number TYPE if_s4d445_types=>tv_group READ-ONLY.


ENDCLASS.

CLASS lcl_Controller IMPLEMENTATION.
  METHOD constructor.
    DATA l_bin TYPE string.
    IF NOT matches( val = sy-uname regex = 'S4D445-\d{2}' ).
      RAISE EXCEPTION TYPE cx_S4d445_wrong_user.
    ENDIF.
    SPLIT sy-uname AT '-' INTO l_bin me->mv_group_number.

  ENDMETHOD.
  METHOD get_status.
    DATA: lt_exercises TYPE TABLE OF d445_exercise,
          lt_texts     TYPE TABLE OF d445_exerciset,
          lt_status    TYPE TABLE OF d445_ex_status.
* Select exercises, texts in logon language or in English, whether the user has already
* executed this step.
    SELECT FROM d445_exercise FIELDS * ORDER BY exercise INTO TABLE @lt_exercises.
    SELECT FROM d445_exerciset FIELDS * WHERE spras = @sy-langu INTO TABLE @lt_texts.
    IF sy-subrc <> 0.
      SELECT FROM d445_exerciset FIELDS * WHERE spras = 'E' INTO TABLE @lt_texts.
    ENDIF.
    SELECT FROM d445_ex_status FIELDS * WHERE username =  @sy-uname INTO TABLE @lt_status.

* Merge the tables
   rt_status = VALUE #( FOR line IN lt_exercises ( exercise     = line-exercise
                                                    exercisetext = lt_texts[ exercise = line-exercise ]-exercisetext
                                                    status = COND #(
                                                    WHEN line_exists( lt_status[ exercise = line-exercise ] ) THEN icon_led_green ELSE icon_led_inactive )
                                                    generate_data = COND #( WHEN lt_exercises[ exercise = line-exercise ]-generate = abap_true THEN 'Generate Data' )
                                                    show_code_1 = COND #( WHEN lt_exercises[ exercise = line-exercise ]-has_code_1 IS NOT INITIAL
                                                    THEN substring_after( val = lt_Exercises[ exercise = line-exercise ]-has_code_1 sub = 'S4D445_CODE_' ) ELSE space )
                                                    show_code_2 = COND #( WHEN lt_exercises[ exercise = line-exercise ]-has_code_2 IS NOT INITIAL
                                                    THEN substring_After( val = lt_Exercises[ exercise = line-exercise ]-has_Code_2 sub = 'S4D445_CODE_' )
                                                      ELSE space ) ) ).
  ENDMETHOD.

  METHOD provide_Data.
    DATA lo_provider TYPE REF TO cl_S4d445_provider_Base.

    lo_provider = cl_s4d445_provider_factory=>get_exercise_object(
                    iv_group          = me->mv_group_number
*                it_staging_tables =
                    iv_exercise_no    = iv_exercise
                  ).
    lo_provider->provide_Data( ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_event_Handler DEFINITION DEFERRED.
DATA: ok_Code         TYPE syst-ucomm,
      go_Application  TYPE REF TO lcl_Controller,
      go_custom       TYPE REF TO cl_gui_Custom_Container,
      go_alv          TYPE REF TO cl_gui_Alv_Grid,
      gt_alv_data     TYPE lcl_controller=>tt_ex_status,
      go_handler      TYPE REF TO lcl_event_handler,
      gv_group_number TYPE if_S4D445_types=>tv_group.
