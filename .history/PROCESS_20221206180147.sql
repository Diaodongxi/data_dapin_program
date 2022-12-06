create or replace procedure process is

file_name varchar2(255);
insert_into varchar2(500);
begin
/**
 * @description: 清理数据
 */

insert_into :='insert into gla_glis_h_t02
    select *
      from gla_glis_h_tb t'||'
     where t.stacid = ''1'''||'
       and t.systid != ''99'''||'
       and t.acctdt = ''20221101'''||'
       and t.crcycd in (''aud'', ''cad'', ''cny'', ''eur'', ''gbp'', ''hkd'', ''jpy'', ''usd'')'||'
       and t.geldtp = ''d'''||'
       and t.detltg = ''1''' ;
 
execute immediate 'truncate table sungl.gla_glis_h_t02';
execute immediate 'truncate table sungl.gla_glis_count';
execute immediate 'truncate table sungl.gla_glis_count2';
execute immediate 'truncate table sungl.data_rj_base';
execute immediate 'truncate table sungl.data_dapin_reslt';
execute immediate insert_into;
commit;

/**
 * @description: 获取日期
 */

file_name := 'uacp_dapin_data_'||to_char(sysdate,'yyyymmdd')||'.csv';

/**
 * @description: 汇总计税折算
 */

--价税分离
sungl.pkg_item_count_fac.tax_count();
--科目机构汇总
sungl.pkg_item_count_fac.count_brch_item();
--折算
sungl.pkg_item_count_fac.convert_to_rmb();
--币种来源汇总
sungl.pkg_item_count_fac.count_crc_sys();
--余额更新
sungl.pkg_item_count_fac.update_onlnbl();

/**
 * @description: 指标加工
 */

--加工指标
sungl.pkg_item_count_fac.insert_data_dapin_result();

/**
 * @description: 卸数
 */

--将结果表生成csv文件放在服务器对应目录，out_path路径需要预先设置！
sungl.pkg_item_count_fac.sql_to_csv('select * from data_dapin_reslt','out_path',file_name);
--将数据文件通过ftp传输给下游
sungl.pkg_item_count_fac.ftp_to_dapin();

end process;
