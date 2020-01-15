select round(sum(bytes/1024/1024/1024)) GB 
from dba_segments;