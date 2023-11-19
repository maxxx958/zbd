To run the project I execute the command:

`mariadb -u root -p < ./create_and_populate.sql`

and then type in the password.

To create a backup file including the procedures, triggers and functions run:

'mariadb-dump -u root -p --routines --triggers league > db_backup.sql'

To migrate the database from mariadb to postgres use:
pgloader mysql://root:admin@0.0.0.0:3306/league pgsql://root@127.0.0.1:5432/league
