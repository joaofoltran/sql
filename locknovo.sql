select sid, oracle_username, os_user_name, owner, ctime, created, object_name, process
from v$locked_object, all_objects, v$lock
where v$locked_object.object_id = all_objects.object_id AND v$lock.id1 = all_objects.object_id AND v$lock.sid = v$locked_object.session_id
order by session_id, sid, ctime desc, owner;