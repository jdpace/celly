require 'capybara-webkit'
require 'digest/md5'

module Celly
  module Driver
    class ATT

      Capybara.app_host = 'https://www.att.com'

      attr_accessor :username, :password, :bill_total, :bill_period, :screenshot

      def initialize(username, password)
        self.username = username
        self.password = password
      end

      def scrape
        sign_in unless signed_in?

        session.visit '/view/statementHistoryReflectionAction.doview'
        session.within('#subsections table tbody tr:first-child') do
          self.bill_period = session.find('td:first-child nobr').text
          self.bill_total = session.find('td.forceRight').text
          session.click_link 'View'
        end

        screenshot_hash = Digest::MD5.hexdigest(session.current_url)
        session.driver.browser.save_screenshot "/tmp/#{screenshot_hash}.png"
        self.screenshot = File.new("/tmp/#{screenshot_hash}.png")
      end

      def bill_total=(total)
        @bill_total = total.to_s.gsub(/[^\d\.,]+/,'').to_f
      end

      def bill_period=(period)
        start_date, end_date = period.split('-').map {|stamp| parse_date stamp.strip}
        @bill_period = (start_date..end_date)
      end

      private

      def session
        @session ||= Capybara::Session.new :selenium
      end

      def sign_in
        session.visit '/olam/loginDisplay.olamexecute'
        session.fill_in 'userID', :with => username
        session.execute_script("showPasswordField();")
        session.fill_in 'password', :with => password
        session.click_button 'Login'

        @signed_in = true
      end

      def signed_in?
        @signed_in
      end

      def parse_date(mdy)
        m, d, y = mdy.split('/').map(&:to_i)
        Date.civil y, m, d
      end

    end
  end
end
