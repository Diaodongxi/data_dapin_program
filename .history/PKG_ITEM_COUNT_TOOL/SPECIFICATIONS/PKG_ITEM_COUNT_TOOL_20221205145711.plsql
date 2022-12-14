CREATE OR REPLACE PACKAGE PKG_ITEM_COUNT_TOOL IS

  -- AUTHOR  : ZHOUMINGLE
  -- CREATED : 2022/11/23 18:01:43
  -- PURPOSE : 大屏数据年终展示-损益类数据加工包
  
  FUNCTION TOTALREV(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6011(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6012(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6021(I_COL NUMBER) RETURN NUMBER;
  FUNCTION OTHERREV(I_COL NUMBER) RETURN NUMBER;
  FUNCTION TOTALEXP(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6411(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6412(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6421(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6601(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM660101(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM66010501(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM660130(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6602(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6711(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6403(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6061(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6101(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6111(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6701(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6702(I_COL NUMBER) RETURN NUMBER;
  FUNCTION TOTALPROF(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6801(I_COL NUMBER) RETURN NUMBER;
  FUNCTION NETPROF(I_COL NUMBER) RETURN NUMBER;
  FUNCTION ITEM6301(I_COL NUMBER) RETURN NUMBER;
  
END PKG_ITEM_COUNT_TOOL;
