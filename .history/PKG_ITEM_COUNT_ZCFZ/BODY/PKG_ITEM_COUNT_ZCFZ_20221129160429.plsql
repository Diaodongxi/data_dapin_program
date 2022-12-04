CREATE OR REPLACE PACKAGE BODY "SUNGL".PKG_ITEM_COUNT_ZCFZ IS
----------------------------------------------------------------------------------------------------------------------------------------
/*
存款总额
2014 保证金存款+2001单位活期存款+2011应解汇款+2006财政性存款+
2002单位定期存款+2052国库定期存款+2005银行卡存款+2003个人活期存款+
2004个人定期存款+2083大额存单+2012汇出汇款+2013开出本票+201702境内非银行同业存放款项+
201703境外同业存放款项+202302银行业非存款类金融机构同业存单+202303非银行业金融机构同业存单+2084结构性存款
*/
  FUNCTION TOTALDEP(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (2014,
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
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END TOTALDEP;
----------------------------------------------------------------------------------------------------------------------------------------
  --资产总额相关科目计算100303-2007

  /*MAX((100303-2007,0)
  MAX(3101+3201+3202,0)
  MAX((1005-2016),0)
  MAX((1311+1321-132104-2312-2313-2314+231410),0)
  MAX((132104-231410),0)
  MAX((3001+3002),0)
  MAX(3051,0)
  MAX(3301,0)
  MAX((101105-201704),0)*/

  FUNCTION ITEM100303_2007(I_COL NUMBER) RETURN NUMBER IS
    ITEM100303 NUMBER;
    ITEM2007   NUMBER;
    N1         NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM100303
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (100303)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM100303 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM2007
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (2007)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM2007 := 0;
      
    END;
    N1 := ITEM100303 - ITEM2007;
    RETURN N1;
  END ITEM100303_2007;

  --资产总额相关科目计算3101+3201+3202
  FUNCTION ITEM3101_3202(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (3101, 3201, 3202)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM3101_3202;

  --资产总额相关科目计算1005-2016
  FUNCTION ITEM1005_2016(I_COL NUMBER) RETURN NUMBER IS
    ITEM1005 NUMBER;
    ITEM2016 NUMBER;
    N1       NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM1005
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (1005)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM1005 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM2016
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (2016)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM2016 := 0;
      
    END;
    N1 := ITEM1005 - ITEM2016;
    RETURN N1;
  END ITEM1005_2016;

  --资产总额相关科目计算1311+1321-132104-2312-2313-2314+231410
  FUNCTION ITEM1311_231410(I_COL NUMBER) RETURN NUMBER IS
    ITEM1311_231410 NUMBER;
    ITEM132104_2314 NUMBER;
    N1              NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM1311_231410
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (1311, 1321, 231410)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM1311_231410 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM132104_2314
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (132104, 2312, 2313, 2314)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM132104_2314 := 0;
      
    END;
    N1 := ITEM1311_231410 - ITEM132104_2314;
    RETURN N1;
  END ITEM1311_231410;

  --资产总额相关科目计算MAX((132104-231410),0)
  FUNCTION ITEM132104_231410(I_COL NUMBER) RETURN NUMBER IS
    ITEM132104 NUMBER;
    ITEM231410 NUMBER;
    N1         NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM132104
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (132104)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM132104 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM231410
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (231410)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM231410 := 0;
      
    END;
    N1 := ITEM132104 - ITEM231410;
    RETURN N1;
  END ITEM132104_231410;

  --资产总额相关科目计算3001+3002
  FUNCTION ITEM3001_3002(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (3001, 3002)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM3001_3002;

  --资产总额相关科目计算3051+3301
  FUNCTION ITEM3051(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (3051)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM3051;

  --资产总额相关科目计算3301
  FUNCTION ITEM3301(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (3301)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM3301;

  --资产总额相关科目计算101105-201704

  FUNCTION ITEM101105_201704(I_COL NUMBER) RETURN NUMBER IS
    ITEM101105 NUMBER;
    ITEM201704 NUMBER;
    N1         NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM101105
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (101105)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM101105 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM201704
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (201704)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM201704 := 0;
      
    END;
    N1 := ITEM101105 - ITEM201704;
    RETURN N1;
  END ITEM101105_201704;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /*
  资产总额（各行社）
  1001现金+1002业务周转金+100301准备金存款+100302存放中央银行特种存款+MAX((100303缴存中央银行财政性存款-2007待结算财政款项,0)+
  11320102应计存放央行利息+1011存放同业款项-101105专项风险互助金+1012存放系统内款项+1031存出保证金-123105存放同业坏账准备-1032存出保证金减值准备+
  11320103应计存放同业款项利息+11320104应计存放系统内款项利息+1431贵金属+
  1013拆放同业款项-101302拆放非存款类金融机构资金-101303拆放境外同业资金-123106拆放同业坏账准备+1014拆放系统内款项+11320105应计拆出资金利息+
  MAX(3101衍生工具+3201套期工具+3202被套期项目,0)+1111买入返售金融资产-1112买入返售金融资产减值准备+11320106应计买入返售资产利息+
  1481持有待售资产-1482持有待售资产减值准备+1301农户贷款+1304非农贷款+1302农村经济组织贷款+1303农村企业贷款+1305贷记卡透支+1307贸易融资+1308垫款+
  101302拆放非存款类金融机构资金+101303拆放境外同业资金+(1306贴现资产-2022再贴现负债-2021转贴现负债-1309贷款损失准备)+1101交易性金融资产+
  1132020201应收未收交易性金融资产利息+1501债权投资-1502债权投资减值准备+1132020202应收未收债权投资利息+1503其他债权投资+1132020203应收未收其他债权投资利息+
  1505其他权益工具投资+1511长期股权投资-1512长期股权投资减值准备+1521投资性房地产-1522投资性房地产累计折旧(摊销)-1523投资性房地产减值准备+
  1601固定资产-1602累计折旧-1603固定资产减值准备+1604在建工程-1605在建工程减值准备+1607使用权资产-1608使用权资产累计折旧-1609使用权资产减值准备+
  1701无形资产-1702无形资产累计摊销-1703无形资产减值准备+1801长期待摊费用+1441抵债资产-1442抵债资产减值准备+1811递延所得税资产+
  MAX((1005央行专项扶持资金-2016央行拨付专项票据资金),0)+1124应收手续费及佣金+1131应收股利+1221其他应收款+1606固定资产清理+1711商誉+1721研发支出+
  1901待处理财产损溢-123101应收手续费收入及佣金坏账准备-123103应收股利坏账准备-123104其他应收款坏账准备-123199其他应收款坏账准备-1712商誉减值准备+
  MAX((1311代理兑付证券+1321代理业务资产-132104自营理财资产-2312代理承销证券款-2313代理承销证券款-2314代理业务负债+231410自营理财负债),0)+
  MAX((132104自营理财资产-231410自营理财负债),0)+MAX((3001清算资金往来+3002社内往来),0)+MAX(3051外汇营运资金,0)+MAX(3301外汇买卖,0)+
  11320201应收未收贷款利息+11320199应计其他利息+11320299应收未收其他利息-123102应收利息坏账准备+MAX((101105专项风险互助金-201704存入专项风险互助资金),0)
  */
  FUNCTION TOTALASSETS(I_COL NUMBER) RETURN NUMBER IS
    N1     NUMBER;
    ADDSUM NUMBER;
    NEGSUM NUMBER;
    NUM1   NUMBER;
    NUM2   NUMBER;
    NUM3   NUMBER;
    NUM4   NUMBER;
    NUM5   NUMBER;
    NUM6   NUMBER;
    NUM7   NUMBER;
    NUM8   NUMBER;
    NUM9   NUMBER;

  BEGIN
    IF I_COL = 910000000 THEN
      N1 := 0;
      RETURN N1;
    ELSE
      BEGIN
        SELECT SUM(ONLNBL)
          INTO ADDSUM
          FROM DATA_RJ_BASE
         WHERE ITEMCD IN (1001,
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
           AND BRCHCD = I_COL
         GROUP BY BRCHCD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          ADDSUM := 0;
      END;
      BEGIN
        SELECT SUM(ONLNBL)
          INTO NEGSUM
          FROM DATA_RJ_BASE
         WHERE ITEMCD IN (123102,
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
           AND BRCHCD = I_COL
         GROUP BY BRCHCD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NEGSUM := 0;
        
      END;
    
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM100303_2007(I_COL), 0)
        INTO NUM1
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3101_3202(I_COL), 0)
        INTO NUM2
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM1005_2016(I_COL), 0)
        INTO NUM3
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM1311_231410(I_COL), 0)
        INTO NUM4
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM132104_231410(I_COL), 0)
        INTO NUM5
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3001_3002(I_COL), 0)
        INTO NUM6
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3051(I_COL), 0)
        INTO NUM7
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3301(I_COL), 0)
        INTO NUM8
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM101105_201704(I_COL), 0)
        INTO NUM9
        FROM DUAL;
      N1 := ADDSUM - NEGSUM + NUM1 + NUM2 + NUM3 + NUM4 + NUM5 + NUM6 + NUM7 + NUM8 + NUM9;
      RETURN N1;
    END IF;
  END TOTALASSETS;
