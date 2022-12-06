create or replace package body pkg_item_count_zcfz is
----------------------------------------------------------------------------------------------------------------------------------------
/*
存款总额
2014 保证金存款+2001单位活期存款+2011应解汇款+2006财政性存款+
2002单位定期存款+2052国库定期存款+2005银行卡存款+2003个人活期存款+
2004个人定期存款+2083大额存单+2012汇出汇款+2013开出本票+201702境内非银行同业存放款项+
201703境外同业存放款项+202302银行业非存款类金融机构同业存单+202303非银行业金融机构同业存单+2084结构性存款
*/
  function totaldep(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (2014,
                      2001,
                      2011,
                      2006,
                      2002,
                      2052,
                      2005,
                      2003,
                      2004,
                      2083,
                      2012,
                      2013,
                      201702,
                      201703,
                      202302,
                      202303,
                      2084)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end totaldep;
----------------------------------------------------------------------------------------------------------------------------------------
  --资产总额相关科目计算100303-2007

  /*max((100303-2007,0)
  max(3101+3201+3202,0)
  max((1005-2016),0)
  max((1311+1321-132104-2312-2313-2314+231410),0)
  max((132104-231410),0)
  max((3001+3002),0)
  max(3051,0)
  max(3301,0)
  max((101105-201704),0)*/

  function item100303_2007(i_col number) return number is
    item100303 number;
    item2007   number;
    n1         number;
  begin
    begin
      select sum(onlnbl)
        into item100303
        from sungl.data_rj_base
       where itemcd in (100303)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item100303 := 0;
    end;
    begin
      select sum(onlnbl)
        into item2007
        from sungl.data_rj_base
       where itemcd in (2007)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item2007 := 0;
      
    end;
    n1 := item100303 - item2007;
    return n1;
  end item100303_2007;

  --资产总额相关科目计算3101+3201+3202
  function item3101_3202(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (3101, 3201, 3202)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item3101_3202;

  --资产总额相关科目计算1005-2016
  function item1005_2016(i_col number) return number is
    item1005 number;
    item2016 number;
    n1       number;
  begin
    begin
      select sum(onlnbl)
        into item1005
        from sungl.data_rj_base
       where itemcd in (1005)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item1005 := 0;
    end;
    begin
      select sum(onlnbl)
        into item2016
        from sungl.data_rj_base
       where itemcd in (2016)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item2016 := 0;
      
    end;
    n1 := item1005 - item2016;
    return n1;
  end item1005_2016;

  --资产总额相关科目计算1311+1321-132104-2312-2313-2314+231410
  function item1311_231410(i_col number) return number is
    item1311_231410 number;
    item132104_2314 number;
    n1              number;
  begin
    begin
      select sum(onlnbl)
        into item1311_231410
        from sungl.data_rj_base
       where itemcd in (1311, 1321, 231410)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item1311_231410 := 0;
    end;
    begin
      select sum(onlnbl)
        into item132104_2314
        from sungl.data_rj_base
       where itemcd in (132104, 2312, 2313, 2314)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item132104_2314 := 0;
      
    end;
    n1 := item1311_231410 - item132104_2314;
    return n1;
  end item1311_231410;

  --资产总额相关科目计算max((132104-231410),0)
  function item132104_231410(i_col number) return number is
    item132104 number;
    item231410 number;
    n1         number;
  begin
    begin
      select sum(onlnbl)
        into item132104
        from sungl.data_rj_base
       where itemcd in (132104)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item132104 := 0;
    end;
    begin
      select sum(onlnbl)
        into item231410
        from sungl.data_rj_base
       where itemcd in (231410)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item231410 := 0;
      
    end;
    n1 := item132104 - item231410;
    return n1;
  end item132104_231410;

  --资产总额相关科目计算3001+3002
  function item3001_3002(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (3001, 3002)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item3001_3002;

  --资产总额相关科目计算3051+3301
  function item3051(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (3051)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item3051;

  --资产总额相关科目计算3301
  function item3301(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (3301)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end item3301;

  --资产总额相关科目计算101105-201704

  function item101105_201704(i_col number) return number is
    item101105 number;
    item201704 number;
    n1         number;
  begin
    begin
      select sum(onlnbl)
        into item101105
        from sungl.data_rj_base
       where itemcd in (101105)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item101105 := 0;
    end;
    begin
      select sum(onlnbl)
        into item201704
        from sungl.data_rj_base
       where itemcd in (201704)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item201704 := 0;
      
    end;
    n1 := item101105 - item201704;
    return n1;
  end item101105_201704;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /*
  资产总额（各行社）
  1001现金+1002业务周转金+100301准备金存款+100302存放中央银行特种存款+max((100303缴存中央银行财政性存款-2007待结算财政款项,0)+
  11320102应计存放央行利息+1011存放同业款项-101105专项风险互助金+1012存放系统内款项+1031存出保证金-123105存放同业坏账准备-1032存出保证金减值准备+
  11320103应计存放同业款项利息+11320104应计存放系统内款项利息+1431贵金属+
  1013拆放同业款项-101302拆放非存款类金融机构资金-101303拆放境外同业资金-123106拆放同业坏账准备+1014拆放系统内款项+11320105应计拆出资金利息+
  max(3101衍生工具+3201套期工具+3202被套期项目,0)+1111买入返售金融资产-1112买入返售金融资产减值准备+11320106应计买入返售资产利息+
  1481持有待售资产-1482持有待售资产减值准备+1301农户贷款+1304非农贷款+1302农村经济组织贷款+1303农村企业贷款+1305贷记卡透支+1307贸易融资+1308垫款+
  101302拆放非存款类金融机构资金+101303拆放境外同业资金+(1306贴现资产-2022再贴现负债-2021转贴现负债-1309贷款损失准备)+1101交易性金融资产+
  1132020201应收未收交易性金融资产利息+1501债权投资-1502债权投资减值准备+1132020202应收未收债权投资利息+1503其他债权投资+1132020203应收未收其他债权投资利息+
  1505其他权益工具投资+1511长期股权投资-1512长期股权投资减值准备+1521投资性房地产-1522投资性房地产累计折旧(摊销)-1523投资性房地产减值准备+
  1601固定资产-1602累计折旧-1603固定资产减值准备+1604在建工程-1605在建工程减值准备+1607使用权资产-1608使用权资产累计折旧-1609使用权资产减值准备+
  1701无形资产-1702无形资产累计摊销-1703无形资产减值准备+1801长期待摊费用+1441抵债资产-1442抵债资产减值准备+1811递延所得税资产+
  max((1005央行专项扶持资金-2016央行拨付专项票据资金),0)+1124应收手续费及佣金+1131应收股利+1221其他应收款+1606固定资产清理+1711商誉+1721研发支出+
  1901待处理财产损溢-123101应收手续费收入及佣金坏账准备-123103应收股利坏账准备-123104其他应收款坏账准备-123199其他应收款坏账准备-1712商誉减值准备+
  max((1311代理兑付证券+1321代理业务资产-132104自营理财资产-2312代理承销证券款-2313代理承销证券款-2314代理业务负债+231410自营理财负债),0)+
  max((132104自营理财资产-231410自营理财负债),0)+max((3001清算资金往来+3002社内往来),0)+max(3051外汇营运资金,0)+max(3301外汇买卖,0)+
  11320201应收未收贷款利息+11320199应计其他利息+11320299应收未收其他利息-123102应收利息坏账准备+max((101105专项风险互助金-201704存入专项风险互助资金),0)
  */
  function totalassets(i_col number) return number is
    n1     number;
    addsum number;
    negsum number;
    num1   number;
    num2   number;
    num3   number;
    num4   number;
    num5   number;
    num6   number;
    num7   number;
    num8   number;
    num9   number;

  begin
    if i_col = 910000000 then
      n1 := 0;
      return n1;
    else
      begin
        select sum(onlnbl)
          into addsum
          from sungl.data_rj_base
         where itemcd in (1001,
                          1002,
                          100301,
                          100302,
                          11320102,
                          1011,
                          1012,
                          1031,
                          11320103,
                          11320104,
                          1431,
                          1013,
                          1014,
                          11320105,
                          1111,
                          11320106,
                          1481,
                          1301,
                          1304,
                          1302,
                          1303,
                          1305,
                          1307,
                          8888,
                          1308,
                          101302,
                          101303,
                          1306,
                          1101,
                          1132020201,
                          1501,
                          1132020202,
                          1503,
                          1132020203,
                          1505,
                          1511,
                          1521,
                          1601,
                          1604,
                          1607,
                          1701,
                          1801,
                          1441,
                          1811,
                          1124,
                          1131,
                          1221,
                          1606,
                          1711,
                          1721,
                          1901,
                          11320201,
                          11320199,
                          11320299)
           and brchcd = i_col
         group by brchcd;
      exception
        when no_data_found then
          addsum := 0;
      end;
      begin
        select sum(onlnbl)
          into negsum
          from sungl.data_rj_base
         where itemcd in (123102,
                          123101,
                          123103,
                          123104,
                          123199,
                          1712,
                          1702,
                          1703,
                          123105,
                          1032,
                          1112,
                          1522,
                          1523,
                          1502,
                          1602,
                          1603,
                          1605,
                          1608,
                          1609,
                          2022,
                          2021,
                          1309,
                          101302,
                          101303,
                          123106,
                          1512,
                          101105,
                          1482,
                          1442)
           and brchcd = i_col
         group by brchcd;
      exception
        when no_data_found then
          negsum := 0;
        
      end;
    
      select greatest(sungl.pkg_item_count_zcfz.item100303_2007(i_col), 0)
        into num1
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3101_3202(i_col), 0)
        into num2
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item1005_2016(i_col), 0)
        into num3
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item1311_231410(i_col), 0)
        into num4
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item132104_231410(i_col), 0)
        into num5
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3001_3002(i_col), 0)
        into num6
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3051(i_col), 0)
        into num7
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3301(i_col), 0)
        into num8
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item101105_201704(i_col), 0)
        into num9
        from dual;
      n1 := addsum - negsum + num1 + num2 + num3 + num4 + num5 + num6 + num7 + num8 + num9;
      return n1;
    end if;
  end totalassets;
