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

--用户表
SELECT * from cap_user

--角色表
select * from cap_role

--用户对应的角色表
SELECT * from com_cap_partyauth

--角色对应的资源表
SELECT * from com_cap_resauth

当缓存重启时，手动初始化缓存数据

缓存策略：
1、user_id,role_id...
2、role_id,res_id...
3、res_id,resInfo

缓存处理说明：
1、从缓存中获取用户对应的角色；
   当获取不到数据时，从数据库中获取，当获取不到数据时，返回一个默认对象
2、当新增，修改用户的角色时，根据groupName,key清理缓存role_id,res_id...并重新缓存数据
3、当新增资源时，需要更新资源明细缓存表；当删除资源时，清理缓存role_id,res_id...
4、当新增，修改角色的资源时，根据goupName,key清理缓存role_id,res_id...并重新缓存数据
5、获取用户对应的角色；遍历角色，获取角色对应的资源，取唯一资源信息；遍历资源，获取资源对应的详细信息，并排序

权限判断逻辑说明：
1、从缓存获取用户的角色，获取不到时从数据库取，取到继续下一步，取不到则返回没权限
2、获取角色对应的资源，获取不到时从数据库取，取到继续下一步，取不到返回没权限，并缓存一个默认对像到user_id,role_id...
3、获取资源ID对应的详细资源信息，判断WEB请求的url存不存在，如果存在则有权限，如果不存在，则没权限
























