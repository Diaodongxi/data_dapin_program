create or replace package body pkg_item_count_fac is

acct_date varchar2(20);
 /**
 * @description: 固定科目价税分离
 */
 ------------------------------------------------***特殊机构计税开始------------------------------------------------------------------------------------------------------
procedure tax_count is

begin
  select distinct (t.acctdt) into acct_date from sungl.gla_glis_h_t02 t order by t.acctdt;
 /* 
税率表是财务部提供的，两张不同的税率表，包含普通机构和特殊机构
计税要从末级数据计，且只有核心来源的部分科目才需要计税
价税分离后余额 = 原币余额 + 发生额 * 税率
*/
    update sungl.gla_glis_h_t02 t
    set
 --借贷方发生额计税
        t.crtsam = t.crtsam / (1+(select e.taxrate from sungl.tax_rate_sp e where t.itemcd = e.itemcd)),
        t.drtsam = t.drtsam / (1+(select e.taxrate from sungl.tax_rate_sp e where t.itemcd = e.itemcd))

    where
        t.systid = '30101'
        and t.acctdt = acct_date
        and t.brchcd in (
            select b.brchcd from sungl.com_brch b where b.detltg = '1' start with b.brchcd in (901020000, 901060000, 902010000, 903020000, 904020000, 905020000, 906020000, 907020000, 908020000, 909020000) connect by prior b.brchcd = b.sprrcd
        )
        and t.itemcd in (
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
    commit;
 ------------------------------------------------***特殊机构计税结束***------------------------------------------------------------------------------------------------------
 -----------------------------------------------***普通机构机构计税开始***------------------------------------------------------------------------------------------------------
    update sungl.gla_glis_h_t02 t
    set
        t.crtsam = t.crtsam / (1+(select e.taxrate from sungl.tax_rate_nm e where t.itemcd = e.itemcd)),
        t.drtsam = t.drtsam / (1+(select e.taxrate from sungl.tax_rate_nm e where t.itemcd = e.itemcd))
    where
        t.systid = '30101'
        and t.acctdt = acct_date
        and t.itemcd in (
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
        and t.brchcd not in (
            select b.brchcd from sungl.com_brch b where b.detltg = '1' start with b.brchcd in (901020000, 901060000, 902010000, 903020000, 904020000, 905020000, 906020000, 907020000, 908020000, 909020000) connect by prior b.brchcd = b.sprrcd
        );
    commit;
 -----------------------------------------------***普通机构机构计税结束***------------------------------------------------------------------------------------------------------
end tax_count;


/**
 * @description: 根据机构、科目维度从末级汇总到一级
 */
-----------------------------***机构科目汇总开始***------------------------------------------
procedure count_brch_item is

begin
    insert into sungl.gla_glis_count
        select
            *
        from
            ( with temp2 as (
                select
                    temp1.itemcd, -- 科目号
                    nvl(u.onlnbl,
                    0)           onlnbl, --原币余额
                    u.lastbl, --上期原币余额
                    u.crtsam, --贷方发生额
                    u.drtsam, --借方发生额
                    u.dlflcbl, --借方本位币期初余额
                    u.clflcbl, --贷方本位币期初余额
                    root_id, --该科目所属的一级科目号
                    root_name, --该科目所属的一级科目名称
                    u.brchcd, --机构号
                    u.crcycd, --币种
                    u.acctdt, --账务日期
                    u.blncdn, --科目方向
                    u.systid --来源系统号
                from
                    ( --根据科目层级，找出指标内需要的科目（有一级，二级...末级）对应的所有的末级科目
                        select
                            t.itemcd,
                            t.itemna,
                            connect_by_root(t.itemcd) root_id,
                            connect_by_root(t.itemna) root_name
                        from
                            sungl.com_item t
                        where
                            t.detltg = '1' start with t.itemcd in (6011,
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
                        connect by
                            prior t.itemcd = t.sprrcd
                    )                    temp1
 --根据科目拼上总账余额表
                    left join sungl.gla_glis_h_t02 u
                    on temp1.itemcd = u.itemcd
                    and u.stacid = 1
                    and u.geldtp = 'd'
            ),
 --step 开始根据科目维度汇总
            temp3 as(
                select
                    root_id,
                    root_name,
                    sum(onlnbl)  onlnbl,
                    sum(lastbl)  lastbl,
                    sum(crtsam)  crtsam,
                    sum(drtsam)  drtsam,
                    sum(dlflcbl) dlflcbl,
                    sum(clflcbl) clflcbl,
                    brchcd,
                    crcycd,
                    acctdt,
                    blncdn,
                    systid
                from
                    temp2
                group by
                    brchcd,
                    root_id,
                    root_name,
                    crcycd,
                    acctdt,
                    blncdn,
                    systid
            ),
            temp5 as(
                select
                    temp4.root_id2,
                    temp4.root_name2,
                    temp3.root_id,
                    temp3.root_name,
                    temp3.onlnbl,
                    temp3.lastbl,
                    temp3.crtsam,
                    temp3.drtsam,
                    temp3.dlflcbl,
                    temp3.clflcbl,
                    temp3.crcycd,
                    temp3.acctdt,
                    temp3.blncdn,
                    temp3.systid
                from
                    ( --找出68家汇总机构所有的末级机构
                        select
                            b.brchcd,
                            b.brchna,
                            connect_by_root(b.brchcd) root_id2,
                            connect_by_root(b.brchna) root_name2
                        from
                            sungl.com_brch b
                        where
                            b.detltg = '1' start with b.brchcd in (901070000,
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
                        connect by
                            prior b.brchcd = b.sprrcd
                    )                    temp4
 --拼上 已汇总到一级科目的数据
                    left join temp3
                    on temp3.brchcd = temp4.brchcd
            )
 --汇总末级机构，完成机构维度汇总
                select
                    root_id2     brchcd,
                    root_name2   brchna,
                    root_id      itemcd,
                    root_name    itemna,
                    crcycd,
                    systid,
                    acctdt,
                    blncdn,
                    sum(lastbl)  lastbl,
                    sum(crtsam)  crtsam,
                    sum(drtsam)  drtsam,
                    sum(dlflcbl) dlflcbl,
                    sum(clflcbl) clflcbl,
                    sum(onlnbl)  onlnbl
                from
                    temp5
                group by
                    root_id2,
                    root_name2,
                    root_id,
                    root_name,
                    crcycd,
                    acctdt,
                    blncdn,
                    systid
            ) commit;
end count_brch_item;
-----------------------------***机构科目汇总结束***------------------------------------------
/**
 * @description: 根据汇率进行折算，更新gla_glis_count的余额为本位币余额
 */

procedure convert_to_rmb is

new_date varchar(10);

begin
 -- 关联汇率表，排序后取第一个值作为最新日期
    select
        efctdt into new_date
    from
        (
            select
                rownum a,
                efctdt
            from
                (
                    select
                        distinct (t.efctdt)
 --rownum rn
                    from
                        sungl.com_exrt t
                    order by
                        t.efctdt desc
                )
            where
                rownum <= 3
            order by
                a asc
        )
    where
        a = 1;
 ---------------------------------------------------***折算开始***---------------------------------------------------------------------------
    update sungl.gla_glis_count c
    set
            c.lastbl = c.lastbl * (select e.middpr from sungl.com_exrt e where e.efctdt = new_date and e.crcycd = c.crcycd),
            c.crtsam = c.crtsam * (select e.middpr from sungl.com_exrt e where e.efctdt = new_date and e.crcycd = c.crcycd),
            c.drtsam = c.drtsam * (select e.middpr from sungl.com_exrt e where e.efctdt = new_date and e.crcycd = c.crcycd),
            c.onlnbl = c.onlnbl * (select e.middpr from sungl.com_exrt e where e.efctdt = new_date and e.crcycd = c.crcycd);
    commit;
end convert_to_rmb;
 --------------------------------------------------***折算结束***---------------------------------------------------------------------------
 /**
  * @description: 来源以及币种汇总
  */ 
 --------------------------------------------------***汇总来源以及币种开始***--------------------------------------------------------------------
procedure count_crc_sys is

begin
 /* 3开头的往来类科目双向都可能有余额,需要统一方向
 会计核算默认这类科目在借方，因此贷方余额统一转向  */
    update sungl.gla_glis_count t
    set
        t.onlnbl = t.onlnbl * (
            -1
        )
    where
        t.blncdn = 'c'
        and t.itemcd in (
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
    commit;
insert into sungl.gla_glis_count2  select * from 
(with temp1 as
 (select brchcd, --机构号
         brchna, --机构名称
         itemcd, --科目号
         itemna, --科目名称
         systid, --来源系统号
         acctdt, --账务日期
         sum(lastbl) lastbl,
         sum(crtsam) crtsam,
         sum(drtsam) drtsam,
         sum(onlnbl) onlnbl --余额汇总值
    from sungl.gla_glis_count
   group by brchcd, brchna, itemcd, itemna, acctdt, systid),
temp2 as
 (select temp1.acctdt,
         temp1.brchcd,
         temp1.brchna,
         temp1.itemcd,
         temp1.itemna,
         sum(lastbl) lastbl,
         sum(crtsam) crtsam,
         sum(drtsam) drtsam,
         sum(onlnbl) onlnbl
    from temp1
   group by temp1.acctdt, temp1.brchcd, temp1.brchna, temp1.itemcd, temp1.itemna) ,
temp3 as
 (select temp2.acctdt,
         temp2.brchcd,
         temp2.brchna,
         temp2.itemcd,
         temp2.itemna,
         sum(temp2.lastbl) lastbl,
         sum(temp2.crtsam) crtsam,
         sum(temp2.drtsam) drtsam,
         sum(temp2.onlnbl) onlnbl
  --b.onlnbl strnbl
    from --#todo:gla_glis_st建表语句，然后余额字段要有默认值0
         temp2
   group by temp2.acctdt, temp2.brchcd, temp2.brchna, temp2.itemcd, temp2.itemna)  
select temp3.acctdt,
         temp3.brchcd,
         temp3.brchna,
         temp3.itemcd,
         temp3.itemna,
         temp3.lastbl,
         temp3.crtsam,
         temp3.drtsam,
         temp3.onlnbl,
         b.onlnbl strnbl
    from temp3
    left join sungl.gla_glis_st b
  
      on b.itemcd = temp3.itemcd
     and b.brchcd = temp3.brchcd);
    commit;
 --双向科目取绝对值作为余额
    update sungl.gla_glis_count2 t
    set
        t.onlnbl = abs(
            t.onlnbl
        )
    where
        t.itemcd in(
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
    commit;
end count_crc_sys;
 --------------------------------------------------***汇总来源以及币种结束***--------------------------------------------------------------------
procedure update_onlnbl is

begin
 ---------------------------------------------------***资产负债类余额更新开始***-------------------------------------------------

 /* 资产负债类的科目，通过余额折算的方式完成，即当前余额 * 汇率
或者通过 （上期余额 + 发生额） * 汇率均可 */
 --资产负债类方向是贷方的科目加工
    update sungl.gla_glis_count2 c
    set
        c.onlnbl = (
            c.lastbl + c.crtsam -c.drtsam
        )
    where
        c.itemcd in (
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
    commit;
 --资产负债类方向是借方的科目加工
    update sungl.gla_glis_count2 c
    set
        c.onlnbl = (
            c.lastbl + c.drtsam -c.crtsam
        )
    where
        c.itemcd in (
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
    commit;
 -----------------------------------------***资产负债类余额更新完毕***-------------------------------------------------------------
 -------------------------------------------***损益类余额更新开始***---------------------------------------------------------------
 --6411利息支出特殊计算公式(借方)
    update gla_glis_count2 c
    set
        c.onlnbl = c.strnbl + (
            c.drtsam -c.crtsam
        )
    where
        c.itemcd in (
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
    commit;
 --6411利息支出特殊计算公式(贷方)
    update sungl.gla_glis_count2 c
       set c.onlnbl =
            (c.strnbl + (c.crtsam - c.drtsam))
     where c.itemcd in (6011,
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
                        6301);
    commit;
 -------------------------------------------***损益类折算结束***---------------------------------------------------------------
insert into sungl.data_rj_base
    select
        t.acctdt,
        t.brchcd,
        t.brchna,
        t.itemcd,
        t.itemna,
        t.onlnbl
    from
        sungl.gla_glis_count2 t;
end update_onlnbl;

/**
 * @description: 加工指标，插入结果表
 */
 -------------------------------------------***指标加工开始***---------------------------------------------------------------
procedure insert_data_dapin_result is

--机构循环取数，插入结果表
i_col number;

type num_list is varray(68) of number;

var_array num_list := num_list(901070000, 901080000, 901090000, 903060000, 903070000, 904020000, 904060000, 905030000, 905090000, 908050000, 909020000, 901020000, 901040000, 901060000, 906100000, 908040000, 908070000, 909060000, 901100000, 903020000, 905100000, 906030000, 908020000, 908030000, 909030000, 903050000, 903090000, 906080000, 908090000, 908110000, 909040000, 901030000, 903040000, 903110000, 903120000, 905020000, 905110000, 906070000, 907100000, 908060000, 909080000, 902010000, 905050000, 905070000, 905080000, 906020000, 906060000, 907030000, 910000000, 901050000, 903030000, 903100000, 905040000, 905060000, 906040000, 906050000, 907070000, 907110000, 909050000, 909070000, 903080000, 906090000, 907020000, 907040000, 907060000, 907090000, 908080000, 908100000);

begin
  select distinct (t.acctdt) into acct_date from sungl.gla_glis_h_t02 t order by t.acctdt;
    for i in 1 .. var_array.count loop
        i_col := var_array(i);
        insert into sungl.data_dapin_reslt values (
            acct_date, --#fixme:加上日期参数
            i_col,
            sungl.pkg_item_count_zcfz.turnbrchcd(i_col),
            sungl.pkg_item_count_tool.totalrev(i_col),
            sungl.pkg_item_count_tool.item6011(i_col),
            sungl.pkg_item_count_tool.item6012(i_col),
            sungl.pkg_item_count_tool.item6021(i_col),
            sungl.pkg_item_count_tool.otherrev(i_col),
            sungl.pkg_item_count_tool.totalexp(i_col),
            sungl.pkg_item_count_tool.item6411(i_col),
            sungl.pkg_item_count_tool.item6412(i_col),
            sungl.pkg_item_count_tool.item6421(i_col),
            sungl.pkg_item_count_tool.item6601(i_col),
            sungl.pkg_item_count_tool.item660101(i_col),
            sungl.pkg_item_count_tool.item66010501(i_col),
            sungl.pkg_item_count_tool.item660130(i_col),
            sungl.pkg_item_count_tool.item6602(i_col),
            sungl.pkg_item_count_tool.item6711(i_col),
            sungl.pkg_item_count_tool.item6403(i_col),
            sungl.pkg_item_count_tool.item6061(i_col),
            sungl.pkg_item_count_tool.item6101(i_col),
            sungl.pkg_item_count_tool.item6111(i_col),
            sungl.pkg_item_count_tool.item6701(i_col),
            sungl.pkg_item_count_tool.item6702(i_col),
            sungl.pkg_item_count_tool.totalprof(i_col),
            sungl.pkg_item_count_tool.item6801(i_col),
            sungl.pkg_item_count_tool.netprof(i_col),
            sungl.pkg_item_count_zcfz.totaldep(i_col),
            sungl.pkg_item_count_zcfz.totalassets(i_col),
            sungl.pkg_item_count_zcfz.totalassets2(i_col),
            sungl.pkg_item_count_zcfz.totalloans(i_col),
            sungl.pkg_item_count_zcfz.ownsequity(i_col),
            sungl.pkg_item_count_zcfz.loandecpre(i_col),
            0,
            0,
            0,
            concat(to_char(sungl.pkg_item_count_bili.roe(i_col) * 100, 'fm990.99'), '%'),
 --!成本收入比需要转换成百分比
            concat(to_char(sungl.pkg_item_count_bili.costinco(i_col) * 100, 'fm990.99'), '%'),
            0,
            sungl.pkg_item_count_tool.item6301(i_col)
        );
    end loop;
    commit;
end insert_data_dapin_result;
 -------------------------------------------***指标结束***---------------------------------------------------------------
 -------------------------------------------***csv文件生成工具***---------------------------------------------------------------
procedure sql_to_csv( p_query in varchar2, -- plsql文
p_dir in varchar2, -- 导出的文件放置目录
p_filename in varchar2 -- csv名
) is l_output utl_file.file_type;

l_thecursor integer default dbms_sql.open_cursor;
l_columnvalue varchar2(4000);
l_status integer;
l_colcnt number := 0;
l_separator varchar2(1);
l_desctbl dbms_sql.desc_tab;
p_max_linesize number := 32000;

begin
 --open file
    l_output := utl_file.fopen(p_dir, p_filename, 'w', p_max_linesize);
 --define date format
    execute immediate 'alter session set nls_date_format=''yyyy-mm-dd hh24:mi:ss''';
 --open cursor
    dbms_sql.parse(l_thecursor, p_query, dbms_sql.native);
    dbms_sql.describe_columns(l_thecursor, l_colcnt, l_desctbl);
 --dump table column name
    for i in 1 .. l_colcnt loop
        utl_file.put(l_output, l_separator
            || ''
            || l_desctbl(i).col_name
            || ''); --输出表字段
        dbms_sql.define_column(l_thecursor, i, l_columnvalue, 4000);
        l_separator := ',';
    end loop;
    utl_file.new_line(l_output); --输出表字段
 --execute the query statement
    l_status := dbms_sql.execute(l_thecursor);
 --dump table column value
    while (dbms_sql.fetch_rows(l_thecursor) > 0) loop
        l_separator := '';
        for i in 1 .. l_colcnt loop
            dbms_sql.column_value(l_thecursor, i, l_columnvalue);
            utl_file.put(l_output, l_separator
                || ''
                || trim(both ' ' from replace(l_columnvalue, '"', '""'))
                || '');
            l_separator := ',';
        end loop;
        utl_file.new_line(l_output);
    end loop;
 --close cursor
    dbms_sql.close_cursor(l_thecursor);
 --close file
    utl_file.fclose(l_output);
exception
    when others then
        raise;
end sql_to_csv;
 -------------------------------------------***csv文件生成工具***---------------------------------------------------------------
 -------------------------------------------***ftp调用工具***---------------------------------------------------------------

procedure ftp_to_dapin is 
l_conn utl_tcp.connection; --定义一个连接类型
r_put_file varchar2(255);
l_blob_len integer;
p_reason varchar2(2555) := null; --定义报错信息，默认为null
v_result varchar2(255) := 0; --定义结果信息
v_sign number(4) := 0; --定义结果状态，默认为0

begin
 --使用ftp.login方法创建连接，参数依次为ip/端口/用户名/密码 #todo:生产上的地址记得配置
    l_conn := sungl.ftp.login('192.111.29.94', '21', 'ftpusr', 'ftp@123..');
    begin
 --获取远程文件绝对路径
        r_put_file := 'uacp_dapin_data_'
            ||to_char(sysdate, 'yyyymmdd')
            ||'.csv';
 --获取指定文件字节大小
 --l_blob_len := dbms_lob.getlength(ftp.get_remote_binary_data(l_conn,r_from_file));
 --使用ftp.get下载文件
        sungl.ftp.put(
            p_conn => l_conn, --传入连接
            p_from_dir => 'out_path', --件绝对路径
            p_from_file => r_put_file, ---传入oracle服务器的目录，需确保dba_directories表下存在
            p_to_file => r_put_file
        ); --生成的文件名 #fixme:生成的文件加上日期参数
 --判断文件是否为空，如果为空返回失败
        if l_blob_len = 0 then
            v_sign := 1;
            v_result := '失败';
        else
            v_result := '成功';
        end if;
 --获取异常
    exception
        when others then
 --dbms_utility.format_error_backtrace方法用于获取报错的行数，sqlerrm用于获取报错信息
            p_reason := dbms_utility.format_error_backtrace
                || sqlerrm;
            v_sign := 1;
            v_result := '失败';
            end;
        ftp.logout(l_conn); --关闭fpt连接
        utl_tcp.close_all_connections; --关闭tcp连接
 --insert into gsc_test values(v_sign, v_result || '，数据大小为：' ||l_blob_len, p_reason);
 --commit;
    end ftp_to_dapin;
end pkg_item_count_fac;
 -------------------------------------------***ftp调用工具***---------------------------------------------------------------
