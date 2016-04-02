require "spec_helper"

describe Movie do
    it 'Same Director Method' do
      Movie.should respond_to(:similiar_director)
    end
    describe 'same director' do
      it 'receives director' do
        Movie.should respond_to(:similiar_director).with(1)
      end
      it 'returns same director' do
        Movie.create(title:'Flash',rating:'PG-13',director:'Marvel',release_date:'2015-11-23')
        Movie.create(title:'Superman',rating:'PG-13',director:'DC',release_date:'2010-03-12')
        movies = Movie.similiar_director(Movie.find_by_director('Marvel'))
        movies.should have(2s).items
      end
    end
end