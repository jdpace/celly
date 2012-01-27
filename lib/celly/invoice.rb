require 'pdfkit'
require 'erb'

module Celly
  class Invoice

    attr_accessor :options

    def initialize(options)
      self.options = options
    end

    def pdf
      @pdf ||= PDFKit.new(render_template)
    end

    def render_template
      @html ||= ERB.new(Template).result(binding)
    end

    Template = <<-HTML
      <html>
        <head>
          <title>Cell Phone Expense Report | <%= options[:bill_period].first %> - <%= options[:bill_period].last %></title>
          <style>
            h1 {
              font-size: 18px;
              margin-bottom: 0.6em;
            }

            h3 {
              font-size: 14px;
              margin: 1em 0;
            }

            table {
              margin: 1em 0;
              width: 100%;
              border: 1px solid #999;
              font-size: 12px !important;
            }

            table thead tr {
              background-color: #EEE;
            }

            table th, table td {
              padding: 0.6em 0.8em;
              text-align: left;
            }

            table th:last-child, table td:last-child {
              text-align: right;
            }
          </style>
        </head>
        <body>
          <h1>Cell Phone Expense Report</h1>
          <h3>Employee: <%= options[:employee] %></h3>

          <table cellspacing="0">
            <thead>
              <tr>
                <th>Billing Period</th>
                <th>Purpose</th>
                <th>Bill Total</th>
                <th>Reimbursable Total</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><%= options[:bill_period].first %> - <%= options[:bill_period].last %></td>
                <td>Cell Phone</td>
                <td>$<%= options[:bill_total] %></td>
                <td>$<%= [options[:bill_total], options[:reimbursable]].min %></td>
              </tr>
            </tbody>
        </body>
      </html>
    HTML

  end
end
