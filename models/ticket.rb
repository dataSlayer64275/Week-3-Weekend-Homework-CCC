require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @customer_id = info['customer_id'].to_i
    @film_id = info['film_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets
          (customer_id, film_id)
          VALUES
          ($1, $2)
          RETURNING id'
    values = [@customer_id, @film_id]
    ticket = Sql_runner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM tickets'
    values =[]
    tickets = Sql_runner.run(sql, values)
    result = tickets.map {|ticket| Ticket.new (ticket)}
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    Sql_runner.run(sql)
  end

  def delete
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    Sql_runner.run(sql, values)
  end

  def update
    sql = 'UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3'
    values = [@customer_id, @film_id, @id]
    Sql_runner.run(sql, values)
  end

end
