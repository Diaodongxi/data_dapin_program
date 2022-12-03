/**
 * @description: 根据汇率进行折算，更新GLA_GLIS_COUNT的余额为本位币余额
 */

 
CREATE OR REPLACE PROCEDURE CONVERT_TO_RMB IS
    NEW_DATE VARCHAR(10);
BEGIN
 /* 3开头的往来类科目双向都可能有余额,需要统一方向
 会计核算默认这类科目在借方，因此贷方余额统一转向  */
    UPDATE SUNGL.GLA_GLIS_COUNT T
    SET
        T.ONLNBL = T.ONLNBL * (
            -1
        )
    WHERE
        T.BLNCDN = 'C'
        AND T.ITEMCD IN (
            3001,
            3002,
            3051,
            3099,
            3101,
            3201,
            3202,
            3301,
            330108,
            33010899
        );
    COMMIT;
---------------------------------------------------***-------------------------------------------------    
 -- 关联汇率表，排序后取第一个值作为最新日期
    SELECT
        TEMP1.EFCTDT INTO NEW_DATE
    FROM
        (
            SELECT
                DISTINCT (T.EFCTDT)
            FROM
                SUNGL.COM_EXRT T
            ORDER BY
                T.EFCTDT DESC
        ) TEMP1
    WHERE
        ROWNUM = 1;
 ------------------------------------***资产负债类折算开始***-------------------------------------------

 /* 资产负债类的科目，通过余额折算的方式完成，即当前余额 * 汇率
或者通过 （上期余额 + 发生额） * 汇率均可 */
 --资产负债类方向是贷方的科目加工
    UPDATE SUNGL.GLA_GLIS_COUNT C
    SET
        C.ONLNBL = (
            C.LASTBL + C.CRTSAM -C.DRTSAM
        ) * (
 --传入 NEW_DATE,通过币种关联查询对应汇率
            SELECT E.MIDDPR FROM SUNGL.COM_EXRT E WHERE E.EFCTDT = NEW_DATE AND E.CRCYCD = C.CRCYCD
        )
    WHERE
        C.ITEMCD IN (
            1112,
            1512,
            1522,
            1523,
            1602,
            1603,
            1605,
            1608,
            1609,
            1702,
            1703,
            1712,
            123101,
            123102,
            123103,
            123104,
            123105,
            123106,
            123199,
            1309,
            1442,
            1482,
            1502,
            1032,
            2021,
            2022,
            2052,
            2083,
            2084,
            2312,
            2313,
            2314,
            231410,
            2001,
            2002,
            2003,
            2004,
            2005,
            2006,
            2007,
            2011,
            2012,
            2013,
            2014,
            2016,
            201702,
            201703,
            201704,
            202302,
            202303,
            4001,
            4002,
            4003,
            40050104,
            40050106,
            4101,
            4102,
            4103,
            4104
        );
    COMMIT;
 --资产负债类方向是借方的科目加工
    UPDATE SUNGL.GLA_GLIS_COUNT C
    SET
        C.ONLNBL = (
            C.LASTBL + C.DRTSAM -C.CRTSAM
        ) * (
            SELECT E.MIDDPR FROM SUNGL.COM_EXRT E WHERE E.EFCTDT = NEW_DATE AND E.CRCYCD = C.CRCYCD
        )
    WHERE
        C.ITEMCD IN (
            1111,
            1124,
            1131,
            11320102,
            11320103,
            11320104,
            11320105,
            11320106,
            11320199,
            11320201,
            1132020201,
            1132020202,
            1132020203,
            11320299,
            1221,
            1521,
            1601,
            1604,
            1606,
            1607,
            1701,
            1711,
            1721,
            1301,
            1302,
            1303,
            1304,
            8888,
            1305,
            1306,
            13060101,
            13060102,
            13060201,
            13060202,
            1307,
            1308,
            1311,
            1321,
            132104,
            1431,
            1441,
            1481,
            1501,
            1503,
            1505,
            1511,
            1001,
            1002,
            100301,
            100302,
            100303,
            1005,
            1011,
            101105,
            1012,
            1013,
            101302,
            101303,
            1014,
            1031,
            1101,
            1801,
            1811,
            1901,
            4004,
            13070101
        );
    COMMIT;
 --资产负债类方向是双向的科目加工
    UPDATE SUNGL.GLA_GLIS_COUNT C
    SET
        C.ONLNBL = C.ONLNBL * (
            SELECT E.MIDDPR FROM SUNGL.COM_EXRT E WHERE E.EFCTDT = NEW_DATE AND E.CRCYCD = C.CRCYCD
        )
    WHERE
        C.ITEMCD IN (
            3001,
            3002,
            3051,
            3099,
            3101,
            3201,
            3202,
            3301,
            330108,
            33010899
        );
    COMMIT;
 -----------------------------------------***资产负债类折算完毕***-------------------------------------------------------------
 -------------------------------------------***损益类折算开始***---------------------------------------------------------------
 --损益类的折算，通过 上期期末本位币余额 + 发生额 * 汇率 得到余额
 --损益类贷方科目数据加工
    UPDATE SUNGL.GLA_GLIS_COUNT C
    SET
        C.ONLNBL = (
            C.CLFLCBL - C.DLFLCBL
        ) + (
            C.CRTSAM -C.DRTSAM
        ) * (
            SELECT E.MIDDPR FROM SUNGL.COM_EXRT E WHERE E.EFCTDT = NEW_DATE AND E.CRCYCD = C.CRCYCD
        )
    WHERE
        C.ITEMCD IN (
            6011,
            601110,
            601111,
            6012,
            6021,
            6051,
            6061,
            6071,
            6101,
            6111,
            6115,
            4005,
            6301
        );
    COMMIT;
 --损益类借方科目数据加工
    UPDATE SUNGL.GLA_GLIS_COUNT C
    SET
        C.ONLNBL = (
            C.DLFLCBL - C.CLFLCBL
        ) + (
            C.DRTSAM -C.CRTSAM
        ) * (
            SELECT E.MIDDPR FROM SUNGL.COM_EXRT E WHERE E.EFCTDT = NEW_DATE AND E.CRCYCD = C.CRCYCD
        )
    WHERE
        C.ITEMCD IN (
            6421,
            6601,
            660101,
            66010501,
            6411,
            6412,
            660130,
            6602,
            6403,
            6701,
            6702,
            6711,
            6801,
            6901
        );
    COMMIT;
 -------------------------------------------***损益类折算结束***---------------------------------------------------------------

 /*--轧差科目的计算公式
    UPDATE GLA_GLIS_COUNT C
    SET
        C.ONLNBL = GREATEST(C.DLFLCBL,C.CLFLCBL)-LEAST(C.DLFLCBL,C.CLFLCBL) + (
            GREATEST(C.DRTSAM, C.CRTSAM) - LEAST(C.DRTSAM, C.CRTSAM)
        ) * (
            SELECT E.MIDDPR FROM COM_EXRT E WHERE E.EFCTDT = NEW_DATE AND E.CRCYCD = C.CRCYCD
        )
    WHERE
        C.ROOT_ID IN (
            3001,
            3002,
            3051,
            3099,
            3101,
            3201,
            3202,
            3301,
            330108,
            33010899
        );
    COMMIT;*/
