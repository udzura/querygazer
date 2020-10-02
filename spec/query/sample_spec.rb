require 'spec_helper'

RSpec.describe dataset('example_test') do
  def expect_bq_client_to_receive(query, &blk)
    allow(Querygazer.client.dataset).
      to receive(:query)
           .with(query)
           .and_return(blk.call)
  end

  describe query("SELECT count(*) FROM articles") do
    before do
      expect_bq_client_to_receive subject.sql do
        [{:f0 => 999}]
      end
    end

    it { should be_successful }
    its(:result) { expect(subject.result).to be <= 1000 }
  end

  describe query("SELECT max(updated_at) FROM articles") do
    before do
      expect_bq_client_to_receive subject.sql do
        [{:f0 => (Time.now - 29 * 24 * 60 * 60)}]
      end
    end

    it { should be_successful }
    its(:result) { should be_within(30.days).of Time.now }
  end

  describe query("SELECT foo, bar FROM articles") do
    before do
      allow(Querygazer.client.dataset).
        to receive(:query)
             .with(subject.sql)
             .and_raise(Google::Cloud::Error)
    end

    it { should_not be_successful }
  end

  describe query("SELECT 'dummy' as foo, 1000 as bar FROM articles LIMIT 1") do
    before do
      expect_bq_client_to_receive subject.sql do
        [{:foo => "dummy", :bar => 1000}]
      end
    end

    its("result[foo]")  { should eq "dummy" }
    its("result[bar]")  { should eq 1000 }

    its([:foo]) { should eq "dummy" }
    its([:bar]) { should eq 1000 }
  end

  describe query("SELECT id, author, updated_at FROM articles LIMIT 3") do
    before do
      expect_bq_client_to_receive subject.sql do
        [
          {:id => 3, :author => "udzura", :updated_at => Time.parse("2020-01-01 10:00:00 +09:00")},
          {:id => 6, :author => "akubi",  :updated_at => Time.parse("2020-01-10 14:00:00 +09:00")},
          {:id => 9, :author => "Matz",   :updated_at => Time.parse("2020-03-30 21:00:00 +09:00")},
        ]
      end
    end

    its([0])    { should eq [3, "udzura", Time.parse("2020-01-01 10:00:00 +09:00")] }
    its([1])    { should eq [6, "akubi",  Time.parse("2020-01-10 14:00:00 +09:00")] }
    its([2])    { should eq [9, "Matz",   Time.parse("2020-03-30 21:00:00 +09:00")] }
    its(:first) { should eq [3, "udzura", Time.parse("2020-01-01 10:00:00 +09:00")] }
    its(:last)  { should eq [9, "Matz",   Time.parse("2020-03-30 21:00:00 +09:00")] }

    its(:count) { should eq 3 }
  end
end
