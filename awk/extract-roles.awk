

BEGIN {
  RS=";|\n"
  print "begin;"
}
END { 
  print "commit;"
} 
{
  switch ($0) {
    case /CREATE ROLE (postgres|replication)/:
      print "-- ", gensub(/\n/, "", "g",$0)
      break

    case /CREATE ROLE/:
      role = gensub( /CREATE ROLE ([^ ;]*).*/, "\\1", "g", $0 ) ;
      print "-- role is ", role 
      print "CREATE ROLE ", role, " WITH NOSUPERUSER NOREPLICATION;"
      print "GRANT ", role, " TO imosadmin;"
      break

    case /ALTER ROLE (postgres|replication)/:
      print "-- ", gensub(/\n/, "", "g",$0), ";"
      break

    case /ALTER ROLE/: 
      print gensub( /NOSUPERUSER|NOREPLICATION/, "", "g", $0 ), ";"

      break

    default:
  }
}


# print gensub( /CREATE ROLE ([^ ;]*).*/, "CREATE ROLE \\1 WITH NOSUPERUSER NOREPLICATION;", "g", $0 ) 
