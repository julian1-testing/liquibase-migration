
-- note, create db cannot be run in a transaction block,
-- begin;

create database test
  template = template0 
  encoding = UTF8 
  lc_collate = 'en_AU.UTF-8' 
  lc_ctype = 'en_AU.UTF-8'

  owner imosadmin
;


grant all on database test to imosadmin;

-- rollback;


