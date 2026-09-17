Success. You can now start the database server using:

    '/opt/homebrew/Cellar/postgresql@18/18.6/bin/pg_ctl' -D '/opt/homebrew/var/postgresql@18' -l logfile start

initdb: warning: enabling "trust" authentication for local connections
initdb: hint: You can change this by editing pg_hba.conf or using the option -A, or --auth-local and --auth-host, the next time you run initdb.
🍺  /opt/homebrew/Cellar/postgresql@18/18.6: 3,873 files, 77.7MB
==> Caveats
==> postgresql@18
This formula has created a default database cluster with:
  initdb --locale=en_US.UTF-8 -E UTF-8 /opt/homebrew/var/postgresql@18

When uninstalling, some dead symlinks are left behind so you may want to run:
  brew cleanup --prune-prefix

To start postgresql@18 now and restart at login:
  brew services start postgresql@18
Or, if you don't want/need a background service you can just run:
  LC_ALL="en_US.UTF-8" /opt/homebrew/opt/postgresql@18/bin/postgres -D /opt/homebrew/var/postgresql@18
