class Receipt
  def initialize(foods, party)
    @foods = foods
    @party = party
  end

  def to_s
    receipt = ""
    receipt << title
    receipt << blank_line
    receipt << time
    receipt << blank_line
    receipt << table_number
    receipt << blank_line
    receipt << food_lines
    receipt << blank_line
    receipt << subtotal
    receipt << blank_line
    receipt << tax
    receipt << blank_line
    receipt << total
    receipt << blank_line
    receipt << suggested_tip
    receipt << blank_line
    receipt << greeting
  end

  def title
    "Ruby Burgers by the Kaiser Chef's".center(30)
  end

  def table_number
    "Table Number: #{@party.table_number}".center(30)
  end

  def time
    "Time: #{DateTime.now}\n"
  end

  def blank_line
    "\n"
  end

  def food_lines
    formatted_foods = @foods.map do |food|
      food.name.to_s.ljust(20, '.') +
        formatted_price(food.price.to_s).rjust(10, '.')
    end
    formatted_foods.join("\n")
  end

  def subtotal
    "Subtotal".ljust(20, '.') + 
    formatted_price("#{sum}").rjust(10, '.')
  end

  def formatted_price(price)
    dollars, cents = price.split('.')
    cents = cents.ljust(2, "0")
    [dollars, cents].join(".")
  end

  def sum
    prices = @foods.map {|food| 
      food.price}
    prices.inject(:+)
  end

  def tax
    tax_amount = (sum * 0.2).round(2)
    "Tax".ljust(20, '.') + 
    formatted_price("#{tax_amount}").rjust(10, '.')
  end

  def suggested_tip
    tip_amount = (sum * 0.15).round(2)
    "Suggested Gratuity".ljust(20, '.') + 
    formatted_price("#{tip_amount}").rjust(10, '.')
  end

  def total
    grand_total = (sum * 1.2)
    "Grand Total".ljust(20, '.') + 
    formatted_price("#{grand_total}").rjust(10, '.')
  end

  def greeting
    "Thank You for Dinning with us\nCOME AGAIN".center(30)
  end


end