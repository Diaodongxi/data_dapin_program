CREATE OR REPLACE PROCEDURE PROCESS IS

FILE_NAME VARCHAR2(255);
INSERT_INTO VARCHAR2(500);
BEGIN
/**
 * @description: 清理数据
 */

INSERT_INTO :='INSERT INTO GLA_GLIS_H_T02
    SELECT *
      FROM GLA_GLIS_H_TS T'||'
     WHERE T.STACID = ''1'''||'
       AND T.SYSTID != ''99'''||'
       AND T.ACCTDT = ''20221101'''||'
       AND T.CRCYCD IN (''AUD'', ''CAD'', ''CNY'', ''EUR'', ''GBP'', ''HKD'', ''JPY'', ''USD'')'||'
       AND T.GELDTP = ''D'''||'
       AND T.DETLTG = ''1''' ;
 
EXECUTE IMMEDIATE 'TRUNCATE TABLE SUNGL.GLA_GLIS_H_T02';
EXECUTE IMMEDIATE 'TRUNCATE TABLE SUNGL.GLA_GLIS_COUNT';
EXECUTE IMMEDIATE 'TRUNCATE TABLE SUNGL.DATA_RJ_BASE';
EXECUTE IMMEDIATE 'TRUNCATE TABLE SUNGL.DATA_DAPIN_RESLT';
EXECUTE IMMEDIATE INSERT_INTO;
COMMIT;

/**
 * @description: 获取日期
 */

FILE_NAME := 'uacp_DAPIN_DATA_'||TO_CHAR(SYSDATE,'YYYYMMDD')||'.csv';

/**
 * @description: 汇总计税折算
 */

--价税分离
SUNGL.PKG_ITEM_COUNT_FAC.TAX_COUNT();
--科目机构汇总
SUNGL.PKG_ITEM_COUNT_FAC.COUNT_BRCH_ITEM();
--折算
SUNGL.PKG_ITEM_COUNT_FAC.CONVERT_TO_RMB();
--币种来源汇总
SUNGL.PKG_ITEM_COUNT_FAC.COUNT_CRC_SYS();

/**
 * @description: 指标加工
 */

--加工指标
SUNGL.PKG_ITEM_COUNT_FAC.INSERT_DATA_DAPIN_RESULT();

/**
 * @description: 卸数
 */

--将结果表生成CSV文件放在服务器对应目录，OUT_PATH路径需要预先设置！
SUNGL.PKG_ITEM_COUNT_FAC.SQL_TO_CSV('SELECT * FROM DATA_DAPIN_RESLT','OUT_PATH',FILE_NAME);
--将数据文件通过FTP传输给下游
SUNGL.PKG_ITEM_COUNT_FAC.FTP_TO_DAPIN();

END PROCESS;
