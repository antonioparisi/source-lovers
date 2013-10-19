require 'spec_helper'

describe HooksController do

  describe "GET 'github'" do
    it "returns http success" do
      get 'github'
      response.should be_success
    end
  end

  describe "GET 'stripe'" do
    it "returns http success" do
      get 'stripe'
      response.should be_success
    end
  end

end
