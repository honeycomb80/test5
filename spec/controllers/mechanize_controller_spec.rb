require 'spec_helper'

describe MechanizeController do

  describe "GET 'go'" do
    it "returns http success" do
      get 'go'
      response.should be_success
    end
  end

end
