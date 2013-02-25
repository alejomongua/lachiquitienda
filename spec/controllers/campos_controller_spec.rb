require 'spec_helper'

describe CamposController do

  describe "GET 'categoria'" do
    it "returns http success" do
      get 'categoria'
      response.should be_success
    end
  end

end
