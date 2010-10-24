require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RecipesControllerTest < ActionController::TestCase
  def test_routing
    assert_routing '/recipes', :controller => 'recipes', :action => 'index'
    assert_routing '/recipes/123', :controller => 'recipes', :action => 'show', :id => '123'
    assert_routing '/recipes/new', :controller => 'recipes', :action => 'new'
    assert_routing({:method => 'post', :path => '/recipes'}, :controller => 'recipes', :action => 'create')

  end

  def test_index_shows_list_of_recipes
    get :index 
    assert_select "h2", :text => 'Recipes'
    assert_select "ul#recipes" do
      assert_select "li a[href*=?]", /recipes\/\d+/, :text => 'Scrambled Eggs'
      assert_select "li a[href*=?]", /recipes\/\d+/, :text => 'Toast'
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

  def test_new_has_form_fields
    get :new
    assert_select "form[method=post]" do
      assert_select "label[for=recipe_name]"
      assert_select "input[type=text][id=recipe_name]"
      assert_select "label[for=recipe_ingredients_attributes_0_quantity]"
      assert_select "input[type=text][id=recipe_ingredients_attributes_0_quantity]"
      assert_select "label[for=recipe_ingredients_attributes_0_name]"
      assert_select "input[type=text][id=recipe_ingredients_attributes_0_name]"
      assert_select "label[for=recipe_instructions]"
      assert_select "textarea[id=recipe_instructions]"
      assert_select "input[type=submit]", :value => "Add Recipe"
    end
  end

  def test_create_saves_and_redirects
    post :create, {:recipe => {:name => name}}
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  def test_create_accepts_nested_attributes
    name = 'foos'
    ingredient_1 = 'foo'
    ingredient_2 = 'bar'
    post :create, {:recipe => {:name => name, :ingredients_attributes => [{:name => ingredient_1},{:name => ingredient_2}]}}

    recipe = assigns(:recipe)
    assert_equal name, recipe.name
    assert_equal ingredient_1, recipe.ingredients.first.name
  end

end