END CONVERT_TO_RMB;


 /**
 * @description: 折算后根据科目、币种维度进行汇总
 */


CREATE OR REPLACE PROCEDURE COUNT_CRC_SYS IS
BEGIN
    INSERT INTO SUNGL.DATA_RJ_BASE
        SELECT
            *
        FROM
            ( WITH TEMP1 AS(
                SELECT
                    BRCHCD, --机构号
                    BRCHNA, --机构名称
                    ITEMCD, --科目号
                    ITEMNA, --科目名称
                    SYSTID, --来源系统号
                    ACCTDT, --账务日期
                    SUM(ONLNBL) ONLNBL --余额汇总值
                FROM
                    SUNGL.GLA_GLIS_COUNT
                GROUP BY
                    BRCHCD,
                    BRCHNA,
                    ITEMCD,
                    ITEMNA,
                    ACCTDT,
                    SYSTID
            )
                SELECT
                    TEMP1.ACCTDT,
                    TEMP1.BRCHCD,
                    TEMP1.BRCHNA,
                    TEMP1.ITEMCD,
                    TEMP1.ITEMNA,
                    SUM(ONLNBL) ONLNBL
                FROM
                    TEMP1
                GROUP BY
                    TEMP1.ACCTDT,
                    TEMP1.BRCHCD,
                    TEMP1.BRCHNA,
                    TEMP1.ITEMCD,
                    TEMP1.ITEMNA
            );
------------------------------------------------------***----------------------------------------------------------            
 --! 汇总完科目币种，双向类的科目要取绝对值作为余额
    UPDATE SUNGL.DATA_RJ_BASE T
    SET
        T.ONLNBL = ABS(
            T.ONLNBL
        )
    WHERE
        T.ITEMCD IN(
            3001,
            3002,
            3051,
            3099,
            3101,
            3201,
            3202,
            3301,
            330108,
            33010899
        ) COMMIT;
END COUNT_CRC_SYS;