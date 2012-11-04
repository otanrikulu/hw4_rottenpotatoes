require 'spec_helper'

describe MoviesController do

  describe 'find movies with same director' do
	before :each do
	  @fake_movie = mock('FakeMovie', :id => '1', :director => 'velidede')
	  Movie.stub(:find_by_id).with("1").and_return(@fake_movie)
	end
	it 'should (1) generate a restful route for finding similar movies' do
#	  @movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R', :director => 'velidede')	
	  get :same_movies, {:id => @fake_movie.id}
	  response.should be_success
	end
	it 'should (2) call a controller method to receive the click and grab the id of the current movie' do
#	  @movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R', :director => 'velidede')
	  post :same_movies, {:id => @fake_movie.id}
	  response.should be_success
	end
	it 'should (3) find similar movies' do
#	  @movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R', :director => 'velidede')
	  Movie.should_receive(:find_similar).with('velidede').and_return(@fake_movie)
	  get :same_movies, {:id => @fake_movie.id}
	  response.should be_success
	end
	describe 'after valid search' do
	  before :each do
	    Movie.should_receive(:find_similar).with('velidede').and_return(@fake_movie)
	    post :same_movies, {:id => @fake_movie.id}
	  end
	  it 'should (4) select same template for rendering results' do
	    response.should render_template('same_movies')
	  end
	  it 'should (5) make the search results available to that template' do
            assigns(:movies).should == @fake_movie
          end
	end
  end

  describe 'searching TMDb' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_in_tmdb).with('hardware').
        and_return(@fake_results)
      post :search_tmdb, {:search_terms => 'hardware'}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, {:search_terms => 'hardware'}
      end
      it 'should select the Search Results template for rendering' do
        response.should render_template('search_tmdb')
      end
      it 'should make the TMDb search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end
  end

end
