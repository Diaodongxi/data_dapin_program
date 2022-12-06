create or replace package body pkg_item_count_tool is
----------------------------------------------------------------------------------------------------------------------------------------
  /*
  总收入
  6011利息收入+6012金融机构往来收入+6021手续费及佣金收入+
  6051其他业务收入+6071其他收益+6115资产处置损益+6301营业外收入+
  6061汇兑损益+6101公允价值变动损益+6111投资收益
  */
  function totalrev(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in
           (6011, 6012, 6021, 6051, 6071, 6115, 6301, 6061, 6101, 6111)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end totalrev;
----------------------------------------------------------------------------------------------------------------------------------------
  --利息收入
  --6011利息收入-601110债权投资利息收入-601111其他债权投资利息收入
  function item6011(i_col number) return number is
    item6011c         number;
    item601110_601111 number;
    n1                number;
  begin
    begin
      select sum(onlnbl)
        into item6011c
        from sungl.data_rj_base
       where itemcd in (6011)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item6011c := 0;
    end;
    begin
      select sum(onlnbl)
        into item601110_601111
        from sungl.data_rj_base
       where itemcd in (601110, 601111)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item601110_601111 := 0;
      
    end;
    n1 := item6011c - item601110_601111;
    return n1;
  end item6011;
----------------------------------------------------------------------------------------------------------------------------------------
  --6012金融机构往来收入
  function item6012(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6012)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6012;
----------------------------------------------------------------------------------------------------------------------------------------
  --6021手续费及佣金收入
  function item6021(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6021)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6021;
----------------------------------------------------------------------------------------------------------------------------------------
  /*
  其他收入
  6051其他业务收入+6071其他收益+6115资产处置损益+6301营业外收入
  */
  function otherrev(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6051, 6071, 6115, 6301)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end otherrev;
----------------------------------------------------------------------------------------------------------------------------------------
  /*
  总支出
  6411利息支出+6412金融机构往来支出+6421手续费及佣金支出+6601业务及管理费+
  6602其他业务支出+6711营业外支出+6403税金及附加+6701资产减值损失+6702信用减值损失+6801所得税费用
  */
  function totalexp(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in
           (6411, 6412, 6421, 6601, 6602, 6711, 6403, 6701, 6702, 6801)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end totalexp;
----------------------------------------------------------------------------------------------------------------------------------------
  --6411利息支出
  function item6411(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6411)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6411;
----------------------------------------------------------------------------------------------------------------------------------------
  --6412金融机构往来支出
  function item6412(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6412)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6412;
----------------------------------------------------------------------------------------------------------------------------------------
  --6421 手续费以及佣金支出
  function item6421(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6421)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6421;
----------------------------------------------------------------------------------------------------------------------------------------
  --6601业务管理费
  function item6601(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6601)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6601;
----------------------------------------------------------------------------------------------------------------------------------------
  --660101职工薪酬
  function item660101(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (660101)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item660101;

  --66010501电子运行费
  function item66010501(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (66010501)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item66010501;
----------------------------------------------------------------------------------------------------------------------------------------
  --660130 服务费
  function item660130(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (660130)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item660130;
----------------------------------------------------------------------------------------------------------------------------------------
  --6602其他业务支出
  function item6602(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6602)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6602;
----------------------------------------------------------------------------------------------------------------------------------------
  --6711营业外支出
  function item6711(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6711)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6711;
----------------------------------------------------------------------------------------------------------------------------------------
  --6403税金及附加
  function item6403(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6403)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6403;
----------------------------------------------------------------------------------------------------------------------------------------
  --6061汇兑损益
  function item6061(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6061)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6061;
----------------------------------------------------------------------------------------------------------------------------------------
  --6101公允价值变动损益
  function item6101(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6101)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6101;
----------------------------------------------------------------------------------------------------------------------------------------
  --投资收益 6111投资收益+601110债权投资利息收入+601111其他债权投资利息收入
  function item6111(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6111, 601110, 601111)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6111;
----------------------------------------------------------------------------------------------------------------------------------------
  --6701资产减值损失
  function item6701(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6701)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6701;
----------------------------------------------------------------------------------------------------------------------------------------
  --6702信用减值损失
  function item6702(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6702)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6702;
----------------------------------------------------------------------------------------------------------------------------------------
  --利润总额 总收入-总支出+6801所得税费用
  function totalprof(i_col number) return number is
    n1 number;
  
    suodeshui number;
  
    zongsr number;
  
    zongzc number;
  
  begin
    select sungl.pkg_item_count_tool.totalrev(i_col) into zongsr from dual;
  
    select sungl.pkg_item_count_tool.totalexp(i_col) into zongzc from dual;
  
    select sungl.pkg_item_count_tool.item6801(i_col)
      into suodeshui
      from dual;
  
    n1 := zongsr - zongzc + suodeshui;
  
    return n1;
  
  end totalprof;
----------------------------------------------------------------------------------------------------------------------------------------
  --所得税费用6801
  function item6801(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6801)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6801;
----------------------------------------------------------------------------------------------------------------------------------------
  --净利润 总收入-总支出
  function netprof(i_col number) return number is
    n1 number;
  
    zongsr number;
  
    zongzc number;
  
  begin
    select sungl.pkg_item_count_tool.totalrev(i_col) into zongsr from dual;
  
    select sungl.pkg_item_count_tool.totalexp(i_col) into zongzc from dual;
  
    n1 := zongsr - zongzc;
  
    return n1;
  
  end netprof;
----------------------------------------------------------------------------------------------------------------------------------------
  --6301营业外收入
  function item6301(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (6301)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item6301;
 -------------------------------------------------------------------------------------------------------------------------------------------
end pkg_item_count_tool;
