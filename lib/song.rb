
class Song

  #Song
  #when initialized with a name and a albun
   # the name attribute can be accessed
    #the album attribute can be accessed
    #sets the initial value of id to nil

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end
      #.create_table
    #creates the songs table in the database 
  
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end
   
     #save
    #saves an instance of the Song class to the database
    #assigns the id of the song from the database to the instance
    #returns the new object that it instantiated


  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.album)
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    self

  end


#.create
#    saves a song to the database
#   returns the new object that it instantiated
  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end

end