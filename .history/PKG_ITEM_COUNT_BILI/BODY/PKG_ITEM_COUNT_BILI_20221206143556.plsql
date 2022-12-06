create or replace package body pkg_item_count_bili is
---------------------------------------------------------------------------------------------------------------------------------------------------
/*
成本收入比

item6601,item6602
item6011,item6012,item6021,6051其他业务收入+6071其他收益+6115资产处置损益,  item6111,item6101,item6061
item6411,item6412,item6421
(业务及管理费+其他业务支出)/
（利息收入-利息支出+金融机构往来收入-金融机构往来支出+手续费及佣金收入-手续费及佣金支出
+其他业务收入+其他收益+资产处置损益+投资收益+公允价值变动损益+汇兑损益）
//todo:资本利润率还没做
*/

function costinco(i_col number) return number is
  n1             number;
  molecule       number;
  denomi         number;
  count6051_6115 number;
begin
  begin
    select sum(onlnbl)
      into count6051_6115
      from sungl.data_rj_base
     where itemcd in (6051, 6071, 6115)
       and brchcd = i_col
     group by brchcd;
  exception
    when no_data_found then
      count6051_6115 := 0;
  end;
  begin
    molecule := sungl.pkg_item_count_tool.item6601(i_col) +
                sungl.pkg_item_count_tool.item6602(i_col);
                
    denomi   := sungl.pkg_item_count_tool.item6011(i_col) +
                sungl.pkg_item_count_tool.item6012(i_col) +
                sungl.pkg_item_count_tool.item6021(i_col) + 
                count6051_6115 +
                sungl.pkg_item_count_tool.item6111(i_col) +
                sungl.pkg_item_count_tool.item6101(i_col) +
                sungl.pkg_item_count_tool.item6061(i_col) -
                sungl.pkg_item_count_tool.item6411(i_col) -
                sungl.pkg_item_count_tool.item6412(i_col) -
                sungl.pkg_item_count_tool.item6421(i_col);
  
    n1 := molecule / denomi;
  
    return n1;
  end;
  end costinco;
----------------------------------------------------------------------------------------------------

function roe(i_col number) return number is

n1 number;

ownerequ_start number;

avgown number;

begin
  select
    t.onlnbl into ownerequ_start
  from
    ownerequ_start t
  where
    brchcd = i_col;

  avgown := (sungl.pkg_item_count_zcfz.ownsequity(i_col) + ownerequ_start) / 2;
  
  n1 := sungl.pkg_item_count_tool.netprof(i_col) / avgown;
  
  return n1;
end roe;
-----------------------------------------------------------------------------------------------------
end pkg_item_count_bili;
