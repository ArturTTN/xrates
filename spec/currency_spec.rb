require "spec_helper"

module Xrates
  RSpec.describe Currency do

    describe "operations" do

      context "exceptions" do
        let(:cbr) {
          Xrates::Adapter::Cbr.new
        }
        let(:round) {
          2
        }

        it "#convert_to raise if undefined currency" do
          expect {
            Xrates::Currency.new(1000, "EUR", cbr).convert_to("FOO", round)
          }.to raise_exception(Xrates::Adapter::UnknownRate)
        end

        it "#convert_to raise if driver not set" do
          expect {
            Xrates::Currency.new(1000, "EUR").convert_to("USD", round)
          }.to raise_exception(NoDriverSettledError)
        end

        it "#calculate raise if not an object" do
          expect {
            Xrates::Currency.new(1000, "EUR", cbr) - 10
          }.to raise_exception(TypeError)
        end
      end

      context "success" do

        let(:cbr) {
          Xrates::Adapter::Cbr.new
        }
        let(:fixer) {
          Xrates::Adapter::Fixer.new
        }
        let(:round) {
          2
        }

        it "#convert_to" do
          rate = cbr.fetch()["EUR"]
          curr = Xrates::Currency.new(1000, "EUR", cbr).convert_to("RUB")
          expect(curr.amount).to eq( (rate["value"]*1000).round(2) )
        end

        it "#convert_list" do
          amount        = 1000
          currencies    = ["EUR", "USD", "BYN"]
          curr_conv     = Xrates::Currency.new(amount, "RUB", cbr).convert_list(currencies).map(&:amount)
          expected_rate = []

          currencies.each do |c|
            expected_rate << Xrates::Currency.new(amount, "RUB", cbr).convert_to(c).amount
          end

          expect(curr_conv).to eq( expected_rate )
        end

        it "#-" do
          curr = Xrates::Currency.new(1000, "EUR", cbr) - Xrates::Currency.new(100, "EUR", cbr)
          expect(curr.amount).to eq(Xrates::Currency.new(900, "EUR", cbr).amount)
        end

        it "#+" do
          curr = Xrates::Currency.new(1000, "EUR", cbr) + Xrates::Currency.new(100, "EUR", cbr)
          expect(curr.amount).to eq(Xrates::Currency.new(1100, "EUR", cbr).amount)
        end

        it "#/" do
          curr = Xrates::Currency.new(1000, "EUR", cbr) / Xrates::Currency.new(100, "EUR", cbr)
          expect(curr.amount).to eq(Xrates::Currency.new(10, "EUR", cbr).amount)
        end

        it "#*" do
          curr = Xrates::Currency.new(10, "EUR", cbr) * Xrates::Currency.new(100, "EUR", cbr)
          expect(curr.amount).to eq(Xrates::Currency.new(1000, "EUR", cbr).amount)
        end

      end
    end
  end
end
