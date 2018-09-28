require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i
  end

  def save()
  sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def update()
    sql = "
      UPDATE customers
      set(
        name,
        funds
      ) = ($1, $2)
      WHERE id = $3;
      "
    values = [
      @name,
      @funds,
      @id
    ]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"

    results = SqlRunner.run(sql, [@id])
    films = results.map do |order_hash|
    Film.new(order_hash)
    end
  end

  def remainder()
    # roles = roles()
    film_price = films.map{|film| film.price}.first
    # combined_fees = role_fees.sum
    return @funds - film_price
  end

  def tickets()
    sql = "SELECT films.title
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"

    results = SqlRunner.run(sql, [@id])
    tickets = results.count
  
  end
  # end

end
