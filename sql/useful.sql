
begin;


CREATE or replace FUNCTION exec(text) 
returns text
language plpgsql volatile
AS $$
    BEGIN
      EXECUTE $1;
      RETURN $1;
    END;
$$;


create or replace function drop_non_rds_groups_and_roles()
returns void 
language plpgsql
as $$
  begin

    -- remove grants on public schemas, 
    perform exec( 'revoke all on schema public from ' ||  usename)  
      from pg_user 
      where usename 
      not in ( 'rdsadmin' , 'imosadmin' );

    perform exec('revoke all on schema public from ' || groname)
      from pg_group
      where groname 
      not in ('rds_superuser' , 'rds_replication' , 'pg_signal_backend', 'rdsrepladmin' ) ;

    -- drop the roles
    perform exec( 'drop role ' ||  usename)  
      from pg_user 
      where usename 
      not in ( 'rdsadmin' , 'imosadmin' );

    perform exec('drop group ' || groname)
      from pg_group
      where groname 
      not in ('rds_superuser' , 'rds_replication' , 'pg_signal_backend', 'rdsrepladmin' ) ;

  end 
$$;



create or replace function drop_non_public_schemas()
returns void 
language plpgsql
as $$
  begin

    perform exec( 'drop schema ' || nspname)  
      from pg_catalog.pg_namespace
      where nspname
      not in ( 'public', 'information_schema'  )
      and not nspname ~ '^pg_';

  end 
$$;



create or replace function drop_extensions()
returns void 
language plpgsql
as $$
  begin

    -- perform exec( 'drop extension \'' || extname || ''')  
    perform exec( 'drop extension "' || extname || '"' )  
      from pg_catalog.pg_extension 
      where extname 
      not in ( 'plpgsql' );

  end 
$$;



create or replace function grant_roles_to_imosadmin()
returns void 
language plpgsql
as $$
  begin

    perform exec('grant ' || usename || ' to imosadmin')  
      from pg_user 
      where usename 
      not in ( 'rdsadmin' , 'imosadmin' );

    -- do groups as well? ...

  end 
$$;


create or replace function cleanup()
returns void 
language plpgsql
as $$
  begin
    perform grant_roles_to_imosadmin();
    perform drop_non_public_schemas();
    perform drop_non_rds_groups_and_roles();
    perform drop_extensions();
  end 
$$;

commit;

