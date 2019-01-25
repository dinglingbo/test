SELECT m.menuid, m.menuname, m.menucode, m.imagepath, m.parentsid, m.funccode, 
			 m.DISPLAYORDER, null as funcaction, m.EXPANDPATH as expandpath, 
			 m.APP_ID as appId, m.parameter as params
from app_menu m
where ifnull(m.funccode, '') = ''
order by m.DISPLAYORDER asc

SELECT DISTINCT a.menuid, a.menuname, a.menucode, a.imagepath, a.parentsid, b.funccode, 
				 a.DISPLAYORDER,  b.funcaction, a.EXPANDPATH as expandpath, 
				 a.APP_ID as appId, b.parainfo as params
from app_menu a
inner join com_app_function b
on a.funccode = b.FUNCCODE
inner join com_cap_resauth c
on b.funccode = c.RES_ID

SELECT * from com_app_function

SELECT * from app_menu

--�û���
SELECT * from cap_user

--��ɫ��
select * from cap_role

--�û���Ӧ�Ľ�ɫ��
SELECT * from com_cap_partyauth

--��ɫ��Ӧ����Դ��
SELECT * from com_cap_resauth

����������ʱ���ֶ���ʼ����������

������ԣ�
1��user_id,role_id...
2��role_id,res_id...
3��res_id,resInfo

���洦��˵����
1���ӻ����л�ȡ�û���Ӧ�Ľ�ɫ��
   ����ȡ��������ʱ�������ݿ��л�ȡ������ȡ��������ʱ������һ��Ĭ�϶���
2�����������޸��û��Ľ�ɫʱ������groupName,key������role_id,res_id...�����»�������
3����������Դʱ����Ҫ������Դ��ϸ�������ɾ����Դʱ��������role_id,res_id...
4�����������޸Ľ�ɫ����Դʱ������goupName,key������role_id,res_id...�����»�������
5����ȡ�û���Ӧ�Ľ�ɫ��������ɫ����ȡ��ɫ��Ӧ����Դ��ȡΨһ��Դ��Ϣ��������Դ����ȡ��Դ��Ӧ����ϸ��Ϣ��������

Ȩ���ж��߼�˵����
1���ӻ����ȡ�û��Ľ�ɫ����ȡ����ʱ�����ݿ�ȡ��ȡ��������һ����ȡ�����򷵻�ûȨ��
2����ȡ��ɫ��Ӧ����Դ����ȡ����ʱ�����ݿ�ȡ��ȡ��������һ����ȡ��������ûȨ�ޣ�������һ��Ĭ�϶���user_id,role_id...
3����ȡ��ԴID��Ӧ����ϸ��Դ��Ϣ���ж�WEB�����url�治���ڣ������������Ȩ�ޣ���������ڣ���ûȨ��
























