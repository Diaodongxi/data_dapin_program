CREATE OR REPLACE PACKAGE BODY "SUNGL".PKG_ITEM_COUNT_TOOL IS
----------------------------------------------------------------------------------------------------------------------------------------
  /*
  总收入
  6011利息收入+6012金融机构往来收入+6021手续费及佣金收入+
  6051其他业务收入+6071其他收益+6115资产处置损益+6301营业外收入+
  6061汇兑损益+6101公允价值变动损益+6111投资收益
  */
  FUNCTION TOTALREV(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN
           (6011, 6012, 6021, 6051, 6071, 6115, 6301, 6061, 6101, 6111)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END TOTALREV;
----------------------------------------------------------------------------------------------------------------------------------------
  --利息收入
  --6011利息收入-601110债权投资利息收入-601111其他债权投资利息收入
  FUNCTION ITEM6011(I_COL NUMBER) RETURN NUMBER IS
    ITEM6011C         NUMBER;
    ITEM601110_601111 NUMBER;
    N1                NUMBER;
  BEGIN
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM6011C
        FROM SUNGL.DATA_RJ_BASE
       WHERE ITEMCD IN (6011)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM6011C := 0;
    END;
    BEGIN
      SELECT SUM(ONLNBL)
        INTO ITEM601110_601111
        FROM SUNGL.DATA_RJ_BASE
       WHERE ITEMCD IN (601110, 601111)
         AND BRCHCD = I_COL
       GROUP BY BRCHCD;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ITEM601110_601111 := 0;
      
    END;
    N1 := ITEM6011C - ITEM601110_601111;
    RETURN N1;
  END ITEM6011;
----------------------------------------------------------------------------------------------------------------------------------------
  --6012金融机构往来收入
  FUNCTION ITEM6012(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6012)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6012;
----------------------------------------------------------------------------------------------------------------------------------------
  --6021手续费及佣金收入
  FUNCTION ITEM6021(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6021)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6021;
----------------------------------------------------------------------------------------------------------------------------------------
  /*
  其他收入
  6051其他业务收入+6071其他收益+6115资产处置损益+6301营业外收入
  */
  FUNCTION OTHERREV(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6051, 6071, 6115, 6301)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END OTHERREV;
----------------------------------------------------------------------------------------------------------------------------------------
  /*
  总支出
  6411利息支出+6412金融机构往来支出+6421手续费及佣金支出+6601业务及管理费+
  6602其他业务支出+6711营业外支出+6403税金及附加+6701资产减值损失+6702信用减值损失+6801所得税费用
  */
  FUNCTION TOTALEXP(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN
           (6411, 6412, 6421, 6601, 6602, 6711, 6403, 6701, 6702, 6801)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END TOTALEXP;
----------------------------------------------------------------------------------------------------------------------------------------
  --6411利息支出
  FUNCTION ITEM6411(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6411)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6411;
----------------------------------------------------------------------------------------------------------------------------------------
  --6412金融机构往来支出
  FUNCTION ITEM6412(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6412)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6412;
----------------------------------------------------------------------------------------------------------------------------------------
  --6421 手续费以及佣金支出
  FUNCTION ITEM6421(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6421)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6421;
----------------------------------------------------------------------------------------------------------------------------------------
  --6601业务管理费
  FUNCTION ITEM6601(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6601)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6601;
----------------------------------------------------------------------------------------------------------------------------------------
  --660101职工薪酬
  FUNCTION ITEM660101(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (660101)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM660101;

  --66010501电子运行费
  FUNCTION ITEM66010501(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (66010501)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM66010501;
----------------------------------------------------------------------------------------------------------------------------------------
  --660130 服务费
  FUNCTION ITEM660130(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (660130)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM660130;
----------------------------------------------------------------------------------------------------------------------------------------
  --6602其他业务支出
  FUNCTION ITEM6602(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6602)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6602;
----------------------------------------------------------------------------------------------------------------------------------------
  --6711营业外支出
  FUNCTION ITEM6711(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6711)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6711;
----------------------------------------------------------------------------------------------------------------------------------------
  --6403税金及附加
  FUNCTION ITEM6403(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6403)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6403;
----------------------------------------------------------------------------------------------------------------------------------------
  --6061汇兑损益
  FUNCTION ITEM6061(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6061)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6061;
----------------------------------------------------------------------------------------------------------------------------------------
  --6101公允价值变动损益
  FUNCTION ITEM6101(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6101)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6101;
----------------------------------------------------------------------------------------------------------------------------------------
  --投资收益 6111投资收益+601110债权投资利息收入+601111其他债权投资利息收入
  FUNCTION ITEM6111(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6111, 601110, 601111)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6111;
----------------------------------------------------------------------------------------------------------------------------------------
  --6701资产减值损失
  FUNCTION ITEM6701(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6701)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6701;
----------------------------------------------------------------------------------------------------------------------------------------
  --6702信用减值损失
  FUNCTION ITEM6702(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6702)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6702;
----------------------------------------------------------------------------------------------------------------------------------------
  --利润总额 总收入-总支出+6801所得税费用
  FUNCTION TOTALPROF(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
    SUODESHUI NUMBER;
  
    ZONGSR NUMBER;
  
    ZONGZC NUMBER;
  
  BEGIN
    SELECT SUNGL.PKG_ITEM_COUNT_TOOL.TOTALREV(I_COL) INTO ZONGSR FROM DUAL;
  
    SELECT SUNGL.PKG_ITEM_COUNT_TOOL.TOTALEXP(I_COL) INTO ZONGZC FROM DUAL;
  
    SELECT SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6801(I_COL)
      INTO SUODESHUI
      FROM DUAL;
  
    N1 := ZONGSR - ZONGZC + SUODESHUI;
  
    RETURN N1;
  
  END TOTALPROF;
----------------------------------------------------------------------------------------------------------------------------------------
  --所得税费用6801
  FUNCTION ITEM6801(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6801)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6801;
----------------------------------------------------------------------------------------------------------------------------------------
  --净利润 总收入-总支出
  FUNCTION NETPROF(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
    ZONGSR NUMBER;
  
    ZONGZC NUMBER;
  
  BEGIN
    SELECT SUNGL.PKG_ITEM_COUNT_TOOL.TOTALREV(I_COL) INTO ZONGSR FROM DUAL;
  
    SELECT SUNGL.PKG_ITEM_COUNT_TOOL.TOTALEXP(I_COL) INTO ZONGZC FROM DUAL;
  
    N1 := ZONGSR - ZONGZC;
  
    RETURN N1;
  
  END NETPROF;
----------------------------------------------------------------------------------------------------------------------------------------
  --6301营业外收入
  FUNCTION ITEM6301(I_COL NUMBER) RETURN NUMBER IS
    N1 NUMBER;
  
  BEGIN
    SELECT SUM(ONLNBL)
      INTO N1
      FROM SUNGL.DATA_RJ_BASE
     WHERE ITEMCD IN (6301)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
    RETURN N1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      N1 := 0;
    
      RETURN N1;
    
  END ITEM6301;
 -------------------------------------------------------------------------------------------------------------------------------------------
END PKG_ITEM_COUNT_TOOL;
