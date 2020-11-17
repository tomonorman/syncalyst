require "open-uri"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destroy all the agendas.."
Agenda.destroy_all

puts "destroy all the tasks.."
Task.destroy_all

puts "destroy all the meetings.."
Meeting.destroy_all

puts "destroy all the users.."
User.destroy_all

puts "destroy all the attendances.."
Attendance.destroy_all

puts "Creating users.."

user1 = User.create!(
  email: 'tomo@gmail.com',
  password: 'password',
  nickname: 'Tomo',
  job_title: 'Group Manager',
)
file = URI.open("https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/23755318_10209407560259098_2219201042514856512_n.jpg?_nc_cat=103&ccb=2&_nc_sid=09cbfe&_nc_ohc=rRaefdazVI4AX-TlLI2&_nc_ht=scontent-nrt1-1.xx&oh=ac5179312798d823a4c4bf0d0c42581a&oe=5FD84B94")
user1.photo.attach(io: file, filename: 'user1.jpg', content_type: 'image/jpg')

user2 = User.create!(
  email: 'taku@gmail.com',
  password: 'password',
  nickname: 'Taku',
  job_title: 'Group Manager'
)

file = URI.open("https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/11010000_10207671646052097_5981245681317027726_n.jpg?_nc_cat=104&ccb=2&_nc_sid=09cbfe&_nc_ohc=7TWJA6w_w4sAX-iRfnc&_nc_ht=scontent-nrt1-1.xx&oh=47e5fa86c96252c9c7a5a3f192530827&oe=5FD88C94")
user2.photo.attach(io: file, filename: 'user2.jpg', content_type: 'image/jpg')

user3 = User.create!(
  email: 'jess@gmail.com',
  password: 'password',
  nickname: 'Jess',
  job_title: 'Project Manager'
)

file = URI.open("https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/107053910_10159805100998219_2164698174907062565_o.jpg?_nc_cat=101&ccb=2&_nc_sid=09cbfe&_nc_ohc=QYHlmyJEE_MAX8Z3YoS&_nc_ht=scontent-nrt1-1.xx&oh=0b69f174a09c1a1b27ca8663bb0d60ae&oe=5FD95F4A")
user3.photo.attach(io: file, filename: 'user3.jpg', content_type: 'image/jpg')

puts "...Created #{User.count} users!"

puts "Creating meetings.."
