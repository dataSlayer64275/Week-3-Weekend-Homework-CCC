require ('pg')

class Sql_runner

  def self.run (sql, values = []) #Why empty array
    begin
      db = PG.connect({host:'localhost', dbname: 'codeclan_cinema'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close
    end
    return result
  end

end