-------------------------------------------------------------------------------------------------------------------------------------------
  --资产总额（省联社）,公式同各行社的计算公式
  FUNCTION TOTALASSETS2(I_COL NUMBER) RETURN NUMBER IS
    N1     NUMBER;
    ADDSUM NUMBER;
    NEGSUM NUMBER;
    NUM1   NUMBER;
    NUM2   NUMBER;
    NUM3   NUMBER;
    NUM4   NUMBER;
    NUM5   NUMBER;
    NUM6   NUMBER;
    NUM7   NUMBER;
    NUM8   NUMBER;
    NUM9   NUMBER;

  BEGIN
    IF I_COL != 910000000 THEN
      N1 := 0;
      RETURN N1;
    ELSE
      BEGIN
        SELECT SUM(ONLNBL)
          INTO ADDSUM
          FROM DATA_RJ_BASE
         WHERE ITEMCD IN (1001,
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
           AND BRCHCD = I_COL
         GROUP BY BRCHCD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          ADDSUM := 0;
      END;
      BEGIN
        SELECT SUM(ONLNBL)
          INTO NEGSUM
          FROM DATA_RJ_BASE
         WHERE ITEMCD IN (123102,
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
           AND BRCHCD = I_COL
         GROUP BY BRCHCD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NEGSUM := 0;
        
      END;
    
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM100303_2007(I_COL), 0)
        INTO NUM1
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3101_3202(I_COL), 0)
        INTO NUM2
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM1005_2016(I_COL), 0)
        INTO NUM3
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM1311_231410(I_COL), 0)
        INTO NUM4
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM132104_231410(I_COL), 0)
        INTO NUM5
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3001_3002(I_COL), 0)
        INTO NUM6
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3051(I_COL), 0)
        INTO NUM7
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM3301(I_COL), 0)
        INTO NUM8
        FROM DUAL;
      SELECT GREATEST(SUNGL.PKG_ITEM_COUNT_ZCFZ.ITEM101105_201704(I_COL), 0)
        INTO NUM9
        FROM DUAL;
      N1 := ADDSUM - NEGSUM + NUM1 + NUM2 + NUM3 + NUM4 + NUM5 + NUM6 + NUM7 + NUM8 + NUM9;
      RETURN N1;
    END IF;
  END TOTALASSETS2;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
