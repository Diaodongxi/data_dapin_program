create or replace package pkg_item_count_bili is

  -- author  : n_zhoumingle
  -- created : 2022/11/26 11:21:11
  -- purpose : 比例类指标
  
function costinco(i_col number) return number;
function roe(i_col number) return number;

end pkg_item_count_bili;
