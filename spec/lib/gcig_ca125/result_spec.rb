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

  context "#message", :focus => true do
    before do
      @calculator = instance_double("GcigCa125::Calculator")
    end
    it "starts with 'Not evaluable' if not evaluable" do
      expect(@calculator).to receive(:is_evaluable?).and_return(false)
      expect(GcigCa125::Result.new(@calculator).message).to include('Not evaluable')
    end

    it "starts with 'No response' if evaluable but no response and has not normalised" do
      expect(@calculator).to receive(:is_evaluable?).and_return(true)
      expect(@calculator).to receive(:is_response?).and_return(false)
      expect(@calculator).to receive(:is_normalised?).and_return(false)
      expect(GcigCa125::Result.new(@calculator).message).to include('No response')
    end

    it "starts with 'Not confirmed' if evaluable and normalised but not response" do
      expect(@calculator).to receive(:is_evaluable?).and_return(true)
      expect(@calculator).to receive(:is_response?).and_return(false)
      expect(@calculator).to receive(:is_normalised?).and_return(true)
      expect(GcigCa125::Result.new(@calculator).message).to include('Not confirmed')
    end

    it "starts with 'Confirmed response' if evaluable, not normalised and is a response" do
      expect(@calculator).to receive(:is_evaluable?).and_return(true)
      expect(@calculator).to receive(:is_response?).and_return(true)
      expect(@calculator).to receive(:is_normalised?).and_return(false)

      expect(GcigCa125::Result.new(@calculator).message).to include('Confirmed response')
    end

    it "starts with 'Confirmed response' if evaluable, normalised and is a response" do
      expect(@calculator).to receive(:is_evaluable?).and_return(true)
      expect(@calculator).to receive(:is_response?).and_return(true)
      expect(@calculator).to receive(:is_normalised?).and_return(true)
      expect(GcigCa125::Result.new(@calculator).message).to include('Confirmed response')
    end
  end
end
