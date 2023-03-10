CLASS cl_s4d445_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_Hdb.



    CLASS-METHODS create_Bank_data IMPORTING iv_tabname TYPE dd02l-tabname iv_group TYPE if_s4d445_types=>tv_group iv_count TYPE i.
    CLASS-METHODS create_Customer_Data IMPORTING
                                         iv_tabname_p  TYPE dd02l-tabname
                                         iv_Tabname_r  TYPE dd02l-tabname
                                         iv_tabname_sd TYPE dd02l-tabname
                                         iv_Tabname_sp TYPE dd02l-tabname
                                         iv_Tabname_tx TYPE dd02l-tabname
                                         iv_group      TYPE if_s4d445_types=>tv_group
                                         iv_Attempt type if_s4d445_types=>tv_attempt
                                         iv_count      TYPE i.
    CLASS-METHODS create_Customer_Data_2 IMPORTING
                                           iv_tabname_p  TYPE dd02l-tabname
                                           iv_Tabname_r  TYPE dd02l-tabname
                                           iv_tabname_sd TYPE dd02l-tabname
                                           iv_Tabname_sp TYPE dd02l-tabname
                                           iv_Tabname_tx TYPE dd02l-tabname
                                           iv_group      TYPE if_s4d445_types=>tv_group
                                           iv_Attempt type if_S4D445_types=>tv_Attempt
                                           iv_count      TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS delete_existing IMPORTING VALUE(iv_tabname) TYPE dd02l-tabname.
    CLASS-METHODS create_banks IMPORTING VALUE(iv_tabname) TYPE dd02l-tabname
                                         VALUE(iv_group)   TYPE if_s4d445_types=>tv_group
                                         VALUE(iv_Count)   TYPE i.
    CLASS-METHODS create_customers IMPORTING VALUE(iv_tabname_p)  TYPE dd02l-tabname
                                             VALUE(iv_Tabname_r)  TYPE dd02l-tabname
                                             VALUE(iv_Tabname_sd) TYPE dd02l-tabname
                                             VALUE(iv_Tabname_sp) TYPE dd02l-tabname
                                             VALUE(iv_Tabname_tx) TYPE dd02l-tabname
                                             VALUE(iv_group)      TYPE if_s4d445_types=>tv_group
                                             value(iv_attempt)   type if_s4D445_types=>tv_attempt
                                             VALUE(iv_count)      TYPE i.
    CLASS-METHODS create_customers_2 IMPORTING VALUE(iv_tabname_p)  TYPE dd02l-tabname
                                               VALUE(iv_Tabname_r)  TYPE dd02l-tabname
                                               VALUE(iv_Tabname_sd) TYPE dd02l-tabname
                                               VALUE(iv_Tabname_sp) TYPE dd02l-tabname
                                               VALUE(iv_Tabname_tx) TYPE dd02l-tabname
                                               VALUE(iv_group)      TYPE if_s4d445_types=>tv_group
                                               value(iv_attempt)   type if_s4D445_types=>tv_attempt
                                               VALUE(iv_count)      TYPE i.
ENDCLASS.



CLASS CL_S4D445_AMDP IMPLEMENTATION.


  METHOD create_banks BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.
    declare l_count int := 1;
    declare l_account nvarchar(8);
 while l_count < :iv_count do
 if l_count < 10 then
 l_account := '1000000' || l_count;
 elseif l_Count < 100 then
 l_account := '100000' || l_count;
 else
 l_account := '10000' || l_count;
 end if ;
 exec
