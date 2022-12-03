/*
#TODO:给所有的表加上sungl.
*/


--给SUNGL用户增加系统包权限
----------------------------------------------------------------------------------------------------------------------------
begin
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'Resolve_Access.xml',
                                    description => 'Resolve Access',
                                    principal   => 'SUNGL',
                                    is_grant    => true,
                                    privilege   => 'connect');
end;
-----------------------------------------------------------------------------------------------------------------------------
begin
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'Resolve_Access.xml',
                                       principal => 'SUNGL',
                                       is_grant  => true,
                                       privilege => 'connect');
end;
-----------------------------------------------------------------------------------------------------------------------------
begin

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'Resolve_Access.xml',
                                    host => '*');
end;
-------------------------------------------------------------------------------------------------------------------------------

--查询权限表
SELECT * FROM DBA_NETWORK_ACL_PRIVILEGES;
-------------------------------------------------------------------------------------------------------------------------------
-- 插入数据前，先清理基础表
TRUNCATE TABLE DATA_DAPIN_RESLT;
TRUNCATE TABLE DATA_RJ_BASE;
--------------------------------------------------------------------------------------------------------------------------------
--从GLA_GLIS总账余额表筛选需要的科目，机构到基础表
CALL SUNGL.PKG_ITEM_COUNT_PROCESS.INSERT_DATA_RJ_BASE();
--遍历机构数组，根据机构计算指标，插入结果表
CALL SUNGL.PKG_ITEM_COUNT_PROCESS.INSERT_DATA_DAPIN_RESULT();
--将结果表生成CSV文件放在服务器对应目录，OUT_PATH路径需要预先设置！
CALL SUNGL.PKG_ITEM_COUNT_PROCESS.SQL_TO_CSV('SELECT * FROM DATA_DAPIN_RESLT','OUT_PATH','uacp_DAPIN_DATA_20221101.csv');
--将数据文件通过FTP传输给下游
CALL SUNGL.PKG_ITEM_COUNT_PROCESS.FTP_TO_DAPIN();
--------------------------------------------------------------------------------------------------------------------------------