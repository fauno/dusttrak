# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"

shell.say ""

account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""

# Umbral de error default
Configuracion.create unless Configuracion.any?

if ENV['password'].present?
  Usuario.create(nombre: 'admin', password: ENV['password'])
else
  logger.info 'Si querías crear un admin probá de nuevo con:

             rake db:seed password="el password del admin global"'
end

# Aparatos de acuerdo a los historical existentes. Se crean con cero y escala
# por default. Hay que modificarlos y correr
#
#     rake dusttrak:mediciones_previas
#
# para que se creen las mediciones con los cero y escala correctos
Historical.pluck(:grd_id).uniq.each do |grd|
  Aparato.find_or_create_by_grd(grd) do |aparato|
    aparato.nombre = "id: #{grd}"
  end
end

logger.info "Después de configurar cada aparato, corré

             rake dusttrak:mediciones_previas"
