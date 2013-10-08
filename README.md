## Instalación

Clonar este repositorio y correr bundle install:

    bundle install --path=vendor

Configurar la base de datos en `config/database.rb`.

Luego, hacer las migraciones e instalar el trigger:

    bundle exec rake db:migrate
    bundle exec rake dusttrak:instalar_trigger

Y completar la base de datos con datos necesarios:

    bundle exec rake db:seed
    bundle exec rake dusttrak:mediciones_previas

Hacer prueba:

    bundle exec padrino start -h 0.0.0.0
