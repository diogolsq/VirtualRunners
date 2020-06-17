# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'date'
require 'time'

puts "Cleaning database"
User.destroy_all
puts "Users destroyed"
Track.destroy_all
puts "Tracks destroyed"
Race.destroy_all
puts "Races Destroyed"


puts "Creating runners/users"

#runners

milene = User.create!({ name: "Milene Cardoso", username: "milene", password: "123456", email: 'milene@gmail.com', level: 1})
file = open("https://ca.slack-edge.com/T02NE0241-UDE76BKKN-1936f122810b-512")
milene.photo.attach(io:file, filename: "milene.jpg")

gisela = User.create!({ name: "Gisela Keidel", username: "gkeidel", password: "123456", email: "gisela@gmail.com", level: 4 , races_number: 15 })
file = open("https://ca.slack-edge.com/T02NE0241-U012H8Q8VH7-3866d81e71e9-512")
gisela.photo.attach(io:file, filename:"gisela.jpg")

runner1 = User.create!({ name: "John Pesch", username: "John Pesch", password: "123456", email: "Jpesch@gmail.com", level: 3 , races_number: 7 })
file = open("https://media.peterhahn.com/i/peterhahn/411348_CAT_M_010219_085529/athlet-sport-leisure-suit-navy?$productdetail$")
runner1.photo.attach(io:file, filename:"john.jpg")

runner2 = User.create!({ name: "Maria Mary", username: "Mmaria", password: "123456", email: "maria@gmail.com", level: 4 , races_number: 13 })
file = open("https://images.tcdn.com.br/img/img_prod/621294/180_camiseta_regata_de_corrida_baby_look_team_runner_shop_rs_1233_1_20200208151957.jpg")
runner2.photo.attach(io:file, filename:"maria.jpg")


#users
matheus = User.create!({ name: "Matheus Penchel", username: "mcpenchel", password: "123456", email: "matheus@gmail.com", level: 1})
file = open("https://ca.slack-edge.com/T02NE0241-U3N8S3LFK-73039713a064-512")
matheus.photo.attach(io:file, filename:"matheus.jpg")

isa = User.create!({ name: "Isabella Meyer", username: "imeyer", password: "123456", email: "isa@gmail.com", level:3})
file = open("https://ca.slack-edge.com/T02NE0241-UPEP1SZ8E-6cf29e90be34-512")
isa.photo.attach(io:file, filename:"isa.jpg")

diogo = User.create!({ name: "Diogo Queiroz", username: "diogoQ", password: "123456", email: "diogolsq@poli.ufrj.br", level:5, races_number: 23})
file = open("https://instagram.fsdu5-1.fna.fbcdn.net/v/t51.2885-15/e35/14711869_201629310262927_2584149859133030400_n.jpg?_nc_ht=instagram.fsdu5-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=U8E5c-zHPoUAX-0Xkd4&oh=1109346adea09353934e5f318bca855d&oe=5F12B529")
diogo.photo.attach(io:file, filename:"diogo.jpg")



puts "Creating Tracks"


volta_na_lagoa = Track.create!({ name: "Volta na Lagoa Rodrigo de Freitas", description: "Vamos dar 1 volta na lagoa", distance: 2.73, level: 2, date: Date.parse('20-06-2020'), time_to_start: Time.parse("June 20 18:00"), time_to_complete: Time.parse("June 20 20:00"), start_address:'Avenida Epitácio Pessoa 1, Rio de <Janeiro></Janeiro>', end_address:'Avenida Borges de Medeiros 1, Rio de Janeiro'})
 file = open("https://media-cdn.tripadvisor.com/media/photo-s/0a/be/77/97/a-lagoa-que-fica-bem.jpg")
  volta_na_lagoa.photo.attach(io: file, filename: "lagoa.jpg")
maraca = Track.create!({ name: "Corrida em volta do maraca ", description: "2 voltas no maraca", distance: 1.71, level: 1, date: Date.parse('19-06-2020'), time_to_start: Time.parse("June 19 19:00"), time_to_complete: Time.parse("June 19 21:00"), start_address:'Avenida Maracanã, Rio de Janeiro', end_address:'Estátua do Bellini, Rio de Janeiro'})
 file = open("https://upload.wikimedia.org/wikipedia/commons/b/b4/Aerial_view_of_the_Maracan%C3%A3_Stadium.jpg")
  maraca.photo.attach(io: file, filename: "maraca.jpg")
lemeaoleblon = Track.create!({ name: " Rio Beach Run", description: "Run in Rio's beach ", distance: 7.90, level: 2, date: Date.parse('19-06-2020'), time_to_start: Time.parse("June 19 19:00"), time_to_complete: Time.parse("June 19 21:00"), start_address:'Pedra do Leme, Rio de Janeiro', end_address:'Mirante Leblon, Rio de Janeiro'})
 file = open("https://greatruns.com/wp-content/uploads/2016/11/Rio-Cover-e1478717116196.jpg")
  lemeaoleblon.photo.attach(io: file, filename: "lemeleblon.jpg")
ny_marathon = Track.create!({ name: " New York Marathon", description: "One of the most famous marathons in the world circuit, now in virtual edition ", distance: 42.00, level: 5, date: Date.parse('19-06-2020'), time_to_start: Time.parse("June 19 8:00"), time_to_complete: Time.parse("June 19 23:00"), start_address:'Verrazano-Narrows Bridge, Staten Island', end_address:'67th Street, West Drive, New York'})
 file = open("https://www.ef.com.br/sitecore/__/~/media/universal/pg/8x5/destination/US_US-NY_NYC_1.jpg")
 ny_marathon.photo.attach(io:file, filename: "ny_marathon.jpg")

puts "Creating Race"

race1 = Race.create!({user_id: gisela.id, track_id: volta_na_lagoa.id, km_ran: 0})
race2 = Race.create!({user_id: isa.id, track_id: volta_na_lagoa.id, km_ran: 0})
race3 = Race.create!({user_id: milene.id, track_id: volta_na_lagoa.id, km_ran: 0})
race4 = Race.create!({user_id: gisela.id, track_id: maraca.id, km_ran: 0 })
race5 = Race.create!({user_id: isa.id, track_id: maraca.id, km_ran: 0})
race6 = Race.create!({user_id: matheus.id, track_id: maraca.id, km_ran: 0})
race7 = Race.create!({user_id: isa.id, track_id: lemeaoleblon.id, km_ran: 0})
race8 = Race.create!({user_id: milene.id, track_id: lemeaoleblon.id, km_ran: 0})
race9 = Race.create!({user_id: diogo.id, track_id: lemeaoleblon.id, km_ran: 0})
race10 = Race.create!({user_id: gisela.id, track_id: ny_marathon.id, km_ran: 0})
race11 = Race.create!({user_id: diogo.id, track_id: ny_marathon.id, km_ran: 0})
race12 = Race.create!({user_id: isa.id, track_id: ny_marathon.id, km_ran: 0})
race13 = Race.create!({user_id: runner1.id, track_id: ny_marathon.id, km_ran: 0})
race14 = Race.create!({user_id: runner2.id, track_id: ny_marathon.id, km_ran: 0})
race15 = Race.create!({user_id: matheus.id, track_id: ny_marathon.id, km_ran: 0})

puts "finished!"

