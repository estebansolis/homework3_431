require "spec_helper"

describe MoviesController, type: :controller do
  describe 'Director Tests' do
    before :each do
      @movie1 = double('movie')
      @movie2 = double('movies')
      allow(@movie1).to receive(:director){'Some Name'}
      Movie.should_receive(:find).and_return(@movie1)
      allow(Movie).to receive(:similiar_director){@movie2}
    end
    describe 'Similar' do
      it 'Gets Movie Info In View' do
        post :same_director, {:id => '1'}
        assigns(:movie).should eql(@movie1)
      end
      #Happy Path
      it 'Returns Similar Movies' do
        Movie.should_receive(:similiar_director).and_return(@movie2)
        post :same_director, {:id => '1'}
      end
      it 'Sets Similiar Movies' do
        allow(Movie).to receive(:similiar_director){@movie2}
        post :same_director, {:id => '1'}
        assigns(:movies).should eql(@movie2)
      end
    end
  end
  describe 'Completing Code Coverage' do
    describe 'Add Director' do
      before :each do
        @movie=double(Movie, :title => "Fast Furious", :director => "Diesel", :id => "1")
        Movie.stub(:find).with("1").and_return(@movie)
      end
      it 'Should Update_attributes and Redirect' do
        @movie.stub(:update_attributes!).and_return(true)
        put :update, {:id => "1", :movie => @movie}
        response.should redirect_to(movie_path(@movie))
      end
    end
    it 'Should Create New Movie' do
      MoviesController.stub(:create).and_return(double('Movie'))
      post :create, {:id => "1"}
    end
    it 'Should Destroy Movie' do
      movie = double(Movie, :id => "1", :title => "Boats")
      Movie.stub(:find).with("1").and_return(movie)
      movie.should_receive(:destroy)
      delete :destroy, {:id => "1"}
    end
    describe 'Sorting Movies' do
      it 'Should Show All' do
        movie = double('Movie')
        Movie.should_receive(:find_all_by_rating).and_return(movie)
        get :index
        response.should render_template('index')
      end
      it 'Should Sort Title' do
        get :index, {:sort => 'title', :ratings => 'R'}
        response.should redirect_to(:sort => 'title', :ratings => 'R')
      end
      it 'Should Sort Release Date' do
        get :index, {:sort => 'release_date', :ratings => 'R'}
        response.should redirect_to(:sort => 'release_date', :ratings => 'R')
      end
      it 'Should Sort Rating R' do
        get :index, {:ratings => 'R'}
        response.should redirect_to(:ratings => 'R')
      end
    end
  end
end

