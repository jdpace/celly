require "celly/version"
require "celly/config"
require "celly/driver/att"
require "celly/invoice"
require 'pony'

module Celly

  def self.do_your_thing
    driver = Celly::Driver::ATT.new(config['att_username'], config['att_password'])
    driver.scrape

    invoice = Celly::Invoice.new :employee => config['name'], :bill_period => driver.bill_period, :bill_total => driver.bill_total, :reimbursable => config['reimbursable']

    Pony.mail(
      from: 'celly@thinkrelevance.com',
      to: config['email'],
      subject: "Cell Phone Expense Report: #{driver.bill_period.first} - #{driver.bill_period.last}",
      body: "Receipt and expense report are attached.",
      :attachments => {
        'reciept.png' => driver.screenshot.read,
        'expense-report.pdf' => invoice.pdf.to_pdf
      }
    )
  end

  def self.config
    @config = Celly::Config.load
  end

end
