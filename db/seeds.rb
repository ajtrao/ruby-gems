User.create(email: "admin1@example.com", password: "admin1@example.com", password_confirmation: "admin1@example.com")

User.update_all confirmed_at: DateTime.now

Classroom.create(name: "Room 1")
Classroom.create(name: "Room 2")
Classroom.create(name: "Room 3")

Service.create(name: "Math", duration: 10 , client_price: 250)
Service.create(name: "Yoga", duration: 30 , client_price: 25)
Service.create(name: "Jumba", duration: 50 , client_price: 1000)

