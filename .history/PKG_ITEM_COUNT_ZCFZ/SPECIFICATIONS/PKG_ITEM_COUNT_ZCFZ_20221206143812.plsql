create or replace package pkg_item_count_zcfz is

  -- author  : administrator
  -- created : 2022/11/24 19:48:37
  -- purpose : 
  
  function totaldep (i_col number) return number;
  function item100303_2007 (i_col number) return number;
  function item3101_3202 (i_col number) return number;
  function item1005_2016 (i_col number) return number;
  function item1311_231410 (i_col number) return number;
  function item132104_231410 (i_col number) return number;
  function item3001_3002 (i_col number) return number;
  function item3051 (i_col number) return number;
  function item3301 (i_col number) return number;
  function item101105_201704 (i_col number) return number;
  function totalassets (i_col number) return number;
  function totalassets2 (i_col number) return number;
  function totalloans (i_col number) return number;
  function ownsequity (i_col number) return number;
  function loandecpre (i_col number) return number;
  function turnbrchcd (i_col number) return varchar2;

end pkg_item_count_zcfz;
