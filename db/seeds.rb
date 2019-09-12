# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Family.destroy_all
User.destroy_all
Garage.destroy_all
Car.destroy_all
UserCar.destroy_all
UserFamily.destroy_all

knutsens = Family.create()
jansens = Family.create()

knut = User.create(name: "Knut Knutsen")
nina = User.create(name: "Nina Knutsen")
sven = User.create(name: "Sven Knutsen")
gry = User.create(name: "Gry Jansen")
jan = User.create(name: "Jan Jansen")

acme_parking = Garage.create(name: "Acme Parking Garage")

tacoma = Car.create(make: "Toyota", model: "Tacoma", license_plate: "APM 674", garage_id: acme_parking.id)
charger = Car.create(make: "Dodge", model: "Charger", license_plate: "DLM 747", garage_id: acme_parking.id)
f_150 = Car.create(make: "Ford", model: "F-150", license_plate: "KLM 125", garage_id: acme_parking.id)
taurus = Car.create(make: "Ford", model: "Taurus", license_plate: "JNM 572", garage_id: acme_parking.id)

UserCar.create(user: knut, car: tacoma)
UserCar.create(user: knut, car: charger)
UserCar.create(user: nina, car: tacoma)
UserCar.create(user: nina, car: charger)
UserCar.create(user: sven, car: tacoma)
UserCar.create(user: sven, car: charger)

UserCar.create(user: gry, car: f_150)
UserCar.create(user: gry, car: taurus)
UserCar.create(user: jan, car: f_150)
UserCar.create(user: jan, car: taurus)

UserFamily.create(user: knut, family: knutsens)
UserFamily.create(user: nina, family: knutsens)
UserFamily.create(user: sven, family: knutsens)
UserFamily.create(user: gry, family: jansens)
UserFamily.create(user: jan, family: jansens)


puts "Seeds done."