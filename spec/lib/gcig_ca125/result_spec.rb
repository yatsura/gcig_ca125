require 'spec_helper'

describe "GcigCa125::Result" do
  it "response to message" do
    expect(GcigCa125::Result.instance_methods).to include(:message)
  end

  it "response to evaluable" do
    expect(GcigCa125::Result.instance_methods).to include(:evaluable?)
  end

  it "response to response" do
    expect(GcigCa125::Result.instance_methods).to include(:response?)
  end

  it "response to normalised" do
    expect(GcigCa125::Result.instance_methods).to include(:normalised?)
  end

  context "#message" do
    it "starts with 'No response' if evaluable but no response and has not normalised" do
      skip
    end

    it "starts with 'Not evaluable' if not evaluable" do
      skip
    end

    it "starts with 'Not confirmed' if evaluable and normalised but not response" do
      skip
    end

    it "starts with 'Confirmed response' if evaluable, normalised and is a response" do
      skip
    end
  end
end