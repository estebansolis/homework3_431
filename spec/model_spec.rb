require "spec_helper"

describe Movie, type: :model do
  describe 'Finding Similar Directors' do
    before :each do
      Movie.create(title:'Superman',rating:'PG',director:'Marvel',release_date:'2010-03-12')
      Movie.create(title:'Flash',rating:'PG-13',director:'Speed',release_date:'2015-11-23')
      Movie.create(title:'Batman',rating:'R',director:'Marvel',release_date:'2013-08-07')
    end
    it 'Should find Movies with Same Director' do
      Movie.should_receive(:similar_directors).with('Superman')
      Movie.similar_directors('Superman')
    end
  end
end


