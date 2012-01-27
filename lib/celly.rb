require "celly/version"
require "celly/driver/att"

module Celly

  def self.getBill(*credentials)
    driver = Celly::Driver::ATT.new(*credentials)

    total = driver.get_current_bill_total
    puts "Total: #{total}"
  end

end
