CREATE OR REPLACE PACKAGE BODY "SUNGL".PKG_ITEM_COUNT_PROCESS IS
  ---------------------------------------------------------------------------------------------------------
  /*PROCEDURE INSERT_DATA_RJ_BASE IS
  BEGIN
    INSERT INTO DATA_RJ_BASE
      (SYSTID,
       ACCTDT,
       BRCHCD,
       ITEMCD,
       CRCYCD,
       DRTSAM,
       CRTSAM,
       DRCTBL,
       CRCTBL,
       BLNCDN,
       ONLNBL)
      SELECT T.SYSTID,
             T.ACCTDT,
             T.BRCHCD,
             T.ITEMCD,
             T.CRCYCD,
             T.DRTSAM,
             T.CRTSAM,
             T.DRCTBL,
             T.CRCTBL,
             T.BLNCDN,
             T.ONLNBL
        FROM GLA_GLIS_H_TS T
       WHERE T.ACCTDT = '20221101'
         AND T.STACID = 1
         AND T.CRCYCD = 'CCC'
            --AND T.CRCYCD IN (SELECT C.CRCYCD FROM COM_CRCY C WHERE C.ISFOLD = 0)
         AND T.SYSTID = 99
         AND T.GELDTP = 'D'
         AND T.BRCHCD IN (901070000,
                          901080000,
                          901090000,
                          903060000,
                          903070000,
                          904020000,
                          904060000,
                          905030000,
                          905090000,
                          908050000,
                          909020000,
                          901020000,
                          901040000,
                          901060000,
                          906100000,
                          908040000,
                          908070000,
                          909060000,
                          901100000,
                          903020000,
                          905100000,
                          906030000,
                          908020000,
                          908030000,
                          909030000,
                          903050000,
                          903090000,
                          906080000,
                          908090000,
                          908110000,
                          909040000,
                          901030000,
                          903040000,
                          903110000,
                          903120000,
                          905020000,
                          905110000,
                          906070000,
                          907100000,
                          908060000,
                          909080000,
                          902010000,
                          905050000,
                          905070000,
                          905080000,
                          906020000,
                          906060000,
                          907030000,
                          910000000,
                          901050000,
                          903030000,
                          903100000,
                          905040000,
                          905060000,
                          906040000,
                          906050000,
                          907070000,
                          907110000,
                          909050000,
                          909070000,
                          903080000,
                          906090000,
                          907020000,
                          907040000,
                          907060000,
                          907090000,
                          908080000,
                          908100000)
         AND T.ITEMCD IN (SELECT I.ITEMCD
                            FROM COM_ITEM I
                           WHERE I.STACID = 1
                                --AND I.DETLTG = 1
                             AND I.ITEMCD IN (6011,
                                              6012,
                                              6021,
                                              6051,
                                              6071,
                                              6115,
                                              6301,
                                              6061,
                                              6101,
                                              6111,
                                              6411,
                                              6412,
                                              6421,
                                              6601,
                                              6602,
                                              6711,
                                              6403,
                                              6701,
                                              6702,
                                              6801,
                                              2014,
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
                                              2084,
                                              1001,
                                              1002,
                                              100301,
                                              100302,
                                              100303,
                                              2007,
                                              11320102,
                                              1011,
                                              101105,
                                              1012,
                                              1031,
                                              123105,
                                              1032,
                                              11320103,
                                              11320104,
                                              1431,
                                              1013,
                                              101302,
                                              101303,
                                              123106,
                                              1014,
                                              11320105,
                                              3101,
                                              3201,
                                              3202,
                                              1111,
                                              1112,
                                              11320106,
                                              1481,
                                              1482,
                                              1301,
                                              1304,
                                              1302,
                                              1303,
                                              1305,
                                              1307,
                                              8888,
                                              1308,
                                              1306,
                                              2022,
                                              2021,
                                              1309,
                                              1101,
                                              1132020201,
                                              1501,
                                              1502,
                                              1132020202,
                                              1503,
                                              1132020203,
                                              1505,
                                              1511,
                                              1512,
                                              1521,
                                              1522,
                                              1523,
                                              1601,
                                              1602,
                                              1603,
                                              1604,
                                              1605,
                                              1607,
                                              1608,
                                              1609,
                                              1701,
                                              1702,
                                              1703,
                                              1801,
                                              1441,
                                              1442,
                                              1811,
                                              1005,
                                              2016,
                                              1124,
                                              1131,
                                              1221,
                                              1606,
                                              1711,
                                              1721,
                                              1901,
                                              123101,
                                              123103,
                                              123104,
                                              123199,
                                              1712,
                                              1311,
                                              1321,
                                              132104,
                                              2312,
                                              2313,
                                              2314,
                                              231410,
                                              3001,
                                              3002,
                                              3051,
                                              3301,
                                              11320201,
                                              11320199,
                                              11320299,
                                              123102,
                                              201704,
                                              13070101,
                                              13060101,
                                              13060201,
                                              13060102,
                                              13060202,
                                              4001,
                                              4002,
                                              4003,
                                              4004,
                                              4005,
                                              4101,
                                              4102,
                                              4103,
                                              4104,
                                              6102,
                                              6901,
                                              330108,
                                              33010899,
                                              3099,
                                              40050104,
                                              40050106,
                                              660101,
                                              66010501,
                                              601110,
                                              601111,
                                              660130));
    COMMIT;
  END INSERT_DATA_RJ_BASE;*/
  --------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE INSERT_DATA_DAPIN_RESULT IS
    --机构循环取数，插入结果表
    I_COL NUMBER;
    TYPE NUM_LIST IS VARRAY(68) OF NUMBER;
    VAR_ARRAY NUM_LIST := NUM_LIST(901070000,
                                   901080000,
                                   901090000,
                                   903060000,
                                   903070000,
                                   904020000,
                                   904060000,
                                   905030000,
                                   905090000,
                                   908050000,
                                   909020000,
                                   901020000,
                                   901040000,
                                   901060000,
                                   906100000,
                                   908040000,
                                   908070000,
                                   909060000,
                                   901100000,
                                   903020000,
                                   905100000,
                                   906030000,
                                   908020000,
                                   908030000,
                                   909030000,
                                   903050000,
                                   903090000,
                                   906080000,
                                   908090000,
                                   908110000,
                                   909040000,
                                   901030000,
                                   903040000,
                                   903110000,
                                   903120000,
                                   905020000,
                                   905110000,
                                   906070000,
                                   907100000,
                                   908060000,
                                   909080000,
                                   902010000,
                                   905050000,
                                   905070000,
                                   905080000,
                                   906020000,
                                   906060000,
                                   907030000,
                                   910000000,
                                   901050000,
                                   903030000,
                                   903100000,
                                   905040000,
                                   905060000,
                                   906040000,
                                   906050000,
                                   907070000,
                                   907110000,
                                   909050000,
                                   909070000,
                                   903080000,
                                   906090000,
                                   907020000,
                                   907040000,
                                   907060000,
                                   907090000,
                                   908080000,
                                   908100000);
  BEGIN
  
    FOR I IN 1 .. VAR_ARRAY.COUNT LOOP
      I_COL := VAR_ARRAY(I);
      INSERT INTO SUNGL.DATA_DAPIN_RESLT
      VALUES
        (20221101,  --#FIXME:加上日期参数
         I_COL,
         sungl.pkg_item_count_zcfz.turnbrchcd(i_col),
         SUNGL.PKG_ITEM_COUNT_TOOL.TOTALREV(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6011(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6012(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6021(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.OTHERREV(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.TOTALEXP(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6411(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6412(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6421(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6601(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM660101(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM66010501(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM660130(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6602(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6711(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6403(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6061(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6101(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6111(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6701(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6702(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.TOTALPROF(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6801(I_COL),
         SUNGL.PKG_ITEM_COUNT_TOOL.NETPROF(I_COL),
         SUNGL.PKG_ITEM_COUNT_ZCFZ.TOTALDEP(I_COL),
         SUNGL.PKG_ITEM_COUNT_ZCFZ.TOTALASSETS(I_COL),
         SUNGL.PKG_ITEM_COUNT_ZCFZ.TOTALASSETS2(I_COL),
         SUNGL.PKG_ITEM_COUNT_ZCFZ.TOTALLOANS(I_COL),
         SUNGL.PKG_ITEM_COUNT_ZCFZ.OWNSEQUITY(I_COL),
         SUNGL.PKG_ITEM_COUNT_ZCFZ.LOANDECPRE(I_COL),
         0,
         0,
         0,
         0,
         --!成本收入比需要转换成百分比
         CONCAT(TO_CHAR(SUNGL.PKG_ITEM_COUNT_BILI.COSTINCO(I_COL) * 100,
                        'FM990.99'),
                '%'),
         0,
         SUNGL.PKG_ITEM_COUNT_TOOL.ITEM6301(I_COL));
    END LOOP;
    COMMIT;
  END INSERT_DATA_DAPIN_RESULT;
------------------------------------------------------------------------------------------------------------------------------------------
  --生成CSV文件
  PROCEDURE SQL_TO_CSV(P_QUERY    IN VARCHAR2, -- PLSQL文
                       P_DIR      IN VARCHAR2, -- 导出的文件放置目录
                       P_FILENAME IN VARCHAR2 -- CSV名
                       ) IS
    L_OUTPUT       UTL_FILE.FILE_TYPE;
    L_THECURSOR    INTEGER DEFAULT DBMS_SQL.OPEN_CURSOR;
    L_COLUMNVALUE  VARCHAR2(4000);
    L_STATUS       INTEGER;
    L_COLCNT       NUMBER := 0;
    L_SEPARATOR    VARCHAR2(1);
    L_DESCTBL      DBMS_SQL.DESC_TAB;
    P_MAX_LINESIZE NUMBER := 32000;
  BEGIN
    --OPEN FILE
    L_OUTPUT := UTL_FILE.FOPEN(P_DIR, P_FILENAME, 'W', P_MAX_LINESIZE);
    --DEFINE DATE FORMAT
    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_DATE_FORMAT=''YYYY-MM-DD HH24:MI:SS''';
    --OPEN CURSOR
    DBMS_SQL.PARSE(L_THECURSOR, P_QUERY, DBMS_SQL.NATIVE);
    DBMS_SQL.DESCRIBE_COLUMNS(L_THECURSOR, L_COLCNT, L_DESCTBL);
    --DUMP TABLE COLUMN NAME
    FOR I IN 1 .. L_COLCNT LOOP
      UTL_FILE.PUT(L_OUTPUT,
                   L_SEPARATOR || '' || L_DESCTBL(I).COL_NAME || ''); --输出表字段
      DBMS_SQL.DEFINE_COLUMN(L_THECURSOR, I, L_COLUMNVALUE, 4000);
      L_SEPARATOR := ',';
    END LOOP;
    UTL_FILE.NEW_LINE(L_OUTPUT); --输出表字段
    --EXECUTE THE QUERY STATEMENT
    L_STATUS := DBMS_SQL.EXECUTE(L_THECURSOR);
  
    --DUMP TABLE COLUMN VALUE
    WHILE (DBMS_SQL.FETCH_ROWS(L_THECURSOR) > 0) LOOP
      L_SEPARATOR := '';
      FOR I IN 1 .. L_COLCNT LOOP
        DBMS_SQL.COLUMN_VALUE(L_THECURSOR, I, L_COLUMNVALUE);
        UTL_FILE.PUT(L_OUTPUT,
                     L_SEPARATOR || '' ||
                     TRIM(BOTH ' ' FROM REPLACE(L_COLUMNVALUE, '"', '""')) || '');
        L_SEPARATOR := ',';
      END LOOP;
      UTL_FILE.NEW_LINE(L_OUTPUT);
    END LOOP;
    --CLOSE CURSOR
    DBMS_SQL.CLOSE_CURSOR(L_THECURSOR);
    --CLOSE FILE
    UTL_FILE.FCLOSE(L_OUTPUT);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END SQL_TO_CSV;
  ----------------------------------------------------------------------------------------------------------------------------------------------
  --通过FTP下载远程服务器文件下载到本地
  PROCEDURE FTP_TO_DAPIN IS
    L_CONN      UTL_TCP.CONNECTION; --定义一个连接类型
    R_FROM_FILE VARCHAR2(255);
    L_BLOB_LEN  INTEGER;
    P_REASON    VARCHAR2(2555) := NULL; --定义报错信息，默认为NULL
    V_RESULT    VARCHAR2(255) := 0; --定义结果信息
    V_SIGN      NUMBER(4) := 0; --定义结果状态，默认为0
  BEGIN
    --使用FTP.LOGIN方法创建连接，参数依次为IP/端口/用户名/密码 #TODO:生产上的地址记得配置
    L_CONN := SUNGL.FTP.LOGIN('192.111.29.94', '21', 'ftpusr', 'Ftp@123..');
    BEGIN
      --获取远程文件绝对路径
      --R_FROM_FILE := '/DATA/TOTAL/'||TO_CHAR(ADD_MONTHS(SYSDATE,-1),'YYYYMM')||'.AVL'; 
      --获取指定文件字节大小
      --L_BLOB_LEN := DBMS_LOB.GETLENGTH(FTP.GET_REMOTE_BINARY_DATA(L_CONN,R_FROM_FILE));
      --使用FTP.GET下载文件
      SUNGL.FTP.PUT(P_CONN      => L_CONN, --传入连接
                    P_FROM_DIR  => 'OUT_PATH', --件绝对路径
                    P_FROM_FILE => 'uacp_DAPIN_DATA_20221101.csv', ---传入ORACLE服务器的目录，需确保DBA_DIRECTORIES表下存在 
                    P_TO_FILE   => 'uacp_DAPIN_DATA_20221101.csv'); --生成的文件名 #FIXME:生成的文件加上日期参数
      --判断文件是否为空，如果为空返回失败
      IF L_BLOB_LEN = 0 THEN
        V_SIGN   := 1;
        V_RESULT := '失败';
      ELSE
        V_RESULT := '成功';
      END IF;
      --获取异常
    EXCEPTION
      WHEN OTHERS THEN
        --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE方法用于获取报错的行数，SQLERRM用于获取报错信息
        P_REASON := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || SQLERRM;
        V_SIGN   := 1;
        V_RESULT := '失败';
    END;
    FTP.LOGOUT(L_CONN); --关闭FPT连接
    UTL_TCP.CLOSE_ALL_CONNECTIONS; --关闭TCP连接
    --INSERT INTO GSC_TEST VALUES(V_SIGN, V_RESULT || '，数据大小为：' ||L_BLOB_LEN, P_REASON);
    --COMMIT;
  END FTP_TO_DAPIN;

END PKG_ITEM_COUNT_PROCESS;
