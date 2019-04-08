require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('ticket.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @title = info['title']
    @price = info['price'].to_i
  end

  def save
    sql = 'INSERT INTO films
          (title, price)
          VALUES
          ($1, $2)
          RETURNING id'
    values = [@title, @price]
    film = Sql_runner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM films'
    values = []
    films = Sql_runner.run(sql, values)
    result = films.map {|film| Film.new (film)}
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    Sql_runner.run(sql)
  end

  def delete
    sql = 'DELETE FROM films WHERE id = $1'
    values = [@id]
    Sql_runner.run(sql, values)
  end

  def update
    sql = 'UPDATE films SET (title, price) = ($1, $2) WHERE id = $3'
    values = [@title, @price, @id]
    Sql_runner.run(sql, values)
  end

  def customers
    sql = 'SELECT customers.* FROM customers INNER JOIN tickets ON customers.id
          = tickets.customer_id WHERE tickets.film_id = $1'
    values = [@id]
    results = Sql_runner.run(sql, values)
    return results.map {|customer| Customer.new (customer)}
  end

  def audience_size

  end

end
