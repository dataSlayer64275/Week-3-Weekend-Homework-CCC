require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('ticket.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @funds = info['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers
          (name, funds)
          VALUES
          ($1, $2)
          RETURNING id"
    values = [@name, @funds]
    customer = Sql_runner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM customers'
    values = [] #Why empty array here also
    customers = Sql_runner.run(sql, values)
    result = customers.map {|customer| Customer.new (customer)}
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM customers' #Why does this command not require '*'
    Sql_runner.run(sql)
  end

  def delete
    sql = 'DELETE FROM customers WHERE id = $1'
    values = [@id]
    Sql_runner.run(sql, values)
  end

  def update
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    Sql_runner.run(sql, values)
  end

  def films_booked
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1'
    values = [@id]
    results = Sql_runner.run(sql, values)
    return results.map {|film| Film.new (film)}
  end

  def buy_ticket(film)

  end

  def tickets_bought


end