-------------------------------------------------------------------------------------------------------------------------------------------
  --资产总额（省联社）,公式同各行社的计算公式
  function totalassets2(i_col number) return number is
    n1     number;
    addsum number;
    negsum number;
    num1   number;
    num2   number;
    num3   number;
    num4   number;
    num5   number;
    num6   number;
    num7   number;
    num8   number;
    num9   number;

  begin
    if i_col != 910000000 then
      n1 := 0;
      return n1;
    else
      begin
        select sum(onlnbl)
          into addsum
          from sungl.data_rj_base
         where itemcd in (1001,
                          1002,
                          100301,
                          100302,
                          11320102,
                          1011,
                          1012,
                          1031,
                          11320103,
                          11320104,
                          1431,
                          1013,
                          1014,
                          11320105,
                          1111,
                          11320106,
                          1481,
                          1301,
                          1304,
                          1302,
                          1303,
                          1305,
                          1307,
                          8888,
                          1308,
                          101302,
                          101303,
                          1306,
                          1101,
                          1132020201,
                          1501,
                          1132020202,
                          1503,
                          1132020203,
                          1505,
                          1511,
                          1521,
                          1601,
                          1604,
                          1607,
                          1701,
                          1801,
                          1441,
                          1811,
                          1124,
                          1131,
                          1221,
                          1606,
                          1711,
                          1721,
                          1901,
                          11320201,
                          11320199,
                          11320299)
           and brchcd = i_col
         group by brchcd;
      exception
        when no_data_found then
          addsum := 0;
      end;
      begin
        select sum(onlnbl)
          into negsum
          from sungl.data_rj_base
         where itemcd in (123102,
                          123101,
                          123103,
                          123104,
                          123199,
                          1712,
                          1702,
                          1703,
                          123105,
                          1032,
                          1112,
                          1522,
                          1523,
                          1502,
                          1602,
                          1603,
                          1605,
                          1608,
                          1609,
                          2022,
                          2021,
                          1309,
                          101302,
                          101303,
                          123106,
                          1512,
                          101105,
                          1482,
                          1442)
           and brchcd = i_col
         group by brchcd;
      exception
        when no_data_found then
          negsum := 0;
        
      end;
    
      select greatest(sungl.pkg_item_count_zcfz.item100303_2007(i_col), 0)
        into num1
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3101_3202(i_col), 0)
        into num2
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item1005_2016(i_col), 0)
        into num3
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item1311_231410(i_col), 0)
        into num4
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item132104_231410(i_col), 0)
        into num5
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3001_3002(i_col), 0)
        into num6
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3051(i_col), 0)
        into num7
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item3301(i_col), 0)
        into num8
        from dual;
      select greatest(sungl.pkg_item_count_zcfz.item101105_201704(i_col), 0)
        into num9
        from dual;
      n1 := addsum - negsum + num1 + num2 + num3 + num4 + num5 + num6 + num7 + num8 + num9;
      return n1;
    end if;
  end totalassets2;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
