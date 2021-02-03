## Working with docker
We use `Docker` and `docker-compose` for development to keep the environment consistent and easy to set up.

It's also recommended to add an alias to `.bashrc` or `.zshrc` to simplify running most commands. Commands in this README will use the suggested alias.
```bash
alias dcrun='docker-compose run --rm web'
```

## Environment Variables / Secrets
All variables are already encrypted in the repository under `config/credentials/`. You'll need to ask for the development key and add under `config/credentials/development.key`. This should be automatically ignored from version control.

## Setup the api
```bash
docker-compose build
dcrun rake db:prime
```

## Run the api
```bash
docker-compose up
```

## Useful commands

Run tests
```bash
dcrun rspec
```

Run rubocop
```bash
dcrun rubocop
```

Edit credentials
```bash
dcrun rails credentials:edit --environment=development
```

Better logs
```bash
docker-compose up -d # Sart services in daemon mode
docker-compose logs -f web # View logs for a specific service (e.g. web, db, redis)
docker-compose stop # Stop the dameon services
```
