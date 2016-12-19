
# awk -f xxx.awk dbrc/schemas.sql  | less

BEGIN { 
  # field separator is not enough...
  FS="\n"; 
  RS="CREATE |ALTER |COMMENT |SET " 
} 
{ 

  # don't have a clear 

  # print all functions...
  # if($1 ~ /^FUNCTION/) print $0
  
  # if($1 ~ /^SCHEMA /) print $0
  # print $NF 



  print $1 


}

