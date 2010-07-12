require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RecipesControllerTest < ActionController::TestCase
  def test_routing
    assert_routing '/recipes', :controller => 'recipes', :action => 'index'
    assert_routing '/recipes/new', :controller => 'recipes', :action => 'new'
    assert_routing '/recipes/123', :controller => 'recipes', :action => 'show', :id => '123'

  end

  def test_index_shows_list_of_recipes
    get :index 
    assert_select "h2", :text => 'Recipes'
    assert_select "ul#recipes" do
      assert_select "li a[href*=?]", /recipes\/\d+/, :text => 'Scrambled Eggs'
      assert_select "li a[href*=?]", /recipes\/\d+/, :text => 'Toast'
    end
  end

  def test_new_has_form_fields
    get :new
    assert_select "form" do
      assert_select "label[for=recipe_name]"
      assert_select "input[id=recipe_name][type=text]"
      assert_select "label[for=recipe_ingredients]"
      assert_select "textarea[id=recipe_ingredients]"
      assert_select "label[for=recipe_instructions]"
      assert_select "textarea[id=recipe_instructions]"
      assert_select "input[type=submit]", :value => "Add Recipe"
    end
  end

  def test_show_displays_recipe_name
    recipe = recipes(:eggs)
    name = recipe.name

    get :show, :id => recipe.id
    assert_select "h2", :text => name
  end

  def test_show_displays_recipe_ingredients
    recipe = recipes(:eggs)
    ingredients = recipe.ingredients

    get :show, :id => recipe.id
    assert_select "ul#ingredients" do
      assert_select "li", :text => ingredients.shift.to_s
      assert_select "li", :text => ingredients.shift.to_s
    end
  end

  def test_show_displays_recipe_instructions
    recipe = recipes(:eggs)
    instructions = recipe.instructions

    get :show, :id => recipe.id
    assert_select "div#instructions", :text => instructions 
  end


end
