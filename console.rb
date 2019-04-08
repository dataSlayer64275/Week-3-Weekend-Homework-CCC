require_relative('models/customer.rb')
require_relative('models/ticket.rb')
require_relative('models/film.rb')

require ('pry-byebug')

Customer.delete_all
Film.delete_all
Ticket.delete_all #How come ON DELETE CASCARD is necessary here?

customer1 = Customer.new ({'name' => 'Jonnie Cooper', 'funds' => '75'})
customer2 = Customer.new ({'name' => 'Lena Jordan', 'funds' => '50'})

customer1.save
customer2.save

film1 = Film.new ({'title' => 'Watchmen', 'price' => '10'})
film2 = Film.new ({'title' => 'V for Vendetta', 'price' => '15'})

film1.save
film2.save

ticket1 = Ticket.new ({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2 = Ticket.new ({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new ({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4 = Ticket.new ({'customer_id' => customer2.id, 'film_id' => film1.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save



customer1.name = 'Brendan Moreno'
customer2.funds = '100'
customer1.update
customer2.update

film1.title = 'Annihilation'
film2.price = '20'
film1.update
film2.update

ticket1.customer_id = customer1.id
ticket2.film_id = film2.id
ticket1.update
ticket2.update

binding.pry
nil #Why nil?
