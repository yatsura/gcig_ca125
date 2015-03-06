require 'pry'
require 'spec_helper'

# Test data from GCIG RESP SET
#

describe "GcigCa125::Calculator" do
  before(:all) do
    file = File.new('./spec/data/gcig_test_data.csv')
    @test_data = TestDataReader.new(file)
  end

  context "GCIG Test Data" do
    (1..30).each do |test_id|
      context "ID_NUM #{test_id}" do
        before do
          @data = @test_data.get_test(test_id)
          @calculator = GcigCa125::Calculator.new Date.parse(@data[:rx_date])
          @data[:results].each do |result|
            @calculator.add_ca125_test(Date.parse(result[:date]),result[:value].to_i)
          end
        end

        it "evaluable" do
          if @data[:evaluable].upcase == 'YES'
            expect(@calculator.result).to be_evaluable
          else
            expect(@calculator.result).not_to be_evaluable
          end
        end

        it "response" do
          if @data[:response].upcase == 'YES'
            expect(@calculator.result).to be_response
          else
            expect(@calculator.result).not_to be_response
          end
        end

        it "normalised" do
          if @data[:normalised].upcase == 'YES'
            expect(@calculator.result).to be_normalised
          else
            expect(@calculator.result).not_to be_normalised
          end
        end
      end
    end
  end
end
