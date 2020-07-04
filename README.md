## Setup the api
```bash
docker-compose build
docker-compose run web rake db:setup
```

## Run the api
```bash
docker-compose up
```

## Useful commands

Better logs
```bash
docker-compose up -d # Sart services in daemon mode
docker-compose logs -f web # View logs for a specific service (e.g. web, db, redis)
docker-compose stop # Stop the dameon services
```
