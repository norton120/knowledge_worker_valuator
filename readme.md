## Knowledge Worker Valuator
built to support simple analysis from [this experiment](https://medium.com/@ethan.m.knox/an-approach-to-knowledge-worker-metrics-55574efc210c)

### Formatting data
- The build expects the both gcal and domain csv exports with name format
`YYYYMMDD.csv`. 
- The files need to be in distinct folders (`gcal/` and `domain/` , resprectively). 
- The build is expecting one `domain` file per day (the date name of the file will not backfill to the previous day, but be considered records for that day only). 
- The build will import _all_ the gcal records and de-duple favoring the newest record.

### loading data
in this repo is a folder `data` with sub-folders `gcal` and `domains`. Fill appropriately with all the data you've got! 

### running the build
start with `docker-compose up` from the root directory

### accessing the data
you can view your transformed data at [http://localhost:5050](http://localhost:5050)

## changing your domain mappings
this is all grossly hardcoded for now in `dbt/data/domain_map.csv`. Update as needed and then restart the app with `docker-compose down && docker-compose up`



