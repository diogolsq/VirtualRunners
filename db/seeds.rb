# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'Date'
require 'time'

puts "Cleaning database"
User.destroy_all
puts "Users destroyed"
Track.destroy_all
puts "Tracks destroyed"



puts "Creating runners/users"

#runners

milene = User.create!({ name: "Milene Cardoso", username: "milene", password: "123456", email: 'milene@gmail.com', level: 1})

gisela = User.create!({ name: "Gisela Keidel", username: "gkeidel", password: "123456", email: "gisela@gmail.com", level: 4 , races_number: 15 })

#users
matheus = User.create!({ name: "Matheus Penchel", username: "mcpenchel", password: "123456", email: "matheus@gmail.com", level: 1})

isa = User.create!({ name: "Isabella Meyer", username: "imeyer", password: "123456", email: "isa@gmail.com", level:3})


puts "Creating Tracks"

volta_na_lagoa = Track.create!({ name: "Volta na Lagoa Rodrigo de Freitas", description: "Vamos dar 1 volta na lagoa", level: 2, date: Date.parse('20-06-2020'), time_to_start: Time.parse("June 20 18:00"), time_to_complete: Time.parse("June 20 20:00"), start_address:'Avenida Epitácio Pessoa 1', end_address:'Avenida Borges de Medeiro 1'})
 file = open("https://media-cdn.tripadvisor.com/media/photo-s/0a/be/77/97/a-lagoa-que-fica-bem.jpg")
  volta_na_lagoa.photo.attach(io: file, filename: "lagoa.jpg")
maraca = Track.create!({ name: "Corrida em volta do maraca ", description: "2 voltas no maraca", level: 1, date: Date.parse('19-06-2020'), time_to_start: Time.parse("June 19 19:00"), time_to_complete: Time.parse("June 19 21:00"), start_address:'Avenida Maracanã', end_address:'Estátua do Bellini'})
 file = open("https://upload.wikimedia.org/wikipedia/commons/b/b4/Aerial_view_of_the_Maracan%C3%A3_Stadium.jpg")
  maraca.photo.attach(io: file, filename: "maraca.jpg")

puts "Creating Race"

race1 = Race.create!({user_id: gisela.id, track_id: volta_na_lagoa.id, km_ran: 0})
race2 = Race.create!({user_id: gisela.id, track_id: maraca.id, km_ran: 0 })
race3 = Race.create!({user_id: isa.id, track_id: maraca.id, km_ran: 0})



puts "finished!"

