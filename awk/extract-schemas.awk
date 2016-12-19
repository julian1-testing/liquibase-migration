# awk
# extract schemas, but ignore liquibase type objects -  tables, funcs, sequences, etc.

BEGIN {
  RS="\n"
  print "begin;"
}
END { 
  print "commit;"
} 
{
  switch ($0) {

    # handle create schema
    case /CREATE SCHEMA (chef|admin)/:
      break

    case /CREATE SCHEMA/:
      print  $0
      break


    # handle alter schema
    case /ALTER SCHEMA (chef|admin)/:
      print "-- ", gensub(/\n/, "", "g",$0)
      break

    case /ALTER SCHEMA/:
      # schemas owned by postgres need to change to imosadmin
      print gensub(/OWNER TO postgres/, "OWNER TO imosadmin", "g", $0)
      break

    # handle extensions 
    case /CREATE EXTENSION/:
      # ignore imos extension
      if( $0 !~ /EXISTS imos/) 
        print $0
      break


    # handle extensions 
    case /GRANT [^ ]* ON SCHEMA/:
      print $0
      break


    case /ALTER DEFAULT PRIVILEGES FOR ROLE/:

      # ignore postgres
      if( $0 !~ /FOR ROLE postgres/) 
        print $0
      break

    default:
  }
}




