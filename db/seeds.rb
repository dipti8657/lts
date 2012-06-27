# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

admin = User.create!(:email => 'admin@cuberoot.in', 
                     :password => 'secret',
                     :password_confirmation => 'secret',
                     :role => 'admin',
                     :manager_id => 1)