#todo:贷款总额 ：本次用的还是旧的科目公式计算，新的科目拆分后需要修改
1301农户贷款+1302农村经济组织贷款+1303农村企业贷款+1304非农贷款+1305贷记卡透支+
1307贸易融资+1308垫款+101302拆放非存款类金融机构资金+101303拆放境外同业资金+（1306贴现资产-2022再贴现负债-2021转贴现负债)
*/ 

  function totalloans(i_col number) return number is
    item1301_1306 number;
    item2021_2022 number;
    n1            number;
  begin
    begin
      select sum(onlnbl)
        into item1301_1306
        from sungl.data_rj_base
       where itemcd in (1301,
                        1302,
                        1303,
                        1304,
                        8888,
                        1305,
                        1307,
                        1308,
                        101302,
                        101303,
                        1306)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item1301_1306 := 0;
    end;
    begin
      select sum(onlnbl)
        into item2021_2022
        from sungl.data_rj_base
       where itemcd in (2022, 2021)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item2021_2022 := 0;
      
    end;
    n1 := item1301_1306 - item2021_2022;
    return n1;
  end totalloans;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /*
  所有者权益
4001实收资本+4002其他权益工具+4003资本公积-4004库存股+4005其他综合收益+
4101盈余公积+4102一般风险准备+4103本年利润+4104利润分配+6011利息收入+6012金融机构往来收入+
6021手续费及佣金收入+6051其他业务收入+6061汇兑损益+6071其他收益+6101公允价值变动损益+6102套期损益+
6111投资收益+6115资产处置损益+
6301营业外收入-6602其他业务支出-6403税金及附加-6411利息支出-6412金融机构往来支出-
6421手续费及佣金支出-6601业务及管理费-6701资产减值损失-6702信用减值损失-6711营业外支出-6801所得税费用-6901以前年度损益调整-330108货币兑换+
33010899其他货币兑换-3099外币利润结转
  */
  function ownsequity(i_col number) return number is
    item4001_33010899 number;
    item4004_3099     number;
    n1                number;
  begin
    begin
      select sum(onlnbl)
        into item4001_33010899
        from sungl.data_rj_base
       where itemcd in (4001,
                        4002,
                        4003,
                        4005,
                        4101,
                        4102,
                        4103,
                        4104,
                        6011,
                        6012,
                        6021,
                        6051,
                        6061,
                        6071,
                        6101,
                        6102,
                        6111,
                        6115,
                        6301,
                        33010899)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item4001_33010899 := 0;
    end;
    begin
      select sum(onlnbl)
        into item4004_3099
        from sungl.data_rj_base
       where itemcd in (4004,
                        6602,
                        6403,
                        6411,
                        6412,
                        6421,
                        6601,
                        6701,
                        6702,
                        6711,
                        6801,
                        6901,
                        330108,
                        3099)
         and brchcd = i_col
       group by brchcd;
    exception
      when no_data_found then
        item4004_3099 := 0;
      
    end;
    n1 := item4001_33010899 - item4004_3099;
    return n1;
  end ownsequity;
--------------------------------------------------------------------------------------------------------------------------------------
  --贷款减值准备 1309 贷款损失准备+40050104 福费廷减值准备+40050106贴现资产减值准备
  function loandecpre(i_col number) return number is
    n1 number;
  
  begin
    select sum(onlnbl)
      into n1
      from sungl.data_rj_base
     where itemcd in (1309, 40050104, 40050106)
       and brchcd = i_col
     group by brchcd;
    return n1;
  exception
    when no_data_found then
      n1 := 0;
    
      return n1;
    
  end loandecpre;
--------------------------------------------------------------------------------------------------------------------------------------
function turnbrchcd (i_col number) return varchar2 is
  n1 varchar2(100);
  begin
    select brchna into n1 from sungl.com_brch where brchcd = i_col;
    return n1;
      exception
    when no_data_found then
      n1 := 0;
return n1;
end turnbrchcd;
--------------------------------------------------------------------------------------------------------------------------------------------
end pkg_item_count_zcfz;
