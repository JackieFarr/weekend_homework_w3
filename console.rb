require_relative("./models/films.rb")
require_relative("./models/customers.rb")
require_relative("./models/tickets.rb")

require( 'pry-byebug' )

Film.delete_all
Customer.delete_all
Ticket.delete_all

film1 = Film.new({
  "title" => "King of Thieves",
  "price" => 10
})

film2 = Film.new({
  "title" => "Goldfinger",
  "price" => 7
  })

film3 = Film.new({
  "title" => "Titanic",
  "price" => 5
  })

  film1.save
  film2.save
  film3.save

customer1 = Customer.new({
  "name" => "Jackie",
  "funds" => 50
})

customer2 = Customer.new({
  "name" => "Calum",
  "funds" => 70
})

customer3 = Customer.new({
  "name" => "Jen",
  "funds" => 30
})

customer4 = Customer.new({
  "name" => "James",
  "funds" => 100
})

customer1.save
customer2.save
customer3.save
customer4.save



ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
})

ticket2 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film1.id
})

ticket3 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film2.id
})

ticket4 = Ticket.new({
  "customer_id" => customer4.id,
  "film_id" => film2.id
})

ticket5 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film3.id
  })

  ticket6 = Ticket.new({
    "customer_id" => customer1.id,
    "film_id" => film2.id
    })

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save

binding.pry
nil
