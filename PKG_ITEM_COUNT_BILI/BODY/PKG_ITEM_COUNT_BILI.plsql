CREATE OR REPLACE PACKAGE BODY "SUNGL".PKG_ITEM_COUNT_BILI IS
---------------------------------------------------------------------------------------------------------------------------------------------------
/*
成本收入比

ITEM6601,ITEM6602
ITEM6011,ITEM6012,ITEM6021,6051其他业务收入+6071其他收益+6115资产处置损益,  ITEM6111,ITEM6101,ITEM6061
ITEM6411,ITEM6412,ITEM6421
(业务及管理费+其他业务支出)/
（利息收入-利息支出+金融机构往来收入-金融机构往来支出+手续费及佣金收入-手续费及佣金支出
+其他业务收入+其他收益+资产处置损益+投资收益+公允价值变动损益+汇兑损益）
//TODO:资本利润率还没做
*/

FUNCTION COSTINCO(I_COL NUMBER) RETURN NUMBER IS
  N1             NUMBER;
  MOLECULE       NUMBER;
  DENOMI         NUMBER;
  COUNT6051_6115 NUMBER;
BEGIN
  BEGIN
    SELECT SUM(ONLNBL)
      INTO COUNT6051_6115
      FROM DATA_RJ_BASE
     WHERE ITEMCD IN (6051, 6071, 6115)
       AND BRCHCD = I_COL
     GROUP BY BRCHCD;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      COUNT6051_6115 := 0;
  END;
  BEGIN
    MOLECULE := SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6601(I_COL) +
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6602(I_COL);
                
    DENOMI   := SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6011(I_COL) +
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6012(I_COL) +
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6021(I_COL) + 
                COUNT6051_6115 +
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6111(I_COL) +
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6101(I_COL) +
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6061(I_COL) -
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6411(I_COL) -
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6412(I_COL) -
                SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6421(I_COL);
  
    N1 := MOLECULE / DENOMI;
  
    RETURN N1;
  END;
  END COSTINCO;
-----------------------------------------------------------------------------------------------------
END PKG_ITEM_COUNT_BILI;