贷款总额 ：本次用的还是旧的科目公式计算，新的科目拆分后需要修改
1301农户贷款+1302农村经济组织贷款+1303农村企业贷款+1304非农贷款+1305贷记卡透支+
1307贸易融资+1308垫款+101302拆放非存款类金融机构资金+101303拆放境外同业资金+（1306贴现资产-2022再贴现负债-2021转贴现负债)
*/

  FUNCTION TOTALLOANS(I_COL NUMBER) RETURN NUMBER IS
    ITEM1301_1306 NUMBER;
    ITEM2021_2022 NUMBER;
    N1            NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM1301_1306
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (1301,
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
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM1301_1306 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM2021_2022
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (2022, 2021)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM2021_2022 := 0;
      
    END;
    N1 := ITEM1301_1306 - ITEM2021_2022;
    RETURN N1;
  END TOTALLOANS;
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
  FUNCTION OWNSEQUITY(I_COL NUMBER) RETURN NUMBER IS
    ITEM4001_33010899 NUMBER;
    ITEM4004_3099     NUMBER;
    N1                NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM4001_33010899
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (4001,
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
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM4001_33010899 := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM4004_3099
        FROM DATA_RJ_BASE
       WHERE ITEMCD IN (4004,
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
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM4004_3099 := 0;
      
    END;
    N1 := ITEM4001_33010899 - ITEM4004_3099;
    RETURN N1;
  END OWNSEQUITY;
--------------------------------------------------------------------------------------------------------------------------------------
  --贷款减值准备 1309 贷款损失准备+40050104 福费廷减值准备+40050106贴现资产减值准备
  FUNCTION LOANDECPRE(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (1309, 40050104, 40050106)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END LOANDECPRE;
--------------------------------------------------------------------------------------------------------------------------------------
function turnbrchcd (i_col number) return varchar2 is
  n1 varchar2(100);
  begin
    select brchna into n1 from com_brch where brchcd = i_col;
    return n1;
      EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
return n1;
end turnbrchcd;
--------------------------------------------------------------------------------------------------------------------------------------------
END PKG_ITEM_COUNT_ZCFZ;
