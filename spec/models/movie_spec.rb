# spec/models/movie_spec.rb

require 'spec_helper'
#describe Movie do
#  it 'should include rating and year in full name' do
#    movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R')
#    movie.name_with_rating.should == 'Milk (R)'
#  end
#end

# or if you mix in FactoryGirl's syntax methods (see FactoryGirl README):

#describe Movie do
#  subject { create :movie, :title => 'Milk', :rating => 'R' }
#  its :name_with_rating { should == 'Milk (R)' }
#end

describe Movie do

# spec/models/movie_spec.rb


  it 'should include title, rating, director' do
    @movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R', :director => 'velidede')
    @movie.director.should == 'velidede'
  end

  describe 'searching Tmdb by keyword' do
    it 'should call Tmdb with title keywords given valid API key' do
      TmdbMovie.should_receive(:find).
        with(hash_including :title => 'Inception')
      Movie.find_in_tmdb('Inception')
    end
    it 'should raise an InvalidKeyError with no API key' do
      Movie.stub(:api_key).and_return('')
      lambda { Movie.find_in_tmdb('Inception') }.
        should raise_error(Movie::InvalidKeyError)
    end
    it 'should raise an InvalidKeyError with invalid API key' do
      TmdbMovie.stub(:find).
        and_raise(RuntimeError.new("API returned status code '404'"))
      lambda { Movie.find_in_tmdb('Inception') }.
        should raise_error(Movie::InvalidKeyError)
    end
  end
end
