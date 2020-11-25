require "open-uri"
require 'faker'
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

puts "destroy all the attendances.."
Attendance.destroy_all

puts "destroy all the meetings.."
Meeting.destroy_all

puts "destroy all the users.."
User.destroy_all

puts "Creating users.."

user1 = User.create!(
  email: 'tomo@gmail.com',
  password: 'password',
  nickname: 'Tomo',
  job_title: 'Group Manager',
  trello_member_id: '5f421438fb1b3732a210da0c'
)
file = URI.open("https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/23755318_10209407560259098_2219201042514856512_n.jpg?_nc_cat=103&ccb=2&_nc_sid=09cbfe&_nc_ohc=rRaefdazVI4AX-TlLI2&_nc_ht=scontent-nrt1-1.xx&oh=ac5179312798d823a4c4bf0d0c42581a&oe=5FD84B94")
user1.photo.attach(io: file, filename: 'user1.jpg', content_type: 'image/jpg')

user2 = User.create!(
  email: 'taku@gmail.com',
  password: 'password',
  nickname: 'Taku',
  job_title: 'Group Manager',
  trello_member_id: '5fa8af96904250203410e07e'
)

file = URI.open("https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/11010000_10207671646052097_5981245681317027726_n.jpg?_nc_cat=104&ccb=2&_nc_sid=09cbfe&_nc_ohc=7TWJA6w_w4sAX-iRfnc&_nc_ht=scontent-nrt1-1.xx&oh=47e5fa86c96252c9c7a5a3f192530827&oe=5FD88C94")
user2.photo.attach(io: file, filename: 'user2.jpg', content_type: 'image/jpg')

user3 = User.create!(
  email: 'hwyann@gmail.com',
  password: 'password',
  nickname: 'Jess',
  job_title: 'Project Manager',
  trello_member_id: '5433f34bb761eb81e61730f9'
)

file = URI.open("https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/107053910_10159805100998219_2164698174907062565_o.jpg?_nc_cat=101&ccb=2&_nc_sid=09cbfe&_nc_ohc=QYHlmyJEE_MAX8Z3YoS&_nc_ht=scontent-nrt1-1.xx&oh=0b69f174a09c1a1b27ca8663bb0d60ae&oe=5FD95F4A")
user3.photo.attach(io: file, filename: 'user3.jpg', content_type: 'image/jpg')

user4 = User.create!(
  email: 'yann@gmail.com',
  password: 'password',
  nickname: 'Yann',
  job_title: 'CFO',
  trello_member_id: '5c4d3ff49f27d977b69866cb'
)

file = URI.open("https://avatars2.githubusercontent.com/u/26819547?s=400&u=ae79d8825ad1127723641cbf32a9a7e2ec221e7f&v=4")
user4.photo.attach(io: file, filename: 'user4.jpg', content_type: 'image/jpg')

user5 = User.create!(
  email: 'Doug@gmail.com',
  password: 'password',
  nickname: 'Doug',
  job_title: 'CRO',
  trello_member_id: '5f421438fb1b3732a210da0c'
)

file = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1523933095/viqfqp0tfkmcwmj7cfwe.jpg")
user5.photo.attach(io: file, filename: 'user5.jpg', content_type: 'image/jpg')


user6 = User.create!(
  email: 'sylvain@gmail.com',
  password: 'password',
  nickname: 'sylvain',
  job_title: 'CEO',
  trello_member_id: '5f421438fb1b3732a210da0c'
)

file = URI.open("https://avatars3.githubusercontent.com/u/24268006?v=4")
user6.photo.attach(io: file, filename: 'user6.jpg', content_type: 'image/jpg')

users = User.all

puts "...Created #{User.count} users!"

puts "Creating meetings.."


users.each do |user|
  Meeting.create!(
    user_id: user.id,
    date_time: Time.new(2020, rand(11..12), rand(26..30), rand(10..18), [0, 15, 30, 45].sample, 0),
    description: 'Syncalyst phase 1 standups to track progress and discuss about ideas.',
    trello_board: 'https://trello.com/b/hmiXsuho/syncalyst',
    title: 'Syncalyst daily standups',
    duration: 30
  )
end

meetings = Meeting.all

puts "...Created #{Meeting.count} meetings!"

puts "Creating attendances.."


meetings.each do |meeting|
  # array of attendees excluding the meeting host
  attendees = []
  users.each do |user|
    attendees << user if user.id != meeting.user.id
  end

  5.times do
    Attendance.create!(
      meeting_id: meeting.id,
      user_id: attendees.sample.id,
      status: true
    )
  end
end


puts "...Created #{Attendance.count} attendances!"

puts "Creating agendas.."

