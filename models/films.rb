require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"]
  end

  def save()
  sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i
  end

  def update()
    sql = "
      UPDATE films
      set(
        title,
        price
      ) = ($1, $2)
      WHERE id = $3;
      "
    values = [
      @title,
      @price,
      @id
    ]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"

    results = SqlRunner.run(sql, [@id])
    customers = results.map do |order_hash|
    Customer.new(order_hash)
  end
  end


end
