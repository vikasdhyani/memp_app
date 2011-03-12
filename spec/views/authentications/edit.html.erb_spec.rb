require 'spec_helper'

describe "authentications/edit.html.erb" do
  before(:each) do
    @authentication = assign(:authentication, stub_model(Authentication,
      :new_record? => false,
      :user_id => 1,
      :provider => "MyString",
      :uid => "MyString"
    ))
  end

  it "renders the edit authentication form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => authentication_path(@authentication), :method => "post" do
      assert_select "input#authentication_user_id", :name => "authentication[user_id]"
      assert_select "input#authentication_provider", :name => "authentication[provider]"
      assert_select "input#authentication_uid", :name => "authentication[uid]"
    end
  end
end