AGENDA_TITLE = ['Project Progress', 'Product Test', 'Sales Update']
TRANSCRIPTION = ["How do you think we should move forward with this project? As you know, we are expected to present it to our clients next week.\n\nHow about we get in touch with Acme Corp and discuss moving the deadline out three weeks?\n\nWe really need to push forward with this project to have it completed by the deadline. They are not interested in extensions.\n\nIn that case, we could delay completion on the Archibald Co. work.\n\nI think you are right, that is the only way we can finish working on the Acme project by next Thursday.", "Your products are very interesting. But I have some questions about the products.\n\nNo problem. What would you like to know?\n\nO.K. Tell me about these products, Mark.\n\nO.K. Well, you can use these products in your machines at your factory.\n\nReally? How will they help?\n\nWell, first of all, they can help your machines to run faster.\n\nYou mean they will help to improve the production if I use these products.\n\nYes. You will have more production and you will have better quallity if you use these products.\n\nFor my factory, which product is the best use?\n\nLet’s see. I think this product is the best for your factory.\n\nWhy?\n\nWell, because you can use this product in all of your machines and it’s very easy to use.\n\nIs it dangerous or toxic?\n\nOh, not at all. Not at all!\n\nAnd can I store this in my warehouse?\n\nYes, you can.\n\nFor how long?\n\nYou can store this product in your warehouse for over 1 year.\n\nCan I test this product before I buy it?\n\nYou sure can. As a matter of fact, I’ve brought a small sample for you to test in your factory.\n\nA small sample, I think this will be enough for you to test.\n\nYes!! I am very sure that will be enough. Can you help my workers at the factory to test this product?\n\nYes, I can. It’s very easy. When would you like to test it?\n\nIf you have enough time, you could go to the factory today. I can call and let them know you are coming.\n\nToday? Sure, that’s fine. That’s fine.","Susan, would you like to give your report.\n\nYes, thank you. I have a sales graph I would like to show everyone. This shows how well we are selling our products this year.\n\nThis line is the sales of our products. And this line is the sales of our competitors’ products.\n\nSo if that line goes up, am I doing a good job?\n\nExactly.\n\nO.K. And if that line goes up, does my salary go up?\n\nGood question, Ann. We’ll talk about that after the meeting.\n\nSusan, do we have many competitors?\n\nNo, not really but enough to keep us busy. Anyway, good job, Ann. I’m sure you and Mark will do even better next month!\n\nThank you, Susan. Very good. Tom, do you have anything to tell everyone.\n\nYes. Don’t forget, if you want me to buy something for your office, the deadline is tomorrow.\n\nOh!! I need a new typewriter. Mine is broken.\n\nO.K. No problem. If anyone wants me to buy something, tell me before the deadline.\n\nO.K. Is that everything?\n\n O.K. I think that’s all. You can go now.", ]


meetings.each do |meeting|
  i = 0
  AGENDA_TITLE.each do |title|
    Agenda.create!(
      meeting_id: meeting.id,
      title: title,
      transcription: TRANSCRIPTION[i],
      est_duration: 10
    )
    i += 1
  end
end

puts "...Created #{Agenda.count} agendas!"

puts "Creating tasks.."
TASK = ['create components', 'add edit user image feature', 'add delete user feature']

meetings.each do |meeting|
  Task.create!(
    user_id: rand(User.first.id..User.last.id),
    meeting_id: meeting.id,
    description: TASK.sample,
  )
end

puts "...Created #{Task.count} tasks!"

meeting = Meeting.create!(
  user_id: user3.id,
  date_time: Time.new(2020, 11, 20, 18, 0, 0),
  description: 'Weekly Progress Sharing on Product Development',
  trello_board: 'https://trello.com/b/hmiXsuho/syncalyst',
  title: 'Project Syncabuddy Weekly Meeting',
  duration: 10
)

Agenda.create!(
  meeting_id: meeting.id,
  title: "Tasks completed last week",
  transcription: "Jess: it should start recording and transcribing automatically. Last week I have made a new button on the agenda page. Let's go to the next item on the agenda",
  est_duration: 2
)

Agenda.create!(
  meeting_id: meeting.id,
  title: "Issues from last week",
  transcription: "Jess: But we have one problem. That its loading the page very slowly so we need to fix it.",
  est_duration: 2
)

Agenda.create!(
  meeting_id: meeting.id,
  title: "New Ideas from Jess",
  transcription: "Jess: Let's talk about other new ideas. How about adding a search function? How about you Tomo?",
  est_duration: 2
)

Agenda.create!(
  meeting_id: meeting.id,
  title: "New Ideas from Tomo",
  transcription: "Tomo: We need to add more animations.",
  est_duration: 2
)
