class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist.name if !!self.artist
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre.name if !!self.genre
  end

  def notes_attributes=(notes_attributes)
    notes_attributes.each do |i,note_attributes|
      self.notes.build(note_attributes)
    end
  end
  
  #For test spec purposes
  def note_contents= (contents)
    contents.each do |content|
      if(!content.strip.empty?)
        note = Note.find_or_create_by(content: content)
        self.notes << note
      end
    end
  end

  def note_contents
    self.notes.collect{|note| note.content}
  end

end
