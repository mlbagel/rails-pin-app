require 'spec_helper'
RSpec.describe PinsController do

  before(:each) do
  @user = FactoryGirl.create(:user)
  login(@user)
  @pin = FactoryGirl.create!(:pin)
end

after(:each) do
  if !@user.destroyed?
    @user.destroy
  end
end

  describe "GET index" do
    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'populates @pins with all pins' do
      get :index
      expect(assigns[:pins]).to eq(Pin.where(user_id: @user.id))
    end

  #  it 'redirects to Login when Logged out' do
  #    logout(@user)
  #    get :index
  #    expect(response).to redirect_to(:login)
  #  end
  end

  describe "GET new" do
      it 'responds with successfully' do
        get :new
        expect(response.success?).to be(true)
      end

      it 'renders the new view' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns an instance variable to a new pin' do
        get :new
        expect(assigns(:pin)).to be_a_new(Pin)
      end
    end

    describe "POST create" do
      #before(:each) do
      #  @pin_hash = {
      #    title: "Rails Wizard",
      #    url: "http://railswizard.org",
      #    slug: "rails-wizard",
      #    text: "A fun and helpful Rails Resource",
      #    category_id: "rails"}
      #end

      #after(:each) do
      #  pin = Pin.find_by_slug("rails-wizard")
      #  if !pin.nil?
      #    pin.destroy
      #  end
      #end

      it 'responds with a redirect' do
        post :create, pin: @pin_hash
        expect(response.redirect?).to be(true)
      end

      it 'creates a pin' do
        post :create, pin: @pin_hash
        expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
      end

      it 'redirects to the show view' do
        post :create, pin: @pin_hash
        expect(response).to redirect_to(pin_url(assigns(:pin)))
      end

      it 'redisplays new form on error' do
        # The title is required in the Pin model, so we'll
        # delete the title from the @pin_hash in order
        # to test what happens with invalid parameters
        @pin_hash.delete(:title)
        post :create, pin: @pin_hash
        expect(response).to render_template(:new)
      end

      it 'assigns the @errors instance variable on error' do
        # The title is required in the Pin model, so we'll
        # delete the title from the @pin_hash in order
        # to test what happens with invalid parameters
        @pin_hash.delete(:title)
        post :create, pin: @pin_hash
        expect(assigns[:errors].present?).to be(true)
      end

    end

    describe "GET edit" do
      #before(:each) do
      #  @pin = Pin.find(3)
      #end

      it 'responds with successfully' do
        get :edit, id: @pin.id
        expect(response.success?).to be(true)
      end

      it 'renders the edit view' do
        get :edit, id: @pin.id
        expect(response).to render_template(:edit)
      end

      it 'assigns an instance variable called @pin to the Pin with the appropriate id' do
        #this happens after we update our pin with new information and assign it back to the
        #pin with the same id.
        get :edit, id: @pin.id
        expect(assigns(:pin)).to eq(@pin)
      end
    end

    describe "POST Update" do
      #with valid parameters
      #before(:each) do
      #  @pin = Pin.find(4)
      #  @pin_hash = {
      #    title: "Ruby Quiz",
      #    url: "http://rubyquiz.org",
      #    slug: "ruby-quiz",
      #    text: "A collection of quizzes on the Ruby programming language.",
      #    category_id: "1"}
      #end
      it 'responds with success' do
        put :update, id: @pin.id, pin: @pin_hash
        expect(response).to redirect_to("/pins/#{@pin.id}")
      end
      it 'upates a pin' do
        put :update, id: @pin.id, pin: @pin_hash
        expect(Pin.find(@pin.id).slug).to eq(@pin_hash[:slug])
      end
      it 'redirects to the show view' do
        put :update, id: @pin.id, pin: @pin_hash
        expect(response).to redirect_to(pin_url(assigns(:pin)))
      end
    end

    describe "POST Update" do
      #with invalid parameters

      #before(:each) do
      #  @pin = Pin.find(4)
      #  @pin_hash = {
      #    title: "",
      #    url: "http://rubyquiz.org",
      #    slug: "ruby-quiz",
      #    text: "A collection of quizzes on the Ruby programming language.",
      #    category_id: "1",
      #  category_iiid: "2"}
      #  end

        it "assigns an @errors instance variable" do
          put :update, id: @pin.id, pin: @pin_hash
          expect(assigns(:errors).present?).to be(true)
        end
        it "renders the edit view" do
          put :update, id: @pin.id, pin: @pin_hash
          expect(response).to render_template(:edit)
        end

      end
end
