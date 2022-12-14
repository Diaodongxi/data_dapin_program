CREATE OR REPLACE PACKAGE BODY "SUNGL".PKG_ITEM_COUNT_FAC IS
 /**
 * @description: 固定科目价税分离
 */
 ------------------------------------------------***特殊机构计税开始------------------------------------------------------------------------------------------------------
    PROCEDURE TAX_COUNT IS
    BEGIN
 /* 
税率表是财务部提供的，两张不同的税率表，包含普通机构和特殊机构
计税要从末级数据计，且只有核心来源的部分科目才需要计税
价税分离后余额 = 原币余额 + 发生额 * 税率
*/
        UPDATE SUNGL.GLA_GLIS_H_T02 T
        SET
            T.ONLNBL = T.LASTBL + (
                T.CRTSAM -T.DRTSAM
            ) / (
                1+ ( SELECT E.TAXRATE FROM SUNGL.TAX_RATE_SP E WHERE T.ITEMCD = E.ITEMCD )
            )
        WHERE
            T.SYSTID = '30101'
            AND T.ACCTDT = 20221101
            AND T.BRCHCD IN (
                SELECT B.BRCHCD FROM SUNGL.COM_BRCH B WHERE B.DETLTG = '1' START WITH B.BRCHCD IN (901020000, 901060000, 902010000, 903020000, 904020000, 905020000, 906020000, 907020000, 908020000, 909020000) CONNECT BY PRIOR B.BRCHCD = B.SPRRCD
            )
            AND T.ITEMCD IN (
                6011888,
                601107,
                601199,
                601202,
                60120102,
                601205,
                601209,
                601210,
                601299,
                60210601,
                60210502,
                60219901,
                60219902,
                60219904,
                60219905,
                60219906,
                602107,
                60210699,
                60219999,
                605105,
                606101,
                606102,
                606103,
                606199,
                610102,
                610103,
                610104,
                610105,
                610199,
                611106,
                611109,
                630101,
                630102,
                630103,
                630104,
                630105,
                630106,
                630107,
                630108,
                630110,
                60110501,
                60110502,
                60110503,
                60110504,
                6012010101,
                6012010102,
                60120401,
                60120301,
                60120402,
                60120399,
                6012070102,
                6012070202,
                60120602,
                6012070101,
                6012070201,
                60120601,
                60120801,
                60120802,
                60120803,
                60120804,
                60120899,
                60210101,
                60210102,
                60210103,
                6021020101,
                6021020102,
                6021020199,
                6021020201,
                6021020202,
                6021020203,
                6021020204,
                6021020205,
                6021020206,
                6021020207,
                6021020299,
                60210301,
                60210302,
                60210303,
                60210305,
                60210306,
                60210307,
                60210308,
                60210309,
                60210310,
                60210311,
                60210312,
                60210313,
                60210399,
                60210314,
                60210315,
                60210316,
                60210317,
                6021050101,
                6021050102,
                6021050301,
                6021050302,
                6021990301,
                60210405,
                60210407,
                60210408,
                6021020301,
                6021020302,
                6021020303,
                6021020304,
                6021020305,
                6021020306,
                6021020307,
                605101,
                605102,
                605103,
                605104,
                605199,
                61010101,
                61010102,
                61110101,
                61110102,
                61110199,
                601110,
                61110201,
                61110299,
                601111,
                61110301,
                61110399,
                611104,
                611105,
                611199,
                63010901,
                630111,
                630199,
                6021030401,
                6021030402,
                6021030403,
                60210401,
                60210402,
                60210403,
                60210404,
                60210406
            );
        COMMIT;
 ------------------------------------------------***特殊机构计税结束***------------------------------------------------------------------------------------------------------
 -----------------------------------------------***普通机构机构计税开始***------------------------------------------------------------------------------------------------------
        UPDATE SUNGL.GLA_GLIS_H_T02 T
        SET
            T.ONLNBL = T.LASTBL + (
                T.CRTSAM -T.DRTSAM
            ) / (
                1+ ( SELECT E.TAXRATE FROM SUNGL.TAX_RATE_NM E WHERE T.ITEMCD = E.ITEMCD )
            )
        WHERE
            T.SYSTID = '30101'
            AND T.ACCTDT = 20221101
            AND T.ITEMCD IN (
                6011888,
                601107,
                601199,
                601202,
                60120102,
                601205,
                601209,
                601210,
                601299,
                60210601,
                60210502,
                60219901,
                60219902,
                60219904,
                60219905,
                60219906,
                602107,
                60210699,
                60219999,
                605105,
                606101,
                606102,
                606103,
                606199,
                610102,
                610103,
                610104,
                610105,
                610199,
                611106,
                611109,
                630101,
                630102,
                630103,
                630104,
                630105,
                630106,
                630107,
                630108,
                630110,
                60110501,
                60110502,
                60110503,
                60110504,
                6012010101,
                6012010102,
                60120401,
                60120301,
                60120402,
                60120399,
                6012070102,
                6012070202,
                60120602,
                6012070101,
                6012070201,
                60120601,
                60120801,
                60120802,
                60120803,
                60120804,
                60120899,
                60210101,
                60210102,
                60210103,
                6021020101,
                6021020102,
                6021020199,
                6021020201,
                6021020202,
                6021020203,
                6021020204,
                6021020205,
                6021020206,
                6021020207,
                6021020299,
                60210301,
                60210302,
                60210303,
                60210305,
                60210306,
                60210307,
                60210308,
                60210309,
                60210310,
                60210311,
                60210312,
                60210313,
                60210399,
                60210314,
                60210315,
                60210316,
                60210317,
                6021050101,
                6021050102,
                6021050301,
                6021050302,
                6021990301,
                60210405,
                60210407,
                60210408,
                6021020301,
                6021020302,
                6021020303,
                6021020304,
                6021020305,
                6021020306,
                6021020307,
                605101,
                605102,
                605103,
                605104,
                605199,
                61010101,
                61010102,
                61110101,
                61110102,
                61110199,
                601110,
                61110201,
                61110299,
                601111,
                61110301,
                61110399,
                611104,
                611105,
                611199,
                63010901,
                630111,
                630199,
                6021030401,
                6021030402,
                6021030403,
                60210401,
                60210402,
                60210403,
                60210404,
                60210406
            )
            AND T.BRCHCD NOT IN (
                SELECT B.BRCHCD FROM SUNGL.COM_BRCH B WHERE B.DETLTG = '1' START WITH B.BRCHCD IN (901020000, 901060000, 902010000, 903020000, 904020000, 905020000, 906020000, 907020000, 908020000, 909020000) CONNECT BY PRIOR B.BRCHCD = B.SPRRCD
            );
        COMMIT;
 -----------------------------------------------***普通机构机构计税结束***------------------------------------------------------------------------------------------------------
    END TAX_COUNT;


 /**
 * @description: 根据机构、科目维度从末级汇总到一级
 */


    PROCEDURE COUNT_BRCH_ITEM IS
    BEGIN
        INSERT INTO SUNGL.GLA_GLIS_COUNT
            SELECT
                *
            FROM
                ( WITH TEMP2 AS (
                    SELECT
                        TEMP1.ITEMCD, -- 科目号
                        NVL(U.ONLNBL,
                        0) ONLNBL, --原币余额
                        U.LASTBL, --上期原币余额
                        U.CRTSAM, --贷方发生额
                        U.DRTSAM, --借方发生额
                        U.DLFLCBL, --借方本位币期初余额
                        U.CLFLCBL, --贷方本位币期初余额
                        ROOT_ID, --该科目所属的一级科目号
                        ROOT_NAME, --该科目所属的一级科目名称
                        U.BRCHCD, --机构号
                        U.CRCYCD, --币种
                        U.ACCTDT, --账务日期
                        U.BLNCDN, --科目方向
                        U.SYSTID --来源系统号
                    FROM
                        ( --根据科目层级，找出指标内需要的科目（有一级，二级...末级）对应的所有的末级科目
                            SELECT
                                T.ITEMCD,
                                T.ITEMNA,
                                CONNECT_BY_ROOT(T.ITEMCD) ROOT_ID,
                                CONNECT_BY_ROOT(T.ITEMNA) ROOT_NAME
                            FROM
                                SUNGL.COM_ITEM T
                            WHERE
                                T.DETLTG = '1' START WITH T.ITEMCD IN (6011,
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
                                660130)
                            CONNECT BY
                                PRIOR T.ITEMCD = T.SPRRCD
                        ) TEMP1
 --根据科目拼上总账余额表
                        LEFT JOIN SUNGL.GLA_GLIS_H_T02 U
                        ON TEMP1.ITEMCD = U.ITEMCD
                        AND U.STACID = 1
                        AND U.GELDTP = 'D'
                ),
 --step 开始根据科目维度汇总
                TEMP3 AS(
                    SELECT
                        ROOT_ID,
                        ROOT_NAME,
                        SUM(ONLNBL) ONLNBL,
                        SUM(LASTBL) LASTBL,
                        SUM(CRTSAM) CRTSAM,
                        SUM(DRTSAM) DRTSAM,
                        SUM(DLFLCBL) DLFLCBL,
                        SUM(CLFLCBL) CLFLCBL,
                        BRCHCD,
                        CRCYCD,
                        ACCTDT,
                        BLNCDN,
                        SYSTID
                    FROM
                        TEMP2
                    GROUP BY
                        BRCHCD,
                        ROOT_ID,
                        ROOT_NAME,
                        CRCYCD,
                        ACCTDT,
                        BLNCDN,
                        SYSTID
                ),
                TEMP5 AS(
                    SELECT
                        TEMP4.ROOT_ID2,
                        TEMP4.ROOT_NAME2,
                        TEMP3.ROOT_ID,
                        TEMP3.ROOT_NAME,
                        TEMP3.ONLNBL,
                        TEMP3.LASTBL,
                        TEMP3.CRTSAM,
                        TEMP3.DRTSAM,
                        TEMP3.DLFLCBL,
                        TEMP3.CLFLCBL,
                        TEMP3.CRCYCD,
                        TEMP3.ACCTDT,
                        TEMP3.BLNCDN,
                        TEMP3.SYSTID
                    FROM
                        ( --找出68家汇总机构所有的末级机构
                            SELECT
                                B.BRCHCD,
                                B.BRCHNA,
                                CONNECT_BY_ROOT(B.BRCHCD) ROOT_ID2,
                                CONNECT_BY_ROOT(B.BRCHNA) ROOT_NAME2
                            FROM
                                SUNGL.COM_BRCH B
                            WHERE
                                B.DETLTG = '1' START WITH B.BRCHCD IN (901070000,
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
                            CONNECT BY
                                PRIOR B.BRCHCD = B.SPRRCD
                        ) TEMP4
 --拼上 已汇总到一级科目的数据
                        LEFT JOIN TEMP3
                        ON TEMP3.BRCHCD = TEMP4.BRCHCD
                )
 --汇总末级机构，完成机构维度汇总
                    SELECT
                        ROOT_ID2 BRCHCD,
                        ROOT_NAME2 BRCHNA,
                        ROOT_ID ITEMCD,
                        ROOT_NAME ITEMNA,
                        CRCYCD,
                        SYSTID,
                        ACCTDT,
                        BLNCDN,
                        SUM(LASTBL) LASTBL,
                        SUM(CRTSAM) CRTSAM,
                        SUM(DRTSAM) DRTSAM,
                        SUM(DLFLCBL) DLFLCBL,
                        SUM(CLFLCBL) CLFLCBL,
                        SUM(ONLNBL) ONLNBL
                    FROM
                        TEMP5
                    GROUP BY
                        ROOT_ID2,
                        ROOT_NAME2,
                        ROOT_ID,
                        ROOT_NAME,
                        CRCYCD,
                        ACCTDT,
                        BLNCDN,
                        SYSTID
                ) 
                END COUNT_BRCH_ITEM;


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


        PROCEDURE COUNT_CRC_SYS IS
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

END PKG_ITEM_COUNT_FAC;