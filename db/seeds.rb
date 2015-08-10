# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Role.create(role:"Admin")
Role.create(role:"Moderatör")
Role.create(role:"Tecrübeli")
Role.create(role:"Çaylak")
User.create(email: "mehmetadil_323@hotmail.com", password: "5u3yqqltul")
User.first.roles << Role.first
