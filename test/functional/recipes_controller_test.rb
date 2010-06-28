require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RecipesControllerTest < ActionController::TestCase
  def test_routing
    assert_routing '/recipes', :controller => 'recipes', :action => 'index'
    assert_routing '/recipes/123', :controller => 'recipes', :action => 'show', :id => '123'
  end

  def test_index_shows_list_of_recipes
    get :index 
    assert_select "a[href*=?]", /recipes\/\d+/, :text => 'Scrambled Eggs'
    assert_select "a[href*=?]", /recipes\/\d+/, :text => 'Toast'
  end
end
