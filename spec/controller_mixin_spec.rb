require File.dirname(__FILE__) + '/spec_helper'

describe Walruz::ControllerMixin do
  
  before(:each) do
    @controller = SongsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  it "should provide a check_authorization! method" do
    @controller.class.should respond_to(:check_authorization!)
  end
  
  it "should provide a before_check_crud_authorizations_on method" do
    @controller.class.should respond_to(:before_check_crud_authorizations_on)
  end
  
  it "should provide a policy_params instance method" do
    @controller.should respond_to(:policy_params)
  end
  
  describe '#check_authorization!' do
    
    describe "with current_user authorized" do
      
      before(:each) do
        @controller.stub!(:current_user).and_return(Beatle::PAUL)
        post(:sings, :song => 'Yesterday')
      end
      
      it "should invoke the authorization with the current_user successfuly" do
        @response.body.should == 'Paul is singing Yesterday'
      end
      
      it "should provide the policy return hash on the policy_params instance method" do
        @controller.policy_params.should_not be_nil
        @controller.policy_params[:author_policy?].should  == true
      end
      
    end

    describe "when the specified user is not setted on the context" do
      
      before(:each) do
        @controller.stub!(:assign_song)
      end
      
      it "should raise an argument error" do
        post(:sings, :song => 'Yesterday')
        @response.body.should =~ /There is neither an instance variable/
      end
      
    end

    describe "with current_user not authorized" do
      
      before(:each) do
        @controller.stub!(:current_user).and_return(Beatle::JOHN)
      end
      
      it "should invoke the authorization with the current_user successfuly" do
        post(:sings, :song => 'Yesterday')
        @response.body.should == 'Unauthorized'
      end
    
    end

    
  end
  
end