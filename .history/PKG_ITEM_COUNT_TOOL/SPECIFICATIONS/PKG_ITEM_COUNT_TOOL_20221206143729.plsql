create or replace package pkg_item_count_tool is

  -- author  : zhoumingle
  -- created : 2022/11/23 18:01:43
  -- purpose : 大屏数据年终展示-损益类数据加工包
  
  function totalrev(i_col number) return number;
  function item6011(i_col number) return number;
  function item6012(i_col number) return number;
  function item6021(i_col number) return number;
  function otherrev(i_col number) return number;
  function totalexp(i_col number) return number;
  function item6411(i_col number) return number;
  function item6412(i_col number) return number;
  function item6421(i_col number) return number;
  function item6601(i_col number) return number;
  function item660101(i_col number) return number;
  function item66010501(i_col number) return number;
  function item660130(i_col number) return number;
  function item6602(i_col number) return number;
  function item6711(i_col number) return number;
  function item6403(i_col number) return number;
  function item6061(i_col number) return number;
  function item6101(i_col number) return number;
  function item6111(i_col number) return number;
  function item6701(i_col number) return number;
  function item6702(i_col number) return number;
  function totalprof(i_col number) return number;
  function item6801(i_col number) return number;
  function netprof(i_col number) return number;
  function item6301(i_col number) return number;
  
end pkg_item_count_tool;
