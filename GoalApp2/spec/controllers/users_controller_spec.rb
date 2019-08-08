require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #edit" do
    it "returns http success" do
      user = User.create(username: "banana", password: "banana")
      get :edit, params: {id:  user.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = FactoryBot.create(:user)
      get :show, params: {id: user.id}
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST #create" do
    let (:user_params) do
      { user: {
        username: 'Kristina',
        password: 'password123'
      }}
    end

    context 'with invalid params' do
      it "renders new template with errors" do
        post :create, params: { user: {username: "apple", password: "no"} }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it "redirect to show template for new user" do
        post :create, params: user_params
        user = User.find_by(username: "Kristina")
        expect(response).to redirect_to(user_url(user))
      end

      it "saves user in the database" do
        post :create, params: user_params
        expect(User.find_by(username: "Kristina")).not_to eq(nil)
      end

      it "logs in user" do
        post :create, params: user_params
        user = User.find_by(username: "Kristina")
        expect(session[:session_token]).to eq(user.session_token)
      end
    end

  end

end