'insert into "S4D445DATATRANSFER"."' || :iv_tabname || '" values( ''DE'', ' ||  :l_account || ', ''NAME'','''','''','''','''','''','''','''','''','''' )';

l_count := l_count + 1;
 end while ;

  ENDMETHOD.


  METHOD create_bank_data.
    delete_existing( iv_tabname ).
    COMMIT WORK.
    create_banks(
      EXPORTING
        iv_tabname = iv_tabname
        iv_group   = iv_group
        iv_count   =  iv_Count
    ).
  ENDMETHOD.


  METHOD create_customers BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.
    declare l_count int := 1;
    declare l_partnernumber nvarchar(10) ;
    declare l_partnername nvarchar(20);
    declare l_attempt nvarchar(2);
    -- Insert general data
    if :iv_attempt < 10 then
    l_attempt := '0' || :iv_Attempt;
    else
    l_attempt := :iv_Attempt;
    end if;

    while l_count <= :iv_count do

    if l_count < 10 then -- single digit
    l_partnernumber := '5' || :iv_group ||'09' || l_attempt || '00' || l_count;
    l_partnername := 'Customer 000' || l_count;
    elseif l_count < 100 then -- 2 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt || '0' || l_count;
    l_partnername := 'Customer 00' || l_count;
    elseif l_count < 1000 then -- 3 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt  || l_count;
    l_partnername := 'Customer 0' || l_count;

     end if ;

     exec
   'insert into "S4D445DATATRANSFER"."' || :iv_tabname_p  || '"' ||
 ' values(''' || l_partnernumber || ''',''S445'',''Z445'',''Business Partner'', ' || -- 1 - 4
''''', '''','''','''','''','''','''','''','''','''',''00000000'', ' || -- 5-15
    ''''','''','''','''','''','''', '''', '''','''','''', ' ||  --16-25
    ''''','''','''',''00000000'',''00000000'',''0000000'',''00000'',''0'','''','''','''','''',''' || l_partnernumber || ''','''','''','||  -- 26-40
   ''''','''','''','''',''00'','''','''','''','''','''', ' ||  -- 41-50
    ''''','''','''','''','''','''','''','''','''','''', ' ||  --51-60
    ''''','''','''','''',''00000000'',''00000000000'','''',''00000000'','''','''', ' ||-- 61-70
    ''''','''','''','''','''','''','''','''','''','''', ' ||   -- 71-80
    ''''','''','''','''','''','''','''','''','''','''',  ' || -- 81-90
    ''''','''','''','''','''','''','''', ''Dietmar-Hopp-Allee'',''5'','''',' ||   -- 91-100
    ''''',''69190'',''Walldorf'',''DE'','''','''','''','''','''','''', ' ||  -- 101-110
    ''''','''','''','''','''','''','''','''','''','''', ' ||  -- 111-120
    ''''','''','''',''EN'','''','''','''','''','''','''', ' ||   -- 121-130
    ''''','''','''','''','''','''','''','''','''','''', ' ||   -- 131-140
    ''''','''','''','''','''','''','''','''','''','''', ' ||  -- 141-150
    ''''','''','''','''','''','''','''','''')' ; -- 151-158

     l_Count := l_Count + 1;

    end while;
    l_Count := 1;

    -- Insert Business Partner role
    while l_count <= :iv_count do
    if l_count < 10 then -- single digit
    l_partnernumber := '5' || :iv_group ||'09' || l_attempt || '00' || l_count;
    l_partnername := 'Customer 000' || l_count;
    elseif l_count < 100 then -- 2 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt || '0' || l_count;
    l_partnername := 'Customer 00' || l_count;
    elseif l_count < 1000 then -- 3 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt  || l_count;
    l_partnername := 'Customer 0' || l_count;

     end if ;
     --exec
     --'insert into "S4D445DATATRANSFER"."' || :iv_tabname_r  || '" values ( '' ' || l_partnernumber || ''', ''000000'', '''' ) ';
     exec
     'insert into "S4D445DATATRANSFER"."' || :iv_tabname_r ||'"' ||
     'values('''|| l_partnernumber ||''',''FLCU01'')';
     l_count := l_count + 1;
     end while;

    l_count := 1;

    -- Insert into sales data
     while l_count <= :iv_count do
      if l_count < 10 then -- single digit
    l_partnernumber := '5' || :iv_group ||'09' || l_attempt || '00' || l_count;
    l_partnername := 'Customer 000' || l_count;
    elseif l_count < 100 then -- 2 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt || '0' || l_count;
    l_partnername := 'Customer 00' || l_count;
    elseif l_count < 1000 then -- 3 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt  || l_count;
    l_partnername := 'Customer 0' || l_count;

     end if ;

    exec
    'insert into "S4D445DATATRANSFER"."' ||:iv_tabname_sd || '" ' ||
     'values(''' || l_partnernumber ||''',''1010'',''10'',''00'',' || --1-4
     ''''','''','''','''','''',''000'','''','''',''EUR'','''', ' || --5-14
     ''''','''',''S'','''','''','''',''01'','''',0,' || --15-23
     ''''','''',0,'''','''',0,0, '|| --24-30
     ''''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''')'; --31-50
    l_count := l_count + 1;
    end while;

    l_count := 1;

    -- insert into sales partner

     while l_count <= :iv_count do
     if l_count < 10 then -- single digit
    l_partnernumber := '5' || :iv_group ||'09' || l_attempt || '00' || l_count;
    l_partnername := 'Customer 000' || l_count;
    elseif l_count < 100 then -- 2 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt || '0' || l_count;
    l_partnername := 'Customer 00' || l_count;
    elseif l_count < 1000 then -- 3 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt  || l_count;
    l_partnername := 'Customer 0' || l_count;

     end if ;
    exec
    'insert into "S4D445DATATRANSFER"."' || :iv_tabname_sp || '" ' ||
    'values(''' || l_partnernumber || ''',''1010'',''10'',''00'',''AG'',''' || l_partnernumber || ''','''','''','''','''','''','''')';
    l_count := l_count + 1;
    end while;

    l_count := 1;

    -- insert into tax classification
    while l_count <= :iv_count do
      if l_count < 10 then -- single digit
    l_partnernumber := '5' || :iv_group ||'09' || l_attempt || '00' || l_count;
    l_partnername := 'Customer 000' || l_count;
    elseif l_count < 100 then -- 2 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt || '0' || l_count;
    l_partnername := 'Customer 00' || l_count;
    elseif l_count < 1000 then -- 3 digits
    l_partnernumber := '5' || :iv_group || '09' || l_attempt  || l_count;
    l_partnername := 'Customer 0' || l_count;

     end if ;
   -- exec
 --    'insert into "S4D445DATATRANSFER"."' || :iv_tabname_tx  || '" ' ||
    -- 'values(''' || l_partnernumber || ''',''DE'', ''TTX1'', ''1''  )';

    l_count := l_count + 1;
     end while;

  ENDMETHOD.


  METHOD create_customers_2 BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.
    declare l_count int := 1;
    declare l_partnernumber nvarchar(10) ;
    declare l_partnername nvarchar(20);

    -- Insert general data
    while l_count <= :iv_count do

    l_partnernumber := :iv_attempt || l_count;
    l_partnername := 'Group ' || l_count;

     exec
  'insert into "S4D445DATATRANSFER"."' || :iv_tabname_p  || '"' ||
 ' values(''' || l_partnernumber || ''',''S445'',''Z445'',''Business Partner'', ' || -- 1 - 4
''''', '''','''','''','''','''','''','''','''','''',''00000000'', ' || -- 5-15
    ''''','''','''','''','''','''', '''', '''','''','''', ' ||  --16-25
    ''''','''','''',''00000000'',''00000000'',''0000000'',''00000'',''0'','''','''','''','''',''' || l_partnernumber || ''','''','''','||  -- 26-40
   ''''','''','''','''',''00'','''','''','''','''','''', ' ||  -- 41-50
    ''''','''','''','''','''','''','''','''','''','''', ' ||  --51-60
    ''''','''','''','''',''00000000'',''00000000000'','''',''00000000'','''','''', ' ||-- 61-70
    ''''','''','''','''','''','''','''','''','''','''', ' ||   -- 71-80
    ''''','''','''','''','''','''','''','''','''','''',  ' || -- 81-90
    ''''','''','''','''','''','''','''', ''Dietmar-Hopp-Allee'',''5'','''',' ||   -- 91-100
    ''''',''69190'',''Walldorf'',''DE'','''','''','''','''','''','''', ' ||  -- 101-110
    ''''','''','''','''','''','''','''','''','''','''', ' ||  -- 111-120
    ''''','''','''',''EN'','''','''','''','''','''','''', ' ||   -- 121-130
    ''''','''','''','''','''','''','''','''','''','''', ' ||   -- 131-140
    ''''','''','''','''','''','''','''','''','''','''', ' ||  -- 141-150
    ''''','''','''','''','''','''','''','''')' ; -- 151-158

     l_Count := l_Count + 1;

    end while;
    l_Count := 1;

    -- Insert Business Partner role
    while l_count <= :iv_count do
     l_partnernumber := :iv_attempt || l_count;
     --exec
     --'insert into "S4D445DATATRANSFER"."' || :iv_tabname_r  || '" values ( '' ' || l_partnernumber || ''', ''000000'', '''', '''') ';
     exec
       'insert into "S4D445DATATRANSFER"."' || :iv_tabname_r ||'"' ||
     'values('''|| l_partnernumber ||''',''FLCU01'')';
     l_count := l_count + 1;
     end while;

    l_count := 1;

    -- Insert into sales data
     while l_count <= :iv_count do
      l_partnernumber := :iv_attempt || l_count;

    exec
   'insert into "S4D445DATATRANSFER"."' ||:iv_tabname_sd || '" ' ||
     'values(''' || l_partnernumber ||''',''1010'',''10'',''00'',' || --1-4
     ''''','''','''','''','''',''000'','''','''',''EUR'','''', ' || --5-14
     ''''','''',''S'','''','''','''',''01'','''',0,' || --15-23
     ''''','''',0,'''','''',0,0, '|| --24-30
     ''''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''','''')'; --31-50
    l_count := l_count + 1;
    end while;

    l_count := 1;

    -- insert into sales partner

     while l_count <= :iv_count do
    l_partnernumber := :iv_attempt || l_count;
    exec
  'insert into "S4D445DATATRANSFER"."' || :iv_tabname_sp || '" ' ||
    'values(''' || l_partnernumber || ''',''1010'',''10'',''00'',''AG'',''' || l_partnernumber || ''','''','''','''','''','''','''')';
    l_count := l_count + 1;
    end while;

    l_count := 1;

    -- insert into tax classification
    while l_count <= :iv_count do
     l_partnernumber := l_count;
 --   exec
 --    'insert into "S4D445DATATRANSFER"."' || :iv_tabname_tx  || '" ' ||
 --   'values(''' || l_partnernumber || ''',''DE'', ''TTX1'', ''1'', '''', '''' )';

    l_count := l_count + 1;
     end while;

  ENDMETHOD.


  METHOD create_customer_data.

    delete_existing(  iv_tabname_p ).
    delete_existing(  iv_tabname_r ).
    delete_existing(  iv_tabname_sd ).
    delete_Existing(  iv_tabname_sp ).
*    _delete_Existing(  iv_tabname_tx ).

    COMMIT WORK.

    create_customers(
      EXPORTING
        iv_tabname_p  = iv_tabname_P
        iv_tabname_r  = iv_tabname_r
        iv_tabname_sd = iv_Tabname_sd
        iv_tabname_sp = iv_tabname_sp
        iv_tabname_tx = iv_Tabname_Tx
        iv_attempt = iv_attempt
        iv_group      =  iv_group
        iv_count      = iv_count
    ).
    COMMIT WORK.

  ENDMETHOD.


  METHOD create_customer_data_2.
    delete_existing(  iv_tabname_p ).
    delete_existing(  iv_tabname_r ).
    delete_existing(  iv_tabname_sd ).
    delete_Existing(  iv_tabname_sp ).
*    delete_Existing(  iv_tabname_tx ).

    COMMIT WORK.

    create_customers_2(
      EXPORTING
        iv_tabname_p  = iv_tabname_P
        iv_tabname_r  = iv_tabname_r
        iv_tabname_sd = iv_Tabname_sd
        iv_tabname_sp = iv_tabname_sp
        iv_tabname_tx = iv_Tabname_Tx
        iv_Attempt = iv_Attempt
        iv_group      =  iv_group
        iv_count      = iv_count
    ).
    COMMIT WORK.
  ENDMETHOD.


  METHOD delete_existing BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.
    exec
    'delete from "S4D445DATATRANSFER"."' || :iv_Tabname || '"';

  ENDMETHOD.
ENDCLASS.
