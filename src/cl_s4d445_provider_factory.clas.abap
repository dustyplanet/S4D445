class CL_S4D445_PROVIDER_FACTORY definition
  public
  final
  create public .

public section.

  class-methods GET_EXERCISE_OBJECT
    importing
      !IV_GROUP type IF_S4D445_TYPES=>TV_GROUP
      !IV_EXERCISE_NO type IF_S4D445_TYPES=>TV_EXERCISE
    returning
      value(RO_OBJECT) type ref to CL_S4D445_PROVIDER_BASE .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_S4D445_PROVIDER_FACTORY IMPLEMENTATION.


  METHOD get_exercise_object.
    SELECT SINGLE FROM d445_exercise FIELDS classname WHERE exercise = @iv_exercise_no
    INTO @DATA(lv_classname).

    CREATE OBJECT ro_object TYPE (lv_classname)
    EXPORTING iv_exercise_number = iv_exercise_no
    iv_group_number = iv_group.

  ENDMETHOD.
ENDCLASS.
