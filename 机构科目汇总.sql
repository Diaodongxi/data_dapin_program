/**
 * @description: 根据机构、科目维度从末级汇总到一级
 */


CREATE OR REPLACE PROCEDURE COUNT_BRCH_ITEM IS
BEGIN
INSERT INTO SUNGL.GLA_GLIS_COUNT
    SELECT
        *
    FROM
        ( WITH TEMP2 AS (
            SELECT
                TEMP1.ITEMCD, -- 科目号
                NVL(U.ONLNBL,0)  ONLNBL, --原币余额
                U.LASTBL, --上期原币余额
                U.CRTSAM, --贷方发生额
                U.DRTSAM, --借方发生额
                U.DLFLCBL,--借方本位币期初余额
                U.CLFLCBL,--贷方本位币期初余额
                ROOT_ID,  --该科目所属的一级科目号
                ROOT_NAME,--该科目所属的一级科目名称
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
                )              TEMP1
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
                (--找出68家汇总机构所有的末级机构
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
                )  TEMP4
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