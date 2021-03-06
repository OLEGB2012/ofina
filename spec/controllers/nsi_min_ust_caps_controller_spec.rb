require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe NsiMinUstCapsController do

  # This should return the minimal set of attributes required to create a valid
  # NsiMinUstCap. As you add validations to NsiMinUstCap, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NsiMinUstCapsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all nsi_min_ust_caps as @nsi_min_ust_caps" do
      nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
      get :index, {}, valid_session
      assigns(:nsi_min_ust_caps).should eq([nsi_min_ust_cap])
    end
  end

  describe "GET show" do
    it "assigns the requested nsi_min_ust_cap as @nsi_min_ust_cap" do
      nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
      get :show, {:id => nsi_min_ust_cap.to_param}, valid_session
      assigns(:nsi_min_ust_cap).should eq(nsi_min_ust_cap)
    end
  end

  describe "GET new" do
    it "assigns a new nsi_min_ust_cap as @nsi_min_ust_cap" do
      get :new, {}, valid_session
      assigns(:nsi_min_ust_cap).should be_a_new(NsiMinUstCap)
    end
  end

  describe "GET edit" do
    it "assigns the requested nsi_min_ust_cap as @nsi_min_ust_cap" do
      nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
      get :edit, {:id => nsi_min_ust_cap.to_param}, valid_session
      assigns(:nsi_min_ust_cap).should eq(nsi_min_ust_cap)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new NsiMinUstCap" do
        expect {
          post :create, {:nsi_min_ust_cap => valid_attributes}, valid_session
        }.to change(NsiMinUstCap, :count).by(1)
      end

      it "assigns a newly created nsi_min_ust_cap as @nsi_min_ust_cap" do
        post :create, {:nsi_min_ust_cap => valid_attributes}, valid_session
        assigns(:nsi_min_ust_cap).should be_a(NsiMinUstCap)
        assigns(:nsi_min_ust_cap).should be_persisted
      end

      it "redirects to the created nsi_min_ust_cap" do
        post :create, {:nsi_min_ust_cap => valid_attributes}, valid_session
        response.should redirect_to(NsiMinUstCap.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved nsi_min_ust_cap as @nsi_min_ust_cap" do
        # Trigger the behavior that occurs when invalid params are submitted
        NsiMinUstCap.any_instance.stub(:save).and_return(false)
        post :create, {:nsi_min_ust_cap => {}}, valid_session
        assigns(:nsi_min_ust_cap).should be_a_new(NsiMinUstCap)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        NsiMinUstCap.any_instance.stub(:save).and_return(false)
        post :create, {:nsi_min_ust_cap => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested nsi_min_ust_cap" do
        nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
        # Assuming there are no other nsi_min_ust_caps in the database, this
        # specifies that the NsiMinUstCap created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        NsiMinUstCap.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => nsi_min_ust_cap.to_param, :nsi_min_ust_cap => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested nsi_min_ust_cap as @nsi_min_ust_cap" do
        nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
        put :update, {:id => nsi_min_ust_cap.to_param, :nsi_min_ust_cap => valid_attributes}, valid_session
        assigns(:nsi_min_ust_cap).should eq(nsi_min_ust_cap)
      end

      it "redirects to the nsi_min_ust_cap" do
        nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
        put :update, {:id => nsi_min_ust_cap.to_param, :nsi_min_ust_cap => valid_attributes}, valid_session
        response.should redirect_to(nsi_min_ust_cap)
      end
    end

    describe "with invalid params" do
      it "assigns the nsi_min_ust_cap as @nsi_min_ust_cap" do
        nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        NsiMinUstCap.any_instance.stub(:save).and_return(false)
        put :update, {:id => nsi_min_ust_cap.to_param, :nsi_min_ust_cap => {}}, valid_session
        assigns(:nsi_min_ust_cap).should eq(nsi_min_ust_cap)
      end

      it "re-renders the 'edit' template" do
        nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        NsiMinUstCap.any_instance.stub(:save).and_return(false)
        put :update, {:id => nsi_min_ust_cap.to_param, :nsi_min_ust_cap => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested nsi_min_ust_cap" do
      nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
      expect {
        delete :destroy, {:id => nsi_min_ust_cap.to_param}, valid_session
      }.to change(NsiMinUstCap, :count).by(-1)
    end

    it "redirects to the nsi_min_ust_caps list" do
      nsi_min_ust_cap = NsiMinUstCap.create! valid_attributes
      delete :destroy, {:id => nsi_min_ust_cap.to_param}, valid_session
      response.should redirect_to(nsi_min_ust_caps_url)
    end
  end

end
